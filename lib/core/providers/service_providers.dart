import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:wm_app/core/providers/database_provider.dart';
import 'package:wm_app/services/auth_service.dart';
import 'package:wm_app/services/inventory_service.dart';
import 'package:wm_app/services/sale_service.dart';
import 'package:wm_app/services/purchase_service.dart';
import 'package:wm_app/services/supplier_payment_service.dart';
import 'package:wm_app/services/customer_payment_service.dart';
import 'package:wm_app/services/expense_service.dart';
import 'package:wm_app/services/cash_service.dart';
import 'package:wm_app/services/receipt_service.dart';
import 'package:wm_app/services/stock_adjustment_service.dart';
import 'package:wm_app/services/report_service.dart';
import 'package:wm_app/services/audit_service.dart';
import 'package:wm_app/services/whatsapp_service.dart';
import 'package:wm_app/services/reminder_service.dart';

part 'service_providers.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) => AuthService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
InventoryService inventoryService(Ref ref) =>
    InventoryService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SaleService saleService(Ref ref) => SaleService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
PurchaseService purchaseService(Ref ref) =>
    PurchaseService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SupplierPaymentService supplierPaymentService(Ref ref) =>
    SupplierPaymentService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CustomerPaymentService customerPaymentService(Ref ref) =>
    CustomerPaymentService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ExpenseService expenseService(Ref ref) =>
    ExpenseService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CashService cashService(Ref ref) => CashService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ReceiptService receiptService(Ref ref) =>
    ReceiptService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
StockAdjustmentService stockAdjustmentService(Ref ref) =>
    StockAdjustmentService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ReportService reportService(Ref ref) =>
    ReportService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
AuditService auditService(Ref ref) =>
    AuditService(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
WhatsAppService whatsAppService(Ref ref) => WhatsAppService();

@Riverpod(keepAlive: true)
ReminderService reminderService(Ref ref) => ReminderService(
      ref.watch(appDatabaseProvider),
      ref.watch(whatsAppServiceProvider),
    );
