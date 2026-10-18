import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';

class CustomerPaymentService {
  CustomerPaymentService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<String> recordPayment(
    String customerId,
    String? saleId,
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

      // 1. Insert Customer Payment Record
      await _db.into(_db.customerPayments).insert(
            CustomerPaymentsCompanion.insert(
              id: paymentId,
              customerId: customerId,
              saleId: Value(saleId),
              amount: amount,
              paymentMethod: method.index,
              reference: Value(reference),
              notes: Value(notes),
              createdAt: now,
            ),
          );

      // 2. Update Sale Payment Status and Amount Received if Linked to a Sale
      if (saleId != null) {
        final sale = await (_db.select(_db.sales)
              ..where((t) => t.id.equals(saleId)))
            .getSingleOrNull();
        if (sale != null) {
          final newReceived = roundMoney(sale.amountReceived + amount);
          final isPaid = newReceived >= (sale.total - 0.009);
          final newStatus = isPaid
              ? PaymentStatus.paid
              : PaymentStatus.partiallyPaid;

          await (_db.update(_db.sales)..where((t) => t.id.equals(saleId))).write(
            SalesCompanion(
              amountReceived: Value(newReceived),
              paymentStatus: Value(newStatus.index),
            ),
          );
        }
      }

      // 3. Record Cash Inflow if Cash
      if (method == PaymentMethod.cash) {
        await _ledger.addCash(
          type: CashEntryType.customerPayment,
          signedAmount: amount,
          description: 'Customer payment ${reference ?? ''}'.trim(),
          referenceId: paymentId,
          at: now,
        );
      }

      // 4. Audit Log
      await _ledger.audit(
        action: AuditAction.create,
        entityType: AuditEntityType.customerPayment,
        entityId: paymentId,
        newValue: 'Amount: $amount, Customer: $customerId, Sale: $saleId',
      );

      return paymentId;
    });
  }

  Future<double> getCustomerBalance(String customerId) async {
    final totalExpr = _db.sales.total.sum();
    final receivedExpr = _db.sales.amountReceived.sum();

    final row = await (_db.selectOnly(_db.sales)
          ..addColumns([totalExpr, receivedExpr])
          ..where(_db.sales.customerId.equals(customerId) &
              _db.sales.isVoided.equals(false)))
        .getSingle();

    final total = row.read(totalExpr) ?? 0.0;
    final received = row.read(receivedExpr) ?? 0.0;

    return roundMoney(total - received);
  }

  Future<List<Sale>> getOverdueReceivables() async {
    final now = DateTime.now();
    final sales = await (_db.select(_db.sales)
          ..where((t) =>
              t.saleType.equals(SaleType.credit.index) &
              t.isVoided.equals(false) &
              t.dueDate.isNotNull() &
              t.dueDate.isSmallerThanValue(now))
          ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
        .get();

    return sales.where((s) => (s.total - s.amountReceived) > 0.009).toList();
  }
}
