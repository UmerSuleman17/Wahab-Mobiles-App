# WM_APP Flutter Web Offline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a persistent offline Flutter web target for WM_APP, portable manual backups, and a verified localhost run without changing the native database schema or business services.

**Architecture:** Keep `AppDatabase`, Riverpod lifecycle, repositories, and services shared. Select native file SQLite or Drift WASM behind a platform connection boundary; encode portable backups as a versioned logical snapshot and replace rows in one Drift transaction. Platform file selection/download stays in conditional adapters.

**Tech Stack:** Flutter 3.24.5 / Dart 3.5.4, Drift 2.19.1+1, sqlite3 2.4.5, Riverpod 2.5.x, `file_picker` 8.0.3 for native/web import and native save, and a conditional browser download adapter for web export.

**Spec:** `docs/superpowers/specs/2026-10-15-flutter-web-offline-design.md`

## Execution status (2026-10-16)

- Tasks 1–3 are implemented and their focused tests passed. The web connector uses a direct `IndexedDbFileSystem` VFS on the page because the Drift worker probe stalled in the tested Chromium environment; this replaces the worker-based steps below.
- The browser persistence harness passed close/reopen and page-reload checks. `flutter build web` passed, and the actual web app plus Backup & Restore route loaded on localhost.
- Task 4's focused verification and documentation are complete. Its browser check used the isolated persistence harness and Backup & Restore widget tests; a downloaded-file export/import round trip was not run in the browser. Full-suite and analyzer limitations are recorded in `docs/agent/DEVELOPMENT_STATE.md`.
- The requested 8080 port could not bind (Windows error 10048); the live app is at `http://127.0.0.1:8765`.

## Global Constraints

- WM_APP remains an offline-first app for one local business/admin; do not add cloud sync, multiple users, or shared cross-device databases.
- Preserve Flutter, Riverpod, Drift/SQLite, repository, service, and presentation boundaries.
- Keep stock, sale, purchase, payment, cash, receipt, and audit writes atomic and preserve reversible transaction history.
- Do not change schema version 1, money representation, or existing business-service rules.
- Do not upgrade existing dependency versions; add only `file_picker` 8.0.3 if required for portable file import/export.
- Reject in-memory web storage; keep persistent single-tab IndexedDB only with a visible single-tab notice.
- Continue accepting existing native `.db` backups through the current integrity-checked restore path; use `.wmbak` for new cross-platform backups.
- Tests use only in-memory or temporary databases, never real business data/backups.
- Do not initialize Git; the workspace has no `.git` directory.

## Review Focus

1. **Only in-memory browser storage is available:** test that database startup fails with a user-facing persistence error instead of silently opening ephemeral storage.
2. **Malformed, unsupported, or future-format `.wmbak`:** test that decode rejects it before any rows are changed.
3. **Duplicate keys or broken foreign-key rows in a valid-looking backup:** test that import rolls back and leaves the prior active rows unchanged.
4. **User cancels the restore confirmation or file picker:** widget tests assert no restore occurs and current data remains intact.
5. **An existing native raw `.db` backup is selected:** keep the existing native validator/lifecycle tests passing and assert the native-only path is not offered in web builds.

---

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

### Task 2: Add portable versioned backup codec and transactional restore

**Files:**
- Create: `lib/services/portable_backup_service.dart`
- Test: `test/portable_backup_service_test.dart`
- Use: `lib/core/database/app_database.dart`

**Interfaces:**
- `Future<Uint8List> exportBackup()` serializes a consistent read snapshot of all 21 tables to UTF-8 JSON.
- `PortableBackupSummary inspectBackup(Uint8List bytes)` validates format ID `wm_app_backup`, format version `1`, current schema version, exact table/column sets, and row shapes; returns UTC timestamp and per-table row counts without writing data.
- `Future<void> restoreBackup(PortableBackupSummary backup)` clears rows child-first, imports parent-first, checks foreign keys, and commits all changes in one Drift transaction.
- Backup JSON fields are `format`, `formatVersion`, `schemaVersion`, `exportedAtUtc`, and `tables`; database values remain SQL-level JSON scalar values.

- [ ] **Step 1: Write failing tests** for exporting all 21 tables and preserving IDs, exact money values, ledger entries, receipts, and audit rows through encode/inspect/restore.
- [ ] **Step 2: Run `flutter test test/portable_backup_service_test.dart`** and confirm the service/format API is missing.
- [ ] **Step 3: Write failing rejection/rollback tests** for invalid JSON, wrong format, unsupported format/schema versions, missing/extra tables or columns, duplicate IDs, broken foreign keys, and a failed import leaving pre-existing active rows unchanged.
- [ ] **Step 4: Implement snapshot encoding and `inspectBackup`** using the current Drift table metadata and a stable JSON envelope; do not serialize file paths or business values to logs.
- [ ] **Step 5: Implement `restoreBackup`** as one Drift transaction with child-first delete, parent-first insert, and foreign-key validation before commit.
- [ ] **Step 6: Run `flutter test test/portable_backup_service_test.dart`**; all round-trip, validation, and rollback tests must pass.

### Task 3: Add platform backup file handling and connect Backup & Restore UI

**Files:**
- Create: `lib/core/backup/backup_file.dart`, `lib/core/backup/backup_file_adapter.dart`, `lib/core/backup/backup_file_adapter_stub.dart`, `lib/core/backup/backup_file_adapter_io.dart`, `lib/core/backup/backup_file_adapter_web.dart`
- Create: `lib/core/providers/legacy_backup_restorer.dart`, `lib/core/providers/legacy_backup_restorer_factory.dart`, `lib/core/providers/legacy_backup_restorer_factory_stub.dart`, `lib/core/providers/legacy_backup_restorer_factory_io.dart`
- Modify: `pubspec.yaml`, `pubspec.lock`
- Modify: `lib/services/backup_service.dart` (implement the shared native legacy restore interface without changing its validation/replacement algorithm)
- Modify: `lib/core/providers/service_providers.dart`, `lib/core/providers/service_providers.g.dart`
- Modify: `lib/features/settings/presentation/backup_restore_screen.dart`
- Test: `test/features/backup_restore_screen_test.dart`

**Interfaces:**
- `PickedBackupFile` contains `name`, `Uint8List? bytes`, and `String? nativePath`.
- `BackupFileAdapter.pickBackup()` returns one `.wmbak` file on web and `.wmbak` or legacy `.db` on native; `saveBackup(bytes, suggestedName)` downloads in web and uses the native save dialog on IO.
- `LegacyBackupRestorer` exposes only `Future<bool> validateBackup(String path)` and `Future<void> restoreBackup(String path)`; its platform factory returns `null` on web and the existing `BackupService` on IO.
- A shared `portableBackupServiceProvider` exposes the API from Task 2. Remove the unused generated native `backupServiceProvider` from the shared provider file so web compilation cannot import `dart:io` through it; keep direct native `BackupService` use and tests.

- [ ] **Step 1: Add widget tests** verifying export invokes the platform adapter, invalid imports show an error, cancel leaves data untouched, and confirmed import displays the file timestamp/row counts and runs restore once.
- [ ] **Step 2: Run `flutter test test/features/backup_restore_screen_test.dart`** and confirm the Backup & Restore UI is currently inert.
- [ ] **Step 3: Add `file_picker` 8.0.3 as a direct dependency** without changing existing dependency versions; run `flutter pub get` and inspect the lockfile for unrelated version changes.
- [ ] **Step 4: Implement conditional file adapters.** Native uses `FilePicker` for read/save paths; web uses picker bytes for import and a browser download for export because `file_picker` 8.0.3 does not implement web `saveFile`.
- [ ] **Step 5: Add the IO-only legacy restore factory** that injects the current `AppDatabaseLifecycle` close/reopen callbacks; web uses the null stub.
- [ ] **Step 6: Wire the screen** to real `.wmbak` export/import, display export metadata before confirmation, preserve the native `.db` restore branch, remove the fabricated last-backup date, and show storage clearing/private-window/sensitive-file guidance.
- [ ] **Step 7: Regenerate `service_providers.g.dart`** with the project's locked `build_runner` because a Riverpod-annotated provider changed; confirm unrelated generated code is unchanged.
- [ ] **Step 8: Run `flutter test test/features/backup_restore_screen_test.dart test/backup_service_test.dart`**; UI tests and all existing native restore safety tests must pass.
- [ ] **Step 9: Run `flutter build web`** and confirm file-picker web imports compile while IO legacy restore code is excluded.

### Task 4: Verify offline behavior, update project state, and serve localhost

**Files:**
- Modify: `docs/agent/DEVELOPMENT_STATE.md`
- Modify: `docs/agent/DECISIONS.md`
- Modify: `docs/agent/NEXT_TASK.md`
- Modify: `docs/agent/PROJECT_CONTEXT.md` only if verified architecture/limitations changed

**Interfaces:**
- Uses the web database, portable backup service, and file adapters from Tasks 1–3. No new runtime API is introduced here.

- [ ] **Step 1: Run `dart analyze lib test`** and fix all new warnings/errors; existing info-level findings may remain documented.
- [ ] **Step 2: Run focused backend tests and the browser persistence test**; use only in-memory/temporary test data and record exact counts/results.
- [ ] **Step 3: Run `flutter build web`** and inspect that `build/web` contains the worker, WASM module, and Flutter service worker; confirm `.wasm` is served as `application/wasm`.
- [ ] **Step 4: Start the app in Chrome via the web-server target** and use the backup screen to exercise file export, malformed import rejection, cancel confirmation, and confirmed restore. Reload the same origin and verify browser-local data persists.
- [ ] **Step 5: Run `flutter test`** and report both new results and any known baseline failures; do not count an old failure as a regression.
- [ ] **Step 6: Update the four project agent notes** with the web storage boundary, portable backup format/version, browser data-loss warning, build/test outcomes, local run command, and remaining screen-wiring/PIN-security limitations.
- [ ] **Step 7: Start `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080`**, probe `http://127.0.0.1:8080`, and keep the live session running for the user.

## Plan self-review

- **Spec coverage:** Tasks 1–4 cover conditional native/web database selection, persistent storage rejection/notice, local web target, portable versioned exports, transactional restore, metadata confirmation, native `.db` compatibility, backup warning copy, cross-platform browser testing, and project-state updates.
- **Step scan:** Each task has failing tests before implementation and explicit commands/results. The worker/WASM versions, format keys, restore transaction order, file adapter result type, and native legacy boundary are fixed above.
- **Type consistency:** Task 1 exports `openPlatformDatabase`; Task 2 exports `PortableBackupService`/`PortableBackupSummary`; Task 3 consumes those APIs and defines the file/legacy interfaces; Task 4 consumes the completed runtime.
- **Review focus:** All five risks at the top map to storage policy, codec/restore, widget confirmation, or existing native restore tests.
- **Proportion:** Four sequential tasks keep the web runtime, codec, UI adapter, and end-to-end verification independently reviewable while preserving dependencies among their interfaces.

No commit step is included because this workspace has no Git repository and the project instructions prohibit initializing one without a separate product decision.
