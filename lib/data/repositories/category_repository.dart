import 'package:fixedfundsflows/data/datasource/hive_data_source.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final dataSource = ref.watch(hiveDataSourceProvider);
  final contractRepo = ref.watch(contractRepositoryProvider);
  return CategoryRepository(dataSource, contractRepo);
}

class CategoryRepository {
  final HiveDataSource dataSource;
  final ContractRepository contractRepo;

  CategoryRepository(this.dataSource, this.contractRepo);

  Future<void> addCategory(Category category) async {
    await dataSource.addCategory(category);
  }

  Future<List<Category>> getCategories() {
    return dataSource.getCategories();
  }

  Category getCategory(int key) {
    final category = dataSource.getCategory(key);
    if (category == null) {
      throw Exception("Kategorie mit ID $key nicht gefunden!");
    }
    return category;
  }

  Future<bool> deleteCategory(int key) async {
    final isUsed = await contractRepo.isCategoryInUse(key);
    if (isUsed) {
      return false;
    }

    await dataSource.deleteCategory(key);
    return true;
  }
}
