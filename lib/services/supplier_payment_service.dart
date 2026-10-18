import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';

class SupplierPaymentService {
  SupplierPaymentService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<String> recordPayment(
    String supplierId,
    double amount,
    PaymentMethod method, {
    String? reference,
    String? notes,
  }) async {
    if (amount <= 0) {
      throw const InvalidAmountException('Payment amount must be greater than zero');
    }

    return _db.transaction(() async {
      final now = DateTime.now();
      final paymentId = IdGenerator.generate();

      // 1. Create Receipt
      final receipt = await _ledger.createReceipt(
        type: ReceiptType.supplierPayment,
        transactionId: paymentId,
        total: amount,
        at: now,
      );

      // 2. Create Supplier Payment Record
      await _db.into(_db.supplierPayments).insert(
            SupplierPaymentsCompanion.insert(
              id: paymentId,
              supplierId: supplierId,
              amount: amount,
              paymentMethod: method.index,
              reference: Value(reference),
              notes: Value(notes),
              createdAt: now,
            ),
          );

      // 3. Record Cash Outflow if Cash
      if (method == PaymentMethod.cash) {
        await _ledger.addCash(
          type: CashEntryType.supplierPayment,
          signedAmount: -amount,
          description: 'Supplier payment #${receipt.receiptNumber}',
          referenceId: paymentId,
          at: now,
        );
      }

      // 4. Audit Log
      await _ledger.audit(
        action: AuditAction.create,
        entityType: AuditEntityType.supplierPayment,
        entityId: paymentId,
        newValue: 'Amount: $amount, Supplier: $supplierId',
      );

      return paymentId;
    });
  }

  Future<void> voidPayment(String paymentId) async {
    await _db.transaction(() async {
      final payment = await (_db.select(_db.supplierPayments)
            ..where((t) => t.id.equals(paymentId)))
          .getSingleOrNull();
      if (payment == null) {
        throw RecordNotFoundException('SupplierPayment', paymentId);
      }
      if (payment.isVoided) return;

      // 1. Mark Voided
      await (_db.update(_db.supplierPayments)
            ..where((t) => t.id.equals(paymentId)))
          .write(
        const SupplierPaymentsCompanion(
          isVoided: Value(true),
        ),
      );

      // 2. Reverse Cash
      await _ledger.reverseCash(
        referenceIds: [paymentId],
        description: 'Reversal for voided supplier payment #$paymentId',
        reversalReferenceId: paymentId,
      );

      // 3. Audit Log
      await _ledger.audit(
        action: AuditAction.void_,
        entityType: AuditEntityType.supplierPayment,
        entityId: paymentId,
        previousValue: 'Amount: ${payment.amount}',
      );
    });
  }

  Future<double> getSupplierBalance(String supplierId) async {
    final purchasesTotalExpr = _db.purchases.total.sum();
    final purchasesPaidExpr = _db.purchases.amountPaid.sum();

    final purchaseRow = await (_db.selectOnly(_db.purchases)
          ..addColumns([purchasesTotalExpr, purchasesPaidExpr])
          ..where(_db.purchases.supplierId.equals(supplierId) &
              _db.purchases.isVoided.equals(false)))
        .getSingle();

    final totalPurchases = purchaseRow.read(purchasesTotalExpr) ?? 0.0;
    final paidAtPurchase = purchaseRow.read(purchasesPaidExpr) ?? 0.0;

    final paymentsSumExpr = _db.supplierPayments.amount.sum();
    final paymentRow = await (_db.selectOnly(_db.supplierPayments)
          ..addColumns([paymentsSumExpr])
          ..where(_db.supplierPayments.supplierId.equals(supplierId) &
              _db.supplierPayments.isVoided.equals(false)))
        .getSingle();

    final separatePayments = paymentRow.read(paymentsSumExpr) ?? 0.0;

    return roundMoney(totalPurchases - paidAtPurchase - separatePayments);
  }
}
