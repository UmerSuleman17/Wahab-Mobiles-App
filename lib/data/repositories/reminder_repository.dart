import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';

class ReminderRepository {
  ReminderRepository(this._db);

  final AppDatabase _db;

  Future<List<Reminder>> getAll() => (_db.select(_db.reminders)
        ..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)]))
      .get();

  Future<List<Reminder>> getScheduled() {
    return (_db.select(_db.reminders)
          ..where((t) => t.status.equals(ReminderStatus.scheduled.index))
          ..orderBy([(t) => OrderingTerm.asc(t.scheduledAt)]))
        .get();
  }

  Future<List<Reminder>> getByCustomer(String customerId) {
    return (_db.select(_db.reminders)
          ..where((t) => t.customerId.equals(customerId))
          ..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)]))
        .get();
  }

  Future<List<Reminder>> getBySale(String saleId) {
    return (_db.select(_db.reminders)
          ..where((t) => t.saleId.equals(saleId))
          ..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)]))
        .get();
  }

  Future<int> create(RemindersCompanion reminder) =>
      _db.into(_db.reminders).insert(reminder);

  Future<void> updateStatus(String id, int status, DateTime? sentAt) async {
    await (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
      RemindersCompanion(
        status: Value(status),
        sentAt: Value(sentAt),
      ),
    );
  }

  Future<List<Reminder>> getPending() {
    final now = DateTime.now();
    return (_db.select(_db.reminders)
          ..where((t) =>
              t.status.equals(ReminderStatus.scheduled.index) &
              t.scheduledAt.isSmallerOrEqualValue(now))
          ..orderBy([(t) => OrderingTerm.asc(t.scheduledAt)]))
        .get();
  }
}
