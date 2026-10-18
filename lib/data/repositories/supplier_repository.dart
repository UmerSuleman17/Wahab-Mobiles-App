import 'package:drift/drift.dart';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';
import 'package:wm_app/data/models/models.dart';

/// Supplier records and computed supplier balances.
class SupplierRepository {
  SupplierRepository(this._db);

  final AppDatabase _db;

  Stream<List<Supplier>> watchAll() => (_db.select(_db.suppliers)
        ..orderBy([(t) => OrderingTerm.asc(t.name)]))
      .watch();

  Future<List<Supplier>> getAll() => (_db.select(_db.suppliers)
        ..orderBy([(t) => OrderingTerm.asc(t.name)]))
      .get();

  Future<Supplier?> findById(String id) =>
      (_db.select(_db.suppliers)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<Supplier> getById(String id) async {
    final s = await findById(id);
    if (s == null) throw RecordNotFoundException('Supplier', id);
    return s;
  }

  Future<String> create({
    required String name,
    String? phone,
    String? email,
    String? address,
    String? notes,
  }) async {
    final id = IdGenerator.generate();
    await _db.into(_db.suppliers).insert(SuppliersCompanion.insert(
          id: id,
          name: name.trim(),
          phone: Value(_blankToNull(phone)),
          email: Value(_blankToNull(email)),
          address: Value(_blankToNull(address)),
          notes: Value(_blankToNull(notes)),
          createdAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> update(
    String id, {
    required String name,
    String? phone,
    String? email,
    String? address,
    String? notes,
  }) async {
    final count = await (_db.update(_db.suppliers)
          ..where((t) => t.id.equals(id)))
        .write(SuppliersCompanion(
      name: Value(name.trim()),
      phone: Value(_blankToNull(phone)),
      email: Value(_blankToNull(email)),
      address: Value(_blankToNull(address)),
      notes: Value(_blankToNull(notes)),
    ));
    if (count == 0) throw RecordNotFoundException('Supplier', id);
  }

  /// Deletes a supplier that has no purchase or payment history.
  Future<void> delete(String id) async {
    await _db.transaction(() async {
      final hasPurchases = await (_db.select(_db.purchases)
            ..where((t) => t.supplierId.equals(id))
            ..limit(1))
          .getSingleOrNull();
      final hasPayments = await (_db.select(_db.supplierPayments)
            ..where((t) => t.supplierId.equals(id))
            ..limit(1))
          .getSingleOrNull();
      if (hasPurchases != null || hasPayments != null) {
        throw const ValidationException(
          'This supplier has purchase or payment history and cannot be '
          'deleted. You can keep them for your records.',
        );
      }
      await (_db.update(_db.products)..where((t) => t.supplierId.equals(id)))
          .write(const ProductsCompanion(supplierId: Value(null)));
      await (_db.delete(_db.suppliers)..where((t) => t.id.equals(id))).go();
    });
  }

  /// All suppliers with balances, recomputed whenever related tables change.
  Stream<List<SupplierAccount>> watchAccounts() {
    return _db
        .customSelect(
          'SELECT 1',
          readsFrom: {_db.suppliers, _db.purchases, _db.supplierPayments},
        )
        .watch()
        .asyncMap((_) => getAccounts());
  }

  Future<List<SupplierAccount>> getAccounts({String query = ''}) async {
    final suppliers = await getAll();
    final purchaseRows = await _db.customSelect(
      'SELECT supplier_id, COUNT(*) AS cnt, COALESCE(SUM(total),0) AS total, '
      'COALESCE(SUM(amount_paid),0) AS paid FROM purchases '
      'WHERE is_voided = 0 GROUP BY supplier_id',
      readsFrom: {_db.purchases},
    ).get();
    final paymentRows = await _db.customSelect(
      'SELECT supplier_id, COALESCE(SUM(amount),0) AS paid '
      'FROM supplier_payments WHERE is_voided = 0 GROUP BY supplier_id',
      readsFrom: {_db.supplierPayments},
    ).get();

    final purchases = {
      for (final r in purchaseRows) r.read<String>('supplier_id'): r,
    };
    final payments = {
      for (final r in paymentRows)
        r.read<String>('supplier_id'): r.read<double>('paid'),
    };

    final q = query.trim().toLowerCase();
    return suppliers
        .where((s) =>
            q.isEmpty ||
            s.name.toLowerCase().contains(q) ||
            (s.phone ?? '').toLowerCase().contains(q))
        .map((s) {
      final p = purchases[s.id];
      return SupplierAccount(
        supplier: s,
        totalPurchases: p?.read<double>('total') ?? 0,
        purchaseCount: p?.read<int>('cnt') ?? 0,
        paidAtPurchase: p?.read<double>('paid') ?? 0,
        payments: payments[s.id] ?? 0,
      );
    }).toList();
  }

  Future<SupplierAccount> getAccount(String supplierId) async {
    final supplier = await getById(supplierId);
    final accounts = await getAccounts();
    return accounts.firstWhere(
      (a) => a.supplier.id == supplierId,
      orElse: () => SupplierAccount(
        supplier: supplier,
        totalPurchases: 0,
        purchaseCount: 0,
        paidAtPurchase: 0,
        payments: 0,
      ),
    );
  }

  Future<double> getOutstandingBalance(String supplierId) async =>
      (await getAccount(supplierId)).balance;

  static String? _blankToNull(String? v) =>
      (v == null || v.trim().isEmpty) ? null : v.trim();
}
