# Next implementation task

## Mission 06 premium mobile UI checkpoint (2026-10-16)

The bounded presentation pass is complete. Shared theme/navigation polish and Dashboard, Inventory, and Product list updates are recorded in `UI_REDESIGN_PROGRESS.md`. The browser preview remains live at `http://127.0.0.1:8765`. Focused UI tests pass (15/15); the full suite has 40 passes and the three documented baseline failures. Analyzer output contains only info-level lints. Most business screens remain unwired; this task did not change backend behavior.

## Next bounded task: secure admin PIN with legacy migration (P0)

Replace deterministic Base64 in `lib/services/auth_service.dart` with a vetted, salted, versioned KDF. Migrate a legacy value only after successful authentication and atomically; invalid PIN attempts must not alter stored credentials. Decide and document the KDF and platform support before adding a dependency or schema change. Test new credentials, correct/wrong PIN, migration, PIN change, malformed formats, and reopen using a temporary database.

The backup-restore P0 has already been repaired. After the PIN task, address setup persistence and route protection, financial input/accounting validation, and service-level integrity coverage before broad business UI integration. Do not replace these safety tasks with a large screen-wiring pass.

## Mission 05 web MVP checkpoint (2026-10-16)

The approved offline web target is implemented and running at `http://127.0.0.1:8765` (active Flutter web-server session). The release web build passed; 33 focused tests passed; the IndexedDB smoke test retained data across close/reopen and a page reload, then removed its isolated smoke database. The app loads Setup Business and Backup & Restore in the browser.

Full `flutter test` reports 34 passed and 3 failures: the two backend integrity tests lack `sqlite3.dll` in this runner, and the pre-existing splash smoke test leaves its two-second timer pending. `dart analyze lib test` reports 40 infos and no warnings/errors but exits nonzero after a denied Dart telemetry timestamp update in AppData. See `DEVELOPMENT_STATE.md` for details.

The web MVP uses per-profile IndexedDB, a visible single-tab notice, and version-1 `.wmbak` JSON backups. Manual import/export logic is covered by focused widget/service tests; the browser VFS persistence path is covered by the smoke harness. Most business screens remain intentionally unwired under the approved bounded scope. The workspace still has no Git repository.

## Mission 03 UI checkpoint (2026-10-15)

Loop 1's design-system foundation and Dashboard presentation-only responsive/accessibility correction are implemented; all nine focused UI tests pass. The tests verify production GoRouter shell/scanner paths, all five shell destinations, and Dashboard layout at 320×700, 390×844, and 1024×900, including 2× system text at 390×844. The complete 37-screen inventory, exact files, analyzer/test results, and visual-inspection limitation are recorded in `docs/agent/UI_UX_PLAN.md` and `docs/agent/UI_IMPLEMENTATION_STATUS.md`. No financial feature was newly wired.

The backup-restore P0 has been repaired and verified; the PIN P0 remains open. Loop 2 also remains gated by setup persistence, route protection, and dashboard data readiness. Do not replace the remaining backend safety task with a broad UI pass.

## Mission 04 backup-restore safety checkpoint (2026-10-15)

The P0 restore issue from `docs/agent/BACKEND_AUDIT.md` is repaired in `lib/services/backup_service.dart` and `lib/core/database/app_database_lifecycle.dart`.

- The candidate is staged beside the active database and checked read-only for SQLite integrity, foreign-key violations, supported `user_version`, all Drift tables/columns, and an exact schema signature from a fresh in-memory `AppDatabase` (tables, indexes, triggers, and views). This rejects same-version files that omit primary/unique constraints or add unexpected triggers.
- The active connection is closed before rename; a saved copy supports rollback; the restored database is reopened and checked before success is reported.
- `test/backup_service_test.dart` covers malformed/unsupported files, missing tables/columns/constraints, an unexpected cash deletion trigger, unchanged active data, close/reopen persistence, and rollback after an injected reopen failure. It uses only temporary database and backup files.
- Verification on 2026-10-15: focused restore tests 13/13 pass; backend integrity tests 2/2 pass; full suite 24 pass with the existing Splash pending-timer smoke-test failure; analyzers report only 31 pre-existing info-level lints.
- Backup and restore outcome logs contain only fixed status messages and no file paths or business data. `sqlite3` 2.4.5 was made a direct dependency without changing its version.

