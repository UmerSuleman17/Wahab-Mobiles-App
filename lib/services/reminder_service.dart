import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/utils/id_generator.dart';
import 'whatsapp_service.dart';

class ReminderService {
  ReminderService(this._db, this._whatsApp);

  final AppDatabase _db;
  final WhatsAppService _whatsApp;

  WhatsAppService get whatsApp => _whatsApp;

  Future<void> scheduleReminder(
    String customerId,
    String saleId,
    double amount, {
    int delayHours = 24,
    String? message,
  }) async {
    final now = DateTime.now();
    final scheduledAt = now.add(Duration(hours: delayHours));
    final reminderId = IdGenerator.generate();

    await _db.into(_db.reminders).insert(
          RemindersCompanion.insert(
            id: reminderId,
            customerId: customerId,
            saleId: saleId,
            outstandingAmount: amount,
            scheduledAt: scheduledAt,
            status: ReminderStatus.scheduled.index,
            message: Value(message),
            createdAt: now,
          ),
        );
  }

  Future<void> processPendingReminders() async {
    final now = DateTime.now();
    final pending = await (_db.select(_db.reminders)
          ..where((t) =>
              t.status.equals(ReminderStatus.scheduled.index) &
              t.scheduledAt.isSmallerOrEqualValue(now)))
        .get();

    for (final reminder in pending) {
      // In practice, could open WhatsApp or send notification
      // Mark as sent
      await (_db.update(_db.reminders)..where((t) => t.id.equals(reminder.id)))
          .write(
        RemindersCompanion(
          status: Value(ReminderStatus.sent.index),
          sentAt: Value(now),
        ),
      );
    }
  }

  Future<void> cancelReminder(String reminderId) async {
    await (_db.update(_db.reminders)..where((t) => t.id.equals(reminderId)))
        .write(
      RemindersCompanion(
        status: Value(ReminderStatus.cancelled.index),
      ),
    );
  }
}
