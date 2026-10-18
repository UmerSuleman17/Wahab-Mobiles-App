# WM_APP Backend Audit

Audit date: 2026-10-15  
Scope: current workspace source, `PRD/PRD_APP.txt` sections 1–58, existing tests, and Codebase Memory. No production application code was changed. A focused test-only file was added at `test/backend_integrity_audit_test.dart`; its execution is pending because Flutter commands did not return output in this environment.

## Post-audit status (2026-10-15)

The findings and readiness tables below record the Mission 02 audit snapshot. Mission 04 subsequently resolved the backup-restore P0: restore now checks SQLite integrity, foreign keys, version, tables/columns, and a complete schema signature from a fresh in-memory `AppDatabase`, then stages, closes, replaces, reopens, and rolls back on failure. The focused restore suite passes 13/13 and the in-memory backend integrity suite passes 2/2. The full suite has 24 passes and the existing Splash pending-timer failure. The admin PIN remains the open P0; other financial, setup, routing, reminder, and accounting gaps remain.

## Executive summary

WM_APP has a local Drift schema, a shared stock/cash ledger, and service methods for many core workflows. Their existence does not establish that the backend is complete: important flows have no tests, several methods accept financially invalid values, public repository write paths can bypass the service reversals, and backup restore can overwrite the live database after only a file-size check. PINs are reversibly Base64 encoded. The backend is **not release-ready**.

Codebase Memory reported 1,587 nodes and 4,890 edges after the audit test was added and the project re-indexed. It partially parsed `android/settings.gradle` and deliberately excluded `docs`, assets, build output, and other ignored files. Dart call edges are heuristic; I checked the material claims against source. The current workspace contains 21 Drift tables, 18 repositories, and 15 services. The declared storage is one local SQLite database; persistent reopen behavior was not demonstrated by tests.

**Section classification coverage:** 58/58 numbered PRD sections have one backend classification below. The denominator is all numbered sections, with pages 1–15 treated as PRD sections 6–15. This is classification coverage only, not an implementation percentage. The PRD itself conflicts on customers and credit: §23 and the final scope text defer customer/credit features, while §§51–58 specify them in detail. I classify §23 as out of MVP scope with that conflict called out, and separately assess §§51–58 as written.

## Readiness by layer

| Layer | Assessment | Evidence |
| --- | --- | --- |
| Domain logic | **Partially implemented; unsafe for release** | Sale, purchase, payments, cash, reports, reminders, and backup services exist. Core financial inputs and balances are not consistently validated; reminder processing marks rows sent without delivery. |
| Database and repositories | **Partially implemented** | 21 Drift tables, FK declarations, and six manual indexes exist. Schema version is 1 and `onUpgrade` is empty. Some repository write methods bypass ledger reversals; no broad pagination or unique SKU/barcode constraint. |
| Transaction integrity | **Some service paths are transaction-wrapped; not comprehensively verified** | Sale, purchase, expense, payment, and stock-adjustment services use Drift transactions. Only a test of the cash-sale path is being added; it has not yet returned a result. |
| Integration readiness | **Low** | Provider references are present in login and splash only. Setup does not persist values; dashboard and product views contain placeholders. Router has no central auth redirect and several UI paths do not match registered routes. |
| End-to-end/release readiness | **Not ready** | Existing widget smoke test fails due to the splash delay’s pending timer; no prior domain/service tests exist. PIN protection and restore safety are release blockers. |

## PRD traceability matrix

Statuses assess backend behavior. For mixed UI/backend sections, UI-only obligations are identified separately. `OUT OF MVP SCOPE` reflects explicit deferral, not a claim that later detailed requirements are satisfied.

| § | PRD area | Status | Backend evidence and remaining gap |
|---:|---|---|---|
| 1 | Project overview | PARTIALLY IMPLEMENTED | Offline Flutter/Drift foundation exists; the central product loop is not consistently integrated or proven. |
| 2 | Target user | IMPLEMENTED, UNVERIFIED | Single local admin data model; no restart/persistence acceptance test. |
| 3 | User role and authentication | DEFECTIVE | `AuthService.hashPin` is fixed-prefix Base64; no session/logout/central route guard. |
| 4 | First-launch setup | DEFECTIVE | Setup form routes to dashboard without writing business, currency, opening cash, receipt settings, or admin PIN. |
| 5 | App structure/pages | PARTIALLY IMPLEMENTED | Routes and screens exist, but most are not provider/service wired; several navigation paths mismatch. |
| 6 | Splash/loading | NOT APPLICABLE TO BACKEND | Primarily presentation timing. The existing smoke test does fail on the pending two-second timer (`splash_screen.dart:23`), which blocks the app test suite but is not a backend defect. |
| 7 | Admin login | PARTIALLY IMPLEMENTED | Login calls `AuthService`; credential design is insecure and direct protected routes remain reachable. |
| 8 | Initial business setup | DEFECTIVE | Six-step UI collects fields but `_completeSetup` only navigates. No backend setup transaction. |
| 9 | Dashboard | PARTIALLY IMPLEMENTED | Report services provide some underlying totals, but the dashboard is hardcoded and has no verified data-provider integration. The wiring gap is presentation/integration work. |
| 10 | Inventory | PARTIALLY IMPLEMENTED | Product and stock tables/services exist; direct quantity/history methods can bypass ledger and behavior is untested. |
| 11 | Add/edit product | PARTIALLY IMPLEMENTED | Product CRUD exists, but SKU/barcode duplicates and numeric input rules are not enforced in DB/service. |
| 12 | Product details | PARTIALLY IMPLEMENTED | Product reads/history exist; no verified end-to-end data wiring. |
| 13 | Barcode/QR scanner | PARTIALLY IMPLEMENTED | Product repository can look up barcode/SKU and a scanner screen/plugin exist; camera-to-lookup/action flow is not implemented or verified. |
| 14 | Incoming stock/purchases | PARTIALLY IMPLEMENTED | Purchase service records receipt/stock/cash/audit transactionally; input/status validation and bank movement are absent. |
| 15 | Outgoing stock/sales | PARTIALLY IMPLEMENTED | Cash/credit service paths write core records transactionally; negative quantities/prices/discounts and overpayments are accepted. |
| 16 | Financial calculation rules | DEFECTIVE | REAL/double with 2-place rounding; no currency precision decision; balance and status can diverge under invalid inputs. |
| 17 | Stock adjustments | IMPLEMENTED, UNVERIFIED | Service validates positive adjustment quantity and uses ledger/audit in a transaction; no behavior tests. |
| 18 | Transactions | DEFECTIVE | Unified repository omits cash/stock entries; `productId` filter is not applied; list is assembled in memory. |
| 19 | Transaction integrity | PARTIALLY IMPLEMENTED | Compound service methods use transactions and ledger helpers; alternate repository void/write paths bypass reversals; important rollback scenarios lack tests. |
| 20 | Reports | PARTIALLY IMPLEMENTED | Basic totals and void filters exist; no reconciliation tests, receivable filters are limited, and supplier totals use per-supplier queries. |
| 21 | Settings | PARTIALLY IMPLEMENTED | Business/receipt/app setting persistence exists; validation and setup integration are missing. |
| 22 | Must-have features | PARTIALLY IMPLEMENTED | Core entities and service methods exist, but scanner, dashboard, data validation, backup, and integration obligations remain incomplete. |
| 23 | Nice-to-have features | OUT OF MVP SCOPE (CONFLICT) | PRD defers customers/credit here and again at the end, but §§51–58 later specify them. Resolve scope before treating receivables as release acceptance. |
| 24 | Design requirements | NOT APPLICABLE TO BACKEND | Primarily visual/theme requirements. |
| 25 | UX requirements | NOT APPLICABLE TO BACKEND | Primarily interaction/navigation requirements; see §5/§45 integration gaps. |
| 26 | Search and filtering | PARTIALLY IMPLEMENTED | Search/filter methods exist; several lists are unpaged, and transaction product filtering is ignored. |
| 27 | Technical requirements | PARTIALLY IMPLEMENTED | Declared Flutter/Riverpod/Drift/GoRouter stack is present; intended repository/service boundary is not followed consistently. |
| 28 | Database/data storage | DEFECTIVE | Schema version 1, empty migration callback, no unique SKU/barcode, no DB amount/quantity checks, and receipt links are not FK-constrained. |
| 29 | Offline-first | IMPLEMENTED, UNVERIFIED | Local SQLite and no core cloud dependency exist; persistence/reopen and offline acceptance were not tested. |
| 30 | Backup/recovery | DEFECTIVE AT AUDIT; RESOLVED IN MISSION 04 | At audit time any non-empty file passed validation. Mission 04 added integrity/version/full-schema checks and a staged close/replace/reopen/rollback lifecycle; platform behavior remains unverified. |
| 31 | Scanning | PARTIALLY IMPLEMENTED | Barcode lookup exists in the repository; no verified camera scan → lookup → business action path. |
| 32 | Receipt technical requirements | PARTIALLY IMPLEMENTED | Receipt rows have a unique receipt number and service lookup; customer-payment receipt creation and robust sequence concurrency are missing/unverified. PDF/print is presentation/export work. |
| 33 | Data validation | DEFECTIVE | Sales/purchases accept invalid signs and inconsistent amounts; payment ownership/status/balance checks are incomplete. |
| 34 | Security | DEFECTIVE | Reversible PIN storage, route bypass, no throttling/session, and backups remain unencrypted. Restore schema validation was added in Mission 04. |
| 35 | Content requirements | NOT APPLICABLE TO BACKEND | Mostly copy and presentation requirements. |
| 36 | Notifications | DEFECTIVE | No scheduler/background executor; due reminders are marked sent without sending or checking outstanding balance. |
| 37 | Audit history | PARTIALLY IMPLEMENTED | Financial services log audit rows; master-data CRUD, login/logout, and backup operations are not consistently audited. |
| 38 | MVP scope | PARTIALLY IMPLEMENTED | Single-admin offline scope is reflected in architecture; core MVP behavior and acceptance evidence are incomplete. |
| 39 | Future phases | OUT OF MVP SCOPE | Cloud sync, staff, branches, and advanced future functionality are not implemented, consistent with deferral. |
| 40 | Error/edge cases | PARTIALLY IMPLEMENTED | Some typed exceptions and FK behavior exist; invalid input, restore corruption, concurrency, and recovery cases are not covered. |
| 41 | Application states | NOT APPLICABLE TO BACKEND | Primarily loading/empty/error UI states; no integration evidence for most screens. |
| 42 | Accessibility | NOT APPLICABLE TO BACKEND | Presentation responsibility. |
| 43 | Performance | PARTIALLY IMPLEMENTED | A few indexes exist; broad unpaged queries and in-memory aggregation make large-inventory performance unproven. |
| 44 | Testing requirements | DEFECTIVE | Only the widget smoke test existed and fails; no service, repository, migration, integrity, or security tests existed before this audit. |
| 45 | Acceptance criteria | PARTIALLY IMPLEMENTED | Several functional entities exist, but no passing end-to-end acceptance evidence and critical security/restore requirements fail. |
| 46 | Final product experience | PARTIALLY IMPLEMENTED | Dashboard/data integration and fast actions are not implemented end-to-end. |
| 47 | Core business data flow | PARTIALLY IMPLEMENTED | Ledger connects many service writes; setup, bank movements, customer payment receipts, reports, and reminders break the stated flow. |
| 48 | Final tech stack | IMPLEMENTED, UNVERIFIED | Required stack dependencies/types exist; this does not verify platform builds or app behavior. |
| 49 | Final build principles | DEFECTIVE | Atomic service writes exist, but alternate direct-write paths, unsafe restore, and incomplete audit trail violate integrity/traceability principles. |
| 50 | Final scope statement | PARTIALLY IMPLEMENTED | Single-admin Flutter scope matches; customer/credit scope contradicts §§51–58. |
| 51 | Credit sales/receivables | PARTIALLY IMPLEMENTED | Credit sale/account calculations exist; validation, overpayment handling, reminder scheduling, and dashboard integration are missing. |
| 52 | Customer collections | PARTIALLY IMPLEMENTED | Collection service writes payment, updates linked sale, cash, and audit; it lacks ownership/void/overpayment checks and receipt generation. |
| 53 | Automatic WhatsApp reminders | DEFECTIVE | No scheduled invocation or WhatsApp delivery; processor labels due reminders `sent` without sending. |
| 54 | Reminder settings/history | PARTIALLY IMPLEMENTED | Settings keys and reminder rows/statuses exist; deduplication, retries, real delivery state, and UI wiring are absent. |
| 55 | WhatsApp integration | PARTIALLY IMPLEMENTED | User-initiated `wa.me` fallback exists; automatic API integration is absent, which must not be represented as automatic delivery. |
| 56 | Receivables dashboard | PARTIALLY IMPLEMENTED | Customer receivable aggregates exist in `ReportService`, but due-today/overdue counts and dashboard wiring are absent. |
| 57 | Receivables report | PARTIALLY IMPLEMENTED | Aggregate customer balance report exists; required status/date filters and per-sale detail are absent. |
| 58 | Important data flow | DEFECTIVE | Credit/payment/stock/cash/receipt pieces exist, but reminder delivery, customer-payment receipts, bank movement, and complete reconciliation do not. |

## Database findings

- `lib/core/database/app_database.dart`: 21 tables, schema version 1, `onCreate` creates six manual indexes; `onUpgrade` does nothing. `beforeOpen` enables `PRAGMA foreign_keys = ON`.
- Foreign keys cover core product/category/supplier, sale/customer/item, purchase/supplier/item, payment, reminder, and stock relationships. `Sales.receiptId`, `Purchases.receiptId`, and `Receipts.transactionId` are plain text without relational uniqueness/FK enforcement.
- Category name, cash-close business date, and receipt number have unique constraints. SKU/barcode do not. There are no database CHECK constraints for positive quantity/amount, valid enum ranges, discount bounds, or payment consistency.
- The six manually created indexes cover product barcode/SKU, stock transaction product/date, cash created date, sales created date, and purchase created date. Common customer/supplier/status/date combinations and reminder scheduling are not indexed explicitly.
- `lib/core/providers/database_provider.dart` opens a persistent database in the app documents directory with `NativeDatabase.createInBackground`; no test proved close/reopen persistence or corruption recovery.
- `lib/core/database/app_database.g.dart` is present. Generated/source consistency was not independently verified; no code generation was run.
- `REAL`/Dart `double` and `roundMoney` to two decimals are in use. Currency minor-unit support is undecided; changing storage needs a documented migration decision first.

## Repository assessment

Repositories expose useful CRUD/query helpers, but services often query and mutate `_db` directly. The graph/source scan found service providers and repository providers, while `ref.read/watch` in feature code appears only in login and splash. This weakens the intended persistence boundary and leaves repository methods as alternate unsafe write paths.

| Repository | Assessment |
|---|---|
| `audit_repository.dart` | Partial: query/create support; no access protection or pagination beyond recent limit. |
| `auth_repository.dart` | Defective: duplicates auth logic and check-then-insert admin creation has no singleton constraint. |
| `business_repository.dart` | Partial: CRUD/setup flags exist, but wizard does not call it and singleton is not DB-enforced. |
| `cash_repository.dart` | Partial: totals/range methods exist; no pagination and opening balance is not represented by current service flow. |
| `category_repository.dart` | Partial: unique exact name and CRUD; no case-normalized validation or reliable audit. |
| `customer_payment_repository.dart` | Defective: no void state/reversal operation and totals do not provide complete allocation semantics. |
| `customer_repository.dart` | Partial: account aggregation exists; loads sales into memory, requires phone in create, and due-date boundary can report overdue on the due date. |
| `expense_repository.dart` | Defective alternate path: `voidExpense` marks void without reversing cash/auditing; service path handles reversal. |
| `inventory_repository.dart` | Defective alternate path: `recordStockTransaction` can add history without changing product quantity or using ledger. |
| `product_repository.dart` | Defective: no SKU/barcode uniqueness guard; `updateQuantity` bypasses ledger; search unpaged. |
| `purchase_repository.dart` | Defective alternate path: direct create/void methods do not perform compound stock/cash reversals. |
| `receipt_repository.dart` | Partial: lookups/settings exist; sequence helper relies on current max/order behavior and has no tested concurrent retry. |
| `reminder_repository.dart` | Partial: status CRUD exists; no dedupe, delivery attempt history, or retry semantics. |
| `sale_repository.dart` | Defective alternate path: direct void only marks row; generic reads can include voided records. |
| `settings_repository.dart` | Partial: persistence exists without domain validation. |
| `supplier_payment_repository.dart` | Defective alternate path: direct void marks row without cash reversal/audit. |
| `supplier_repository.dart` | Partial: aggregate/watch methods exist; unpaged list and input validation are limited. |
| `transaction_repository.dart` | Defective: omits cash/stock movement records, ignores `filter.productId`, and assembles full collections in memory. |

## Service assessment

| Service | Assessment and material gap |
|---|---|
| `AuthService` | **Defective.** Deterministic Base64 PIN, no KDF/rate limiting/session/logout, and no minimum rule in service for changed PIN. |
| `SaleService` | **Partially implemented.** Sale/receipt/stock/cash/audit are in one transaction. It checks only non-empty items; accepts negative quantity/price/discount and overpayment; sale void leaves payment history unvoided. |
| `PurchaseService` | **Partially implemented.** Receipt/stock/cash/audit are transactional. Sign/discount/status consistency and overpayment are not validated; bank method has no bank ledger. |
| `InventoryService` | **Implemented, unverified.** Forwards stock changes to ledger; no focused service tests. |
| `StockAdjustmentService` | **Implemented, unverified.** Checks product and positive quantity, writes through ledger/audit in transaction; reason may be empty and no tests. |
| `CashService` | **Defective.** Opening cash is not incorporated; no bank ledger; closing writes/overwrites a unique daily row then audits separately, so audit failure can leave an unaudited close. |
| `CustomerPaymentService` | **Partially implemented/defective.** Positive amount check and transaction exist; no customer ownership/void/credit validation, overpayment guard, receipt generation, or void support. Nullable sale allocation can create a payment that does not reduce a sale. |
| `SupplierPaymentService` | **Partially implemented.** Transaction/reversal/audit in service path; no balance cap or bank balance movement. |
| `ExpenseService` | **Partially implemented.** Positive amount and transaction/reversal/audit exist for cash; no bank ledger or receipt. |
| `ReceiptService` | **Partially implemented.** Reads sale/purchase/payment data; customer-payment creation never calls it. Receipt totals can differ from recomputed rounded line sums and names come from current master data. |
| `ReportService` | **Partially implemented.** Basic reports filter voided sales/purchases/expenses; receivables are aggregated rather than per-sale; supplier report uses N+1 reads; no reconciliation tests. |
| `ReminderService` | **Defective.** Creates rows and marks due rows sent without contacting WhatsApp or checking outstanding balance; no application scheduler calls it. |
| `WhatsAppService` | **Partially implemented.** Formats and opens a prefilled `wa.me` link only; this is manual fallback, not automatic delivery. |
| `BackupService` | **Defective, P0.** Any nonempty file passes validation; restore copies it over the active database without validating SQLite integrity/schema or closing/reopening safely. |
| `AuditService` | **Partially implemented.** Query/log path exists, but repository/service bypasses leave important master-data, login/logout, backup, and settings changes unaudited. |

## Financial and inventory integrity

- **Atomicity:** `SaleService`, `PurchaseService`, `CustomerPaymentService`, `SupplierPaymentService`, `ExpenseService`, and `StockAdjustmentService` wrap multi-write operations in `db.transaction`. `Ledger` documents that it expects callers to supply the transaction. This is a good foundation, not proof that all flows roll back correctly.
- **Cash sale rollback evidence:** `test/backend_integrity_audit_test.dart` adds an in-memory success case and a failure after receipt/sale/item writes (insufficient stock) that asserts rollback of sale, receipt, item, stock, cash, and audit rows. The Flutter test command had not returned output at report time; therefore this is a test artifact, **not yet verified evidence**.
- **Input validation:** Sale and purchase paths only require a nonempty item list. `Ledger.moveStock` accepts any signed delta/type/price; stock-adjustment service checks quantity > 0 but service-level transaction validation is not universal. Payment services do not consistently check ownership, remaining debt, duplicate submissions, or accepted states.
- **Reversals:** Service void paths preserve history by adding reverse stock/cash entries. Direct repository void functions only set flags, so correctness depends on callers choosing the service path. Sale void does not void customer payment rows. Purchase void can be blocked if reversing stock would make quantity negative; product behavior is not documented/tested.
- **Customer balances:** Linked collections update the sale's amount received and add a payment. Unallocated payments are not reflected in sale-based receivable totals. Overpayments are accepted; ownership/status checks are missing. Due dates stored at midnight can be treated overdue on the due date after midnight.
- **Supplier balances:** Calculated as non-void purchases less amount paid at purchase and separate non-void payments; no bank balance is maintained for `PaymentMethod.bank`.
- **Cash:** Signed cash entries and reversal rows provide a useful ledger. Opening cash is not represented in `CashService` summary. A cash close overwrites the unique date row on repeated close and the stored count discrepancy does not become a ledger adjustment.
- **Money:** SQLite `REAL` and Dart `double` with 2-decimal rounding. No currency precision decision, cross-currency behavior, rounding reconciliation, or stress test exists.
- **Duplicate submission/concurrency:** No idempotency key or tested concurrent receipt sequence. Receipt numbering uses count + 1 and unique receipt number; simultaneous writers can collide and have no retry policy.

## Security and backup

`lib/services/auth_service.dart:76-80` uses `base64Encode(utf8.encode('wm_salt_$pin'))`. This is reversible encoding with a fixed prefix, not a salted password KDF. A safe repair must retain legacy compatibility: after a valid legacy login only, atomically replace the credential with a versioned random-salt KDF record; invalid login must not change storage. Add tests for new credentials, wrong PIN, migration, change, malformed versions, and reopen.

`lib/core/routing/app_router.dart` defines routes without a global redirect/auth state. Direct route navigation can bypass the login screen. There is no persistent session/logout flow. The setup page also skips directly to dashboard without setting up the admin.

`lib/services/backup_service.dart:37-56` checks existence and then accepts any nonzero file while `_db.schemaVersion > 0`; `restoreBackup` copies that file onto the live DB path. There is no `PRAGMA integrity_check`, target schema validation, staging copy, close/reopen sequence, atomic replacement/rollback, or restore audit. Do not test this against real data. Backup files are direct database copies with no explicit encryption or audit record.

## Test and command results

| Command/check | Result |
|---|---|
| `flutter doctor -v` | Prior baseline completed with Flutter 3.24.5 stable / Dart 3.5.4; Android SDK/Android Studio and Visual Studio C++ workload were absent. Current rerun remained pending with no output. |
| `flutter pub get` | Prior baseline passed with no upgrades (99 newer incompatible versions reported). Current rerun remained pending with no output. |
| `dart analyze lib` | Prior baseline: exit 0 with 32 info lints and no warnings/errors. Current rerun printed the same 32 info issues, then exited nonzero because Dart analytics could not write `C:\Users\DEEL\AppData\Roaming\.dart-tool\dart-flutter-telemetry-session.json` (access denied). |
| `flutter analyze` | Prior baseline exited 1 solely for the 32 info-level lints, no warnings/errors. A clean rerun was not obtained. |
| `flutter test` | Existing `WmApp smoke test initializes` fails: the two-second splash delay leaves a pending fake timer at teardown (`lib/features/splash/presentation/splash_screen.dart:23`). No prior service/database tests existed. |
| `flutter test --no-pub test/backend_integrity_audit_test.dart` | Started during this audit but did not return output; result is unknown and must not be represented as passing. |
| Codebase Memory | Ready; 1,584 nodes / 4,865 edges. `AuthService.hashPin` and core service methods were found. Call edges are heuristic and not treated as proof. |

The environment did not return results for current Flutter doctor/pub/test invocations; I did not terminate those commands. Treat prior baseline results as historical evidence, and rerun these commands in a responsive Flutter environment before release.

## Prioritized findings

At most the 15 most actionable findings are listed here. Priority indicates business impact, not estimated effort.

| Priority | Finding / evidence | Impact | Recommended remediation and regression evidence |
|---|---|---|---|
| P0 | Unsafe restore — `BackupService.validateBackup` / `restoreBackup` (`lib/services/backup_service.dart:37-56`). **Follow-up status (2026-10-15): Resolved;** see the Mission 04 checkpoint in `docs/agent/DEVELOPMENT_STATE.md`. | At audit time, a corrupt or unrelated nonempty file could replace the active DB and lose all local business data. **Historical repro:** on a temp setup, pass any nonempty text file to `validateBackup`; it returned true while the current schema version was positive. Do not call restore on real data. | Remediation verified with staged SQLite integrity/schema checks, close/atomic rename/reopen/rollback, and temporary-database tests for malformed, incompatible, valid, and failed-reopen backups. |
| P0 | Reversible admin PIN — `AuthService.hashPin` (`lib/services/auth_service.dart:76-80`). | Anyone reading the local DB can recover the PIN immediately; offline guessing is trivial. **Repro:** call `hashPin` for a test PIN and Base64-decode the result; the fixed prefix and PIN are visible. | Versioned random-salt KDF; migrate only after successful legacy login in one transaction. Test legacy/new formats and failure behavior. |
| P1 | Setup is not persisted and router lacks an auth guard (`setup_wizard_screen.dart:_completeSetup`, `app_router.dart`). | First-run values/admin are discarded; direct dashboard/business routes bypass login. **Repro:** enter values, complete setup, then inspect the DB/reopen; `_completeSetup` only navigates. Open a protected route directly; no router redirect checks auth. | Persist setup atomically, route to login/dashboard based on state, add centralized redirect/session semantics; test setup, restart, and deep links. |
| P1 | Financial input validation absent (`SaleService.createCashSale/createCreditSale`, `PurchaseService.createPurchase`). | Negative quantities/prices/discounts and excessive payments can corrupt stock, receipts, cash, or balances. **Repro on a temporary DB:** call sales/purchase methods with negative quantity/price/discount and with amount paid above total; source has no rejecting guard. | Validate units, nonnegative prices/discounts, totals, amount-paid bounds, party ownership and payment status before writes; test boundary matrix and rollback. |
| P1 | Public repository mutation paths bypass reversals (`SaleRepository.voidSale`, `PurchaseRepository.voidPurchase`, `SupplierPaymentRepository.voidPayment`, `ExpenseRepository.voidExpense`, `InventoryRepository.recordStockTransaction`). | A future/current caller can mark history void or add history without reversing/maintaining cash or stock. **Repro on a temporary DB:** invoke a repository void directly and compare the cash/stock ledger before/after; the repository only changes the flag. | Make compound writes service-only; route all callers through transactional services or remove unsafe methods. Test final ledger/account balance after void. |
| P1 | Customer collection inconsistencies (`CustomerPaymentService.recordPayment`). | Wrong-customer/void-sale payments and overpayments are accepted; no void/reversal or receipt path; unallocated receipts do not reduce receivables. **Repro on a temporary DB:** record a payment larger than the linked sale balance or link it to another customer's sale; there is no association/balance check. | Validate customer-sale association and open balance; define allocation policy; add void/history and receipt generation atomically. Test partial/full/overpay/wrong-party/void cases. |
| P1 | Reminders falsely marked sent (`ReminderService.processPendingReminders`, lines 40-58); no call site/scheduler. | The owner may believe customers were reminded when no message was delivered. **Repro:** insert a due scheduled reminder and call the processor; status/sentAt change without invoking WhatsApp or a notification sender. | Keep scheduled/attempted/delivered states distinct; check balance at send time; invoke an actual platform scheduler/API or expose explicit manual-send status; test retries and no-longer-due cases. |
| P1 | Opening cash and bank movements are missing (`CashService`, `BusinessEntries`, `PaymentMethod.bank`). | Opening balances and noncash transactions do not reconcile to the business cash/bank position. | Define opening balance entries and bank ledger semantics; setup should post opening entries once. Test opening cash, cash/bank sale/purchase/payment/expense, and closing reconciliation. |
| P1 | PRD and implemented tests do not cover financial workflows. | Atomic transaction intent may regress silently; current test suite gives no confidence in purchase/payment/void/close/migration/reopen. | Expand temp/in-memory DB coverage for the 12 mission scenarios; make CI/test result clean and record baselines. |
| P1 | Schema upgrade path is empty (`app_database.dart`, schema version 1). | Future releases have no migration behavior; schema change may strand existing installs or misread data. | Add migration planning and tests before schema changes; test upgrade from each supported version with foreign keys/integrity. |
| P2 | Transaction history omits cash/stock and ignores product filter (`TransactionRepository.getAll`). | Ledger activity and product-specific history filters are incomplete or misleading. **Repro:** call `getAll` with `TransactionFilter(productId: ...)`; the method never applies that field and never adds cash/stock rows. | Include cash/stock records with stable source IDs and apply all filters in query/data layer; test each type/filter combination. |
| P2 | Receipt sequence and detail are fragile (`Ledger.createReceipt`, `ReceiptService`). | Concurrent numbering can collide; customer collection has no receipt; current product names/rounded line sums can diverge from original transaction. | Allocate sequence atomically with retry and preserve receipt snapshot/amount semantics; test concurrent numbers and every receipt type. |
| P2 | Reports and account queries lack reconciliation/performance evidence (`ReportService`, customer/supplier repositories). | Report totals may diverge from ledgers; all-row aggregation/N+1 queries may stall as data grows. | Reconcile reports to source transactions in tests; push aggregation/filtering into SQL and add paging/indexes based on measured workloads. |
| P2 | Most UI screens are not wired and routes mismatch (`service_providers.dart`, feature screens, `app_router.dart`). | A correct service method is not usable end-to-end; broken navigation prevents workflows. Examples: dashboard uses `/inventory/stock-in` and `/inventory/stock-out`, while registered paths are `/stock-in` and `/stock-out`; product edit uses `/products/edit/$id` while router registers `/products/:id/edit`. | Before UI release, wire bounded feature slices to providers/services and test route-to-service flows. This audit does not redesign UI. |
| P3 | REAL/double money without currency precision policy. | Small rounding differences can accumulate or fail for currencies with different minor-unit precision. | Document supported currencies/precision and migration needs before considering exact minor-unit storage; add arithmetic/reconciliation tests. |

## Untested risks

No verified behavior tests existed for credit sale/down payment, purchase partial payment, customer collection, supplier payment, stock adjustment, insufficient stock, sale/purchase void, cash close/reconciliation, receipt concurrency/uniqueness, auth migration, restore recovery, or database reopen persistence. The added cash-sale test is still pending, so it does not close this gap. Concurrency, process interruption, SQLite corruption recovery, large data volumes, Android/iOS packaging, and platform key storage were not tested.

## Recommended remediation order

1. **Restore data safety (P0):** make invalid/corrupt restore incapable of replacing the active database; safe close/stage/replace/reopen and recovery tests.
2. **PIN security and auth boundary (P0/P1):** versioned KDF with successful-login legacy migration, validation/rate limit policy, session/logout semantics, and router guard tests.
3. **Financial validation and accounting rules (P1):** bound quantities/prices/discounts/payments, validate customer/supplier relations and sale states, settle overpayment policy, and add void/payment receipt semantics.
4. **Opening balances and bank/cash accounting (P1):** decide and implement cash/bank ledgers and closing adjustment/history rules.
5. **Reminder honesty and scheduling (P1):** no `sent` state until delivery evidence exists; schedule and recheck outstanding amounts.
6. **Repository boundary and transaction history (P1/P2):** remove or harden unsafe direct mutation methods, complete transaction filters, audit master-data/security/backup actions.
7. **Test and migration base (P1):** fix the splash test timing separately, add service/database/report/reopen/migration coverage, and require clean analyzer/test evidence.
8. **Integration readiness (P2):** resolve the PRD customer/credit scope conflict, then wire UI slices and correct route paths.
9. **Currency and scale decisions (P2/P3):** document currency precision; measure data volume and optimize unpaged queries/N+1 reports.

## Verdict

**Not release-ready and not 100% complete against the PRD.** Some core service writes are transaction-wrapped, but the backend has confirmed critical security/restore defects, financial validation gaps, incomplete accounting/reminders, and no passing business-logic suite. Do not begin broad production UI integration until findings 1–5 have owners and tests. Modern UI scaffolding may continue only against clearly labeled mock data; it must not be presented as an integrated working backend.

**Not checked:** Android/iOS builds, persistent reopen/recovery, backup restore against real data, concurrent workloads, large-data performance, device-level secure storage, and delivery through WhatsApp Business/API. No real business database or backup was used.
