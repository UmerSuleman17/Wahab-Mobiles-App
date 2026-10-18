import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/core/errors/app_exception.dart';

class StockAdjustmentService {
  StockAdjustmentService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<void> adjustStock(
    String productId,
    double quantity,
    bool increase,
    String reason, {
    String? notes,
  }) async {
    if (quantity <= 0) {
      throw const InvalidAmountException('Adjustment quantity must be greater than zero');
    }

    await _db.transaction(() async {
      final product = await (_db.select(_db.products)
            ..where((t) => t.id.equals(productId)))
          .getSingleOrNull();
      if (product == null) {
        throw RecordNotFoundException('Product', productId);
      }

      final delta = increase ? quantity.abs() : -quantity.abs();
      final reasonText = notes != null && notes.trim().isNotEmpty
          ? '$reason: ${notes.trim()}'
          : reason;

      final updated = await _ledger.moveStock(
        productId: productId,
        delta: delta,
        type: StockTransactionType.adjustment,
        unitPrice: product.purchasePrice,
        reason: reasonText,
        allowNegative: await _ledger.allowNegativeStock(),
      );

      await _ledger.audit(
        action: AuditAction.adjust,
        entityType: AuditEntityType.product,
        entityId: productId,
        previousValue: 'Quantity: ${product.quantity}',
        newValue: 'Quantity: ${updated.quantity}, Reason: $reasonText',
      );
    });
  }
}
