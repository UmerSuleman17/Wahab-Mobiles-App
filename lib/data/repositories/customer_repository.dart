import 'package:drift/drift.dart';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';
import 'package:wm_app/data/models/models.dart';

/// Customer records and computed receivables (PRD §51–52).
class CustomerRepository {
  CustomerRepository(this._db);

  final AppDatabase _db;

  Future<List<Customer>> getAll() => (_db.select(_db.customers)
        ..orderBy([(t) => OrderingTerm.asc(t.name)]))
      .get();

  Future<Customer?> findById(String id) =>
      (_db.select(_db.customers)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<Customer> getById(String id) async {
    final c = await findById(id);
    if (c == null) throw RecordNotFoundException('Customer', id);
    return c;
  }

  Future<String> create({
    required String name,
    required String phone,
    String? address,
    String? notes,
  }) async {
    final id = IdGenerator.generate();
    await _db.into(_db.customers).insert(CustomersCompanion.insert(
          id: id,
          name: name.trim(),
          phone: Value(phone.trim()),
          address: Value(_blankToNull(address)),
          notes: Value(_blankToNull(notes)),
          createdAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> update(
    String id, {
    required String name,
    required String phone,
    String? address,
    String? notes,
  }) async {
    final count = await (_db.update(_db.customers)
          ..where((t) => t.id.equals(id)))
        .write(CustomersCompanion(
      name: Value(name.trim()),
      phone: Value(phone.trim()),
      address: Value(_blankToNull(address)),
      notes: Value(_blankToNull(notes)),
    ));
    if (count == 0) throw RecordNotFoundException('Customer', id);
  }

  /// Deletes a customer without any sales history.
  Future<void> delete(String id) async {
    final hasSales = await (_db.select(_db.sales)
          ..where((t) => t.customerId.equals(id))
          ..limit(1))
        .getSingleOrNull();
    if (hasSales != null) {
      throw const ValidationException(
        'This customer has sales history and cannot be deleted.',
      );
    }
    await (_db.delete(_db.customers)..where((t) => t.id.equals(id))).go();
  }

  Stream<List<CustomerAccount>> watchAccounts() {
    return _db
        .customSelect(
          'SELECT 1',
          readsFrom: {_db.customers, _db.sales, _db.customerPayments},
        )
        .watch()
        .asyncMap((_) => getAccounts());
  }

  Future<List<CustomerAccount>> getAccounts({String query = ''}) async {
    final customers = await getAll();
    final now = DateTime.now();
    final sales = await (_db.select(_db.sales)
          ..where((t) => t.customerId.isNotNull() & t.isVoided.equals(false)))
        .get();

    final byCustomer = <String, List<Sale>>{};
    for (final s in sales) {
      byCustomer.putIfAbsent(s.customerId!, () => []).add(s);
    }

    final q = query.trim().toLowerCase();
    return customers
        .where((c) =>
            q.isEmpty ||
            c.name.toLowerCase().contains(q) ||
            (c.phone ?? '').toLowerCase().contains(q))
        .map((c) {
      final list = byCustomer[c.id] ?? const <Sale>[];
      double total = 0, paid = 0, overdue = 0;
      int active = 0;
      DateTime? nextDue;
      for (final s in list) {
        total += s.total;
        paid += s.amountReceived;
        final outstanding = s.total - s.amountReceived;
        if (outstanding > 0.009) {
          active++;
          if (s.dueDate != null) {
            if (s.dueDate!.isBefore(now)) overdue += outstanding;
            if (nextDue == null || s.dueDate!.isBefore(nextDue)) {
              nextDue = s.dueDate;
            }
          }
        }
      }
      return CustomerAccount(
        customer: c,
        totalPurchases: total,
        totalPaid: paid,
        activeCreditSales: active,
        overdueAmount: overdue,
        nextDueDate: nextDue,
      );
    }).toList();
  }

  Future<CustomerAccount> getAccount(String customerId) async {
    await getById(customerId);
    final accounts = await getAccounts();
    return accounts.firstWhere((a) => a.customer.id == customerId);
  }

  Future<double> getOutstandingBalance(String customerId) async =>
      (await getAccount(customerId)).outstanding;

  static String? _blankToNull(String? v) =>
      (v == null || v.trim().isEmpty) ? null : v.trim();
}
