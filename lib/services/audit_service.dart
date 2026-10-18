import 'package:drift/drift.dart';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/utils/id_generator.dart';

/// Service for audit trail logging and retrieval.
///
/// Records all significant user and system actions for accountability,
/// debugging, and compliance purposes.
class AuditService {
  AuditService(this._db);

  final AppDatabase _db;

  /// Log an action to the audit trail.
  ///
  /// [action] — the type of action performed (create, update, delete, etc.).
  /// [entityType] — the type of entity affected.
  /// [entityId] — the ID of the affected entity.
  /// [previousValue] — optional JSON string of the entity's state before the action.
  /// [newValue] — optional JSON string of the entity's state after the action.
  Future<void> logAction(
    AuditAction action,
    AuditEntityType entityType,
    String entityId, {
    String? previousValue,
    String? newValue,
  }) async {
    final now = DateTime.now();
    await _db.into(_db.auditEntries).insert(
          AuditEntriesCompanion.insert(
            id: IdGenerator.generate(),
            action: action.index,
            entityType: entityType.index,
            entityId: entityId,
            previousValue: Value(previousValue),
            newValue: Value(newValue),
            createdAt: now,
          ),
        );
  }

  /// Get the full audit history for a specific entity.
  ///
  /// Returns entries ordered by most recent first.
  Future<List<AuditEntry>> getEntityHistory(
    AuditEntityType entityType,
    String entityId,
  ) async {
    return (_db.select(_db.auditEntries)
          ..where((t) =>
              t.entityType.equals(entityType.index) &
              t.entityId.equals(entityId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// Get the most recent audit entries across all entities.
  ///
  /// [limit] — maximum number of entries to return (default 50).
  Future<List<AuditEntry>> getRecentActivity({int limit = 50}) async {
    return (_db.select(_db.auditEntries)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .get();
  }
}
