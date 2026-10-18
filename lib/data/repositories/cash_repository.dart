import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';

class CashRepository {
  CashRepository(this._db);

  final AppDatabase _db;

  Future<List<CashEntry>> getAll() => (_db.select(_db.cashEntries)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<List<CashEntry>> getByDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.cashEntries)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<CashEntry>> getByType(int type) {
    return (_db.select(_db.cashEntries)
          ..where((t) => t.type.equals(type))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> create(CashEntriesCompanion entry) =>
      _db.into(_db.cashEntries).insert(entry);

  Future<List<CashEntry>> getTodayEntries() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    return getByDateRange(start, end);
  }

  Future<double> getTotalByTypeAndDateRange(
    int type,
    DateTime start,
    DateTime end,
  ) async {
    final sumExpr = _db.cashEntries.amount.sum();
    final query = _db.selectOnly(_db.cashEntries)
      ..addColumns([sumExpr])
      ..where(_db.cashEntries.type.equals(type) &
          _db.cashEntries.createdAt.isBetweenValues(start, end));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }

  Future<double> getBalance() async {
    final sumExpr = _db.cashEntries.amount.sum();
    final query = _db.selectOnly(_db.cashEntries)..addColumns([sumExpr]);
    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }
}
