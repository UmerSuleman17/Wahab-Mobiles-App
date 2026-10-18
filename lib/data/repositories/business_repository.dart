import 'package:drift/drift.dart';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';

/// Repository for business profile operations.
///
/// Manages the single business record including creation,
/// updates, and setup-completion status.
class BusinessRepository {
  BusinessRepository(this._db);

  final AppDatabase _db;

  /// Retrieves the business record, or null if not yet created.
  Future<BusinessEntry?> getBusiness() async {
    final query = _db.select(_db.businessEntries);
    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  /// Creates a new business record.
  ///
  /// Throws [DuplicateRecordException] if a business already exists.
  Future<void> createBusiness({
    required String id,
    required String name,
    String? logoPath,
    String? phone,
    String? email,
    String? address,
    String currency = 'PKR',
    double openingCash = 0,
    double openingBank = 0,
  }) async {
    final existing = await getBusiness();
    if (existing != null) {
      throw const DuplicateRecordException('business', 'default');
    }

    final now = DateTime.now();
    await _db.into(_db.businessEntries).insert(
          BusinessEntriesCompanion.insert(
            id: id,
            name: name,
            logoPath: Value(logoPath),
            phone: Value(phone),
            email: Value(email),
            address: Value(address),
            currency: Value(currency),
            openingCash: Value(openingCash),
            openingBank: Value(openingBank),
            isSetupComplete: Value(false),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  /// Updates the existing business record.
  ///
  /// Throws [RecordNotFoundException] if no business record exists.
  Future<void> updateBusiness({
    required String id,
    String? name,
    Value<String?> logoPath = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    String? currency,
    double? openingCash,
    double? openingBank,
  }) async {
    final count = await (_db.update(_db.businessEntries)
          ..where((t) => t.id.equals(id)))
        .write(
      BusinessEntriesCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        logoPath: logoPath,
        phone: phone,
        email: email,
        address: address,
        currency:
            currency != null ? Value(currency) : const Value.absent(),
        openingCash:
            openingCash != null ? Value(openingCash) : const Value.absent(),
        openingBank:
            openingBank != null ? Value(openingBank) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    if (count == 0) {
      throw RecordNotFoundException('Business', id);
    }
  }

  /// Marks the business setup as complete.
  ///
  /// Throws [RecordNotFoundException] if no business record exists.
  Future<void> markSetupComplete() async {
    final business = await getBusiness();
    if (business == null) {
      throw const RecordNotFoundException('Business', 'default');
    }

    await (_db.update(_db.businessEntries)
          ..where((t) => t.id.equals(business.id)))
        .write(
      BusinessEntriesCompanion(
        isSetupComplete: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Returns whether the business setup has been completed.
  Future<bool> isSetupComplete() async {
    final business = await getBusiness();
    return business?.isSetupComplete ?? false;
  }
}
