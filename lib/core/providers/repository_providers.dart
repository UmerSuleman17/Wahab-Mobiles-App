import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:wm_app/core/providers/database_provider.dart';
import 'package:wm_app/data/repositories/auth_repository.dart';
import 'package:wm_app/data/repositories/business_repository.dart';
import 'package:wm_app/data/repositories/product_repository.dart';
import 'package:wm_app/data/repositories/category_repository.dart';
import 'package:wm_app/data/repositories/supplier_repository.dart';
import 'package:wm_app/data/repositories/customer_repository.dart';
import 'package:wm_app/data/repositories/inventory_repository.dart';
import 'package:wm_app/data/repositories/sale_repository.dart';
import 'package:wm_app/data/repositories/purchase_repository.dart';
import 'package:wm_app/data/repositories/supplier_payment_repository.dart';
import 'package:wm_app/data/repositories/customer_payment_repository.dart';
import 'package:wm_app/data/repositories/expense_repository.dart';
import 'package:wm_app/data/repositories/cash_repository.dart';
import 'package:wm_app/data/repositories/receipt_repository.dart';
import 'package:wm_app/data/repositories/transaction_repository.dart';
import 'package:wm_app/data/repositories/audit_repository.dart';
import 'package:wm_app/data/repositories/reminder_repository.dart';
import 'package:wm_app/data/repositories/settings_repository.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
BusinessRepository businessRepository(Ref ref) =>
    BusinessRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) =>
    ProductRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) =>
    CategoryRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SupplierRepository supplierRepository(Ref ref) =>
    SupplierRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CustomerRepository customerRepository(Ref ref) =>
    CustomerRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(Ref ref) =>
    InventoryRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SaleRepository saleRepository(Ref ref) =>
    SaleRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
PurchaseRepository purchaseRepository(Ref ref) =>
    PurchaseRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SupplierPaymentRepository supplierPaymentRepository(Ref ref) =>
    SupplierPaymentRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CustomerPaymentRepository customerPaymentRepository(Ref ref) =>
    CustomerPaymentRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ExpenseRepository expenseRepository(Ref ref) =>
    ExpenseRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CashRepository cashRepository(Ref ref) =>
    CashRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ReceiptRepository receiptRepository(Ref ref) =>
    ReceiptRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(Ref ref) =>
    TransactionRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
AuditRepository auditRepository(Ref ref) =>
    AuditRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ReminderRepository reminderRepository(Ref ref) =>
    ReminderRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    SettingsRepository(ref.watch(appDatabaseProvider));
