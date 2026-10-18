import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';

class AuditRepository {
  AuditRepository(this._db);

  final AppDatabase _db;

  Future<List<AuditEntry>> getAll() => (_db.select(_db.auditEntries)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<List<AuditEntry>> getByEntity(int entityType, String entityId) {
    return (_db.select(_db.auditEntries)
          ..where((t) =>
              t.entityType.equals(entityType) & t.entityId.equals(entityId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<AuditEntry>> getByDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.auditEntries)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> create(AuditEntriesCompanion entry) =>
      _db.into(_db.auditEntries).insert(entry);

  Future<List<AuditEntry>> getRecent(int limit) {
    return (_db.select(_db.auditEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }
}
