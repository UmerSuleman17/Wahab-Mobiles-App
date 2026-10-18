import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';
import 'package:wm_app/core/utils/receipt_number_generator.dart';

/// Low-level write helpers shared by every business service.
///
/// IMPORTANT: these methods do NOT open their own transaction. Callers must
/// invoke them from inside `db.transaction(() async { ... })` so that the
/// inventory, cash, receipt and audit side-effects of one business operation
/// commit or roll back together (PRD §19 Transaction Integrity).
class Ledger {
  Ledger(this._db);

  final AppDatabase _db;

  // ---------------------------------------------------------------------------
  // Inventory
  // ---------------------------------------------------------------------------

  /// Applies a signed quantity change to a product and records it in the
  /// stock history. Positive [delta] adds stock, negative removes it.
  ///
  /// Throws [InsufficientStockException] if the result would be negative and
  /// [allowNegative] is false.
  Future<Product> moveStock({
    required String productId,
    required double delta,
    required StockTransactionType type,
    required double unitPrice,
    String? referenceId,
    String? reason,
    bool allowNegative = false,
    DateTime? at,
  }) async {
    final product = await (_db.select(_db.products)
          ..where((t) => t.id.equals(productId)))
        .getSingleOrNull();
    if (product == null) throw RecordNotFoundException('Product', productId);

    final newQty = product.quantity + delta;
    if (!allowNegative && newQty < 0) {
      throw InsufficientStockException(
        productName: product.name,
        available: product.quantity,
        requested: -delta,
      );
    }

    final now = at ?? DateTime.now();
    await (_db.update(_db.products)..where((t) => t.id.equals(productId)))
        .write(ProductsCompanion(
      quantity: Value(newQty),
      updatedAt: Value(now),
    ));

    await _db.into(_db.stockTransactions).insert(
          StockTransactionsCompanion.insert(
            id: IdGenerator.generate(),
            productId: productId,
            type: type.index,
            quantity: delta,
            unitPrice: unitPrice,
            total: _round(delta.abs() * unitPrice),
            referenceId: Value(referenceId),
            reason: Value(reason),
            createdAt: now,
          ),
        );

    return product.copyWith(quantity: newQty);
  }

  // ---------------------------------------------------------------------------
  // Cash
  // ---------------------------------------------------------------------------

  /// Records a cash movement. [signedAmount] is positive for money coming
  /// into the cash drawer and negative for money leaving it, so the cash
  /// balance is always `SUM(amount)` (single source of truth).
  Future<void> addCash({
    required CashEntryType type,
    required double signedAmount,
    required String description,
    String? referenceId,
    DateTime? at,
  }) async {
    if (signedAmount == 0) return;
    await _db.into(_db.cashEntries).insert(
          CashEntriesCompanion.insert(
            id: IdGenerator.generate(),
            type: type.index,
            amount: _round(signedAmount),
            description: description,
            referenceId: Value(referenceId),
            createdAt: at ?? DateTime.now(),
          ),
        );
  }

  /// Reverses every cash entry linked to any of [referenceIds] by inserting
  /// an equal-and-opposite adjustment entry. History is never deleted.
  Future<double> reverseCash({
    required List<String> referenceIds,
    required String description,
    required String reversalReferenceId,
  }) async {
    if (referenceIds.isEmpty) return 0;
    final entries = await (_db.select(_db.cashEntries)
          ..where((t) => t.referenceId.isIn(referenceIds)))
        .get();
    final net = entries.fold<double>(0, (sum, e) => sum + e.amount);
    if (net != 0) {
      await addCash(
        type: CashEntryType.adjustment,
        signedAmount: -net,
        description: description,
        referenceId: reversalReferenceId,
      );
    }
    return net;
  }

  // ---------------------------------------------------------------------------
  // Receipts
  // ---------------------------------------------------------------------------

  /// Creates a receipt with the next sequential number for today.
  Future<Receipt> createReceipt({
    required ReceiptType type,
    required String transactionId,
    required double total,
    DateTime? at,
  }) async {
    final now = at ?? DateTime.now();
    final prefix = switch (type) {
      ReceiptType.sale => 'SL',
      ReceiptType.purchase => 'PUR',
      ReceiptType.supplierPayment => 'SP',
      ReceiptType.customerPayment => 'CP',
    };
    final datePart = '$prefix-${DateFormat('yyyyMMdd').format(now)}';

    final countExpr = _db.receipts.id.count();
    final row = await (_db.selectOnly(_db.receipts)
          ..addColumns([countExpr])
          ..where(_db.receipts.receiptNumber.like('$datePart-%')))
        .getSingle();
    final sequence = (row.read(countExpr) ?? 0) + 1;

    final receipt = Receipt(
      id: IdGenerator.generate(),
      receiptNumber: ReceiptNumberGenerator.generate(
        prefix: prefix,
        sequence: sequence,
        date: now,
      ),
      transactionId: transactionId,
      type: type.index,
      total: _round(total),
      createdAt: now,
    );
    await _db.into(_db.receipts).insert(receipt);
    return receipt;
  }

  // ---------------------------------------------------------------------------
  // Audit
  // ---------------------------------------------------------------------------

  Future<void> audit({
    required AuditAction action,
    required AuditEntityType entityType,
    required String entityId,
    String? previousValue,
    String? newValue,
  }) async {
    await _db.into(_db.auditEntries).insert(
          AuditEntriesCompanion.insert(
            id: IdGenerator.generate(),
            action: action.index,
            entityType: entityType.index,
            entityId: entityId,
            previousValue: Value(previousValue),
            newValue: Value(newValue),
            createdAt: DateTime.now(),
          ),
        );
  }

  // ---------------------------------------------------------------------------
  // Settings helpers
  // ---------------------------------------------------------------------------

  Future<bool> allowNegativeStock() async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(SettingKeys.allowNegativeStock)))
        .getSingleOrNull();
    return row?.value == 'true';
  }

  static double _round(double v) => (v * 100).roundToDouble() / 100;
}

/// Money rounding used across services (2 decimal places).
double roundMoney(double v) => (v * 100).roundToDouble() / 100;

/// Keys for the [AppSettings] key-value table.
class SettingKeys {
  SettingKeys._();
  static const allowNegativeStock = 'allow_negative_stock';
  static const defaultMinStock = 'default_min_stock';
  static const remindersEnabled = 'reminders_enabled';
  static const reminderDelayHours = 'reminder_delay_hours';
  static const reminderRepeatHours = 'reminder_repeat_hours';
  static const reminderTemplate = 'reminder_template';
  static const reminderWindowStart = 'reminder_window_start';
  static const reminderWindowEnd = 'reminder_window_end';
  static const lastBackupAt = 'last_backup_at';
}
