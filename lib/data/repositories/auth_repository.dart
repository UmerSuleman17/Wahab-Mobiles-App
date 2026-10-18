import 'package:drift/drift.dart';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/tables/admin_table.dart';
import 'package:wm_app/core/errors/app_exception.dart';

/// Repository for admin authentication operations.
///
/// Manages admin PIN creation, validation, and updates
/// via the [AdminEntries] table.
class AuthRepository {
  AuthRepository(this._db);

  final AppDatabase _db;

  /// Retrieves the admin entry, or null if no admin exists yet.
  Future<AdminEntry?> getAdmin() async {
    final query = _db.select(_db.adminEntries);
    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  /// Creates the initial admin record with the given [pinHash].
  ///
  /// Throws [DuplicateRecordException] if an admin already exists.
  Future<void> createAdmin(String pinHash) async {
    final existing = await getAdmin();
    if (existing != null) {
      throw const DuplicateRecordException('admin', 'default');
    }

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await _db.into(_db.adminEntries).insert(
          AdminEntriesCompanion.insert(
            id: id,
            pinHash: pinHash,
            createdAt: DateTime.now(),
          ),
        );
  }

  /// Validates the provided [pinHash] against the stored admin PIN.
  ///
  /// Returns `true` if the PIN matches, `false` otherwise.
  /// Returns `false` if no admin exists.
  Future<bool> validatePin(String pinHash) async {
    final admin = await getAdmin();
    if (admin == null) return false;
    return admin.pinHash == pinHash;
  }

  /// Updates the admin PIN for the given admin [id].
  ///
  /// Throws [RecordNotFoundException] if the admin is not found.
  Future<void> updatePin(String id, String newPinHash) async {
    final count = await (_db.update(_db.adminEntries)
          ..where((t) => t.id.equals(id)))
        .write(AdminEntriesCompanion(pinHash: Value(newPinHash)));

    if (count == 0) {
      throw RecordNotFoundException('Admin', id);
    }
  }
}
