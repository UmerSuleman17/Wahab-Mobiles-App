import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';

class InventoryRepository {
  InventoryRepository(this._db);

  final AppDatabase _db;

  Future<List<StockTransaction>> getProductHistory(String productId) {
    return (_db.select(_db.stockTransactions)
          ..where((t) => t.productId.equals(productId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<List<StockTransaction>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return (_db.select(_db.stockTransactions)
          ..where((t) => t.createdAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> recordStockTransaction(StockTransactionsCompanion transaction) {
    return _db.into(_db.stockTransactions).insert(transaction);
  }

  Future<List<StockTransaction>> getTransactionsByType(int type) {
    return (_db.select(_db.stockTransactions)
          ..where((t) => t.type.equals(type))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }
}
