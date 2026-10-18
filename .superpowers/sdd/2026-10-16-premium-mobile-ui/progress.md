# SDD ledger — plan: docs/superpowers/plans/2026-10-16-premium-mobile-ui.md

## Setup

- Read `AGENTS.md`, the four required `docs/agent` context files, the full `PRD/PRD_APP.txt`, the UI inventory/status, the existing UI foundation plan, and the backend audit findings.
- Read source for the app router, theme/tokens/shared widgets, Dashboard, Inventory, Product list, app shell, and existing UI tests. Codebase Memory graph/architecture confirmed the feature/core boundary; source was checked directly.
- Workspace has no `.git` directory. No worktree can be created without violating `AGENTS.md`'s instruction not to initialize Git without a separate user decision.
- Ruling: keep implementation in the existing user workspace — the user explicitly requested in-place changes, and Git/worktree isolation is unavailable without a separate Git decision — cost if wrong: unrelated files cannot be restored through Git.
- Ruling: replace the persistent scanner FAB with a Dashboard header button and Inventory app-bar action, and move Product add to its app bar — rendered 390 px QA showed the FAB covers Inventory/Product rows; keep each action on the screen it serves — cost if wrong: Scan is less direct from other screens, but remains one tap from Dashboard/Inventory.
- Ruling: keep exactly six primary actions in the Dashboard grid and place Scan in the header — this matches the six specified frequent workflows and reduces grid clutter — cost if wrong: Scan is not a grid tile.
- No dependencies, schemas, services, repositories, or financial calculations are in this presentation-only scope.

## Task 1: UI acceptance tests

- Added checks for the theme palette, explicit Dashboard preview state and absence of fake PKR/activity rows, actual quick-action route navigation, preview badges in Inventory/Product list, and responsive layouts including 2× text.
- RED run: `flutter test --no-pub --reporter expanded test/design_system_test.dart` compiled and executed. The expected assertions failed: canvas palette differs, Dashboard has no preview data/action labels, Inventory overflows by 206 px at 390 px width, and preview labels are absent. Existing responsive Dashboard and shell tests still ran.
- RED confirmed: 13 checks passed before the new header-scan assertion failed because the Dashboard did not yet expose the `Scan barcode` control.
- GREEN: all 15 focused design-system tests pass after the header control and six-action grid were implemented.

## Decisions

- Replace dashboard financial placeholders with em-dash values and a visible preview badge; do not reinterpret the old `PKR 0` values as live data.
- Keep supplier payments and Add supplier out of Dashboard quick actions; the six specified core actions have priority, and supplier navigation remains elsewhere in the app.
- Any sample inventory/product rows changed in this loop must remain explicitly labeled as preview content; do not add provider/service integration.

## Verification

- `dart format lib/features/dashboard/presentation/dashboard_screen.dart test/design_system_test.dart`: completed; only the test file required formatting.
- Focused `flutter test --no-pub --reporter expanded test/design_system_test.dart`: 15/15 passed.
- Full `flutter test --no-pub --reporter expanded`: 40 passed, 3 baseline failures. Two `backend_integrity_audit_test.dart` cases cannot load `sqlite3.dll`; `WmApp smoke test initializes` leaves the Splash two-second timer pending.
- `dart analyze lib test`: exit 0, 37 info-level lints, no warnings/errors. `flutter analyze`: exit 1 with 38 infos, no warnings/errors (37 same project infos plus one in the web smoke tool).
- Browser visual QA at 390×844 covered Dashboard, Inventory, and Product list. The final Dashboard screenshot showed the header Scan control and six primary actions; Inventory/Product no longer have a floating control covering list rows. Browser is only a rendering surface; Android/iOS native builds were unavailable because SDK/toolchains are not installed.
- Local Flutter web preview remains available at `http://127.0.0.1:8765` with Dashboard open. No business services or workflows were wired.
