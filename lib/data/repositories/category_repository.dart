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
  final HiveDataSource dataSource;

  CategoryRepository(this.dataSource);

  Future<void> addCategory(Category category) async {
    await dataSource.addCategory(category);
  }

  Future<List<Category>> getCategories() {
    return dataSource.getCategories();
  }

  Future<List<CategoryHive>> getHiveCategories() {
    return dataSource.getHiveCategories();
  }

  Future<CategoryHive?> getHiveCategory(int key) async {
    final category = dataSource.getHiveCategory(key);
    if (category == null) {
      throw Exception("Category with ID $key not found!");
    }
    return category;
  }

  Category getCategory(int key) {
    final category = dataSource.getCategory(key);
    if (category == null) {
      throw Exception("Category with ID $key not found!");
    }
    return category;
  }

  Future<void> deleteCategory(int key) async {
    await dataSource.deleteCategory(key);
  }

  Future<void> deleteAllCategories() async {
    await dataSource.deleteAllCategories();
  }

  Future<List<Category>> insertDefaultCategories(
      List<String> descriptions) async {
    final List<Category> defaultCategories = [];

    for (final desc in descriptions) {
      final category = Category(description: desc);
      final saved = await dataSource.addCategory(category);
      defaultCategories.add(saved);
    }

    return defaultCategories;
  }
}
