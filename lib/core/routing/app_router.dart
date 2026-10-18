import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:wm_app/features/splash/presentation/splash_screen.dart';
import 'package:wm_app/features/auth/presentation/login_screen.dart';
import 'package:wm_app/features/setup/presentation/setup_wizard_screen.dart';
import 'package:wm_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:wm_app/features/products/presentation/product_list_screen.dart';
import 'package:wm_app/features/products/presentation/product_detail_screen.dart';
import 'package:wm_app/features/products/presentation/add_edit_product_screen.dart';
import 'package:wm_app/features/scanner/presentation/scanner_screen.dart';
import 'package:wm_app/features/inventory/presentation/inventory_screen.dart';
import 'package:wm_app/features/inventory/presentation/stock_in_screen.dart';
import 'package:wm_app/features/inventory/presentation/stock_out_screen.dart';
import 'package:wm_app/features/purchases/presentation/purchase_list_screen.dart';
import 'package:wm_app/features/purchases/presentation/create_purchase_screen.dart';
import 'package:wm_app/features/sales/presentation/sale_list_screen.dart';
import 'package:wm_app/features/sales/presentation/create_sale_screen.dart';
import 'package:wm_app/features/sales/presentation/create_credit_sale_screen.dart';
import 'package:wm_app/features/customers/presentation/customer_list_screen.dart';
import 'package:wm_app/features/customers/presentation/customer_detail_screen.dart';
import 'package:wm_app/features/customers/presentation/customer_payment_screen.dart';
import 'package:wm_app/features/suppliers/presentation/supplier_list_screen.dart';
import 'package:wm_app/features/suppliers/presentation/supplier_detail_screen.dart';
import 'package:wm_app/features/suppliers/presentation/add_edit_supplier_screen.dart';
import 'package:wm_app/features/supplier_payments/presentation/supplier_payment_screen.dart';
import 'package:wm_app/features/expenses/presentation/expense_list_screen.dart';
import 'package:wm_app/features/expenses/presentation/add_expense_screen.dart';
import 'package:wm_app/features/cash/presentation/daily_cash_screen.dart';
import 'package:wm_app/features/cash/presentation/cash_close_screen.dart';
import 'package:wm_app/features/receipts/presentation/receipt_list_screen.dart';
import 'package:wm_app/features/receipts/presentation/receipt_detail_screen.dart';
import 'package:wm_app/features/transactions/presentation/transaction_list_screen.dart';
import 'package:wm_app/features/transactions/presentation/transaction_detail_screen.dart';
import 'package:wm_app/features/stock_adjustments/presentation/stock_adjustment_screen.dart';
import 'package:wm_app/features/reports/presentation/reports_screen.dart';
import 'package:wm_app/features/reports/presentation/report_detail_screen.dart';
import 'package:wm_app/features/settings/presentation/settings_screen.dart';
import 'package:wm_app/features/settings/presentation/backup_restore_screen.dart';
import 'package:wm_app/features/settings/presentation/whatsapp_settings_screen.dart';
import 'package:wm_app/core/widgets/app_scaffold.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/setup',
        builder: (context, state) => const SetupWizardScreen(),
      ),

      // Shell route for bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/inventory',
            builder: (context, state) => const InventoryScreen(),
          ),
          GoRoute(
            path: '/transactions',
            builder: (context, state) => const TransactionListScreen(),
          ),
          GoRoute(
            path: '/cash',
            builder: (context, state) => const DailyCashScreen(),
          ),
          GoRoute(
            path: '/more',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),

      // Product routes
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/products/add',
        builder: (context, state) => const AddEditProductScreen(),
      ),
      GoRoute(
        path: '/products/:id',
        builder: (context, state) =>
            ProductDetailScreen(productId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/products/:id/edit',
        builder: (context, state) =>
            AddEditProductScreen(productId: state.pathParameters['id']),
      ),

      // Scanner
      GoRoute(
        path: '/scanner',
        builder: (context, state) => const ScannerScreen(),
      ),

      // Stock
      GoRoute(
        path: '/stock-in',
        builder: (context, state) => StockInScreen(
          productId: state.uri.queryParameters['productId'],
        ),
      ),
      GoRoute(
        path: '/stock-out',
        builder: (context, state) => StockOutScreen(
          productId: state.uri.queryParameters['productId'],
        ),
      ),
      GoRoute(
        path: '/stock-adjustment',
        builder: (context, state) => StockAdjustmentScreen(
          productId: state.uri.queryParameters['productId'],
        ),
      ),

      // Purchases
      GoRoute(
        path: '/purchases',
        builder: (context, state) => const PurchaseListScreen(),
      ),
      GoRoute(
        path: '/purchases/create',
        builder: (context, state) => const CreatePurchaseScreen(),
      ),

      // Sales
      GoRoute(
        path: '/sales',
        builder: (context, state) => const SaleListScreen(),
      ),
      GoRoute(
        path: '/sales/create',
        builder: (context, state) => const CreateSaleScreen(),
      ),
      GoRoute(
        path: '/sales/create-credit',
        builder: (context, state) => const CreateCreditSaleScreen(),
      ),

      // Customers
      GoRoute(
        path: '/customers',
        builder: (context, state) => const CustomerListScreen(),
      ),
      GoRoute(
        path: '/customers/:id',
        builder: (context, state) =>
            CustomerDetailScreen(customerId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/customers/:id/pay',
        builder: (context, state) =>
            CustomerPaymentScreen(customerId: state.pathParameters['id']!),
      ),

      // Suppliers
      GoRoute(
        path: '/suppliers',
        builder: (context, state) => const SupplierListScreen(),
      ),
      GoRoute(
        path: '/suppliers/add',
        builder: (context, state) => const AddEditSupplierScreen(),
      ),
      GoRoute(
        path: '/suppliers/:id',
        builder: (context, state) =>
            SupplierDetailScreen(supplierId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/suppliers/:id/edit',
        builder: (context, state) =>
            AddEditSupplierScreen(supplierId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/suppliers/:id/pay',
        builder: (context, state) =>
            SupplierPaymentScreen(supplierId: state.pathParameters['id']),
      ),

      // Expenses
      GoRoute(
        path: '/expenses',
        builder: (context, state) => const ExpenseListScreen(),
      ),
      GoRoute(
        path: '/expenses/add',
        builder: (context, state) => const AddExpenseScreen(),
      ),

      // Cash
      GoRoute(
        path: '/cash/close',
        builder: (context, state) => const CashCloseScreen(),
      ),

      // Receipts
      GoRoute(
        path: '/receipts',
        builder: (context, state) => const ReceiptListScreen(),
      ),
      GoRoute(
        path: '/receipts/:id',
        builder: (context, state) =>
            ReceiptDetailScreen(receiptId: state.pathParameters['id']!),
      ),

      // Transaction detail
      GoRoute(
        path: '/transactions/:id',
        builder: (context, state) =>
            TransactionDetailScreen(transactionId: state.pathParameters['id']!),
      ),

      // Reports
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: '/reports/:type',
        builder: (context, state) =>
            ReportDetailScreen(reportType: state.pathParameters['type']!),
      ),

      // Settings sub-pages
      GoRoute(
        path: '/settings/backup',
        builder: (context, state) => const BackupRestoreScreen(),
      ),
      GoRoute(
        path: '/settings/whatsapp',
        builder: (context, state) => const WhatsappSettingsScreen(),
      ),
    ],
  );
}
