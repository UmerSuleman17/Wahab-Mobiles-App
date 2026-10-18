import 'package:drift/drift.dart';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';

/// Repository for product inventory operations.
///
/// Provides CRUD, search, stock-level queries, and
/// aggregate inventory value calculations.
class ProductRepository {
  ProductRepository(this._db);

  final AppDatabase _db;

  /// Retrieves all products ordered by name.
  Future<List<Product>> getAllProducts() {
    final query = _db.select(_db.products)
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.get();
  }

  /// Retrieves a single product by [id].
  ///
  /// Throws [RecordNotFoundException] if not found.
  Future<Product> getById(String id) async {
    final query = _db.select(_db.products)
      ..where((t) => t.id.equals(id));
    final result = await query.getSingleOrNull();
    if (result == null) {
      throw RecordNotFoundException('Product', id);
    }
    return result;
  }

  /// Retrieves a product by its [barcode], or null if not found.
  Future<Product?> getByBarcode(String barcode) {
    final query = _db.select(_db.products)
      ..where((t) => t.barcode.equals(barcode));
    return query.getSingleOrNull();
  }

  /// Retrieves a product by its [sku], or null if not found.
  Future<Product?> getBySku(String sku) {
    final query = _db.select(_db.products)
      ..where((t) => t.sku.equals(sku));
    return query.getSingleOrNull();
  }

  /// Searches products by name, SKU, or barcode containing [query].
  Future<List<Product>> search(String query) {
    final pattern = '%$query%';
    final q = _db.select(_db.products)
      ..where((t) =>
          t.name.like(pattern) |
          t.sku.like(pattern) |
          t.barcode.like(pattern))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return q.get();
  }

  /// Retrieves all products in a given [categoryId].
  Future<List<Product>> getByCategory(String categoryId) {
    final query = _db.select(_db.products)
      ..where((t) => t.categoryId.equals(categoryId))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.get();
  }

  /// Retrieves products whose quantity is at or below their minimum stock level
  /// but still greater than zero.
  Future<List<Product>> getLowStock() {
    final query = _db.select(_db.products)
      ..where((t) =>
          t.quantity.isSmallerOrEqual(t.minStock.cast<double>()) &
          t.quantity.isBiggerThanValue(0))
      ..orderBy([(t) => OrderingTerm.asc(t.quantity)]);
    return query.get();
  }

  /// Retrieves products with zero quantity.
  Future<List<Product>> getOutOfStock() {
    final query = _db.select(_db.products)
      ..where((t) => t.quantity.equals(0))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.get();
  }

  /// Creates a new product from the given [companion].
  Future<void> create(ProductsCompanion companion) {
    return _db.into(_db.products).insert(companion);
  }

  /// Updates a product identified by [id] with the given [companion].
  ///
  /// Throws [RecordNotFoundException] if the product does not exist.
  Future<void> update(String id, ProductsCompanion companion) async {
    final count = await (_db.update(_db.products)
          ..where((t) => t.id.equals(id)))
        .write(companion);
    if (count == 0) {
      throw RecordNotFoundException('Product', id);
    }
  }

  /// Updates only the quantity of a product identified by [id].
  ///
  /// Throws [RecordNotFoundException] if the product does not exist.
  Future<void> updateQuantity(String id, double qty) async {
    final count = await (_db.update(_db.products)
          ..where((t) => t.id.equals(id)))
        .write(ProductsCompanion(
      quantity: Value(qty),
      updatedAt: Value(DateTime.now()),
    ));
    if (count == 0) {
      throw RecordNotFoundException('Product', id);
    }
  }

  /// Deletes a product by [id].
  ///
  /// Throws [RecordNotFoundException] if the product does not exist.
  Future<void> delete(String id) async {
    final count = await (_db.delete(_db.products)
          ..where((t) => t.id.equals(id)))
        .go();
    if (count == 0) {
      throw RecordNotFoundException('Product', id);
    }
  }

  /// Returns the total number of products.
  Future<int> getCount() async {
    final countExpr = _db.products.id.count();
    final query = _db.selectOnly(_db.products)..addColumns([countExpr]);
    final result = await query.getSingle();
    return result.read(countExpr) ?? 0;
  }

  /// Returns the total inventory value (sum of quantity × purchasePrice).
  Future<double> getTotalInventoryValue() async {
    final valueExpr =
        (_db.products.quantity * _db.products.purchasePrice).sum();
    final query = _db.selectOnly(_db.products)..addColumns([valueExpr]);
    final result = await query.getSingle();
    return result.read(valueExpr) ?? 0.0;
  }
}
