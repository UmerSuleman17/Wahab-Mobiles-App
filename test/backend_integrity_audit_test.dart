import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/data/models/models.dart';
import 'package:wm_app/services/sale_service.dart';

void main() {
  late AppDatabase database;
  late SaleService saleService;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    saleService = SaleService(database);
  });

  tearDown(() async {
    await database.close();
  });

  Future<void> insertProduct({required double quantity}) async {
    final now = DateTime.now();
    await database.into(database.products).insert(
          ProductsCompanion.insert(
            id: 'product-1',
            name: 'Test product',
            purchasePrice: 4,
            sellingPrice: 10,
            quantity: Value(quantity),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  test('cash sale writes receipt, stock, cash, and audit together', () async {
    await insertProduct(quantity: 3);

    final saleId = await saleService.createCashSale(
      const [LineItemInput(productId: 'product-1', quantity: 2, unitPrice: 10)],
      PaymentMethod.cash,
    );

    final product = await (database.select(database.products)
          ..where((row) => row.id.equals('product-1')))
        .getSingle();
    final sale = await (database.select(database.sales)
          ..where((row) => row.id.equals(saleId)))
        .getSingle();
    final receipt = await (database.select(database.receipts)
          ..where((row) => row.transactionId.equals(saleId)))
        .getSingle();
    final cashEntries = await (database.select(database.cashEntries)
          ..where((row) => row.referenceId.equals(saleId)))
        .get();
    final stockEntries = await (database.select(database.stockTransactions)
          ..where((row) => row.referenceId.equals(saleId)))
        .get();
    final auditEntries = await (database.select(database.auditEntries)
          ..where((row) => row.entityId.equals(saleId)))
        .get();

    expect(product.quantity, 1);
    expect(sale.total, 20);
    expect(receipt.total, 20);
    expect(cashEntries.map((entry) => entry.amount), [20]);
    expect(stockEntries.map((entry) => entry.quantity), [-2]);
    expect(auditEntries, hasLength(1));
  });

  test('insufficient stock rolls back every earlier sale write', () async {
    await insertProduct(quantity: 1);

    await expectLater(
      saleService.createCashSale(
        const [LineItemInput(productId: 'product-1', quantity: 2, unitPrice: 10)],
        PaymentMethod.cash,
      ),
      throwsA(isA<InsufficientStockException>()),
    );

    final product = await (database.select(database.products)
          ..where((row) => row.id.equals('product-1')))
        .getSingle();

    expect(product.quantity, 1);
    expect(await database.select(database.sales).get(), isEmpty);
    expect(await database.select(database.saleItems).get(), isEmpty);
    expect(await database.select(database.receipts).get(), isEmpty);
    expect(await database.select(database.cashEntries).get(), isEmpty);
    expect(await database.select(database.stockTransactions).get(), isEmpty);
    expect(await database.select(database.auditEntries).get(), isEmpty);
  });
}
