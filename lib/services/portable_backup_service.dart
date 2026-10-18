import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';

const _backupFormat = 'wm_app_backup';
const _backupFormatVersion = 1;

/// A validated backup summary. The validated row snapshot is kept private so
/// restore applies exactly the payload the caller inspected.
final class PortableBackupSummary {
  PortableBackupSummary._({
    required this.exportedAtUtc,
    required Map<String, int> rowCounts,
    required Map<String, List<Map<String, Object?>>> tables,
  })  : rowCounts = Map.unmodifiable(rowCounts),
        _tables = Map<String, List<Map<String, Object?>>>.unmodifiable({
          for (final entry in tables.entries)
            entry.key: List<Map<String, Object?>>.unmodifiable(
              entry.value.map((row) => Map<String, Object?>.unmodifiable(row)),
            ),
        });

  final DateTime exportedAtUtc;
  final Map<String, int> rowCounts;
  final Map<String, List<Map<String, Object?>>> _tables;
}

/// Exports and restores a complete logical snapshot of the local database.
///
/// Backups contain SQL-level JSON scalar values and are portable between the
/// native and web database implementations.
abstract interface class PortableBackupStore {
  Future<Uint8List> exportBackup();

  PortableBackupSummary inspectBackup(Uint8List bytes);

  Future<void> restoreBackup(PortableBackupSummary backup);
}

final class PortableBackupService implements PortableBackupStore {
  PortableBackupService(this._database);

  final AppDatabase _database;

  List<TableInfo<Table, Object?>> get _tables =>
      _database.allTables.toList(growable: false);

  /// Encodes a transactionally consistent snapshot of every application table.
  @override
  Future<Uint8List> exportBackup() async {
    late final Map<String, List<Map<String, Object?>>> tables;
    await _database.transaction(() async {
      tables = <String, List<Map<String, Object?>>>{};
      for (final table in _tables) {
        final columns = table.$columns.toList(growable: false);
        final selectedColumns = columns.map((column) => _quote(column.name));
        final rows = await _database
            .customSelect(
              'SELECT ${selectedColumns.join(', ')} '
              'FROM ${_quote(table.actualTableName)}',
            )
            .get();
        tables[table.actualTableName] = [
          for (final row in rows)
            {
              for (final column in columns)
                column.name: _jsonScalar(row.data[column.name]),
            },
        ];
      }
    });

    final envelope = <String, Object?>{
      'format': _backupFormat,
      'formatVersion': _backupFormatVersion,
      'schemaVersion': _database.schemaVersion,
      'exportedAtUtc': DateTime.now().toUtc().toIso8601String(),
      'tables': tables,
    };
    return Uint8List.fromList(utf8.encode(jsonEncode(envelope)));
  }

  /// Validates the format and every table/row shape without writing data.
  @override
  PortableBackupSummary inspectBackup(Uint8List bytes) {
    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(bytes));
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Backup is not valid UTF-8 JSON: $error');
    }

    final envelope = _asStringMap(decoded, 'backup envelope');
    _expectKeys(
      envelope,
      const {
        'format',
        'formatVersion',
        'schemaVersion',
        'exportedAtUtc',
        'tables',
      },
      'backup envelope',
    );
    if (envelope['format'] != _backupFormat) {
      throw const FormatException('Unsupported backup format.');
    }
    if (envelope['formatVersion'] is! int ||
        envelope['formatVersion'] != _backupFormatVersion) {
      throw const FormatException('Unsupported backup format version.');
    }
    if (envelope['schemaVersion'] is! int ||
        envelope['schemaVersion'] != _database.schemaVersion) {
      throw const FormatException('Backup database schema is unsupported.');
    }

    final timestampValue = envelope['exportedAtUtc'];
    if (timestampValue is! String) {
      throw const FormatException('Backup timestamp is missing or invalid.');
    }
    final DateTime exportedAtUtc;
    try {
      exportedAtUtc = DateTime.parse(timestampValue);
    } on FormatException {
      throw const FormatException('Backup timestamp is invalid.');
    }
    if (!exportedAtUtc.isUtc) {
      throw const FormatException('Backup timestamp must be UTC.');
    }

    final encodedTables = _asStringMap(envelope['tables'], 'tables');
    final tableByName = {
      for (final table in _tables) table.actualTableName: table
    };
    _expectKeys(encodedTables, tableByName.keys.toSet(), 'tables');

    final rowsByTable = <String, List<Map<String, Object?>>>{};
    final rowCounts = <String, int>{};
    for (final entry in tableByName.entries) {
      final tableName = entry.key;
      final expectedColumns =
          entry.value.$columns.map((column) => column.name).toSet();
      final rawRows = encodedTables[tableName];
      if (rawRows is! List) {
        throw FormatException('Table "$tableName" must contain a row list.');
      }

      final rows = <Map<String, Object?>>[];
      for (var index = 0; index < rawRows.length; index++) {
        final row = _asStringMap(rawRows[index], 'row $index in $tableName');
        _expectKeys(row, expectedColumns, 'row $index in $tableName');
        final values = <String, Object?>{};
        for (final column in expectedColumns) {
          final value = row[column];
          if (!_isSqlJsonScalar(value)) {
            throw FormatException(
              'Column "$tableName.$column" contains an unsupported value.',
            );
          }
          values[column] = value;
        }
        rows.add(values);
      }

      rowsByTable[tableName] = rows;
      rowCounts[tableName] = rows.length;
    }

    return PortableBackupSummary._(
      exportedAtUtc: exportedAtUtc,
      rowCounts: rowCounts,
      tables: rowsByTable,
    );
  }

  /// Replaces all application rows in one transaction using foreign-key order.
  @override
  Future<void> restoreBackup(PortableBackupSummary backup) async {
    final currentNames = _tables.map((table) => table.actualTableName).toSet();
    _expectKeys(backup._tables, currentNames, 'validated backup tables');

    final tablesInParentFirstOrder = await _tablesInParentFirstOrder();
    await _database.customStatement('PRAGMA foreign_keys = ON');
    await _database.transaction(() async {
      for (final table in tablesInParentFirstOrder.reversed) {
        await _database.customStatement(
          'DELETE FROM ${_quote(table.actualTableName)}',
        );
      }

      for (final table in tablesInParentFirstOrder) {
        final tableName = table.actualTableName;
        final columns = table.$columns.map((column) => column.name).toList();
        final sql = 'INSERT INTO ${_quote(tableName)} '
            '(${columns.map(_quote).join(', ')}) '
            'VALUES (${List.filled(columns.length, '?').join(', ')})';
        for (final row in backup._tables[tableName]!) {
          await _database.customStatement(
            sql,
            [for (final column in columns) row[column]],
          );
        }
      }

      final violations =
          await _database.customSelect('PRAGMA foreign_key_check').get();
      if (violations.isNotEmpty) {
        throw const FormatException('Backup contains broken foreign-key rows.');
      }
    });
  }

  Future<List<TableInfo<Table, Object?>>> _tablesInParentFirstOrder() async {
    final tables = _tables;
    final names = {for (final table in tables) table.actualTableName};
    final parents = <String, Set<String>>{};
    for (final table in tables) {
      final rows = await _database
          .customSelect(
              'PRAGMA foreign_key_list(${_quote(table.actualTableName)})')
          .get();
      parents[table.actualTableName] = {
        for (final row in rows)
          if (row.data['table'] is String &&
              names.contains(row.data['table'] as String))
            row.data['table'] as String,
      };
    }

    final tableByName = {
      for (final table in tables) table.actualTableName: table
    };
    final orderedNames = <String>[];
    final visiting = <String>{};
    final visited = <String>{};

    void visit(String tableName) {
      if (visited.contains(tableName)) return;
      if (!visiting.add(tableName)) {
        throw StateError(
            'Database schema has a circular foreign-key dependency.');
      }
      for (final parent in parents[tableName]!) {
        visit(parent);
      }
      visiting.remove(tableName);
      visited.add(tableName);
      orderedNames.add(tableName);
    }

    for (final table in tables) {
      visit(table.actualTableName);
    }
    return [for (final name in orderedNames) tableByName[name]!];
  }
}

Map<String, Object?> _asStringMap(Object? value, String label) {
  if (value is! Map || value.keys.any((key) => key is! String)) {
    throw FormatException('$label must be an object with string keys.');
  }
  return {for (final entry in value.entries) entry.key as String: entry.value};
}

void _expectKeys(
    Map<String, Object?> values, Set<String> expected, String label) {
  if (values.keys.toSet().difference(expected).isNotEmpty ||
      expected.difference(values.keys.toSet()).isNotEmpty) {
    throw FormatException('$label has missing or unexpected fields.');
  }
}

bool _isSqlJsonScalar(Object? value) =>
    value == null ||
    value is String ||
    value is bool ||
    (value is num && value.isFinite);

Object? _jsonScalar(Object? value) {
  if (!_isSqlJsonScalar(value)) {
    throw const FormatException(
        'Database contains a value unsupported by JSON backups.');
  }
  return value;
}

String _quote(String identifier) => '"${identifier.replaceAll('"', '""')}"';
