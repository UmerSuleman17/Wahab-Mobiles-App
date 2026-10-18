import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';
import 'package:wm_app/data/models/models.dart';
import 'package:wm_app/data/repositories/sale_repository.dart';

class SaleService {
  SaleService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<String> createCashSale(
    List<LineItemInput> items,
    PaymentMethod method, {
    double discount = 0,
    String? notes,
  }) async {
    if (items.isEmpty) {
      throw const ValidationException('Sale must contain at least one item');
    }

    return _db.transaction(() async {
      final now = DateTime.now();
      final saleId = IdGenerator.generate();
      final allowNegative = await _ledger.allowNegativeStock();

      final subtotal = items.fold<double>(
        0,
        (sum, item) => sum + (item.quantity * item.unitPrice),
      );
      final total = roundMoney((subtotal - discount).clamp(0, double.infinity));

      // 1. Create Receipt
      final receipt = await _ledger.createReceipt(
        type: ReceiptType.sale,
        transactionId: saleId,
        total: total,
        at: now,
      );

      // 2. Create Sale Record
      await _db.into(_db.sales).insert(
            SalesCompanion.insert(
              id: saleId,
              receiptId: Value(receipt.id),
              customerId: const Value.absent(),
              total: total,
              discount: Value(discount),
              amountReceived: Value(total),
              paymentMethod: method.index,
              paymentStatus: PaymentStatus.paid.index,
              saleType: SaleType.cash.index,
              notes: Value(notes),
              createdAt: now,
            ),
          );

      // 3. Create Sale Items and Adjust Inventory
      for (final item in items) {
        final itemId = IdGenerator.generate();
        final itemTotal = roundMoney(item.quantity * item.unitPrice);

        await _db.into(_db.saleItems).insert(
              SaleItemsCompanion.insert(
                id: itemId,
                saleId: saleId,
                productId: item.productId,
                quantity: item.quantity,
                unitPrice: item.unitPrice,
                total: itemTotal,
              ),
            );

        await _ledger.moveStock(
          productId: item.productId,
          delta: -item.quantity,
          type: StockTransactionType.stockOut,
          unitPrice: item.unitPrice,
          referenceId: saleId,
          reason: 'Cash sale #${receipt.receiptNumber}',
          allowNegative: allowNegative,
          at: now,
        );
      }

      // 4. Record Cash Drawer Entry if Cash
      if (method == PaymentMethod.cash && total > 0) {
        await _ledger.addCash(
          type: CashEntryType.cashSale,
          signedAmount: total,
          description: 'Cash sale #${receipt.receiptNumber}',
          referenceId: saleId,
          at: now,
        );
      }

      // 5. Audit Log
      await _ledger.audit(
        action: AuditAction.create,
        entityType: AuditEntityType.sale,
        entityId: saleId,
        newValue: 'Total: $total, Items: ${items.length}',
      );

      return saleId;
    });
  }

  Future<String> createCreditSale(
    List<LineItemInput> items,
    String customerId,
    double amountReceived,
    DateTime? dueDate, {
    PaymentMethod method = PaymentMethod.cash,
    double discount = 0,
    String? notes,
  }) async {
    if (items.isEmpty) {
      throw const ValidationException('Sale must contain at least one item');
    }

    return _db.transaction(() async {
      final now = DateTime.now();
      final saleId = IdGenerator.generate();
      final allowNegative = await _ledger.allowNegativeStock();

      final subtotal = items.fold<double>(
        0,
        (sum, item) => sum + (item.quantity * item.unitPrice),
      );
      final total = roundMoney((subtotal - discount).clamp(0, double.infinity));

      final PaymentStatus status;
      if (amountReceived >= total && total > 0) {
        status = PaymentStatus.paid;
      } else if (amountReceived > 0) {
        status = PaymentStatus.partiallyPaid;
      } else {
        status = PaymentStatus.pending;
      }

      // 1. Create Receipt
      final receipt = await _ledger.createReceipt(
        type: ReceiptType.sale,
        transactionId: saleId,
        total: total,
        at: now,
      );

      // 2. Create Sale Record
      await _db.into(_db.sales).insert(
            SalesCompanion.insert(
              id: saleId,
              receiptId: Value(receipt.id),
              customerId: Value(customerId),
              total: total,
              discount: Value(discount),
              amountReceived: Value(amountReceived),
              paymentMethod: method.index,
              paymentStatus: status.index,
              saleType: SaleType.credit.index,
              dueDate: Value(dueDate),
              notes: Value(notes),
              createdAt: now,
            ),
          );

      // 3. Create Sale Items and Adjust Inventory
      for (final item in items) {
        final itemId = IdGenerator.generate();
        final itemTotal = roundMoney(item.quantity * item.unitPrice);

        await _db.into(_db.saleItems).insert(
              SaleItemsCompanion.insert(
                id: itemId,
                saleId: saleId,
                productId: item.productId,
                quantity: item.quantity,
                unitPrice: item.unitPrice,
                total: itemTotal,
              ),
            );

        await _ledger.moveStock(
          productId: item.productId,
          delta: -item.quantity,
          type: StockTransactionType.stockOut,
          unitPrice: item.unitPrice,
          referenceId: saleId,
          reason: 'Credit sale #${receipt.receiptNumber}',
          allowNegative: allowNegative,
          at: now,
        );
      }

      // 4. Record Cash and Payment Record if Down Payment made
      if (amountReceived > 0) {
        await _db.into(_db.customerPayments).insert(
              CustomerPaymentsCompanion.insert(
                id: IdGenerator.generate(),
                customerId: customerId,
                saleId: Value(saleId),
                amount: amountReceived,
                paymentMethod: method.index,
                notes: Value('Down payment for sale #${receipt.receiptNumber}'),
                createdAt: now,
              ),
            );

        if (method == PaymentMethod.cash) {
          await _ledger.addCash(
            type: CashEntryType.customerPayment,
            signedAmount: amountReceived,
            description: 'Credit sale down payment #${receipt.receiptNumber}',
            referenceId: saleId,
            at: now,
          );
        }
      }

      // 5. Audit Log
      await _ledger.audit(
        action: AuditAction.create,
        entityType: AuditEntityType.sale,
        entityId: saleId,
        newValue: 'Total: $total, AmountReceived: $amountReceived',
      );

      return saleId;
    });
  }

  Future<void> voidSale(String saleId) async {
    await _db.transaction(() async {
      final sale = await (_db.select(_db.sales)
            ..where((t) => t.id.equals(saleId)))
          .getSingleOrNull();
      if (sale == null) throw RecordNotFoundException('Sale', saleId);
      if (sale.isVoided) return;

      // 1. Mark Sale Voided
      await (_db.update(_db.sales)..where((t) => t.id.equals(saleId))).write(
        const SalesCompanion(
          isVoided: Value(true),
        ),
      );

      // 2. Reverse Stock
      final items = await (_db.select(_db.saleItems)
            ..where((t) => t.saleId.equals(saleId)))
          .get();

      for (final item in items) {
        await _ledger.moveStock(
          productId: item.productId,
          delta: item.quantity,
          type: StockTransactionType.saleReturn,
          unitPrice: item.unitPrice,
          referenceId: saleId,
          reason: 'Voided sale #$saleId',
          allowNegative: true,
        );
      }

      // 3. Reverse Cash
      await _ledger.reverseCash(
        referenceIds: [saleId],
        description: 'Reversal for voided sale #$saleId',
        reversalReferenceId: saleId,
      );

      // 4. Audit Log
      await _ledger.audit(
        action: AuditAction.void_,
        entityType: AuditEntityType.sale,
        entityId: saleId,
        previousValue: 'Total: ${sale.total}',
      );
    });
  }

  Future<SaleDetail> getSaleDetail(String saleId) {
    return SaleRepository(_db).getSaleDetail(saleId);
  }
}
