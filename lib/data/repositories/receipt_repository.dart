import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';

class ReceiptRepository {
  ReceiptRepository(this._db);

  final AppDatabase _db;

  Future<List<Receipt>> getAll() => (_db.select(_db.receipts)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<Receipt> getById(String id) async {
    final receipt = await (_db.select(_db.receipts)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (receipt == null) {
      throw RecordNotFoundException('Receipt', id);
    }
    return receipt;
  }

  Future<Receipt?> getByNumber(String number) =>
      (_db.select(_db.receipts)..where((t) => t.receiptNumber.equals(number)))
          .getSingleOrNull();

  Future<Receipt?> getByTransaction(String transactionId) => (_db
          .select(_db.receipts)
        ..where((t) => t.transactionId.equals(transactionId)))
      .getSingleOrNull();

  Future<int> create(ReceiptsCompanion receipt) =>
      _db.into(_db.receipts).insert(receipt);

  Future<ReceiptSetting?> getSettings() async {
    final query = _db.select(_db.receiptSettings)..limit(1);
    return query.getSingleOrNull();
  }

  Future<void> saveSettings(ReceiptSettingsCompanion settings) async {
    final existing = await getSettings();
    if (existing != null) {
      await (_db.update(_db.receiptSettings)
            ..where((t) => t.id.equals(existing.id)))
          .write(settings);
    } else {
      await _db.into(_db.receiptSettings).insert(settings);
    }
  }

  Future<int> getNextSequence(String prefix, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

    final query = _db.select(_db.receipts)
      ..where((t) =>
          t.receiptNumber.like('$prefix%') &
          t.createdAt.isBetweenValues(start, end))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(1);

    final lastReceipt = await query.getSingleOrNull();
    if (lastReceipt == null) return 1;

    final parts = lastReceipt.receiptNumber.split('-');
    if (parts.length >= 3) {
      return (int.tryParse(parts.last) ?? 0) + 1;
    }
    return 1;
  }
}
