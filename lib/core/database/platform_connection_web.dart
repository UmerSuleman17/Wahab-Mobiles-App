import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';
import 'package:wm_app/core/database/web_storage_policy.dart';

QueryExecutor openPlatformDatabase({required String databaseName}) {
  return LazyDatabase(() async {
    final sqlite3 = await WasmSqlite3.loadFromUrl(
      Uri.base.resolve('sqlite3.wasm'),
    ).timeout(const Duration(seconds: 20));
    final fileSystem = await IndexedDbFileSystem.open(
      dbName: 'wm_app_files_$databaseName',
    ).timeout(const Duration(seconds: 20));
    sqlite3.registerVirtualFileSystem(fileSystem, makeDefault: true);

    // Drift's worker probe can stall in some Chromium builds on the OPFS
    // feature test. IndexedDB is persistent per origin/profile and is the
    // selected MVP backend; its unsafe mode needs a visible single-tab notice.
    activeWebStoragePolicy =
        WebStoragePolicy.fromMode(WebStorageMode.unsafeIndexedDb);
    return WasmDatabase(
      sqlite3: sqlite3,
      path: databaseName,
      fileSystem: fileSystem,
    );
  });
}
