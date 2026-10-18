import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/open.dart' as sqlite_open;
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/services/portable_backup_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  if (Platform.isWindows) {
    sqlite_open.open.overrideFor(
      sqlite_open.OperatingSystem.windows,
      () => DynamicLibrary.open('winsqlite3.dll'),
    );
  }

  late AppDatabase source;
  late AppDatabase destination;
  late PortableBackupService sourceService;
  late PortableBackupService destinationService;

  Future<AppDatabase> openDatabase() async {
    final database = AppDatabase(NativeDatabase.memory());
    await database.customSelect('SELECT 1').get();
    return database;
  }

  setUp(() async {
    source = await openDatabase();
    destination = await openDatabase();
    sourceService = PortableBackupService(source);
    destinationService = PortableBackupService(destination);
  });

  tearDown(() async {
    await source.close();
    await destination.close();
  });

  test('exports the current table and column sets', () async {
    final bytes = await sourceService.exportBackup();
    final envelope = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    final tables = envelope['tables'] as Map<String, dynamic>;
    final expectedTables =
        source.allTables.map((table) => table.actualTableName).toSet();

    expect(envelope['format'], 'wm_app_backup');
    expect(envelope['formatVersion'], 1);
    expect(envelope['schemaVersion'], source.schemaVersion);
    expect(DateTime.parse(envelope['exportedAtUtc'] as String).isUtc, isTrue);
    expect(tables.keys.toSet(), expectedTables);
    for (final table in source.allTables) {
      final rows = tables[table.actualTableName] as List<dynamic>;
      expect(rows, isEmpty);
      expect(
        table.$columns.map((column) => column.name).toSet(),
        isNotEmpty,
      );
    }
  });

  test('restores business, money, ledger, receipt and audit values', () async {
    final createdAt = DateTime.utc(2026, 10, 15, 12, 30);
    await source.into(source.businessEntries).insert(
          BusinessEntriesCompanion.insert(
            id: 'business-1',
            name: 'Local shop',
            openingCash: const Value(12345.67),
            createdAt: createdAt,
            updatedAt: createdAt,
          ),
        );
    await source.into(source.categories).insert(
          CategoriesCompanion.insert(id: 'category-1', name: 'Stock'),
        );
    await source.into(source.products).insert(
          ProductsCompanion.insert(
            id: 'product-1',
            name: 'Widget',
            categoryId: const Value('category-1'),
            purchasePrice: 1.11,
            sellingPrice: 1.23,
            createdAt: createdAt,
            updatedAt: createdAt,
          ),
        );
    await source.into(source.stockTransactions).insert(
          StockTransactionsCompanion.insert(
            id: 'stock-1',
            productId: 'product-1',
            type: 0,
            quantity: 2.5,
            unitPrice: 1.11,
            total: 2.775,
            createdAt: createdAt,
          ),
        );
    await source.into(source.cashEntries).insert(
          CashEntriesCompanion.insert(
            id: 'cash-1',
            type: 0,
            amount: 987.65,
            description: 'Opening float',
            createdAt: createdAt,
          ),
        );
    await source.into(source.receipts).insert(
          ReceiptsCompanion.insert(
            id: 'receipt-1',
            receiptNumber: 'R-0001',
            transactionId: 'sale-1',
            type: 0,
            total: 1.23,
            createdAt: createdAt,
          ),
        );
    await source.into(source.auditEntries).insert(
          AuditEntriesCompanion.insert(
            id: 'audit-1',
            action: 0,
            entityType: 0,
            entityId: 'product-1',
            newValue: const Value('Widget created'),
            createdAt: createdAt,
          ),
        );
    await destination.into(destination.appSettings).insert(
          AppSettingsCompanion.insert(
              key: 'existing', value: 'keep until restore'),
        );

    final summary = destinationService.inspectBackup(
      await sourceService.exportBackup(),
    );
    expect(summary.rowCounts['business_entries'], 1);
    expect(summary.rowCounts['stock_transactions'], 1);
    expect(summary.rowCounts['receipts'], 1);
    expect(summary.rowCounts['audit_entries'], 1);

    await destinationService.restoreBackup(summary);

    expect(
        (await destination.select(destination.businessEntries).getSingle())
            .openingCash,
        12345.67);
    expect(
        (await destination.select(destination.stockTransactions).getSingle())
            .total,
        2.775);
    expect(
        (await destination.select(destination.cashEntries).getSingle()).amount,
        987.65);
    expect(
        (await destination.select(destination.receipts).getSingle())
            .receiptNumber,
        'R-0001');
    expect(
        (await destination.select(destination.auditEntries).getSingle())
            .newValue,
        'Widget created');
    expect(await destination.select(destination.appSettings).get(), isEmpty);
  });

  test('rejects malformed, unsupported, and structurally invalid backups',
      () async {
    expect(() => sourceService.inspectBackup(Uint8List.fromList([0xff])),
        throwsFormatException);
    expect(
        () => sourceService.inspectBackup(Uint8List.fromList(utf8.encode('{'))),
        throwsFormatException);

    final valid = jsonDecode(utf8.decode(await sourceService.exportBackup()))
        as Map<String, dynamic>;
    final wrongFormat = Map<String, dynamic>.from(valid)..['format'] = 'other';
    final futureFormat = Map<String, dynamic>.from(valid)
      ..['formatVersion'] = 2;
    final futureSchema = Map<String, dynamic>.from(valid)
      ..['schemaVersion'] = 2;
    final missingTable = Map<String, dynamic>.from(valid)
      ..['tables'] = Map<String, dynamic>.from(valid['tables'] as Map)
      ..remove('not_used');
    (missingTable['tables'] as Map<String, dynamic>).remove('products');
    final extraColumn = Map<String, dynamic>.from(valid)
      ..['tables'] = Map<String, dynamic>.from(valid['tables'] as Map);
    (extraColumn['tables'] as Map<String, dynamic>)['app_settings'] = [
      {'key': 'x', 'value': 'y', 'extra': 1},
    ];
    final missingColumn = Map<String, dynamic>.from(valid)
      ..['tables'] = Map<String, dynamic>.from(valid['tables'] as Map);
    (missingColumn['tables'] as Map<String, dynamic>)['app_settings'] = [
      {'key': 'x'},
    ];
    final invalidScalar = Map<String, dynamic>.from(valid)
      ..['tables'] = Map<String, dynamic>.from(valid['tables'] as Map);
    (invalidScalar['tables'] as Map<String, dynamic>)['app_settings'] = [
      {'key': 'x', 'value': ['nested']},
    ];

    Uint8List encode(Map<String, dynamic> value) =>
        Uint8List.fromList(utf8.encode(jsonEncode(value)));
    expect(() => sourceService.inspectBackup(encode(wrongFormat)),
        throwsFormatException);
    expect(() => sourceService.inspectBackup(encode(futureFormat)),
        throwsFormatException);
    expect(() => sourceService.inspectBackup(encode(futureSchema)),
        throwsFormatException);
    expect(() => sourceService.inspectBackup(encode(missingTable)),
        throwsFormatException);
    expect(() => sourceService.inspectBackup(encode(extraColumn)),
        throwsFormatException);
    expect(() => sourceService.inspectBackup(encode(missingColumn)),
        throwsFormatException);
    expect(() => sourceService.inspectBackup(encode(invalidScalar)),
        throwsFormatException);
  });

  test('rolls back when rows contain duplicate primary keys', () async {
    await destination.into(destination.appSettings).insert(
          AppSettingsCompanion.insert(key: 'active', value: 'preserved'),
        );

    final decoded = jsonDecode(utf8.decode(await sourceService.exportBackup()))
        as Map<String, dynamic>;
    final tables = decoded['tables'] as Map<String, dynamic>;
    tables['app_settings'] = [
      {'key': 'duplicate', 'value': 'first'},
      {'key': 'duplicate', 'value': 'second'},
    ];
    final invalid = Uint8List.fromList(utf8.encode(jsonEncode(decoded)));
    final summary = destinationService.inspectBackup(invalid);

    await expectLater(destinationService.restoreBackup(summary), throwsA(anything));

    expect((await destination.select(destination.appSettings).getSingle()).value,
        'preserved');
  });

  test('rolls back all changes when restore violates a foreign key', () async {
    await destination.into(destination.appSettings).insert(
          AppSettingsCompanion.insert(key: 'active', value: 'preserved'),
        );
    await destination.into(destination.categories).insert(
          CategoriesCompanion.insert(id: 'old-category', name: 'Old'),
        );
    await source.into(source.categories).insert(
          CategoriesCompanion.insert(id: 'new-category', name: 'New'),
        );
    final createdAt = DateTime.utc(2026, 10, 15);
    await source.into(source.products).insert(
          ProductsCompanion.insert(
            id: 'product-1',
            name: 'Widget',
            categoryId: const Value('new-category'),
            purchasePrice: 1,
            sellingPrice: 2,
            createdAt: createdAt,
            updatedAt: createdAt,
          ),
        );

    final decoded = jsonDecode(utf8.decode(await sourceService.exportBackup()))
        as Map<String, dynamic>;
    final tables = decoded['tables'] as Map<String, dynamic>;
    final product = Map<String, dynamic>.from(
      (tables['products'] as List<dynamic>).single as Map,
    )..['category_id'] = 'missing-category';
    tables['products'] = [product];
    final invalid = Uint8List.fromList(utf8.encode(jsonEncode(decoded)));
    final summary = destinationService.inspectBackup(invalid);

    await expectLater(
      destinationService.restoreBackup(summary),
      throwsA(anything),
    );

    expect(
        (await destination.select(destination.appSettings).getSingle()).value,
        'preserved');
    expect((await destination.select(destination.categories).getSingle()).id,
        'old-category');
    expect(await destination.select(destination.products).get(), isEmpty);
  });
}
