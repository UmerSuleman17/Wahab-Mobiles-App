import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:wm_app/core/backup/legacy_backup_restorer.dart';
import 'package:wm_app/core/constants/app_constants.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';

class BackupService implements LegacyBackupRestorer {
  BackupService(
    this._db, {
    Future<Directory> Function()? documentsDirectoryProvider,
    Future<void> Function()? closeDatabase,
    Future<void> Function()? reopenDatabase,
  })  : _documentsDirectoryProvider =
            documentsDirectoryProvider ?? getApplicationDocumentsDirectory,
        _closeDatabase = closeDatabase,
        _reopenDatabase = reopenDatabase;

  final AppDatabase _db;
  final Future<Directory> Function() _documentsDirectoryProvider;
  final Future<void> Function()? _closeDatabase;
  final Future<void> Function()? _reopenDatabase;
  Future<List<String>>? _expectedSchemaSignatures;

  static const _schemaQuery =
      "SELECT type, name, tbl_name, sql FROM sqlite_master "
      "WHERE type IN ('table', 'index', 'trigger', 'view') "
      "AND sql IS NOT NULL "
      "AND tbl_name NOT LIKE 'sqlite_%'";

  Future<File> _getDatabaseFile() async {
    final dbFolder = await _documentsDirectoryProvider();
    return File(p.join(dbFolder.path, AppConstants.databaseName));
  }

  Future<String> createBackup() async {
    try {
      final dbFile = await _getDatabaseFile();
      if (!await dbFile.exists()) {
        throw const BackupException('Database file not found');
      }

      final dbFolder = await _documentsDirectoryProvider();
      final backupDir = Directory(p.join(dbFolder.path, 'backups'));
      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final backupFile =
          File(p.join(backupDir.path, 'wm_backup_$timestamp.db'));
      await dbFile.copy(backupFile.path);

      _audit('Backup created.');
      return backupFile.path;
    } catch (_) {
      _audit('Backup creation failed.', isFailure: true);
      rethrow;
    }
  }

  @override
  Future<void> restoreBackup(String filePath) async {
    final backupFile = File(filePath);
    final dbFile = await _getDatabaseFile();
    final suffix = '${pid}_${DateTime.now().microsecondsSinceEpoch}';
    final stagingFile = File('${dbFile.path}.restore-$suffix.stage');
    final rollbackFile = File('${dbFile.path}.restore-$suffix.rollback');
    final closeDatabase = _closeDatabase;
    final reopenDatabase = _reopenDatabase;
    var closeAttempted = false;
    var databaseClosed = false;
    var previousDatabaseSaved = false;
    var candidateInstalled = false;
    var keepRollbackFile = false;

    try {
      if (!await backupFile.exists()) {
        throw const InvalidBackupException();
      }

      await backupFile.copy(stagingFile.path);
      if (!await validateBackup(stagingFile.path)) {
        throw const InvalidBackupException();
      }
      if (closeDatabase == null || reopenDatabase == null) {
        throw const BackupException('Database lifecycle is unavailable');
      }

      closeAttempted = true;
      await closeDatabase();
      databaseClosed = true;

      if (await dbFile.exists()) {
        await dbFile.copy(rollbackFile.path);
        previousDatabaseSaved = true;
      }

      await stagingFile.rename(dbFile.path);
      candidateInstalled = true;
      await reopenDatabase();
      databaseClosed = false;
      if (!await validateBackup(dbFile.path)) {
        throw const InvalidBackupException();
      }

      if (previousDatabaseSaved) await rollbackFile.delete();
      _audit('Backup restore completed.');
    } catch (error) {
      _audit(
        error is InvalidBackupException
            ? 'Backup restore rejected: invalid or unsupported file.'
            : 'Backup restore failed.',
        isFailure: true,
      );

      try {
        if (candidateInstalled) {
          if (!databaseClosed) {
            await closeDatabase!();
            databaseClosed = true;
          }

          if (previousDatabaseSaved && await rollbackFile.exists()) {
            await rollbackFile.rename(dbFile.path);
            previousDatabaseSaved = false;
          } else if (await dbFile.exists()) {
            await dbFile.delete();
          }
          candidateInstalled = false;
        }

        if (closeAttempted) {
          await reopenDatabase!();
          databaseClosed = false;
        }
      } catch (_) {
        keepRollbackFile = await rollbackFile.exists();
        _audit('Backup restore rollback could not be confirmed.',
            isFailure: true);
        throw const BackupException(
          'Restore failed and rollback could not be confirmed.',
          code: 'RESTORE_ROLLBACK_FAILED',
        );
      }

      if (error is InvalidBackupException) rethrow;
      throw const BackupException(
        'Restore failed; the previous database was restored.',
        code: 'RESTORE_FAILED',
      );
    } finally {
      await _deleteTemporaryFile(stagingFile);
      if (!keepRollbackFile) await _deleteTemporaryFile(rollbackFile);
    }
  }

  Future<void> _deleteTemporaryFile(File file) async {
    try {
      if (await file.exists()) await file.delete();
    } catch (_) {
      _audit('Temporary restore file cleanup failed.', isFailure: true);
    }
  }

  void _audit(String outcome, {bool isFailure = false}) {
    developer.log(
      outcome,
      name: 'wm_app.backup',
      level: isFailure ? 1000 : 800,
    );
  }

  @override
  Future<bool> validateBackup(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return false;

    sqlite.Database? candidate;
    try {
      candidate = sqlite.sqlite3.open(
        file.path,
        mode: sqlite.OpenMode.readOnly,
      );

      final integrityCheck = candidate.select('PRAGMA integrity_check');
      if (integrityCheck.length != 1 ||
          integrityCheck.single.values.first != 'ok') {
        return false;
      }

      if (candidate.select('PRAGMA foreign_key_check').isNotEmpty ||
          candidate.userVersion != _db.schemaVersion) {
        return false;
      }

      final expectedSchema =
          await (_expectedSchemaSignatures ??= _loadExpectedSchemaSignatures());
      final candidateSchema = _schemaSignatures(
        candidate.select(_schemaQuery).map((row) => row),
      );
      if (!_sameSignatures(expectedSchema, candidateSchema)) return false;

      final tableRows = candidate.select(
        "SELECT name FROM sqlite_master "
        "WHERE type = 'table' AND name NOT LIKE 'sqlite_%'",
      );
      final tableNames = tableRows.map((row) => row['name'] as String).toSet();
      for (final table in _db.allTables) {
        if (!tableNames.contains(table.actualTableName)) return false;

        final escapedTableName = table.actualTableName.replaceAll('"', '""');
        final columnRows = candidate.select(
          'PRAGMA table_info("$escapedTableName")',
        );
        final columnNames =
            columnRows.map((row) => row['name'] as String).toSet();
        final expectedColumnNames =
            table.$columns.map((column) => column.$name).toSet();
        if (!expectedColumnNames.every(columnNames.contains)) return false;
      }

      return true;
    } on Object {
      return false;
    } finally {
      candidate?.dispose();
    }
  }

  Future<List<String>> _loadExpectedSchemaSignatures() async {
    final expectedDatabase = AppDatabase(NativeDatabase.memory());
    try {
      await expectedDatabase.customSelect('SELECT 1').get();
      final rows = await expectedDatabase.customSelect(_schemaQuery).get();
      return _schemaSignatures(rows.map((row) => row.data));
    } finally {
      await expectedDatabase.close();
    }
  }

  List<String> _schemaSignatures(
    Iterable<Map<String, Object?>> rows,
  ) {
    final signatures = rows
        .map((row) => jsonEncode([
              row['type'],
              row['name'],
              row['tbl_name'],
              row['sql'],
            ]))
        .toList()
      ..sort();
    return signatures;
  }

  bool _sameSignatures(List<String> expected, List<String> actual) {
    if (expected.length != actual.length) return false;
    for (var index = 0; index < expected.length; index++) {
      if (expected[index] != actual[index]) return false;
    }
    return true;
  }
}
