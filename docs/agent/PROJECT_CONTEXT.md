# Project context

Audited 2026-10-15 from the source tree and the project requirements.

## Product and stack

WM_APP is an offline-first Flutter app for a small business to manage products, stock, sales, purchases, customer/supplier balances, cash, expenses, receipts, reports, and backup. The intended initial use is one local business and admin, without cloud sync or multiple users.

- Flutter 3.24.5 / Dart 3.5.4.
- Riverpod 2.x for dependency injection and state.
- Drift with local SQLite for persistence.
- On web, the same Drift database schema uses bundled `sqlite3.wasm` and an IndexedDB-backed VFS; every browser profile has its own origin-local database.
- GoRouter for navigation.
- flutter_secure_storage and device plugins are dependencies; their presence does not prove a feature is wired or secure.
- 21 Drift tables, 18 repositories, 15 services, 37 presentation screens, 19 feature directories, and a consolidated lib/models/models.dart file.

## Structure and data flow

- lib/main.dart initializes Flutter and ProviderScope; lib/app.dart watches the router provider and builds MaterialApp.router.
- lib/core/routing/app_router.dart declares routes and the bottom-navigation shell.
- lib/core/database/app_database.dart defines the Drift schema. Schema version is 1, foreign keys are enabled, and onUpgrade is currently empty.
- lib/core/database/ledger.dart centralizes stock and cash movements, receipts, audit records, and rounding helpers.
- lib/data/repositories contains database access; lib/services contains business operations; lib/core/providers supplies Riverpod providers; lib/features contains screens.
- Sale, purchase, payment, expense, and stock-adjustment services use Drift transactions for multi-record changes. Their intended flows combine records and ledger operations, but the baseline has no meaningful business-logic test coverage.
- The current feature UI is mostly placeholder/mock data. Mission 03 added a shared Material 3 design foundation and adaptive shell; Mission 06 refined Dashboard, Inventory, and Product list presentation without wiring business workflows. Provider/service references in feature screens remain limited to splash and login; setup, dashboard, and most other screens are not connected.
- Mission 05 added browser file adapters and a wired Backup & Restore screen. `.wmbak` portable backups snapshot all 21 Drift tables in versioned JSON and restore transactionally after validation. Web storage is local to the browser profile, has no sync, and uses a single-tab IndexedDB mode with a visible warning.

## Verified gaps and risks

1. **PIN security:** lib/services/auth_service.dart encodes the fixed string wm_salt_ plus the PIN as Base64. This is reversible encoding, not a password hash, and has no per-record salt or work factor. It is a high-priority pre-release issue.
2. **Setup persistence and access:** lib/features/setup/presentation/setup_wizard_screen.dart routes to the dashboard without saving the collected setup values; Skip does the same. The router has no global authentication redirect, so protected routes are not guarded centrally.
3. **Navigation:** several screen paths do not match app_router.dart, including dashboard inventory shortcuts and the product edit path.
4. **Mock state:** Mission 06 now labels Dashboard figures and Inventory/Product examples as preview data and avoids fabricated totals/activity. Most business screens remain mock/unwired; scanner lookup is not implemented.
5. **Backup restore:** the Mission 04 repair now checks integrity, foreign keys, schema version, and a full SQLite schema signature from a fresh in-memory `AppDatabase`, then stages, closes, replaces, reopens, and rolls back on failure. Temporary-database tests cover invalid files, missing primary/unique constraints, an unexpected financial trigger, valid reopen, and injected reopen failure. Android/device behavior and concurrent restores remain unverified.
6. **Money representation:** persisted money uses REAL and Dart double. The rounding helper does not itself establish exactness for every intermediate calculation or currency.
7. **Tests:** the splash smoke test fails because its two-second Future.delayed leaves a pending fake timer. Two backend integrity tests currently need `sqlite3.dll` on Windows. Focused UI coverage passes, but service/repository/financial-integrity coverage remains limited.
8. **Route/auth and history:** hard deletes exist for some master data; foreign keys may restrict referenced records. Source inspection did not find physical delete paths for sales, purchases, cash, stock, receipts, expenses, payments, or audit history. Verify these guarantees with tests before release.

## Codebase Memory index

The local Codebase Memory graph for WM_APP was indexed on 2026-10-15 in moderate mode: 1,584 nodes and 4,865 edges. It found AuthService.hashPin and its login/createAdmin/changePin callers. Static Dart call resolution is best-effort: the graph did not resolve every ledger caller. Verify graph claims against source.

The index excluded .dart_tool, .idea, assets, and build by design, plus generated/ignored files and selected document formats. android/settings.gradle was partially parsed at lines 6 and 8. The project has no Git repository, so re-index manually after source changes rather than expecting Git-based watching.

## Suggested work sequence

1. Replace the deterministic PIN encoding with a vetted salted KDF and a safe, tested legacy migration.
2. Persist initial business/admin setup atomically, then route into login; add centralized route protection and first-run tests.
3. Add service-level tests for sales, purchases, payments, stock, cash reversals, audit history, and rounding.
4. Reconcile route paths, then wire real repositories/services into screens and remove placeholders in bounded feature slices.
5. Decide currency precision and a future-proof exact money representation before broadening supported currencies.

## Mission 02 audit update (2026-10-15)

- Full 58-section PRD classification and service/repository/database review: `docs/agent/BACKEND_AUDIT.md`. Classification coverage is 58/58 sections, not an implementation percentage. PRD §23/final scope defers customer-credit work, while §§51–58 specify it; product scope needs a decision.
- Release blockers confirmed in source: `BackupService.restoreBackup` accepts any nonempty file and overwrites the open database; `AuthService.hashPin` is reversible fixed-prefix Base64. Do not test restore using real business data.
- Financial services commonly use Drift transactions, but sales/purchases accept invalid signed values and overpayments; repository-level void/stock-history methods can bypass reversals. Cash opening/bank accounting, reminder execution, and customer collection receipt/void paths are incomplete.
- Only login and splash currently consume providers from feature screens; setup is not persisted and the dashboard is placeholder data. Broad UI integration is not ready.
- Mission 02 added `test/backend_integrity_audit_test.dart` using only `NativeDatabase.memory()`. Its Flutter invocation did not return output, so it is not verified and must not be counted as passing coverage.
- Current Codebase Memory index after the Mission 03 UI changes: 1,602 nodes / 4,937 edges; static call resolution remains heuristic. The index does not include `docs` and has a partial parse in `android/settings.gradle` lines 6 and 8.

## Mission 03 UI foundation update (2026-10-15)

- Loop 1 updated shared colors/theme, design tokens, common states/summary cards, responsive shell, and Dashboard presentation sizing; five existing routes and scanner navigation remain available. Nine focused UI checks pass, including production route coverage, amount contrast/text scaling, and Dashboard layout at 320×700, 390×844, and 1024×900, with 2× text at 390×844.
- Dashboard presentation now fits these tested widths and enlarged text. It still uses placeholder values and has no provider integration; no financial workflows were added.
- The complete 37-screen/19-feature inventory and blocker matrix is in `docs/agent/UI_UX_PLAN.md`; current test/analyzer results are in `docs/agent/UI_IMPLEMENTATION_STATUS.md`.
- No feature/backend integration was added. Loop 2 stays gated by the backup-restore and PIN P0s, setup persistence, route protection, and dashboard data readiness.
- Codebase Memory was re-indexed after the final responsive source changes: 1,602 nodes / 4,937 edges. Graph relationships remain static hints, `docs` is excluded, and `android/settings.gradle` lines 6 and 8 partially parse.

## Mission 04 backup-restore update (2026-10-15)

- The restore P0 has been repaired and verified. The validator compares the candidate's tables, indexes, triggers, and views to a fresh in-memory `AppDatabase`, in addition to SQLite integrity, foreign-key, version, table, and column checks. Restore stages the candidate and supports rollback after replacement/reopen failure.
- The latest Codebase Memory index has 1,621 nodes / 5,001 edges. It excludes `docs`; `android/settings.gradle` lines 6 and 8 remain partially parsed. Static call relationships remain hints to verify against source.
- Next implementation task is the P0 admin PIN KDF and safe legacy migration; Android/device restore behavior and concurrent restores remain unverified.

## Mission 05 web MVP update (2026-10-16)

- The web database opens `IndexedDbFileSystem` directly from the main page using `WasmSqlite3` and `WasmDatabase`. In the tested Chromium environment, Drift's worker compatibility probe stalled; the direct IndexedDB VFS passed close/reopen and browser-reload persistence checks.
- The browser app loaded its first-run setup and backup routes with no console errors. The single-tab notice is set for the selected `unsafeIndexedDb` mode. Browser storage clearing/private-browsing warnings are present in Backup & Restore.
- `flutter build web` passed; the served WASM response is `application/wasm`. 33 focused regression tests passed. Full-suite failures and analyzer telemetry limitation are recorded in `DEVELOPMENT_STATE.md`.
- Remaining product gaps are unchanged: admin PIN hardening/migration, setup persistence, route protection, financial validation, and placeholder business workflows. Do not infer that the rest of the app is business-ready from a successful web build.

## Mission 06 mobile UI update (2026-10-16)

- Shared theme/shell polish and presentation updates cover Dashboard, Inventory, and Product list. Dashboard preview data remains explicit; the six primary actions stay in the grid and Scan is in the header. Inventory Scan and Product Add remain in their screen app bars.
- The 15-test focused UI suite passes. Full-suite failures remain the two Windows `sqlite3.dll` loads and the pre-existing Splash pending-timer test. Analyzer output has info-only lints; exact command results are recorded in `DEVELOPMENT_STATE.md` and `UI_REDESIGN_PROGRESS.md`.
- This pass changed no business services or persistence. Most feature screens remain placeholders. Continue with salted/versioned admin PIN KDF and safe legacy migration before broad UI integration.

