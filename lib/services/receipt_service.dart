import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/data/models/models.dart';

class ReceiptService {
  ReceiptService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<Receipt> generateReceipt(
    String transactionId,
    ReceiptType type,
    double total,
  ) async {
    return _ledger.createReceipt(
      type: type,
      transactionId: transactionId,
      total: total,
    );
  }

  Future<ReceiptData?> getReceiptData(String receiptId) async {
    final receipt = await (_db.select(_db.receipts)
          ..where((t) => t.id.equals(receiptId) | t.receiptNumber.equals(receiptId)))
        .getSingleOrNull();
    if (receipt == null) return null;

    final business = await (_db.select(_db.businessEntries)..limit(1)).getSingleOrNull();
    final settings = await (_db.select(_db.receiptSettings)..limit(1)).getSingleOrNull();

    final type = ReceiptType.values[receipt.type];

    switch (type) {
      case ReceiptType.sale:
        final sale = await (_db.select(_db.sales)
              ..where((t) => t.id.equals(receipt.transactionId)))
            .getSingleOrNull();

        final itemRows = await (_db.select(_db.saleItems)
              ..where((t) => t.saleId.equals(receipt.transactionId)))
            .join([
          leftOuterJoin(
            _db.products,
            _db.products.id.equalsExp(_db.saleItems.productId),
          ),
        ]).get();

        final items = itemRows.map((row) {
          final item = row.readTable(_db.saleItems);
          final product = row.readTableOrNull(_db.products);
          return LineItemView(
            productId: item.productId,
            productName: product?.name ?? 'Unknown Item',
            quantity: item.quantity,
            unitPrice: item.unitPrice,
            total: item.total,
          );
        }).toList();

        Customer? customer;
        if (sale?.customerId != null) {
          customer = await (_db.select(_db.customers)
                ..where((t) => t.id.equals(sale!.customerId!)))
              .getSingleOrNull();
        }

        final subtotal = items.fold<double>(0, (s, i) => s + i.total);

        return ReceiptData(
          receipt: receipt,
          type: type,
          business: business,
          settings: settings,
          items: items,
          subtotal: subtotal > 0 ? subtotal : receipt.total,
          discount: sale?.discount ?? 0,
          total: receipt.total,
          paymentMethod: sale != null
              ? PaymentMethod.values[sale.paymentMethod]
              : PaymentMethod.cash,
          amountPaid: sale?.amountReceived,
          balanceDue: sale != null ? (sale.total - sale.amountReceived) : null,
          partyLabel: 'Customer',
          partyName: customer?.name,
          partyPhone: customer?.phone,
          dueDate: sale?.dueDate,
          notes: sale?.notes,
          isVoided: sale?.isVoided ?? false,
        );

      case ReceiptType.purchase:
        final purchase = await (_db.select(_db.purchases)
              ..where((t) => t.id.equals(receipt.transactionId)))
            .getSingleOrNull();

        final itemRows = await (_db.select(_db.purchaseItems)
              ..where((t) => t.purchaseId.equals(receipt.transactionId)))
            .join([
          leftOuterJoin(
            _db.products,
            _db.products.id.equalsExp(_db.purchaseItems.productId),
          ),
        ]).get();

        final items = itemRows.map((row) {
          final item = row.readTable(_db.purchaseItems);
          final product = row.readTableOrNull(_db.products);
          return LineItemView(
            productId: item.productId,
            productName: product?.name ?? 'Unknown Item',
            quantity: item.quantity,
            unitPrice: item.unitPrice,
            total: item.total,
          );
        }).toList();

        Supplier? supplier;
        if (purchase != null) {
          supplier = await (_db.select(_db.suppliers)
                ..where((t) => t.id.equals(purchase.supplierId)))
              .getSingleOrNull();
        }

        final subtotal = items.fold<double>(0, (s, i) => s + i.total);

        return ReceiptData(
          receipt: receipt,
          type: type,
          business: business,
          settings: settings,
          items: items,
          subtotal: subtotal > 0 ? subtotal : receipt.total,
          discount: purchase?.discount ?? 0,
          total: receipt.total,
          paymentMethod: purchase != null
              ? PaymentMethod.values[purchase.paymentMethod]
              : PaymentMethod.cash,
          amountPaid: purchase?.amountPaid,
          balanceDue: purchase != null ? (purchase.total - purchase.amountPaid) : null,
          partyLabel: 'Supplier',
          partyName: supplier?.name,
          partyPhone: supplier?.phone,
          notes: purchase?.notes,
          isVoided: purchase?.isVoided ?? false,
        );

      case ReceiptType.supplierPayment:
        final sp = await (_db.select(_db.supplierPayments)
              ..where((t) => t.id.equals(receipt.transactionId)))
            .getSingleOrNull();

        Supplier? supplier;
        if (sp != null) {
          supplier = await (_db.select(_db.suppliers)
                ..where((t) => t.id.equals(sp.supplierId)))
              .getSingleOrNull();
        }

        return ReceiptData(
          receipt: receipt,
          type: type,
          business: business,
          settings: settings,
          items: const [],
          subtotal: receipt.total,
          discount: 0,
          total: receipt.total,
          paymentMethod: sp != null
              ? PaymentMethod.values[sp.paymentMethod]
              : PaymentMethod.cash,
          amountPaid: sp?.amount ?? receipt.total,
          balanceDue: 0,
          partyLabel: 'Supplier',
          partyName: supplier?.name,
          partyPhone: supplier?.phone,
          notes: sp?.notes,
          isVoided: sp?.isVoided ?? false,
        );

      case ReceiptType.customerPayment:
        final cp = await (_db.select(_db.customerPayments)
              ..where((t) => t.id.equals(receipt.transactionId)))
            .getSingleOrNull();

        Customer? customer;
        if (cp != null) {
          customer = await (_db.select(_db.customers)
                ..where((t) => t.id.equals(cp.customerId)))
              .getSingleOrNull();
        }

        return ReceiptData(
          receipt: receipt,
          type: type,
          business: business,
          settings: settings,
          items: const [],
          subtotal: receipt.total,
          discount: 0,
          total: receipt.total,
          paymentMethod: cp != null
              ? PaymentMethod.values[cp.paymentMethod]
              : PaymentMethod.cash,
          amountPaid: cp?.amount ?? receipt.total,
          balanceDue: 0,
          partyLabel: 'Customer',
          partyName: customer?.name,
          partyPhone: customer?.phone,
          notes: cp?.notes,
          isVoided: false,
        );
    }
  }
}
