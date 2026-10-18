### Task 1: Add browser database connection and web scaffold

**Files:**
- Create: `web/index.html`, `web/manifest.json`, `web/drift_worker.dart`, `web/drift_worker.dart.js`, `web/sqlite3.wasm` (plus Flutter scaffold assets as generated)
- Create: `lib/core/database/platform_connection.dart`, `lib/core/database/platform_connection_stub.dart`, `lib/core/database/platform_connection_native.dart`, `lib/core/database/platform_connection_web.dart`
- Modify: `lib/core/providers/database_provider.dart`
- Modify: `lib/features/splash/presentation/splash_screen.dart`
- Test: `test/core/database/web_storage_policy_test.dart`
- Test: `test/web_database_persistence_test.dart`

**Interfaces:**
- Produces `QueryExecutor openPlatformDatabase({required String databaseName})`; native opens the current `NativeDatabase.createInBackground` file, web opens Drift `WasmDatabase` using the shipped `/sqlite3.wasm` and `/drift_worker.dart.js` assets.
- Web storage policy returns persistent OPFS/IndexedDB modes, reports when the selected mode is single-tab IndexedDB, and throws `PersistentStorageUnavailableException` for `WasmStorageImplementation.inMemory`.
- `database_provider.dart` and `AppDatabaseLifecycle` continue to own one `AppDatabase`; callers and repositories do not become platform-aware.

- [ ] **Step 1: Write failing storage policy tests** for every persistent `WasmStorageImplementation`, the single-tab notice mode, and rejection of `inMemory`.
- [ ] **Step 2: Run the focused test** with `flutter test test/core/database/web_storage_policy_test.dart`; confirm the policy type/function is missing.
- [ ] **Step 3: Add the conditional platform connection files** and route `database_provider.dart` through `openPlatformDatabase(databaseName: AppConstants.databaseName)`; preserve native path and background opening exactly.
- [ ] **Step 4: Add failing Chrome persistence test** that opens a uniquely named web database, writes a row, closes it, reopens it on the same origin, and reads the same row.
- [ ] **Step 5: Run the browser test** with `flutter test --platform chrome test/web_database_persistence_test.dart`; confirm web target/assets are not configured yet.
- [ ] **Step 6: Add Flutter web scaffold and compatible database assets.** Compile `drift_worker.dart` with Dart 3.5.4 `dart compile js -O4`; use a sqlite3 2.4.5-compatible WASM binary and confirm its source/version before copying it into `web/`. Keep dependencies locked.
- [ ] **Step 7: Implement `WasmDatabase.open` in the web connection**, inspect `chosenImplementation`, close and reject `inMemory`, and expose a clear single-tab warning for `unsafeIndexedDb`.
- [ ] **Step 8: Show persistence initialization failures in Splash** with a retry action and the persistent-storage/private-browsing guidance; do not route database failures to first-run setup.
- [ ] **Step 9: Run `flutter test --platform chrome test/web_database_persistence_test.dart`** and confirm close/reopen persistence passes.
- [ ] **Step 10: Run `flutter build web`** and confirm native-only `dart:io`/`NativeDatabase` imports are excluded from web output.


