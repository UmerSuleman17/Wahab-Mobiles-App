import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';

class ExpenseRepository {
  ExpenseRepository(this._db);

  final AppDatabase _db;

  Future<List<Expense>> getAll() => (_db.select(_db.expenses)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<Expense> getById(String id) async {
    final expense = await (_db.select(_db.expenses)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (expense == null) {
      throw RecordNotFoundException('Expense', id);
    }
    return expense;
  }

  Future<List<Expense>> getByDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.expenses)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<Expense>> getByCategory(int category) {
    return (_db.select(_db.expenses)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> create(ExpensesCompanion expense) =>
      _db.into(_db.expenses).insert(expense);

  Future<void> voidExpense(String id) async {
    await (_db.update(_db.expenses)..where((t) => t.id.equals(id))).write(
      const ExpensesCompanion(
        isVoided: Value(true),
      ),
    );
  }

  Future<double> getTodayTotal() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    final sumExpr = _db.expenses.amount.sum();
    final query = _db.selectOnly(_db.expenses)
      ..addColumns([sumExpr])
      ..where(_db.expenses.createdAt.isBetweenValues(start, end) &
          _db.expenses.isVoided.equals(false));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }

  Future<double> getTotalByDateRange(DateTime start, DateTime end) async {
    final sumExpr = _db.expenses.amount.sum();
    final query = _db.selectOnly(_db.expenses)
      ..addColumns([sumExpr])
      ..where(_db.expenses.createdAt.isBetweenValues(start, end) &
          _db.expenses.isVoided.equals(false));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }
}
