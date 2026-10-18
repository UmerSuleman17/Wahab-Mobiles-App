# Premium Mobile UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refresh the shared mobile presentation, Dashboard, and inventory browsing screens into a premium, responsive business interface without changing business behavior.

**Architecture:** Keep the existing Material 3 theme, Riverpod feature boundaries, GoRouter routes, and screen files. Use the design tokens already present, add only the presentation needed for this loop, and mark disconnected examples as preview content.

**Tech Stack:** Existing Flutter/Dart, Material 3, Riverpod, GoRouter, and Flutter widget tests; no new dependencies.

**Spec:** `docs/agent/UI_DESIGN_SYSTEM.md` and the user's Mission UI/UX Transformation brief.

## Global Constraints

- Target Android and iOS mobile experiences; the browser is a visual check surface only.
- Keep the single-admin, offline-first product; do not add sync or another persistence model.
- Preserve the existing Flutter, Riverpod, Drift/SQLite, repository, service, and presentation boundaries.
- Do not invent financial values, fake successful business operations, or wire unverified providers/services.
- Preserve existing GoRouter destinations and scanner access; no dependency upgrades or schema changes.
- Keep the unresolved PIN security issue visible in handoff notes; presentation changes do not clear it.
- Do not initialize Git; this workspace has no repository.

## Review Focus

- 320 px width and 2× text scaling: no clipped labels, RenderFlex overflow, or inaccessible controls.
- Disconnected dashboard data: preview state is visible and financial amounts/activity are not fabricated.
- Dashboard quick actions: destinations match registered GoRouter routes.
- Inventory/Product mock rows: preview labeling remains visible while scrolling and amounts are not styled as verified balances.
- Existing web storage notice and five shell destinations remain intact after shell styling.

---

### Task 1: Pin the premium mobile presentation contract with widget tests

**Files:**
- Modify: `test/design_system_test.dart`

**Interfaces:**
- Consumes: current `AppTheme`, `AppScaffold`, `DashboardScreen`, `InventoryScreen`, and `ProductListScreen`.
- Produces: focused tests for explicit preview states, valid Dashboard destinations, and phone/wide/text-scale layout safety.

- [x] **Step 1: Add the failing assertions**
  - Verify the Dashboard communicates that figures are preview/unavailable and contains no `PKR 0` fake totals or sample activity rows.
  - Verify each Dashboard quick action targets an actual registered route.
  - Verify Inventory and Product list visibly label their current examples as preview data.
  - Pump the three screens at 320×700, 390×844, and 1024×900, including 2× phone text, and assert no Flutter exception.
- [x] **Step 2: Run the focused test and record the expected failure**
  - Run `flutter test --no-pub --reporter expanded test/design_system_test.dart`.
  - Expected: new acceptance assertions fail on current generic Dashboard/list UI; the existing baseline tests still execute.

### Task 2: Refine the shared light theme and mobile shell

**Files:**
- Modify: `lib/core/theme/app_colors.dart`
- Modify: `lib/core/theme/app_theme.dart`
- Modify: `lib/core/widgets/app_scaffold.dart`
- Modify: `test/design_system_test.dart`

**Interfaces:**
- Consumes: existing `AppColors`, `AppTokens`, five navigation routes, and scanner route.
- Produces: the same public theme/shell APIs with refined surfaces and navigation selection; Scan is reachable from Dashboard and Inventory without covering scrollable content.

- [x] **Step 1: Implement the approved palette and restrained component treatments**
- [x] **Step 2: Keep five shell destinations and route scanner access through Dashboard/Inventory actions instead of an overlay FAB**
- [x] **Step 3: Run the theme and shell tests; verify all five destinations and scanner routing remain unchanged**

### Task 3: Redesign the Dashboard as an honest business command center

**Files:**
- Modify: `lib/features/dashboard/presentation/dashboard_screen.dart`
- Modify: `test/design_system_test.dart`

**Interfaces:**
- Consumes: theme/tokens, existing GoRouter destinations, and current placeholder Dashboard state.
- Produces: responsive business identity/date header with Scan, navy financial hero with explicit unavailable values, six primary quick actions, compact inventory status, and an honest recent-activity empty state.

- [x] **Step 1: Build the header and financial hero from theme/tokens; use em dashes and an explicit data status**
- [x] **Step 2: Add touch-sized quick actions using only verified routes; keep scanner reachable in the header**
- [x] **Step 3: Replace sample recent activity with a clear, useful empty state**
- [x] **Step 4: Run Dashboard layout, accessibility-label, placeholder-data, and navigation tests**

### Task 4: Refresh Inventory and Product browsing without implying persistence

**Files:**
- Modify: `lib/features/inventory/presentation/inventory_screen.dart`
- Modify: `lib/features/products/presentation/product_list_screen.dart`
- Modify: `test/design_system_test.dart`

**Interfaces:**
- Consumes: existing list routes and current illustrative rows.
- Produces: compact premium inventory/product rows and visible preview-data treatment while retaining current navigation actions.

- [x] **Step 1: Add the preview label and replace generic layout with consistent search, status, and list surfaces**
- [x] **Step 2: Put Scan/Add product in screen app bars, preserve list/detail/add route behavior, and do not add provider or service calls**
- [x] **Step 3: Run narrow, wide, and enlarged-text widget checks**

### Task 5: Verify rendered output and update handoff documentation

**Files:**
- Modify: `docs/agent/UI_DESIGN_SYSTEM.md`
- Create: `docs/agent/UI_REDESIGN_PROGRESS.md`
- Modify: `docs/agent/DEVELOPMENT_STATE.md`
- Modify: `docs/agent/NEXT_TASK.md`

**Interfaces:**
- Consumes: the implementation and actual verification outputs.
- Produces: an accurate screen/files list, visual QA evidence or limitation, test/analyzer outcomes, and next bounded screen loop.

- [x] **Step 1: Format only changed Dart files**
- [x] **Step 2: Run the focused UI tests and relevant analyzer; report known baseline failures separately**
- [x] **Step 3: Inspect a rendered 390 px mobile viewport and correct visible overflow/spacing defects when the browser preview is available**
- [x] **Step 4: Record exactly what changed, what remains mock/unwired, and the next loop**

