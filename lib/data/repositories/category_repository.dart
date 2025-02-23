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
    await dataSource
        .addCategory(CategoryHive(description: category.description));
  }

  List<Category> getCategories() {
    return dataSource.getCategories().map((e) {
      try {
        return Category(id: e.key as int, description: e.description);
      } catch (error) {
        throw Exception("Fehler beim Konvertieren der ID: $error");
      }
    }).toList();
  }

  CategoryHive getCategory(int key) {
    final categoryHive = dataSource.getCategory(key);
    if (categoryHive == null) {
      throw Exception("Kategorie mit ID $key nicht gefunden!");
    }
    return categoryHive;
  }

  Future<void> deleteCategory(int key) async {
    await dataSource.deleteCategory(key);
  }
}
