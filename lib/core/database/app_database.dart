import 'package:drift/drift.dart';

import 'tables/admin_table.dart';
import 'tables/app_settings_table.dart';
import 'tables/audit_entries_table.dart';
import 'tables/business_table.dart';
import 'tables/cash_closings_table.dart';
import 'tables/cash_entries_table.dart';
import 'tables/categories_table.dart';
import 'tables/customer_payments_table.dart';
import 'tables/customers_table.dart';
import 'tables/expenses_table.dart';
import 'tables/products_table.dart';
import 'tables/purchase_items_table.dart';
import 'tables/purchases_table.dart';
import 'tables/receipt_settings_table.dart';
import 'tables/receipts_table.dart';
import 'tables/reminders_table.dart';
import 'tables/sale_items_table.dart';
import 'tables/sales_table.dart';
import 'tables/stock_transactions_table.dart';
import 'tables/supplier_payments_table.dart';
import 'tables/suppliers_table.dart';

part 'app_database.g.dart';

/// Central offline-first SQLite database.
///
/// Repositories are the only layer that talks to this class directly, so a
/// REST/cloud data source can later replace it without touching services/UI.
@DriftDatabase(
  tables: [
    AdminEntries,
    BusinessEntries,
    AppSettings,
    Categories,
    Products,
    Suppliers,
    Customers,
    Sales,
    SaleItems,
    Purchases,
    PurchaseItems,
    SupplierPayments,
    CustomerPayments,
    Expenses,
    StockTransactions,
    CashEntries,
    CashClosings,
    Receipts,
    ReceiptSettings,
    AuditEntries,
    Reminders,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Speeds up the most common lookups.
        await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_products_barcode ON products (barcode)');
        await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_products_sku ON products (sku)');
        await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_stock_tx_product ON stock_transactions (product_id, created_at)');
        await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_cash_created ON cash_entries (created_at)');
        await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sales_created ON sales (created_at)');
        await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_purchases_created ON purchases (created_at)');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future schema migrations go here.
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
