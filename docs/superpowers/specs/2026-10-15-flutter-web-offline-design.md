# WM_APP Flutter Web Offline Design

## Goal

Run WM_APP as a real Flutter web application on localhost, with persistent browser-local Drift storage and manual backups that can move between the browser and the existing native app. Keep the app offline-first, single-business, and on its current Flutter/Riverpod/Drift architecture.

## Grounding in the current source

- Flutter is pinned at 3.24.5 / Dart 3.5.4. `drift` resolves to 2.19.1+1 and `sqlite3` to 2.4.5.
- `AppDatabase` is a platform-neutral Drift schema at schema version 1 with 21 tables.
- `database_provider.dart` currently opens a native file through `dart:io`, `path_provider`, and `NativeDatabase`.
- `BackupService` currently handles native SQLite files and already has integrity, foreign-key, schema-signature, staging, close/reopen, and rollback checks.
- `BackupRestoreScreen` is placeholder UI. Existing product screens are largely not connected to providers/services; this design does not claim to finish that separate integration work.
- Product constraints remain one local business/admin, no automatic sync, no cloud, and no schema or money-representation change.

## Recommended approach

Add a platform-specific Drift connection boundary while keeping `AppDatabase`, repositories, services, and business rules shared. Native builds continue opening the existing database file. Web builds use the locked Drift 2.19.1+1 `WasmDatabase` with the locked sqlite3 2.4.5-compatible WASM asset and a worker compiled from the locked Drift source. Do not upgrade dependencies for this work.

Drift chooses a browser storage implementation. Allow persistent OPFS and IndexedDB modes, including its persistent single-tab fallback with a clear single-tab notice; reject in-memory mode so business writes are never silently volatile. Show a concise data-safety message in Backup & Restore: browser data belongs to this origin and profile, clearing site storage can erase it, private browsing may not retain it, and regular backups are recommended. There is no sync between profiles, origins, or native devices.

### Portable backup format

New manual exports use one versioned `.wmbak` JSON format on native and web. The envelope contains a format identifier, `formatVersion`, `schemaVersion`, UTC export time, and every Drift table with its SQL-level rows. It preserves primary keys, timestamps, ledger rows, receipts, audit records, and financial values without changing their stored representation. A format version is distinct from the Drift schema version.

Before restore, decode and validate the format identifier, supported versions, exact expected table set and columns, and row shapes; show the export timestamp and table/row counts; then require an explicit replace-data confirmation. Apply replacement in one Drift transaction, deleting child rows before parents and inserting parents before children. Run foreign-key validation before commit. Any malformed row, uniqueness/FK failure, or storage error rolls the transaction back, leaving the active data unchanged.

New native and web exports use `.wmbak`. Keep the existing validated native `.db` restore path for already-created native backups. Browser restore accepts `.wmbak`; cross-platform transfers use that portable format. Do not add an unencrypted backup-password flow in this task; clearly treat exported backups as sensitive files, consistent with the existing native database backup behavior.

### Platform boundaries

- Move native-only imports behind a conditional database connection boundary so web compilation never imports `dart:io` or `NativeDatabase` through the provider.
- Keep database lifecycle/Riverpod ownership shared so repository and service providers continue to watch the active database.
- Split backup file selection/save mechanics by platform, but keep portable encoding, validation, and transactional restore in shared Dart code.
- Connect the Backup & Restore screen to actual export/import behavior and remove its fabricated backup timestamp. Do not rework unrelated business screens or business services.
- Existing app services remain database-local and require no internet. The web shell and business data can be operated while offline after the app assets are available; WhatsApp and external sharing remain external integrations.

## Alternatives considered

1. **Recommended: conditional web database plus shared versioned row backup.** Keeps existing Drift schema/services and provides a portable backup independent of native paths or browser storage internals.
2. **Copy raw SQLite files everywhere.** Works with the current native service, but Drift's browser persistence is behind a browser VFS/worker and does not expose a simple native file path for reliable export/import.
3. **Memory-only web preview.** Easy to serve but loses data on reload and fails the explicit offline-storage requirement.

## Acceptance criteria

1. `flutter build web` succeeds without importing native-only filesystem or SQLite APIs into the web target.
2. `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080` serves the app at `http://127.0.0.1:8080`.
3. Browser startup chooses persistent profile storage or reports that persistent storage is unavailable; it never silently continues with an in-memory database.
4. A web database write survives app/database close and browser reload on the same origin/profile. Different browser profiles remain independent.
5. Core database/service behavior stays local and offline; no cloud or synchronization dependency is added.
6. A native `.wmbak` export restores in web and a web export restores in native. Restore preserves all 21 tables and their row values, including ledger, receipt, and audit history.
7. Unsupported versions, malformed files, unexpected tables/columns, and failed imports are rejected without changing active data. User confirmation occurs before data replacement.
8. The existing native `.db` restore validation and rollback behavior continue to work.
9. Backup UI explains per-origin/profile storage, clearing-storage loss, and private-browsing limits; it contains no fabricated backup status.
10. No business schema, money representation, cloud behavior, or dependency version changes. Tests use only in-memory or temporary databases.

## Verification

- Focused portable-backup codec and restore tests using in-memory/temporary databases.
- Existing native backup restore tests.
- `dart analyze lib test` and `flutter build web`.
- Browser smoke test in Chrome: write a test record, close/reopen or reload on the same origin, confirm it remains; exercise export, rejected invalid import, confirmed valid restore, and reload again.
- Start the web-server process only after build and browser smoke checks pass, then confirm the localhost response before sharing the link.

## Risks and limitations

- This project currently has mostly placeholder/unwired screens. The web/runtime task provides persistent storage to the existing database/service architecture and working backup controls; it does not make every business screen operational. A separate bounded screen-integration task is still needed for end-to-end workflows.
- Browser storage can be cleared or evicted by the user/browser. This cannot be prevented; backups remain the recovery mechanism.
- Legacy raw `.db` import remains native-only. `.wmbak` is the cross-platform transfer format.
- The existing admin PIN representation is a documented pre-release security defect. This task does not copy or reimplement that algorithm; localhost use is for development only until the separate PIN hardening task is completed.
- A WASM binary must match sqlite3 2.4.5 and the worker must be compiled from the locked Drift package. Verify the asset provenance and MIME type in the actual Flutter build.
