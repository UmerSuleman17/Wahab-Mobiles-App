# WM_APP UI/UX Plan

Updated 2026-10-15 from the current source tree, PRD, and backend audit. This plan covers the design-system foundation and Dashboard responsive presentation sizing only. Feature workflows remain at their audited baseline until a later bounded loop is cleared by backend readiness.

## Product direction

**Modern Business Command Center.** Use Material 3 as the base with a calm light interface, deep navy identity, blue primary actions, neutral surfaces, and consistent semantic status colors. Emphasize readable amounts, predictable navigation, compact operational summaries, and large touch targets. Avoid decorative gradients, invented financial values, and behavior that suggests an unimplemented integration is working.

## Verified architecture and backend gate

- Flutter + Riverpod + GoRouter + Drift/SQLite; offline, one local business/admin.
- The route shell currently contains Dashboard, Inventory, Transactions, Cash, and More. The scanner opens from a shell-level action.
- Source references to Riverpod providers inside feature screens occur only in Login (`authServiceProvider`) and Splash (`businessRepositoryProvider`, `authRepositoryProvider`). Other listed screens are not connected to providers/services.
- `docs/agent/BACKEND_AUDIT.md` confirms unresolved P0s: reversible Base64 PIN storage and backup restore that can overwrite the active DB without validating the candidate or safely replacing/reopening the connection. Setup persistence, auth route guard, financial validation, audit/reversal paths, and existing test-suite failures are also unresolved.
- Consequently this loop may safely change shared presentation infrastructure; it must not make financial workflows appear live, connect mock screens to unverified paths, or claim completion of backend-facing flows.

## Complete screen inventory (37 screens / 19 feature folders)

Provider column reflects actual feature-screen `ref.read`/`ref.watch` use, not the existence of a provider elsewhere in the project. Unless stated, screens have no backend-driven loading/empty/error state because they do not consume a provider.

| Screen / route | Purpose and current actions | Current implementation and dependencies | Gaps / blockers |
|---|---|---|---|
| Splash — `/` | Resolve first-run/login destination | Reads business and auth repositories; waits before navigation | Pending-timer smoke test failure; auth/setup safety and route protection block workflow sign-off |
| Login — `/login` | Enter PIN and continue | Calls `AuthService`; input validation and login feedback are local to this screen | Reversible PIN format; no central route guard or session model |
| Setup wizard — `/setup` | Collect business, currency, opening cash, and admin details; skip/back | Multi-step local form; completion/skip navigate without saving | Setup transaction absent; do not present setup as persisted |
| Dashboard — `/dashboard` | Business overview and quick actions | Hardcoded PKR zero summaries and sample recent items; no provider; summary grid and inventory overview pass layout checks at 320×700, 390×844, and 1024×900, including 2× text at 390×844 | Mock figures; no true dashboard query; several shortcuts use unregistered paths |
| Product list — `/products` | Browse/search products; add or open an item | Five hardcoded sample rows; search field does not filter; no provider | No real list/search, loading/empty/error states; item IDs are sample indexes |
| Product detail — `/products/:id` | Inspect product and open stock/edit actions | Static product details; no provider | No persisted detail/history; edit and stock links mismatch registered routes |
| Add/edit product — `/products/add`, `/products/:id/edit` | Enter or edit product fields and save | Local form; no provider/service | No persisted create/update, duplicate validation, or verified success state |
| Scanner — `/scanner` | Scan barcode and offer contextual action | Uses MobileScanner and reports scanned/not-found text; no repository lookup | Camera result is not looked up; manual/add action is inert; no camera error/permission recovery |
| Inventory — `/inventory` | View stock and open product/stock actions | Hardcoded totals/list; no provider | No persisted stock state, filters, movement history, or data states; sample navigation |
| Stock in — `/stock-in?productId=…` | Receive quantity into stock | Local form; no provider/service | No verified ledger write, validation, duplicate-submit guard, or result state |
| Stock out — `/stock-out?productId=…` | Remove quantity from stock | Local form; no provider/service | No verified ledger write or stock-availability validation |
| Stock adjustment — `/stock-adjustment?productId=…` | Record a counted-stock correction | Local UI/sample product; no provider/service | Service exists but is not connected; no verified persisted result |
| Purchase list — `/purchases` | Browse purchases and create one | Static sample purchase; no provider | No actual history, filters, or backend states |
| Create purchase — `/purchases/create` | Select supplier/items and record purchase | Local form/sample supplier; no provider/service | Not persisted; purchase service validation gaps block wiring |
| Sale list — `/sales` | Browse cash/credit sales and start a sale | Static sample rows; no provider | No actual history or backend states |
| Create sale — `/sales/create` | Select items and record cash sale | Local cart/sample product; no provider/service | Not persisted; signed values/discounts and overpayment are not consistently validated in service |
| Create credit sale — `/sales/create-credit` | Select customer/items and record credit sale | Local cart/sample customer; no provider/service | Not persisted; customer/credit MVP scope conflict and payment validation gaps |
| Customer list — `/customers` | Browse customer balances and open a profile | Sample customers/balances; no provider | No real search/list states; sample index IDs |
| Customer detail — `/customers/:id` | Inspect customer and start collection | Static profile and balance; no provider | No real account history; payment navigation path is unregistered |
| Customer payment — `/customers/:id/pay` | Record a customer collection | Sample balance and local form; no provider/service | Not persisted; ownership/overpayment/void/receipt gaps block financial wiring |
| Supplier list — `/suppliers` | Browse suppliers and add/open one | Sample suppliers/balances; no provider | No real search/list states; sample index IDs |
| Supplier detail — `/suppliers/:id` | Inspect supplier and open payment/edit | Static profile/balance; no provider | No persisted history; edit/payment paths mismatch router |
| Add/edit supplier — `/suppliers/add`, `/suppliers/:id/edit` | Enter supplier details | Local form; no provider/service | No persisted create/update or verified success state |
| Supplier payment — `/suppliers/:id/pay` | Record a supplier payment | Sample balance and local form; no provider/service | Not persisted; balance and bank/cash validation gaps block wiring |
| Expense list — `/expenses` | Browse expenses and add one | Static electricity-bill row; no provider | No actual history or backend states |
| Add expense — `/expenses/add` | Enter category, amount, and payment details | Local form; submission only shows local feedback; no provider/service | No persistence; bank ledger path is absent |
| Daily cash — `/cash` | Review daily balance and entries; open close flow | Hardcoded sample balances/entries; no provider | Opening balance/bank model incomplete; no live cash ledger view |
| Cash close — `/cash/close` | Enter counted cash and compare with expected close | Amount form with hardcoded expected balance; local only | No verified close persistence; expected value must not be treated as real |
| Receipt list — `/receipts` | Browse receipts | Static sample receipt rows; no provider | No actual receipt list or data states |
| Receipt detail — `/receipts/:id` | Preview/share a receipt | Sample business/receipt/phone; share action is empty; no provider | No persisted receipt lookup or export/share path |
| Reports — `/reports` | Choose a report | Static report menu; no provider | No report loading/error/filter state |
| Report detail — `/reports/:type` | Inspect a summary/table and choose date/filter/export | Static figures/table; print/export/filter actions empty; no provider | No service-backed report result or verified formatting |
| Settings — `/more` | Open business settings, backup, WhatsApp, or log out | Static settings; navigation works for selected subpages; no provider | Most setting actions are empty; logout only navigates; PIN/auth blocker |
| Backup & restore — `/settings/backup` | Create/select/restore a backup | Mock timestamp/size; no provider/service | Restore is P0 unsafe; keep any restore action blocked pending repair |
| WhatsApp settings — `/settings/whatsapp` | Toggle reminder preference and edit template | Local toggle/template; no provider/service | Save/test are UI-only; scheduler/delivery is absent; never claim automatic sending |
| Transaction list — `/transactions` | Browse/filter transactions and open details | Ten static rows; filter action empty; no provider | No actual history; repository omits cash/stock and ignores product filter |
| Transaction detail — `/transactions/:id` | Inspect a transaction and related record | Static sale example; no provider | No persisted lookup, reversal, or receipt integration |

## Loop 1 design system and implementation boundary

### Tokens

Preserve existing `AppColors` names so feature code remains source-compatible while setting a coherent palette: navy `#0F172A`, blue `#2563EB`, background `#F8FAFC`, white surface, primary text `#0F172A`, secondary text `#64748B`, success `#0F766E`, warning `#B45309` (readable amber text), error `#DC2626`, and pale semantic containers. Add a small `AppTokens` source for spacing (4/8/12/16/24/32), radii (8/12/16/24), restrained elevation, motion duration, shell breakpoint (840 logical px), and content max width (1200 logical px). Use platform/system typefaces and Material 3 `TextTheme`; avoid new font or UI dependencies.

### Shared components

Restyle existing `EmptyStateWidget`, `LoadingWidget`, `AppErrorWidget`, `ConfirmationDialog`, `StatusChip`, `QuickActionButton`, and `SummaryCard` to use theme/tokens, accessible contrast, stable tap targets, and consistent radii/spacing. Keep their public constructors compatible. Errors remain explicit and retry only when a callback exists; no empty component should imply that real backend data has loaded.

### Responsive navigation and Dashboard layout correction

Keep all five existing shell destinations and GoRouter paths. Use a Material 3 `NavigationBar` below 840 logical px and a labeled `NavigationRail` at/above it. Keep the scanner reachable through the existing route and a tooltip-labeled shell FAB. On wide layouts, constrain the page region to 1200 logical px; do not rewrite individual feature routes or deep links in this foundation loop. Use safe areas provided by the Material navigation components and do not wrap or truncate child feature layouts unexpectedly.

The Dashboard's presentation-only summary grid and inventory overview now adapt to narrow widths and enlarge card height with system text scaling; summary-card amounts wrap naturally instead of shrinking below the chosen text size. Its placeholder values and quick-action behavior were left unchanged. The Dashboard consumes no provider, so this does not make it a live screen.

### Acceptance criteria

1. Shared palette, text, spacing/radius/elevation/motion/breakpoint values are centralized and themed consistently.
2. Existing shared component APIs remain source-compatible and honor theme semantics.
3. Five shell routes still navigate; scanner action still opens `/scanner`.
4. The shell uses its intended narrow and wide navigation controls without overflow at representative widths. Dashboard layout has focused overflow checks at 320×700, 390×844, and 1024×900, plus 2× text at 390×844. Other child-screen layouts still need separate verification.
5. No feature screen gains fake data or financial backend wiring in Loop 1.
6. Focused widget tests cover theme tokens/navigation responsiveness and preserved navigation. Run the requested formatter, analyzer, and tests only as the environment allows; report baseline failures separately.

## Screen completion state

Loop 1's shared design infrastructure and shell navigation are implemented in `lib/core/theme/` and `lib/core/widgets/`; nine focused checks pass, including Dashboard overflow at 320×700, 390×844, and 1024×900 with default text plus 2× text at 390×844. The shell checks use paths discovered and validated against production GoRouter configuration, then isolate navigation rendering with lightweight pages. Dashboard received a presentation-only responsive correction; its mock data/actions remain unintegrated. The full suite still reports the two backend tests' missing Windows `sqlite3.dll` and the existing Splash pending-timer smoke-test failure; see `docs/agent/UI_IMPLEMENTATION_STATUS.md` for exact command results. Other feature screen integration remains pending by the inventory above. Loop 2 (Splash/Setup/Login/Dashboard backend integration) is explicitly blocked until backup restore and PIN storage P0 issues are repaired and verified, and setup persistence/auth routing/dashboard data readiness have owners and tests.
