import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';

class SupplierPaymentRepository {
  SupplierPaymentRepository(this._db);

  final AppDatabase _db;

  Future<List<SupplierPayment>> getAll() => (_db.select(_db.supplierPayments)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<SupplierPayment> getById(String id) async {
    final payment = await (_db.select(_db.supplierPayments)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (payment == null) {
      throw RecordNotFoundException('SupplierPayment', id);
    }
    return payment;
  }

  Future<List<SupplierPayment>> getBySupplier(String supplierId) {
    return (_db.select(_db.supplierPayments)
          ..where((t) => t.supplierId.equals(supplierId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<SupplierPayment>> getByDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.supplierPayments)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> create(SupplierPaymentsCompanion payment) =>
      _db.into(_db.supplierPayments).insert(payment);

  Future<void> voidPayment(String id) async {
    await (_db.update(_db.supplierPayments)..where((t) => t.id.equals(id)))
        .write(
      const SupplierPaymentsCompanion(
        isVoided: Value(true),
      ),
    );
  }

  Future<double> getTotalPaid(String supplierId) async {
    final sumExpr = _db.supplierPayments.amount.sum();
    final query = _db.selectOnly(_db.supplierPayments)
      ..addColumns([sumExpr])
      ..where(_db.supplierPayments.supplierId.equals(supplierId) &
          _db.supplierPayments.isVoided.equals(false));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }
}
