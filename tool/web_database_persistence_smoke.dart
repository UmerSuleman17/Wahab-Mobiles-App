import 'dart:html' as html;

import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/web_storage_policy.dart';

const _databaseName = 'wm_app_web_persistence_smoke_20261015';
const _fileSystemName = 'wm_app_web_persistence_smoke_files_20261015';

typedef _OpenedSmokeDatabase = ({
  AppDatabase database,
  IndexedDbFileSystem fileSystem,
});

void main() {
  final status = html.querySelector('#status')!;
  _checkPersistence(status);
}

Future<void> _checkPersistence(html.Element status) async {
  try {
    status.text = 'Smoke script loaded; opening persistent IndexedDB…';
    final first = await _openSmokeDatabase(status);
    activeWebStoragePolicy =
        WebStoragePolicy.fromMode(WebStorageMode.unsafeIndexedDb);
    status.text = '${status.text}\nOpened IndexedDB; creating test table…';
    status.text = '${status.text}\nRunning first schema transaction…';
    await first.database
        .customStatement(
          'CREATE TABLE IF NOT EXISTS persistence_check (value TEXT NOT NULL)',
        )
        .timeout(const Duration(seconds: 25));
    status.text = '${status.text}\nFirst schema transaction complete.';
    final existing = await first.database
        .customSelect('SELECT value FROM persistence_check LIMIT 1')
        .get()
        .timeout(const Duration(seconds: 25));
    final wasPresentBeforeLoad = existing.isNotEmpty;
    if (!wasPresentBeforeLoad) {
      await first.database
          .customStatement(
            "INSERT INTO persistence_check (value) VALUES ('retained')",
          )
          .timeout(const Duration(seconds: 25));
    }
    await first.database.close();
    await first.fileSystem.close();

    status.text = '${status.text}\nOpening a second connection…';
    final reopened = await _openSmokeDatabase(status);
    status.text = '${status.text}\nQuerying from the second connection…';
    final row = await reopened.database
        .customSelect('SELECT value FROM persistence_check LIMIT 1')
        .getSingle();
    final value = row.read<String>('value');
    await reopened.database.close();
    await reopened.fileSystem.close();

    if (value != 'retained') {
      throw StateError('The reopened database returned an unexpected value.');
    }

    final reloadMessage = wasPresentBeforeLoad
        ? 'Data survived a browser reload.'
        : 'Data survived close and reopen. Reload this page to verify reload persistence.';
    if (wasPresentBeforeLoad) {
      await IndexedDbFileSystem.deleteDatabase(_fileSystemName);
    }
    status.text = '${status.text}\nPASS: $reloadMessage Storage: IndexedDB. '
        '${wasPresentBeforeLoad ? 'Smoke-test database removed.' : ''}';
    status.classes.add('passed');
  } catch (error, stackTrace) {
    status.text = '${status.text}\nFAIL: $error';
    status.classes.add('failed');
    html.window.console.error('$error\n$stackTrace');
  }
}

Future<_OpenedSmokeDatabase> _openSmokeDatabase(html.Element status) async {
  status.text = '${status.text}\nLoading sqlite3.wasm…';
  final sqlite3 = await WasmSqlite3.loadFromUrl(
    Uri.base.resolve('sqlite3.wasm'),
  ).timeout(const Duration(seconds: 15));
  status.text = '${status.text}\nOpening browser IndexedDB…';
  final fileSystem = await IndexedDbFileSystem.open(
    dbName: _fileSystemName,
  ).timeout(const Duration(seconds: 15));
  status.text = '${status.text}\nRegistering SQLite VFS…';
  sqlite3.registerVirtualFileSystem(fileSystem, makeDefault: true);
  status.text =
      '${status.text}\nSQLite VFS registered; building Drift executor…';
  final executor = WasmDatabase(
    sqlite3: sqlite3,
    path: _databaseName,
    fileSystem: fileSystem,
  );
  status.text = '${status.text}\nConstructing AppDatabase…';
  final database = AppDatabase(executor);
  status.text = '${status.text}\nAppDatabase constructed.';
  return (
    database: database,
    fileSystem: fileSystem,
  );
}
