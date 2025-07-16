import 'package:fixedfundsflows/core/utils/result.dart';
import 'package:fixedfundsflows/data/datasource/hive_data_source.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final dataSource = ref.watch(hiveDataSourceProvider);

  return CategoryRepository(dataSource);
}

class CategoryRepository {
  CategoryRepository(this._dataSource);

  final HiveDataSource _dataSource;

  // ────────────────────────────────────────────────────────────────
  // Create
  // ────────────────────────────────────────────────────────────────

  /// Adds a new [Category].
  Future<Result<void>> addCategory(Category category) async {
    try {
      await _dataSource.addCategory(category);
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Read
  // ────────────────────────────────────────────────────────────────

  Future<Result<List<Category>>> getCategories() async {
    try {
      final categories = await _dataSource.getCategories();
      return Result.ok(categories);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<CategoryHive>>> getHiveCategories() async {
    try {
      final categories = await _dataSource.getHiveCategories();
      return Result.ok(categories);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<CategoryHive>> getHiveCategory(int key) async {
    try {
      final category = await _dataSource.getHiveCategory(key);
      if (category == null) {
        return Result.error(Exception('Category with ID $key not found!'));
      }
      return Result.ok(category);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Result<Category> getCategory(int key) {
    try {
      final category = _dataSource.getCategory(key);
      if (category == null) {
        return Result.error(Exception('Category with ID $key not found!'));
      }
      return Result.ok(category);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Delete
  // ────────────────────────────────────────────────────────────────

  Future<Result<void>> deleteCategory(int key) async {
    try {
      await _dataSource.deleteCategory(key);
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteAllCategories() async {
    try {
      await _dataSource.deleteAllCategories();
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Seed
  // ────────────────────────────────────────────────────────────────

  /// Inserts a list of default category descriptions and returns the
  /// saved [Category] objects.
  Future<Result<List<Category>>> insertDefaultCategories(
    List<String> descriptions,
  ) async {
    final List<Category> defaultCategories = [];

    try {
      for (final desc in descriptions) {
        final category = Category(description: desc);
        final saved = await _dataSource.addCategory(category);
        defaultCategories.add(saved);
      }
      return Result.ok(defaultCategories);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
