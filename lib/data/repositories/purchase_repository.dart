import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/data/models/models.dart';

class PurchaseRepository {
  PurchaseRepository(this._db);

  final AppDatabase _db;

  Future<List<Purchase>> getAll() => (_db.select(_db.purchases)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<Purchase> getById(String id) async {
    final purchase = await (_db.select(_db.purchases)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (purchase == null) {
      throw RecordNotFoundException('Purchase', id);
    }
    return purchase;
  }

  Future<List<Purchase>> getByDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.purchases)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<Purchase>> getBySupplier(String supplierId) {
    return (_db.select(_db.purchases)
          ..where((t) => t.supplierId.equals(supplierId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> createPurchase(PurchasesCompanion purchase) =>
      _db.into(_db.purchases).insert(purchase);

  Future<int> create(PurchasesCompanion purchase) => createPurchase(purchase);

  Future<int> createPurchaseItem(PurchaseItemsCompanion item) =>
      _db.into(_db.purchaseItems).insert(item);

  Future<int> createItem(PurchaseItemsCompanion item) =>
      createPurchaseItem(item);

  Future<List<PurchaseItem>> getPurchaseItems(String purchaseId) {
    return (_db.select(_db.purchaseItems)
          ..where((t) => t.purchaseId.equals(purchaseId)))
        .get();
  }

  Future<List<PurchaseItem>> getItems(String purchaseId) =>
      getPurchaseItems(purchaseId);

  Future<void> voidPurchase(String id) async {
    await (_db.update(_db.purchases)..where((t) => t.id.equals(id))).write(
      const PurchasesCompanion(
        isVoided: Value(true),
      ),
    );
  }

  Future<double> getTodayTotal() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    final sumExpr = _db.purchases.total.sum();
    final query = _db.selectOnly(_db.purchases)
      ..addColumns([sumExpr])
      ..where(_db.purchases.createdAt.isBetweenValues(start, end) &
          _db.purchases.isVoided.equals(false));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }

  Future<double> getTotalBySupplier(String supplierId) async {
    final sumExpr = _db.purchases.total.sum();
    final query = _db.selectOnly(_db.purchases)
      ..addColumns([sumExpr])
      ..where(_db.purchases.supplierId.equals(supplierId) &
          _db.purchases.isVoided.equals(false));

    final result = await query.map((row) => row.read(sumExpr)).getSingleOrNull();
    return result ?? 0.0;
  }

  Future<PurchaseDetail> getPurchaseDetail(String id) async {
    final purchase = await getById(id);

    // Get purchase items joined with products
    final itemRows = await (_db.select(_db.purchaseItems)
          ..where((t) => t.purchaseId.equals(id)))
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
        productName: product?.name ?? 'Unknown Product',
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        total: item.total,
      );
    }).toList();

    // Supplier
    final supplier = await (_db.select(_db.suppliers)
          ..where((t) => t.id.equals(purchase.supplierId)))
        .getSingleOrNull();
    if (supplier == null) {
      throw RecordNotFoundException('Supplier', purchase.supplierId);
    }

    // Receipt
    Receipt? receipt;
    if (purchase.receiptId != null) {
      receipt = await (_db.select(_db.receipts)
            ..where((t) => t.id.equals(purchase.receiptId!)))
          .getSingleOrNull();
    }
    receipt ??= await (_db.select(_db.receipts)
          ..where((t) => t.transactionId.equals(purchase.id)))
        .getSingleOrNull();

    return PurchaseDetail(
      purchase: purchase,
      items: items,
      supplier: supplier,
      receipt: receipt,
    );
  }
}
