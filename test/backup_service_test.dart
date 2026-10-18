import 'dart:io';
import 'dart:ffi';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/open.dart' as sqlite_open;
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/app_database_lifecycle.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/services/backup_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  if (Platform.isWindows) {
    // The Windows Flutter test host does not load the app's bundled SQLite
    // plugin. Use the OS SQLite export for native temporary-database tests.
    sqlite_open.open.overrideFor(
      sqlite_open.OperatingSystem.windows,
      () => DynamicLibrary.open('winsqlite3.dll'),
    );
  }

  late Directory tempDirectory;
  late File activeFile;
  late AppDatabase activeDatabase;
  AppDatabaseLifecycle? testLifecycle;
  const pathProviderChannel = MethodChannel('plugins.flutter.io/path_provider');

  Future<AppDatabase> openDatabase(File file) async {
    final database = AppDatabase(NativeDatabase(file));
    await database.customSelect('SELECT 1').get();
    return database;
  }

  Future<File> createBackup(String name, {String value = 'backup'}) async {
    final file = File('${tempDirectory.path}/$name');
    final database = await openDatabase(file);
    await database.into(database.appSettings).insert(
          AppSettingsCompanion.insert(key: 'restore-test', value: value),
        );
    await database.close();
    return file;
  }

  Future<String?> readSetting(AppDatabase database) async {
    final rows = await (database.select(database.appSettings)
          ..where((row) => row.key.equals('restore-test')))
        .get();
    return rows.isEmpty ? null : rows.single.value;
  }

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp('wm-backup-test-');
    activeFile = File('${tempDirectory.path}/wm_app.db');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathProviderChannel, (call) async {
      if (call.method == 'getApplicationDocumentsDirectory') {
        return tempDirectory.path;
      }
      return null;
    });
    activeDatabase = AppDatabase(NativeDatabase(activeFile));
    await activeDatabase.customSelect('SELECT 1').get();
    await activeDatabase.into(activeDatabase.appSettings).insert(
          AppSettingsCompanion.insert(key: 'restore-test', value: 'active'),
        );
  });

  tearDown(() async {
    await testLifecycle?.closeCurrent();
    await activeDatabase.close();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathProviderChannel, null);
    await tempDirectory.delete(recursive: true);
  });

  group('validateBackup', () {
    test('rejects a missing file', () async {
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup('${tempDirectory.path}/missing.db'),
          isFalse);
    });

    test('rejects an empty file', () async {
      final file = File('${tempDirectory.path}/empty.db');
      await file.writeAsBytes(const []);
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects a non-SQLite file', () async {
      final file = File('${tempDirectory.path}/text.db');
      await file.writeAsString('not a SQLite database');
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects a truncated SQLite header', () async {
      final file = File('${tempDirectory.path}/truncated.db');
      await file.writeAsBytes(<int>[
        83,
        81,
        76,
        105,
        116,
        101,
        32,
        102,
        111,
        114,
        109,
        97,
        116,
        32,
        51,
        0,
        0,
        0,
        0,
      ]);
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects an unsupported SQLite user version', () async {
      final file = await createBackup('future-version.db');
      final database = sqlite.sqlite3.open(file.path);
      database.execute('PRAGMA user_version = 99');
      database.dispose();
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects a same-version SQLite file missing application tables',
        () async {
      final file = File('${tempDirectory.path}/missing-tables.db');
      final database = sqlite.sqlite3.open(file.path);
      database.execute('PRAGMA user_version = 1');
      database.dispose();
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects a same-version table with mismatched columns', () async {
      final file = await createBackup('wrong-columns.db');
      final database = sqlite.sqlite3.open(file.path);
      database.execute('DROP TABLE admin_entries');
      database.execute(
        'CREATE TABLE admin_entries (id TEXT PRIMARY KEY)',
      );
      database.dispose();
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects a same-version settings table without its primary key',
        () async {
      final file = await createBackup('missing-settings-primary-key.db');
      final database = sqlite.sqlite3.open(file.path);
      database.execute('DROP TABLE app_settings');
      database.execute(
        'CREATE TABLE app_settings ("key" TEXT NOT NULL, value TEXT NOT NULL)',
      );
      database.dispose();
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects a same-version table without a required unique constraint',
        () async {
      final file = await createBackup('missing-category-unique-key.db');
      final database = sqlite.sqlite3.open(file.path);
      database.execute('DROP TABLE categories');
      database.execute(
        'CREATE TABLE categories '
        '(id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL)',
      );
      database.dispose();
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });

    test('rejects a backup with an unexpected financial data trigger',
        () async {
      final file = await createBackup('unexpected-trigger.db');
      final database = sqlite.sqlite3.open(file.path);
      database.execute(
        'CREATE TRIGGER erase_cash AFTER INSERT ON cash_entries '
        'BEGIN DELETE FROM cash_entries; END',
      );
      database.dispose();
      final service = BackupService(activeDatabase);

      expect(await service.validateBackup(file.path), isFalse);
    });
  });

  test('invalid restore leaves active data and connection unchanged', () async {
    final invalidFile = File('${tempDirectory.path}/invalid.db');
    await invalidFile.writeAsString('not SQLite');
    final service = BackupService(activeDatabase);
    final activeBytes = await activeFile.readAsBytes();

    await expectLater(
      service.restoreBackup(invalidFile.path),
      throwsA(isA<InvalidBackupException>()),
    );

    expect(await activeFile.readAsBytes(), activeBytes);
    expect(await readSetting(activeDatabase), 'active');
  });

  test('valid restore survives closing and reopening the active database',
      () async {
    final file = await createBackup('valid-restore.db', value: 'restored');
    await activeDatabase.close();
    final lifecycle = AppDatabaseLifecycle(
      () => AppDatabase(NativeDatabase(activeFile)),
    );
    testLifecycle = lifecycle;
    await lifecycle.state.customSelect('SELECT 1').get();
    final service = BackupService(
      lifecycle.state,
      documentsDirectoryProvider: () async => tempDirectory,
      closeDatabase: lifecycle.closeCurrent,
      reopenDatabase: lifecycle.reopenCurrent,
    );

    await service.restoreBackup(file.path);
    expect(await readSetting(lifecycle.state), 'restored');

    await lifecycle.closeCurrent();
    await lifecycle.reopenCurrent();
    expect(await readSetting(lifecycle.state), 'restored');
  });

  test('reopen failure rolls back and reopens the previous database', () async {
    var failNextOpen = false;
    await activeDatabase.close();
    final lifecycle = AppDatabaseLifecycle(() {
      if (failNextOpen) {
        failNextOpen = false;
        throw StateError('injected reopen failure');
      }
      return AppDatabase(NativeDatabase(activeFile));
    });
    testLifecycle = lifecycle;
    await lifecycle.state.customSelect('SELECT 1').get();
    final file =
        await createBackup('rollback-candidate.db', value: 'candidate');
    final service = BackupService(
      lifecycle.state,
      documentsDirectoryProvider: () async => tempDirectory,
      closeDatabase: lifecycle.closeCurrent,
      reopenDatabase: lifecycle.reopenCurrent,
    );
    failNextOpen = true;

    await expectLater(
      service.restoreBackup(file.path),
      throwsA(isA<BackupException>()),
    );

    expect(await readSetting(lifecycle.state), 'active');
  });
}
