import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';

class CustomerPaymentRepository {
  CustomerPaymentRepository(this._db);

  final AppDatabase _db;

  Future<List<CustomerPayment>> getAll() => (_db.select(_db.customerPayments)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<CustomerPayment> getById(String id) async {
    final payment = await (_db.select(_db.customerPayments)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (payment == null) {
      throw RecordNotFoundException('CustomerPayment', id);
    }
    return payment;
  }

  Future<List<CustomerPayment>> getByCustomer(String customerId) {
    return (_db.select(_db.customerPayments)
          ..where((t) => t.customerId.equals(customerId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<CustomerPayment>> getBySale(String saleId) {
    return (_db.select(_db.customerPayments)
          ..where((t) => t.saleId.equals(saleId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<CustomerPayment>> getByDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.customerPayments)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> create(CustomerPaymentsCompanion payment) =>
      _db.into(_db.customerPayments).insert(payment);

  Future<double> getTotalReceived(String customerId) async {
    final sumExpr = _db.customerPayments.amount.sum();
    final query = _db.selectOnly(_db.customerPayments)
      ..addColumns([sumExpr])
      ..where(_db.customerPayments.customerId.equals(customerId));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }
}
