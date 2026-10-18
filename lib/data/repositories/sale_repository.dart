import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/data/models/models.dart';

class SaleRepository {
  SaleRepository(this._db);

  final AppDatabase _db;

  Future<List<Sale>> getAll() => (_db.select(_db.sales)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<Sale> getById(String id) async {
    final sale = await (_db.select(_db.sales)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (sale == null) {
      throw RecordNotFoundException('Sale', id);
    }
    return sale;
  }

  Future<List<Sale>> getByDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.sales)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<Sale>> getByCustomer(String customerId) {
    return (_db.select(_db.sales)
          ..where((t) => t.customerId.equals(customerId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<Sale>> getCreditSales() {
    return (_db.select(_db.sales)
          ..where((t) =>
              t.saleType.equals(SaleType.credit.index) &
              t.isVoided.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<Sale>> getOverdue() async {
    final now = DateTime.now();
    final creditSales = await (_db.select(_db.sales)
          ..where((t) =>
              t.saleType.equals(SaleType.credit.index) &
              t.isVoided.equals(false) &
              t.dueDate.isNotNull() &
              t.dueDate.isSmallerThanValue(now))
          ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
        .get();

    return creditSales.where((s) => (s.total - s.amountReceived) > 0.009).toList();
  }

  Future<int> createSale(SalesCompanion sale) =>
      _db.into(_db.sales).insert(sale);

  Future<int> create(SalesCompanion sale) => createSale(sale);

  Future<int> createSaleItem(SaleItemsCompanion item) =>
      _db.into(_db.saleItems).insert(item);

  Future<int> createItem(SaleItemsCompanion item) => createSaleItem(item);

  Future<List<SaleItem>> getSaleItems(String saleId) {
    return (_db.select(_db.saleItems)..where((t) => t.saleId.equals(saleId)))
        .get();
  }

  Future<List<SaleItem>> getItems(String saleId) => getSaleItems(saleId);

  Future<void> updatePaymentStatus(
    String id,
    int paymentStatus,
    double amountReceived,
  ) async {
    await (_db.update(_db.sales)..where((t) => t.id.equals(id))).write(
      SalesCompanion(
        paymentStatus: Value(paymentStatus),
        amountReceived: Value(amountReceived),
      ),
    );
  }

  Future<void> voidSale(String id) async {
    await (_db.update(_db.sales)..where((t) => t.id.equals(id))).write(
      const SalesCompanion(
        isVoided: Value(true),
      ),
    );
  }

  Future<double> getTodayTotal() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    final sumExpr = _db.sales.total.sum();
    final query = _db.selectOnly(_db.sales)
      ..addColumns([sumExpr])
      ..where(_db.sales.createdAt.isBetweenValues(start, end) &
          _db.sales.isVoided.equals(false));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }

  Future<SaleDetail> getSaleDetail(String id) async {
    final sale = await getById(id);

    // Get sale items joined with products
    final itemRows = await (_db.select(_db.saleItems)
          ..where((t) => t.saleId.equals(id)))
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
        productName: product?.name ?? 'Unknown Product',
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        total: item.total,
      );
    }).toList();

    // Customer
    Customer? customer;
    if (sale.customerId != null) {
      customer = await (_db.select(_db.customers)
            ..where((t) => t.id.equals(sale.customerId!)))
          .getSingleOrNull();
    }

    // Receipt
    Receipt? receipt;
    if (sale.receiptId != null) {
      receipt = await (_db.select(_db.receipts)
            ..where((t) => t.id.equals(sale.receiptId!)))
          .getSingleOrNull();
    }
    receipt ??= await (_db.select(_db.receipts)
          ..where((t) => t.transactionId.equals(sale.id)))
        .getSingleOrNull();

    // Payments
    final payments = await (_db.select(_db.customerPayments)
          ..where((t) => t.saleId.equals(sale.id)))
        .get();

    return SaleDetail(
      sale: sale,
      items: items,
      customer: customer,
      receipt: receipt,
      payments: payments,
    );
  }
}
