import 'package:fixedfundsflows/data/datasource/hive_data_source.dart';
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

  List<Category> getCategories() {
    return dataSource.getCategories();
  }

  Category getCategory(int key) {
    final category = dataSource.getCategory(key);
    if (category == null) {
      throw Exception("Kategorie mit ID $key nicht gefunden!");
    }
    return category;
  }

  Future<void> deleteCategory(int key) async {
    await dataSource.deleteCategory(key);
  }
}
