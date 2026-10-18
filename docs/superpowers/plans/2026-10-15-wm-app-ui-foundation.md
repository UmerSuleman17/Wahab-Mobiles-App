# WM_APP UI Foundation — Implementation Plan

**Goal:** Complete Mission 03 Loop 1 by establishing a coherent light Material 3 theme, reusable design tokens and shared states, and adaptive shell navigation while preserving existing routes and avoiding mock/backend integrations.

**Design source:** `docs/agent/UI_UX_PLAN.md`. It contains the verified 37-screen inventory, visual tokens, backend gate, and acceptance criteria.

**Architecture constraints:** Flutter + Material 3; preserve AppColors compatibility, GoRouter paths, and feature/data/service boundaries. No dependency upgrades. The P0 backup and PIN findings block Loop 2 and financial screen wiring. No Git repo/worktree is available or permitted by `AGENTS.md`.

## Implementation sequence

### 1. Add a focused failing widget test (TDD RED)

- Add `test/design_system_test.dart` with a small GoRouter harness that renders `AppScaffold` and a destination page.
- Assert the Material 3 palette, a narrow `NavigationBar`, a wide `NavigationRail`, all five navigation destinations, and the scanner tooltip/action navigating to `/scanner`.
- Run only this test first and capture the failure against current theme/shell.
- If Flutter cannot run or the test does not reach the assertions, stop before production edits and report the environment limitation; do not count that as a RED result.

### 2. Implement the shared design foundation

- Add `lib/core/theme/app_tokens.dart` for spacing, radii, elevation, motion, responsive breakpoint, and max content width.
- Update `lib/core/theme/app_colors.dart` while preserving existing names used by screens.
- Update `lib/core/theme/app_theme.dart` for the navy/blue-neutral palette, Material 3 text/color/component themes, accessible control sizes, and tokenized shape/spacing.
- Restyle `lib/core/widgets/shared_widgets.dart` and `lib/core/widgets/summary_card.dart` without changing public constructors.
- Update `lib/core/widgets/app_scaffold.dart` to use bottom `NavigationBar` on narrow layouts and labeled `NavigationRail` on wide layouts, keep the five existing paths, and keep the scanner FAB accessible on `/scanner`.
- Do not touch feature screens or provider/service wiring in this loop.

### 3. Verify and review

- Format only files changed in this task.
- Re-run the focused widget test; then run `dart analyze lib`, `flutter analyze`, and `flutter test` as the environment permits.
- Compare failures with the documented baseline: analyzer has 32 info lints; the old smoke test leaves Splash's two-second timer pending. Report unchanged baseline failures distinctly from regressions.
- Inspect any rendered mobile/tablet output only if a device/browser runtime is available; never claim visual QA without rendering.
- Update `docs/agent/UI_IMPLEMENTATION_STATUS.md`, `docs/agent/DEVELOPMENT_STATE.md`, and `docs/agent/NEXT_TASK.md`; preserve backup restore as the next backend task and retain the Loop 2 readiness gate.

## Acceptance checks

1. Token/theme and responsive-navigation tests pass.
2. Existing route paths and scanner action remain intact.
3. Shared widgets use the centralized theme/tokens and retain constructor compatibility.
4. No false backend integration or mock financial display is added.
5. Results and unresolved baseline/environment constraints are documented accurately.
