import 'package:drift/drift.dart';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/tables/categories_table.dart';
import 'package:wm_app/core/errors/app_exception.dart';

/// Repository for product category operations.
///
/// Provides CRUD and lookup by name for the [Categories] table.
class CategoryRepository {
  CategoryRepository(this._db);

  final AppDatabase _db;

  /// Retrieves all categories ordered by name.
  Future<List<Category>> getAll() {
    final query = _db.select(_db.categories)
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.get();
  }

  /// Retrieves a category by [id].
  ///
  /// Throws [RecordNotFoundException] if not found.
  Future<Category> getById(String id) async {
    final query = _db.select(_db.categories)
      ..where((t) => t.id.equals(id));
    final result = await query.getSingleOrNull();
    if (result == null) {
      throw RecordNotFoundException('Category', id);
    }
    return result;
  }

  /// Retrieves a category by its exact [name], or null if not found.
  Future<Category?> getByName(String name) {
    final query = _db.select(_db.categories)
      ..where((t) => t.name.equals(name));
    return query.getSingleOrNull();
  }

  /// Creates a new category from the given [companion].
  ///
  /// Throws [DuplicateRecordException] if the name already exists.
  Future<void> create(CategoriesCompanion companion) async {
    final name = companion.name.value;
    final existing = await getByName(name);
    if (existing != null) {
      throw DuplicateRecordException('category name', name);
    }
    await _db.into(_db.categories).insert(companion);
  }

  /// Updates a category identified by [id] with the given [companion].
  ///
  /// Throws [RecordNotFoundException] if the category does not exist.
  /// Throws [DuplicateRecordException] if updating to an existing name.
  Future<void> update(String id, CategoriesCompanion companion) async {
    if (companion.name.present) {
      final existing = await getByName(companion.name.value);
      if (existing != null && existing.id != id) {
        throw DuplicateRecordException('category name', companion.name.value);
      }
    }

    final count = await (_db.update(_db.categories)
          ..where((t) => t.id.equals(id)))
        .write(companion);
    if (count == 0) {
      throw RecordNotFoundException('Category', id);
    }
  }

  /// Deletes a category by [id].
  ///
  /// Throws [RecordNotFoundException] if the category does not exist.
  Future<void> delete(String id) async {
    final count = await (_db.delete(_db.categories)
          ..where((t) => t.id.equals(id)))
        .go();
    if (count == 0) {
      throw RecordNotFoundException('Category', id);
    }
  }
}
