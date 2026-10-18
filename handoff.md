# WM_APP Developer & Agent Handoff Document

> **Last Updated:** October 2026  
> **Target Audience:** Incoming AI Agents and Software Engineers  
> **Status:** Architecture, Database, Repositories, and Business Services complete. UI scaffolded (37 screens) but currently unlinked from services (mock data/stubs).

---

## 1. Executive Summary & Project Overview

**WM_APP** is an offline-first, single-admin mobile Business & Inventory Management application built using **Flutter + Dart** for Android and iOS. It serves as a personal command center for a business owner, unifying daily operations: product catalogs, stock movements, purchases, cash and credit sales, customer receivables with automated WhatsApp payment reminders, supplier payables, expense tracking, daily physical cash reconciliation, professional receipt generation, and analytical reports.

### Primary Goal & Philosophy
- **Simple → Fast → Reliable**: Minimal taps for daily operations.
- **One Source of Truth**: All cash balances, product quantities, supplier balances, customer debts, and reports are computed directly from atomic transaction records.
- **Transaction Integrity (ACID)**: No isolated or silent data edits. Every purchase, sale, adjustment, or payment executes inside a database transaction that synchronously updates inventory, cash drawer, receipts, and audit logs.
- **Offline-First**: Fully functional without network connectivity; local persistent storage via SQLite.

### Technology Stack
| Layer | Technology |
|---|---|
| **Framework & Language** | Flutter 3.24.5 / Dart 3.5.4 |
| **State Management** | Flutter Riverpod 2.5.1 + `riverpod_annotation` / `riverpod_generator` |
| **Database** | Drift 2.18.0 (SQLite with `sqlite3_flutter_libs`) |
| **Routing** | GoRouter 14.2.0 (ShellRoute + Nested Navigation) |
| **Hardware / Sensors** | `mobile_scanner` 5.1.1 (Camera Barcode/QR scanning) |
| **PDF & Receipts** | `pdf` 3.11.0 & `printing` 5.12.0 |
| **Utilities** | `intl`, `uuid`, `flutter_secure_storage`, `url_launcher`, `share_plus` |

---

## 2. Project Scope (PRD Baseline)

The project specification is formally defined in `PRD/PRD_APP.txt` (and `PRD/PRD_APP.docx`), covering 58 sections.

### In-Scope (MVP Must-Have)
1. **Admin Authentication**: Single-admin PIN login with salted hashing.
2. **First-Launch Setup Wizard**: Business profile, default currency, opening cash balance, admin PIN creation.
3. **Dashboard**: Daily overview (sales, purchases, expenses, cash), inventory status (low stock, out of stock), supplier payables, customer receivables, recent activity stream.
4. **Product Catalog**: Full CRUD, categories, SKU, barcode, cost/selling prices, minimum stock alerts.
5. **Inventory & Stock Management**: Stock In, Stock Out, and traceable Stock Adjustments (damage, loss, found, count correction).
6. **Barcode / QR Scanning**: Camera scanning for instant product lookup, stock-in/out, and checkout.
7. **Incoming Stock (Purchases)**: Supplier purchases, inventory increments, cash/bank deductions, supplier balance tracking.
8. **Outgoing Stock (Sales)**:
   - **Cash Sales**: Instant stock decrement, cash drawer addition, sequential receipt.
   - **Credit Sales & Receivables (PRD §51–§58)**: Customer assignment, down payments, remaining balance due, due date, automatic/manual WhatsApp payment reminders.
9. **Supplier Management & Payments**: Profiles, purchase history, debt tracking, partial/full payment recording.
10. **Customer Management & Collections**: Customer debt profile, payment collection against credit sales.
11. **Expenses**: Categorized operational expenses (rent, utilities, salaries) with cash drawer impact.
12. **Daily Cash Tracking & Reconciliation**: Opening balance + inflows − outflows = expected closing; actual physical cash verification and discrepancy logging.
13. **Receipt Generation**: Sequential numbered receipts for sales, purchases, and payments with PDF preview/print/share.
14. **Unified Transactions Log**: Searchable, filterable audit log of all financial and stock events with void/reversal support.
15. **Reports**: Daily sales, purchases, expenses, cash flow, stock summary, supplier balances, and customer receivables.
16. **Settings & Data Protection**: Business details, receipt configuration, local database backup & restore.

### Out-of-Scope (Future Phases — Do NOT Implement for MVP)
- Multi-user authentication / staff accounts / role-based permissions (PRD §39, §49).
- Multi-branch or multi-warehouse management.
- Cloud database syncing / remote multi-device access (MVP is offline local).
- Bluetooth thermal ESC/POS direct printer drivers.

---

## 3. What Has Been Completed

### A. Architectural Foundation & Code Organization
The codebase follows a feature-driven, clean architecture with strict separation of concerns:
```
lib/
├── core/
│   ├── constants/       # AppConstants, Enums (TransactionType, PaymentMethod, etc.)
│   ├── database/        # Drift database, 21 table schemas, ledger.dart
│   ├── errors/          # AppException hierarchy (InsufficientStock, Validation, etc.)
│   ├── providers/       # Riverpod providers for DB, repositories, and services
│   ├── routing/         # GoRouter setup (30+ routes) and ShellRoute
│   ├── theme/           # AppColors (Dark Navy/Blue branding), AppTheme
│   ├── utils/           # ID & receipt generators, formatters, validators
│   └── widgets/         # AppScaffold, SummaryCard, Shared reusable widgets
├── data/
│   ├── models/          # Composite domain models (SaleDetail, DailyCashSummary, etc.)
│   └── repositories/    # 18 entity repositories interfacing directly with Drift
├── services/            # 15 business services encapsulating domain logic & transactions
└── features/            # 16 feature modules (presentation screens & widgets)
```

### B. Database & Transaction Ledger (`core/database/`)
- **Drift SQLite DB** (`app_database.dart` + generated `app_database.g.dart`):
  - 21 normalized tables covering: `admin`, `business`, `products`, `categories`, `suppliers`, `customers`, `sales`, `sale_items`, `purchases`, `purchase_items`, `supplier_payments`, `customer_payments`, `expenses`, `cash_entries`, `cash_closings`, `stock_transactions`, `receipts`, `receipt_settings`, `reminders`, `audit_entries`, `app_settings`.
- **Atomic Transaction Ledger** (`ledger.dart`):
  - `moveStock()`: Enforces stock non-negativity checks unless explicitly permitted, updates inventory, and creates traceable stock ledger records.
  - `addCash()`: Records signed cash movements (`+` inflow, `-` outflow) ensuring the drawer is a clean aggregate of movements.
  - `reverseCash()`: Inserts equal-and-opposite adjustment records when transactions are voided (history is never deleted).
  - `createReceipt()`: Sequential daily numbered receipts (`SL-YYYYMMDD-001`, `PUR-`, `SP-`, `CP-`).
  - `audit()`: Creates immutable audit logs for system mutations.

### C. Data Models & Repositories (`data/`)
- **Domain Models** (`models.dart`):
  - `LineItemInput`, `LineItemView`
  - `SupplierAccount` (computed total purchases, amount paid, balance)
  - `CustomerAccount` (computed debt, overdue amount, next due date)
  - `SaleDetail`, `PurchaseDetail` (joined items, parties, and receipts)
  - `DailyCashSummary` (calculated expected closing vs actual)
  - `TransactionRecord` & `TransactionFilter` (unified multi-entity query model)
  - `DashboardSnapshot` (aggregates complete business state)
  - `ReceiptData` (joined data for receipt rendering)
- **18 Repositories** (`data/repositories/`):
  - Implemented with pure Drift queries: `audit`, `auth`, `business`, `cash`, `category`, `customer_payment`, `customer`, `expense`, `inventory`, `product`, `purchase`, `receipt`, `reminder`, `sale`, `settings`, `supplier_payment`, `supplier`, and `transaction`.

### D. Business Services (`services/`)
15 complete business service classes orchestrating complex transactions:
1. `SaleService`: Atomic cash & credit sale creation, stock reduction, down-payment handling, customer debt creation, sale voiding with stock/cash reversal.
2. `PurchaseService`: Supplier purchases, inventory increments, cash/bank deductions, supplier debt balance updates, purchase voiding.
3. `InventoryService`: Direct stock adjustments and stock transaction history queries.
4. `CashService`: Opening cash setup, manual adjustments, daily closing reconciliation, discrepancy calculation.
5. `CustomerPaymentService`: Credit collection, customer debt reduction, cash drawer increase, receipt generation.
6. `SupplierPaymentService`: Supplier debt payment, cash drawer reduction, receipt generation.
7. `ExpenseService`: Categorized expense logging with cash drawer integration.
8. `ReceiptService`: Deep entity joins (sale/purchase + items + party + business header) for receipts.
9. `ReportService`: SQL aggregations (`sum`, `count`, `isBetweenValues`) for Sales, Purchases, Expenses, Cash Flow, Supplier Balances, Customer Receivables, and Stock Valuation.
10. `StockAdjustmentService`: Traceable inventory corrections (damaged, lost, found, audit).
11. `ReminderService`: Schedules and manages WhatsApp credit payment reminders.
12. `WhatsAppService`: Formats personalized reminder text, validates phone numbers, and opens WhatsApp via `url_launcher`.
13. `BackupService`: Database file copying to backup directory, backup file validation, and restore.
14. `AuthService`: Salted base64 PIN hashing, initial setup, PIN verification, and PIN changes.
15. `AuditService`: Querying system change history.

### E. Dependency Injection (`core/providers/`)
- All repositories and services are registered via `@Riverpod(keepAlive: true)` in `repository_providers.dart` and `service_providers.dart`.
- Generated provider files (`repository_providers.g.dart`, `service_providers.g.dart`, `app_router.g.dart`) are compiled and up to date.

### F. Shell Navigation & UI Layout
- `AppScaffold`: Shell navigation with 5 bottom tabs:
  1. `/dashboard`
  2. `/inventory`
  3. `/transactions`
  4. `/cash`
  5. `/more` (Settings)
  - Centered floating action button docked to open `/scanner`.
- 37 screens have been created across all 16 features.

---

## 4. Current State of the Codebase

### Static Analysis Status
- **`lib/` Production Code**: **0 ERRORS, 0 WARNINGS.**
  - `dart analyze lib` reports zero errors and zero warnings.
  - 32 `info` lints remain (primarily `prefer_const_constructors`, `prefer_final_fields`, and dangling doc comments).
- **`test/` Test Suite**: **0 ERRORS, 0 WARNINGS.**
  - `test/widget_test.dart` was updated to test `WmApp` with `ProviderScope`.
  - Comprehensive unit/integration tests for business services and ledger are still to be written.

### Git Status
- The workspace is **not a git repository** (no `.git` directory initialized).

---

## 5. What's Left (Gaps & Action Items)

The core architectural layers (Database, Repositories, Services) are complete, but **the UI layer is almost entirely composed of static wireframe mockups with hardcoded values and unhandled user actions**. The app cannot yet be operated end-to-end.

### Critical Gaps:
```
┌────────────────────────────────────────────────────────┐
│                   CURRENT GAP MATRIX                   │
├───────────────────────┬────────────────────────────────┤
│ Module                │ Status                         │
├───────────────────────┼────────────────────────────────┤
│ Database & Tables     │ [x] 100% Complete              │
│ Atomic Ledger         │ [x] 100% Complete              │
│ Repositories          │ [x] 100% Complete              │
│ Business Services     │ [x] 100% Complete              │
│ Provider DI           │ [x] 100% Complete              │
│ Routing Config        │ [x] 95% Complete (links fix)   │
│ UI Layout Wireframes  │ [x] 100% Scaffolding           │
│ UI ↔ Service Wiring   │ [ ] 10% (Major Gap)            │
│ Automated Tests       │ [ ] 0% (Needs suite setup)     │
└───────────────────────┴────────────────────────────────┘
```

### Detailed Breakdown of Remaining Work:

#### 1. Setup Wizard Persistence (`features/setup/presentation/setup_wizard_screen.dart`)
- **Current Issue**: `_completeSetup()` only calls `context.go('/dashboard')` without persisting anything.
- **Impact**: Upon every app restart, `SplashScreen` executes `businessRepo.isSetupComplete()` and `authRepo.getAdmin()`, finds empty tables, and bounces back to `/setup`.
- **To Do**: Call `businessRepository.saveBusiness(...)`, `authService.createAdmin(pin)`, and record opening cash via `cashService.setOpeningBalance(...)` on setup completion.

#### 2. Dashboard Dynamic State (`features/dashboard/presentation/dashboard_screen.dart`)
- **Current Issue**: Displays hardcoded `'PKR 0'`, `'0'`, and dummy `Activity Item $index`.
- **Broken Links**:
  - Pushes `/inventory/stock-in` → should be `/stock-in`.
  - Pushes `/inventory/stock-out` → should be `/stock-out`.
  - Pushes `/suppliers/payment` → should be `/suppliers` or `/suppliers/:id/pay`.
- **To Do**: Wire `DashboardScreen` to a provider that computes `DashboardSnapshot` from `SaleRepository`, `CashRepository`, `InventoryRepository`, and `CustomerRepository`. Fix route links.

#### 3. Product & Inventory Management
- `features/products/presentation/product_list_screen.dart`: Replace `itemCount: 5` dummy cards with `ref.watch(productRepositoryProvider).watchAll()`.
- `features/products/presentation/add_edit_product_screen.dart`: Bind form controllers to `ProductRepository.insertProduct()` / `updateProduct()`.
- `features/products/presentation/product_detail_screen.dart`: Load product by `productId`, fix edit route (`/products/:id/edit` instead of `/products/edit/:id`), fix stock in/out routes (`/stock-in`, `/stock-out`), wire real stock history from `inventoryServiceProvider.getProductHistory(id)`.
- `features/inventory/presentation/inventory_screen.dart`: Replace hardcoded stock numbers with live counts from `productRepository` / `inventoryRepository`.
- `features/inventory/presentation/stock_in_screen.dart` & `stock_out_screen.dart`: Add product picker dropdown if opened without `productId`; call `inventoryServiceProvider.moveStock()` on submit.

#### 4. Sales Workflow (Cash & Credit)
- `features/sales/presentation/create_sale_screen.dart`: Connect product search/selection dialog, dynamic cart list, discount calculation, and call `saleServiceProvider.createCashSale()`. Navigate to receipt on success.
- `features/sales/presentation/create_credit_sale_screen.dart`: Connect customer dropdown, cart items, amount received, due date, WhatsApp reminder toggle, and call `saleServiceProvider.createCreditSale()`.
- `features/sales/presentation/sale_list_screen.dart`: Display real sales stream with filters and void capability via `saleServiceProvider.voidSale()`.

#### 5. Purchases Workflow
- `features/purchases/presentation/create_purchase_screen.dart`: Wire supplier dropdown from `supplierRepositoryProvider`, add product line items, payment options, and invoke `purchaseServiceProvider.createPurchase()`.
- `features/purchases/presentation/purchase_list_screen.dart`: Display real purchases from repository.

#### 6. Suppliers & Customers
- `features/suppliers/presentation/add_edit_supplier_screen.dart`: Save to `SupplierRepository`.
- `features/suppliers/presentation/supplier_list_screen.dart`: Stream supplier accounts with outstanding balances.
- `features/suppliers/presentation/supplier_detail_screen.dart` & `supplier_payment_screen.dart`: Show purchase history and wire `supplierPaymentServiceProvider.recordPayment()`.
- `features/customers/presentation/add_edit_customer_screen.dart` (or dialog): Save to `CustomerRepository`.
- `features/customers/presentation/customer_list_screen.dart`: Stream customer accounts with debt amounts.
- `features/customers/presentation/customer_detail_screen.dart` & `customer_payment_screen.dart`: Wire `customerPaymentServiceProvider.recordPayment()`.

#### 7. Cash Drawer & Daily Closings
- `features/cash/presentation/daily_cash_screen.dart`: Watch `cashServiceProvider.getDailySummary(DateTime.now())` for opening balance, sales, collections, expenses, and expected closing.
- `features/cash/presentation/cash_close_screen.dart`: Wire `cashServiceProvider.closeDay(actualAmount, notes)`.

#### 8. Expenses
- `features/expenses/presentation/add_expense_screen.dart`: Bind form to `expenseServiceProvider.recordExpense()`.
- `features/expenses/presentation/expense_list_screen.dart`: Display real expenses stream.

#### 9. Receipts & PDF Printing
- `features/receipts/presentation/receipt_detail_screen.dart`: Fetch `receiptServiceProvider.getReceiptData(receiptId)` and render actual business name, receipt number, line items, totals, and customer/supplier details.
- Add print/share actions using `printing` (`Printing.layoutPdf()`) and `pdf` package.

#### 10. Reports
- `features/reports/presentation/reports_screen.dart` & `report_detail_screen.dart`: Bind to `reportServiceProvider`:
  - Sales report (daily, weekly, monthly, custom).
  - Purchases report.
  - Expenses report.
  - Cash flow report.
  - Inventory valuation & low-stock summary.
  - Supplier payables report.
  - Customer receivables report.

#### 11. Scanner Integration
- `features/scanner/presentation/scanner_screen.dart`: When a barcode is scanned, lookup product via `productRepositoryProvider.getByBarcode(code)`. If found, offer quick actions (View Details, Stock In, Stock Out, Add to Sale). If not found, prepopulate `AddEditProductScreen(barcode: code)`.

#### 12. Settings & Maintenance
- `features/settings/presentation/whatsapp_settings_screen.dart`: Save reminder template and hours to `settingsRepository`.
- `features/settings/presentation/backup_restore_screen.dart`: Wire `backupServiceProvider.createBackup()` and `backupServiceProvider.restoreBackup()`.
- `features/settings/presentation/settings_screen.dart`: Wire Business Profile editing and Change PIN dialog via `authServiceProvider.changePin()`.

#### 13. Testing & Tooling
- Update `test/widget_test.dart` to instantiate `WmApp` wrapped in `ProviderScope`.
- Add unit tests for `Ledger` (atomic inventory, cash adjustments, receipt sequences).
- Add integration tests for Sale and Purchase workflows.
- Initialize Git repository and commit baseline codebase.

---

## 6. Key File & Directory Map

| Directory / File | Description | Status |
|---|---|---|
| `lib/main.dart` | App entrypoint, initializes bindings, wraps in `ProviderScope` | Complete |
| `lib/app.dart` | Root `WmApp` widget, configures `MaterialApp.router` and theme | Complete |
| `lib/core/routing/app_router.dart` | GoRouter definition with ShellRoute and all feature routes | 95% (Fix path mismatches) |
| `lib/core/theme/app_colors.dart` | Palette: `primaryNavy`, `primaryBlue`, `background`, status colors | Complete |
| `lib/core/database/app_database.dart` | Drift SQLite database definition with all 21 tables | Complete |
| `lib/core/database/ledger.dart` | Low-level atomic transaction engine for stock, cash, receipts | Complete |
| `lib/core/providers/service_providers.dart` | Riverpod providers for all 15 business services | Complete |
| `lib/core/providers/repository_providers.dart` | Riverpod providers for all 18 repositories | Complete |
| `lib/data/models/models.dart` | Unified domain models, filters, aggregates, snapshots | Complete |
| `lib/services/sale_service.dart` | Cash/Credit sale creation, atomic stock & cash updates, voiding | Complete |
| `lib/services/purchase_service.dart` | Supplier purchase processing, debt balance tracking | Complete |
| `lib/services/cash_service.dart` | Cash drawer calculations, daily closing reconciliation | Complete |
| `lib/services/report_service.dart` | SQL aggregate reports for sales, purchases, cash flow, debt | Complete |
| `lib/services/receipt_service.dart` | Receipt data joining (business + items + payments) | Complete |
| `lib/features/splash/presentation/splash_screen.dart` | Initialization check (routes to `/setup`, `/login`, or `/dashboard`) | Complete |
| `lib/features/setup/presentation/setup_wizard_screen.dart` | 6-step business onboarding | Needs persistence wiring |
| `lib/features/dashboard/presentation/dashboard_screen.dart` | Main dashboard control center | Needs dynamic provider & link fixes |
| `lib/features/inventory/presentation/` | Inventory list, Stock In, Stock Out | Needs service wiring |
| `lib/features/sales/presentation/` | Cash sale, Credit sale, Sale list | Needs service wiring |
| `lib/features/purchases/presentation/` | Supplier purchase creation & history | Needs service wiring |
| `lib/features/scanner/presentation/` | Camera barcode scanner | Needs product lookup wiring |
| `lib/features/receipts/presentation/` | Receipt preview & printing | Needs PDF rendering wiring |
| `test/widget_test.dart` | Flutter smoke test | Needs fix (`MyApp` -> `WmApp`) |

---

## 7. Developer & Agent Quickstart

### Commands to Run
```powershell
# Analyze codebase (production code in lib/)
dart analyze lib

# Run Flutter Analyzer (includes test/ directory)
flutter analyze

# Re-run Riverpod and Drift code generation (if modifying tables or @riverpod annotations)
dart run build_runner build --delete-conflicting-outputs

# Run unit and widget tests
flutter test
```

### Golden Rules for Future Agents Working on this Codebase
1. **Never write raw SQL mutations or bypass `Ledger`**: Every inventory change must flow through `Ledger.moveStock()` so stock transactions and product quantities stay synchronized.
2. **Never delete financial history**: Voids and corrections must be recorded as reversal entries (`Ledger.reverseCash()`, setting `isVoided = true`, or stock adjustment records).
3. **Always use atomic transactions**: Compound operations (e.g. Sale = Sale record + Sale items + Move stock + Add cash + Generate receipt + Audit log) must run inside `_db.transaction(() async { ... })`.
4. **Maintain Offline Capability**: Do not introduce required external network calls into core business flows.
5. **Preserve Riverpod Provider Architecture**: Access repositories and services through `ref.watch()` / `ref.read()` with the providers defined in `service_providers.dart` and `repository_providers.dart`.
