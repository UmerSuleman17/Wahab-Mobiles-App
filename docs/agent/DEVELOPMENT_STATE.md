# Development state

Updated 2026-10-16. The 2026-10-15 bootstrap notes below are historical baseline; later mission checkpoints record subsequent work. No business data was changed during these UI tasks.

## Workspace state

- Workspace: C:\Users\DEEL\Desktop\WM_APP
- No .git directory was present. Per the mission, Git was not initialized.
- No dependency versions were upgraded. `sqlite3` 2.4.5 was promoted from transitive to direct because restore validation now uses its read-only SQLite API; `flutter pub get` completed successfully.
- Agent guidance and audit notes were added in AGENTS.md and docs/agent/.

## Baseline commands

| Command | Result |
| --- | --- |
| flutter doctor -v | Command completed. Flutter 3.24.5 stable / Dart 3.5.4. Android SDK/Android Studio and Visual Studio C++ workload are missing; Chrome and Windows/Chrome/Edge devices are available. |
| flutter pub get | Passed; dependencies resolved without upgrades. Pub reported 99 newer incompatible versions. |
| dart analyze lib | Exit 0; 32 info-level lints, no warnings or errors. |
| flutter analyze | Exit 1 because of the same 32 info-level lints; no warnings or errors. |
| flutter test | Exit 1. The existing WmApp smoke test fails because the splash screen's two-second Future.delayed leaves a pending fake timer at test teardown (lib/features/splash/presentation/splash_screen.dart:23). |

The analyzer findings were not changed in this audit. Platform builds were not attempted because the Android SDK and Windows C++ toolchain are unavailable.

## Requested development tools

- **Superpowers:** installed at C:\Users\DEEL\.codex\superpowers, checkout bb92a77. The C:\Users\DEEL\.agents\skills\superpowers junction points to its skills directory; 15 skill directories were verified. Restart Codex to discover these skills in future sessions.
- **Ponytail:** Codex plugin ponytail@ponytail 5.2.0 is installed and enabled from the DietrichGebert/ponytail marketplace. Its manifest registers Node hooks for SessionStart, SubagentStart, and UserPromptSubmit. Review and trust them in Codex's /hooks UI, then restart Codex so the plugin is loaded.
- **Codebase Memory MCP:** version 0.11.0 installed at C:\Users\DEEL\AppData\Local\Programs\codebase-memory-mcp\codebase-memory-mcp.exe. Codex's global MCP entry is named codebase_memory and is restricted to this workspace through CBM_ALLOWED_ROOT. The official Windows installer was inspected and run with --skip-config, so it did not configure another client. The graph was indexed and queried during this audit. Re-index manually after changes because this workspace has no Git repository.

Existing Codex configuration was preserved; the requested marketplace/plugin and MCP entries were added without replacing the file.

## Current top risks

1. Deterministic reversible PIN encoding in AuthService.
2. Setup wizard does not persist business/admin setup; router has no global auth guard.
3. Financial inputs and accounting boundaries remain insufficiently validated.
4. Business-logic coverage is still narrow; the existing splash smoke test has a pending-timer failure.
5. Most screens remain mock/unwired; navigation paths are inconsistent.
6. REAL/double money storage and arithmetic need a documented currency-precision decision and tests.

## Mission 02 backend audit update

Updated 2026-10-15. The audit is recorded in `docs/agent/BACKEND_AUDIT.md`; no production application code or business data was changed. One test-only file was added using an in-memory database.

- Classified all 58 numbered PRD sections; no overall completion percentage was inferred. The PRD conflicts on customer/credit MVP scope (§23/final scope versus §§51–58).
- Confirmed P0 risks: `BackupService.restoreBackup` accepts any nonempty file and copies it over the active DB; `AuthService.hashPin` stores reversible fixed-prefix Base64.
- Confirmed additional gaps: unvalidated sale/purchase amounts and quantities, public repository write paths that bypass ledger reversals, no opening/bank ledger treatment, reminders marked sent without delivery, incomplete customer collection receipts/voiding, and a transaction history repository that omits cash/stock and ignores the product filter.
- At the Mission 02 checkpoint, Codebase Memory contained 1,587 nodes / 4,890 edges after indexing the audit test. Dart call edges remain heuristic and were checked against source.
- Repeated `flutter doctor -v`, `flutter pub get`, and the new focused Flutter test did not return output in the current tool session; they remain unverified. `dart analyze lib` printed 32 info lints then exited due denied Dart telemetry file access. Prior baseline remains: doctor/pub-get passed; `dart analyze lib` had no warnings/errors; `flutter analyze` exited for those info lints; the only widget test failed on the splash screen's pending two-second timer.
- `test/backend_integrity_audit_test.dart` covers one cash sale and an insufficient-stock rollback with `NativeDatabase.memory()`. Its test command has no result yet; do not count it as passing.
- Next task is safe backup restore hardening (see `docs/agent/NEXT_TASK.md`), followed by versioned PIN KDF migration.

## Git baseline proposal

Before establishing version control, review local database/backup locations, ignored/generated content, and any secrets. Then decide which local data stays outside the repository and create an explicit ignore policy. Commit a reviewed source-and-document baseline only after that inventory. This proposal does not initialize Git.

## Mission 03 UI foundation checkpoint

Updated 2026-10-15. Added the Loop 1 design system and responsive shell in `lib/core/theme/` and `lib/core/widgets/`; no feature-level backend workflow was wired. The complete verified inventory is 37 screens across 19 feature folders and is documented in `docs/agent/UI_UX_PLAN.md`.

- Added `AppTokens`, updated the compatible `AppColors` palette and Material 3 theme, restyled shared states/summary cards, and retained the five GoRouter shell destinations with a bottom bar on narrow widths and a rail at 840 logical px and above.
- Added `test/design_system_test.dart`. Nine focused checks now pass, including amount contrast/text scaling, low-stock contrast, Dashboard layout at 320×700/390×844/1024×900 and at 2× text, and production-route validation for all five shell destinations plus scanner navigation. The contrast, default-size overflow, and enlarged-text overflow regressions were observed before their fixes.
- `dart format` on changed Dart sources: passed.
- `dart analyze lib`: exit 0 with 31 info-level lints and no warnings/errors. `flutter analyze`: exit 1 with those same 31 infos and no warnings/errors.
- Full `flutter test`: exit 1. All nine UI tests pass; both backend integrity tests fail because `sqlite3.dll` is not available to the Windows test runner; the existing `WmApp smoke test initializes` still fails on Splash's pending two-second timer.
- Dashboard summary cards and inventory overview were adjusted for phone widths and enlarged text without adding providers or changing placeholder data/actions; widget layout checks pass at 320×700, 390×844, 1024×900, and 390×844 with 2× text.
- No platform build or actual app screenshot was performed. The earlier doctor result reports missing Android SDK and Windows C++ workload; `flutter devices` lists Windows/Chrome/Edge, but web is not an equivalent runtime for this app's native SQLite persistence.
- Codebase Memory was re-indexed after the final responsive source changes: 1,602 nodes / 4,937 edges. It excludes `docs` and partially parses lines 6 and 8 in `android/settings.gradle`.
- Loop 2 remains blocked by the unresolved backup-restore and PIN P0 findings, setup persistence, route protection, and unverified dashboard data. Keep safe backup restore as the next implementation task.

## Mission 04 backup-restore safety checkpoint

Updated 2026-10-15. The P0 restore finding is repaired in source and covered by temporary-database tests. No real business database or backup was opened or changed.

- `BackupService.validateBackup` opens only the candidate in read-only mode and checks SQLite integrity, foreign-key violations, the candidate's `PRAGMA user_version`, and the complete table/index/trigger/view SQL signature against a fresh in-memory `AppDatabase` schema. It also checks all 21 Drift table names and expected columns. This rejects missing primary/unique constraints and unexpected database triggers.
- `restoreBackup` copies the selected file into a staging file beside the active database, validates that staged copy, closes the active Drift instance, saves the previous database for rollback, atomically renames the staged file into place, reopens and verifies it, and restores/reopens the previous file if replacement or reopen fails.
- `AppDatabaseLifecycle` owns the current Drift instance. Riverpod watches its state, so repositories and services receive the reopened instance after a successful restore.
- Backup and restore outcomes are written to `developer.log` using fixed outcome messages; selected file paths, database contents, PINs, and financial values are not included.
- `sqlite3` remains at locked version 2.4.5; it is now an explicit direct dependency. No database schema, money representation, or other dependency version changed.
- `test/backup_service_test.dart`: 13/13 pass, including missing/empty/non-SQLite/truncated files, unsupported version, missing tables/columns/primary and unique constraints, an unexpected cash deletion trigger, unchanged active data on rejection, successful close/reopen, and rollback after an injected reopen failure.
- `test/backend_integrity_audit_test.dart`: 2/2 pass with the local SQLite DLL available to the Windows test process; its database remains in-memory.
- Full `flutter test`: 24 pass, 1 existing failure (`WmApp smoke test initializes`) because Splash leaves its two-second timer pending at teardown. Backend tests ran with temporary test-only SQLite DLL resolution and used in-memory or temporary databases.
- `dart analyze lib test`: exit 0 with 31 existing info-level lints and no warnings/errors. `flutter analyze`: exit 1 because of the same 31 infos and no warnings/errors.
- The backup test uses Windows' system `winsqlite3.dll` override because a plain Flutter test host does not load the packaged SQLite plugin. This is test-only; the application still uses the existing `sqlite3_flutter_libs` runtime.
- Codebase Memory was re-indexed after the final validator changes: 1,621 nodes / 5,001 edges. It excludes `docs` and partially parses lines 6 and 8 in `android/settings.gradle`.
- The workspace still has no Git repository; none was initialized. Android/Windows application builds and real-device restore behavior were not tested.

The remaining P0 is admin PIN protection and legacy migration. Keep broad UI integration gated on that task plus setup persistence, route protection, financial validation, and dashboard data readiness.

## Mission 05 Flutter web MVP checkpoint (2026-10-16)

The approved web MVP now builds and runs locally. Native SQLite, repositories, services, and schema remain in place; the browser uses its own persistent database per origin/profile. No cloud sync or business-screen wiring was added beyond the Backup & Restore screen.

- `lib/core/database/platform_connection_web.dart` loads the bundled `sqlite3.wasm`, opens `IndexedDbFileSystem`, and creates Drift `WasmDatabase` directly in the page. The Drift worker probe stalled in the tested Chromium environment, so the web connector uses the main-thread IndexedDB VFS. It sets `unsafeIndexedDb` and the app shell displays the single-tab warning.
- Portable backups use `.wmbak`, UTF-8 JSON (`format: wm_app_backup`, `formatVersion: 1`, schema version, UTC export time, and all 21 table snapshots). Import validates before confirmation and replaces rows in one transaction. The native integrity-checked `.db` restore path remains available on IO platforms.
- Browser storage and private-browsing data-loss guidance is shown in Backup & Restore. Clearing site storage can permanently erase local browser data. Browser profiles remain independent; there is no sync.
- Focused regression tests: 33/33 passed across web storage policy, design/layout and routing, portable backup, native restore, and Backup & Restore widget behavior.
- Browser smoke harness passed data retention across close/reopen and a full page reload using IndexedDB. It removed its uniquely named smoke database. The actual app loaded the Setup Business route and the Backup & Restore route; browser console inspection found no errors.
- `flutter build web`: passed in 251.1 seconds. The local server serves `sqlite3.wasm` with `application/wasm`.
- `flutter test`: 34 passed, 3 failed. Two backend integrity tests could not load `sqlite3.dll`; the existing `WmApp smoke test initializes` fails because Splash leaves a two-second fake timer pending. The focused tests above passed.
- `dart analyze lib test`: reported 40 info-level lints and no warnings/errors, then exited nonzero because Dart could not update its telemetry session timestamp under `C:\Users\DEEL\AppData\Roaming\.dart-tool`. One info lint is `avoid_web_libraries_in_flutter` in the web download adapter.
- Live preview: `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8765`, at `http://127.0.0.1:8765`. Ports 8080 and 8081 returned Windows bind error 10048; 8765 succeeded. Keep the process session alive when handing off.
- The workspace still has no Git repository. Temporary worker/IndexedDB diagnostics remain preserved under `web/` and `.superpowers/sdd/`; do not treat them as product workflows.

The browser database and portable backup paths are verified for the bounded MVP. The app's business setup is still not persisted and most business screens remain placeholders. Continue with the P0 admin PIN KDF and safe legacy migration before broad UI integration.

## Mission 06 premium mobile UI checkpoint (2026-10-16)

The presentation-only pass refined the shared light theme and responsive shell, and redesigned Dashboard, Inventory, and Product list surfaces. The Dashboard has six primary quick actions and Scan in its header; Inventory keeps Scan in its app bar. Preview-only figures and rows remain clearly labeled. The global shell scanner FAB was removed because browser rendering showed it covering list content.

- Focused design-system suite: 15/15 pass. Full `flutter test --no-pub --reporter expanded`: 40 pass, 3 baseline failures (two backend integrity tests cannot load `sqlite3.dll`; the splash smoke test leaves a two-second fake timer pending).
- `dart analyze lib test`: exit 0 with 37 info-level lints and no warnings/errors. `flutter analyze`: exit 1 with 38 info-level lints and no warnings/errors.
- Browser visual QA covered Dashboard, Inventory, and Product list at 390×844. The final Dashboard shows the scanner header action and six primary actions. Native builds were not run because mobile toolchains are unavailable.
- Details and screen scope: `docs/agent/UI_REDESIGN_PROGRESS.md`. Most business screens remain mock/unwired. No service, repository, database, web storage, or business-rule changes were made in this UI task.

The next bounded task remains the P0 salted/versioned admin PIN KDF with safe legacy migration. Do not begin broad business UI wiring before that and the existing setup/access/accounting blockers are addressed.
