import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';

/// Service for authentication and admin credential management.
class AuthService {
  AuthService(this._db);

  final AppDatabase _db;

  /// Authenticate with a PIN.
  ///
  /// Returns `true` if the PIN matches the stored hash, `false` otherwise.
  Future<bool> login(String pin) async {
    final admins = await (_db.select(_db.adminEntries)).get();
    if (admins.isEmpty) {
      throw const AuthException(
        'No admin account has been set up',
        code: 'NO_ADMIN',
      );
    }

    final admin = admins.first;
    final hashedInput = hashPin(pin);
    return admin.pinHash == hashedInput;
  }

  /// Create the initial admin account with the given PIN.
  ///
  /// Throws if an admin account already exists.
  Future<void> createAdmin(String pin) async {
    final existing = await (_db.select(_db.adminEntries)).get();
    if (existing.isNotEmpty) {
      throw const AuthException(
        'Admin account already exists',
        code: 'ADMIN_EXISTS',
      );
    }

    final now = DateTime.now();
    await _db.into(_db.adminEntries).insert(
          AdminEntriesCompanion.insert(
            id: IdGenerator.generate(),
            pinHash: hashPin(pin),
            createdAt: now,
          ),
        );
  }

  /// Change the admin PIN.
  ///
  /// Validates the old PIN before updating to the new one.
  Future<void> changePin(String oldPin, String newPin) async {
    final admins = await (_db.select(_db.adminEntries)).get();
    if (admins.isEmpty) {
      throw const AuthException(
        'No admin account found',
        code: 'NO_ADMIN',
      );
    }

    final admin = admins.first;
    final oldHash = hashPin(oldPin);
    if (admin.pinHash != oldHash) {
      throw const InvalidCredentialsException();
    }

    await (_db.update(_db.adminEntries)..where((t) => t.id.equals(admin.id)))
        .write(AdminEntriesCompanion(
      pinHash: Value(hashPin(newPin)),
    ));
  }

  /// Hash a PIN using dart:convert base64 encoding with salt.
  String hashPin(String pin) {
    final bytes = utf8.encode('wm_salt_$pin');
    return base64Encode(bytes);
  }

  /// Check if an admin account has been set up.
  Future<bool> isAdminSetup() async {
    final admins = await (_db.select(_db.adminEntries)).get();
    return admins.isNotEmpty;
  }
}
