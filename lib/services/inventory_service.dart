import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/data/repositories/inventory_repository.dart';

class InventoryService {
  InventoryService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);
  late final _repo = InventoryRepository(_db);

  Future<Product> moveStock({
    required String productId,
    required double delta,
    required StockTransactionType type,
    required double unitPrice,
    String? referenceId,
    String? reason,
    bool allowNegative = false,
  }) {
    return _ledger.moveStock(
      productId: productId,
      delta: delta,
      type: type,
      unitPrice: unitPrice,
      referenceId: referenceId,
      reason: reason,
      allowNegative: allowNegative,
    );
  }

  Future<List<StockTransaction>> getProductHistory(String productId) {
    return _repo.getProductHistory(productId);
  }

  Future<List<StockTransaction>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return _repo.getTransactionsByDateRange(start, end);
  }
}
