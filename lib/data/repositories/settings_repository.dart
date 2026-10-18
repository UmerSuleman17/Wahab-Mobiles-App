import 'package:wm_app/core/database/app_database.dart';

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Future<BusinessEntry?> getBusinessInfo() async {
    final query = _db.select(_db.businessEntries)..limit(1);
    return query.getSingleOrNull();
  }

  Future<void> updateBusinessInfo(BusinessEntriesCompanion info) async {
    final existing = await getBusinessInfo();
    if (existing != null) {
      await (_db.update(_db.businessEntries)
            ..where((t) => t.id.equals(existing.id)))
          .write(info);
    } else {
      await _db.into(_db.businessEntries).insert(info);
    }
  }

  Future<ReceiptSetting?> getReceiptSettings() async {
    final query = _db.select(_db.receiptSettings)..limit(1);
    return query.getSingleOrNull();
  }

  Future<void> saveReceiptSettings(ReceiptSettingsCompanion settings) async {
    final existing = await getReceiptSettings();
    if (existing != null) {
      await (_db.update(_db.receiptSettings)
            ..where((t) => t.id.equals(existing.id)))
          .write(settings);
    } else {
      await _db.into(_db.receiptSettings).insert(settings);
    }
  }

  Future<void> updateReceiptSettings(ReceiptSettingsCompanion settings) =>
      saveReceiptSettings(settings);

  Future<String> getCurrency() async {
    final info = await getBusinessInfo();
    return info?.currency ?? 'PKR';
  }

  Future<String?> getSetting(String key) async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setSetting(String key, String value) async {
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: key,
            value: value,
          ),
        );
  }
}
