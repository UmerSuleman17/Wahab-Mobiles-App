import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';
import 'package:wm_app/data/models/models.dart';

class PurchaseService {
  PurchaseService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<String> createPurchase(
    String supplierId,
    List<LineItemInput> items,
    PaymentMethod method,
    PaymentStatus status, {
    double discount = 0,
    double amountPaid = 0,
    String? notes,
  }) async {
    if (items.isEmpty) {
      throw const ValidationException(
        'Purchase must contain at least one item',
      );
    }

    return _db.transaction(() async {
      final now = DateTime.now();
      final purchaseId = IdGenerator.generate();

      final subtotal = items.fold<double>(
        0,
        (sum, item) => sum + (item.quantity * item.unitPrice),
      );
      final total = roundMoney((subtotal - discount).clamp(0, double.infinity));

      final effectiveAmountPaid = (status == PaymentStatus.paid && amountPaid <= 0)
          ? total
          : amountPaid;

      // 1. Create Receipt
      final receipt = await _ledger.createReceipt(
        type: ReceiptType.purchase,
        transactionId: purchaseId,
        total: total,
        at: now,
      );

      // 2. Create Purchase Record
      await _db.into(_db.purchases).insert(
            PurchasesCompanion.insert(
              id: purchaseId,
              supplierId: supplierId,
              receiptId: Value(receipt.id),
              total: total,
              discount: Value(discount),
              amountPaid: Value(effectiveAmountPaid),
              paymentMethod: method.index,
              paymentStatus: status.index,
              notes: Value(notes),
              createdAt: now,
            ),
          );

      // 3. Create Items and Update Inventory
      for (final item in items) {
        final itemId = IdGenerator.generate();
        final itemTotal = roundMoney(item.quantity * item.unitPrice);

        await _db.into(_db.purchaseItems).insert(
              PurchaseItemsCompanion.insert(
                id: itemId,
                purchaseId: purchaseId,
                productId: item.productId,
                quantity: item.quantity,
                unitPrice: item.unitPrice,
                total: itemTotal,
              ),
            );

        await _ledger.moveStock(
          productId: item.productId,
          delta: item.quantity,
          type: StockTransactionType.stockIn,
          unitPrice: item.unitPrice,
          referenceId: purchaseId,
          reason: 'Purchase #${receipt.receiptNumber}',
          allowNegative: true,
          at: now,
        );
      }

      // 4. Record Cash Outflow if Paid in Cash
      if (method == PaymentMethod.cash && effectiveAmountPaid > 0) {
        await _ledger.addCash(
          type: CashEntryType.cashPurchase,
          signedAmount: -effectiveAmountPaid,
          description: 'Cash purchase #${receipt.receiptNumber}',
          referenceId: purchaseId,
          at: now,
        );
      }

      // 5. Audit Log
      await _ledger.audit(
        action: AuditAction.create,
        entityType: AuditEntityType.purchase,
        entityId: purchaseId,
        newValue: 'Total: $total, Paid: $effectiveAmountPaid',
      );

      return purchaseId;
    });
  }

  Future<void> voidPurchase(String purchaseId) async {
    await _db.transaction(() async {
      final purchase = await (_db.select(_db.purchases)
            ..where((t) => t.id.equals(purchaseId)))
          .getSingleOrNull();
      if (purchase == null) throw RecordNotFoundException('Purchase', purchaseId);
      if (purchase.isVoided) return;

      // 1. Mark Voided
      await (_db.update(_db.purchases)
            ..where((t) => t.id.equals(purchaseId)))
          .write(
        const PurchasesCompanion(
          isVoided: Value(true),
        ),
      );

      // 2. Reverse Stock
      final items = await (_db.select(_db.purchaseItems)
            ..where((t) => t.purchaseId.equals(purchaseId)))
          .get();

      final allowNegative = await _ledger.allowNegativeStock();
      for (final item in items) {
        await _ledger.moveStock(
          productId: item.productId,
          delta: -item.quantity,
          type: StockTransactionType.purchaseReturn,
          unitPrice: item.unitPrice,
          referenceId: purchaseId,
          reason: 'Voided purchase #$purchaseId',
          allowNegative: allowNegative,
        );
      }

      // 3. Reverse Cash
      await _ledger.reverseCash(
        referenceIds: [purchaseId],
        description: 'Reversal for voided purchase #$purchaseId',
        reversalReferenceId: purchaseId,
      );

      // 4. Audit Log
      await _ledger.audit(
        action: AuditAction.void_,
        entityType: AuditEntityType.purchase,
        entityId: purchaseId,
        previousValue: 'Total: ${purchase.total}',
      );
    });
  }
}
