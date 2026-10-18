import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/open.dart' as sqlite_open;
import 'package:wm_app/core/backup/backup_file.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/providers/backup_file_adapter.dart';
import 'package:wm_app/core/providers/legacy_backup_restorer.dart';
import 'package:wm_app/core/providers/portable_backup_service.dart';
import 'package:wm_app/features/settings/presentation/backup_restore_screen.dart';
import 'package:wm_app/services/portable_backup_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    sqlite_open.open.overrideFor(
      sqlite_open.OperatingSystem.windows,
      () => DynamicLibrary.open('winsqlite3.dll'),
    );
  }

  late AppDatabase database;
  late PortableBackupService delegate;
  late _FakePortableBackupStore backupStore;
  late _FakeBackupFileAdapter fileAdapter;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    await database.customSelect('SELECT 1').get();
    await database.into(database.appSettings).insert(
          AppSettingsCompanion.insert(key: 'active', value: 'preserved'),
        );
    delegate = PortableBackupService(database);
    backupStore = _FakePortableBackupStore(
      delegate,
      await delegate.exportBackup(),
    );
    fileAdapter = _FakeBackupFileAdapter();
  });

  tearDown(() => database.close());

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portableBackupServiceProvider.overrideWith((ref) => backupStore),
          backupFileAdapterProvider.overrideWith((ref) => fileAdapter),
          legacyBackupRestorerProvider.overrideWith((ref) => null),
        ],
        child: const MaterialApp(home: BackupRestoreScreen()),
      ),
    );
  }

  testWidgets('exports the database through the file adapter', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Create New Backup'));
    await tester.pumpAndSettle();

    expect(fileAdapter.savedBytes, isNotNull);
    final envelope = jsonDecode(utf8.decode(fileAdapter.savedBytes!))
        as Map<String, dynamic>;
    expect(envelope['format'], 'wm_app_backup');
    expect(fileAdapter.suggestedName, endsWith('.wmbak'));
  });

  testWidgets('rejects an invalid import without changing current data',
      (tester) async {
    fileAdapter.pickedFile = PickedBackupFile(
      name: 'broken.wmbak',
      bytes: Uint8List.fromList(utf8.encode('{broken')),
    );
    await pumpScreen(tester);

    await tester.tap(find.text('Restore from Backup'));
    await tester.pumpAndSettle();

    expect(find.textContaining('could not be read'), findsOneWidget);
    expect(backupStore.restoreCalls, 0);
  });

  testWidgets('canceling confirmation leaves current data untouched',
      (tester) async {
    fileAdapter.pickedFile = PickedBackupFile(
      name: 'valid.wmbak',
      bytes: backupStore.backupBytes,
    );
    await pumpScreen(tester);

    await tester.tap(find.text('Restore from Backup'));
    await tester.pumpAndSettle();
    expect(find.textContaining('1 record'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(backupStore.restoreCalls, 0);
  });

  testWidgets('confirmed import invokes restore exactly once', (tester) async {
    fileAdapter.pickedFile = PickedBackupFile(
      name: 'valid.wmbak',
      bytes: backupStore.backupBytes,
    );
    await pumpScreen(tester);

    await tester.tap(find.text('Restore from Backup'));
    await tester.pumpAndSettle();
    expect(find.textContaining('1 record'), findsOneWidget);
    await tester.tap(find.text('Replace data'));
    await tester.pumpAndSettle();

    expect(backupStore.restoreCalls, 1);
    expect(find.text('Restore complete'), findsOneWidget);
  });
}

class _FakePortableBackupStore implements PortableBackupStore {
  _FakePortableBackupStore(this._delegate, this.backupBytes);

  final PortableBackupService _delegate;
  final Uint8List backupBytes;
  int restoreCalls = 0;

  @override
  Future<Uint8List> exportBackup() async => backupBytes;

  @override
  PortableBackupSummary inspectBackup(Uint8List bytes) =>
      _delegate.inspectBackup(bytes);

  @override
  Future<void> restoreBackup(PortableBackupSummary backup) async {
    restoreCalls++;
  }
}

class _FakeBackupFileAdapter implements BackupFileAdapter {
  PickedBackupFile? pickedFile;
  Uint8List? savedBytes;
  String? suggestedName;
  int pickCalls = 0;

  @override
  Future<PickedBackupFile?> pickBackup() async {
    pickCalls++;
    return pickedFile;
  }

  @override
  Future<bool> saveBackup(Uint8List bytes, String suggestedName) async {
    savedBytes = bytes;
    this.suggestedName = suggestedName;
    return true;
  }
}
