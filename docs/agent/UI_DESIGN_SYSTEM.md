# WM_APP Mobile UI Design System

Updated 2026-10-16 for the premium mobile presentation loop.

## Intent

Make WM_APP feel like a calm, premium business command center: clear financial hierarchy, quick touch-first actions, precise spacing, and a restrained navy/blue identity. The PRD's product philosophy remains **Simple → Fast → Reliable**. Android and iOS are the design targets; the browser is only a convenient rendering surface for visual checks.

## Goals and boundaries

- Establish consistent light-theme color, typography, surface, control, and navigation treatments.
- Make the Dashboard the mobile visual centerpiece and improve the Inventory/Product browsing surfaces.
- Keep mock content visibly identified as preview content; never present placeholder financial totals as real.
- Preserve GoRouter paths, providers, services, repository boundaries, database behavior, and offline-first operation.
- Do not wire unverified business workflows, add synchronization, change the web storage model, or change financial calculations.
- Dark theme, authentication/setup redesign, transaction workflow redesign, and the remaining feature screens are follow-up loops after this light mobile surface is verified.

## Visual tokens

| Role | Token |
|---|---|
| Primary navy | `#0B1220` |
| Primary blue | `#2563EB` |
| Accent blue | `#3B82F6` |
| Canvas | `#F6F8FC` |
| Surface | `#FFFFFF` |
| Primary text | `#111827` |
| Secondary text | `#64748B` |
| Success | `#059669` |
| Warning | `#B45309` |
| Error | `#DC2626` |
| Border | `#E5EAF2` |

Spacing follows the existing 4/8/12/16/24/32 logical-pixel scale. Shared corners are 8/12/16/24 px; small transitions use the existing 150/200 ms motion tokens. Use subtle borders and shadows, not decorative gradients. Amounts use tabular figures. Keep the bundled/system sans-serif font so the app works offline without a font dependency.

## Component architecture

Continue using `AppColors`, `AppTokens`, `AppTheme`, `AppScaffold`, and the shared widgets in `lib/core/widgets/`. Keep screen-only sections private to their feature. Promote a component to `core/widgets` only when multiple features need the same behavior and API. Keep the existing five shell destinations. Keep the six primary actions (New sale, Purchase, Add product, Stock in, Stock out, Expense) in the Dashboard grid. Put Scan in the Dashboard header and Inventory app bar rather than overlaying scrollable content or adding it as a seventh grid tile.

## Data honesty and accessibility

- Dashboard totals are disconnected from providers; show an explicit preview/data-availability state and em-dash values, not fabricated PKR totals or activity.
- Inventory/product examples remain preview-only until a verified provider is connected.
- Preserve system text scaling, accessible contrast, meaningful semantics, and at least 48 px primary touch targets.
- Test Dashboard, Inventory, and Product list at 320×700, 390×844, and a wider layout; include 2× system text on phone width.

## Current scope

The shared foundation from Mission 03 exists. This loop refreshes its mobile polish, the shell scanner treatment, Dashboard presentation, and Inventory/Product list presentation. Sales, purchase, payment, cash, receipts, reports, setup, login, and other feature flows remain on their audited baseline and must not be represented as newly integrated.
