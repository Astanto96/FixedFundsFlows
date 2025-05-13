import 'package:fixedfundsflows/data/datasource/hive_data_source_exception.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:fixedfundsflows/data/provider/box_providers.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_data_source.g.dart';

@riverpod
HiveDataSource hiveDataSource(Ref ref) {
  final categoryBox = ref.watch(categoryBoxProvider);
  final contractBox = ref.watch(contractBoxProvider);

  return HiveDataSource(categoryBox: categoryBox, contractBox: contractBox);
}

class HiveDataSource {
  final Box<CategoryHive> categoryBox;
  final Box<ContractHive> contractBox;

  HiveDataSource({required this.categoryBox, required this.contractBox});

  // Category Functions
  Future<Category> addCategory(Category category) async {
    try {
      final key = await categoryBox.add(CategoryHive.fromDomain(category));
      final savedCategoryHive = categoryBox.get(key);
      if (savedCategoryHive == null) {
        throw HiveDataSourceException("Category couldn't be saved");
      }
      return savedCategoryHive.toDomain();
    } catch (e) {
      throw HiveDataSourceException("Category couldn't be saved: $e");
    }
  }

  Future<void> updateCategory(int key, Category category) async {
    try {
      await categoryBox.put(
        key,
        CategoryHive.fromDomain(category),
      );
    } catch (e) {
      throw HiveDataSourceException("Category couldn't be updated: $e");
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      return categoryBox.values.map((categoryHive) {
        return Category(
          id: categoryHive.key as int,
          description: categoryHive.description,
        );
      }).toList();
    } catch (e) {
      throw HiveDataSourceException(
        "Error retrieving categories: $e",
      );
    }
  }

  Future<List<CategoryHive>> getHiveCategories() async {
    try {
      return categoryBox.values.toList();
    } catch (e) {
      throw HiveDataSourceException(
        "Error retrieving categories: $e",
      );
    }
  }

  CategoryHive? getHiveCategory(int key) {
    try {
      final categoryHive = categoryBox.get(key);
      if (categoryHive == null) {
        return null;
      }
      return categoryHive;
    } catch (e) {
      throw HiveDataSourceException(
        "Error retrieving category: $e",
      );
    }
  }

  Category? getCategory(int key) {
    try {
      final categoryHive = categoryBox.get(key);
      if (categoryHive == null) {
        return null;
      }
      return Category(
        id: key,
        description: categoryHive.description,
      );
    } catch (e) {
      throw HiveDataSourceException(
        "Error retrieving category: $e",
      );
    }
  }

  Future<void> deleteCategory(int key) async {
    try {
      await categoryBox.delete(key);
    } catch (e) {
      throw HiveDataSourceException(
        "Error deleting category: $e",
      );
    }
  }

  Future<void> deleteAllCategories() async {
    try {
      await categoryBox.clear();
    } catch (e) {
      throw HiveDataSourceException(
        "Error deleting all categories: $e",
      );
    }
  }

  // Contract Funktionen

  Future<bool> isCategoryInUse(int categoryId) async {
    try {
      return contractBox.values
          .any((contractHive) => contractHive.categoryId == categoryId);
    } catch (e) {
      throw HiveDataSourceException(
        "Error checking if category is in use: $e",
      );
    }
  }

  Future<Contract> addContract(Contract contract) async {
    try {
      final key = await contractBox.add(ContractHive.fromDomain(contract));
      final savedContractHive = contractBox.get(key);
      if (savedContractHive == null) {
        throw HiveDataSourceException("Contract couldn't be saved");
      }
      final categoryHive = categoryBox.get(contract.category.id);
      if (categoryHive == null) {
        throw HiveDataSourceException(
          "Category with ID ${contract.category.id} not found!",
        );
      }
      return savedContractHive.toDomain(categoryHive);
    } catch (e) {
      throw HiveDataSourceException(
        "Contract couldn't be saved: $e",
      );
    }
  }

  Future<List<Contract>> getContracts() async {
    try {
      return contractBox.values.map((contractHive) {
        final categoryHive = categoryBox.get(contractHive.categoryId);
        if (categoryHive == null) {
          throw HiveDataSourceException(
            "Category with ID ${contractHive.categoryId} not found!",
          );
        }
        return contractHive.toDomain(categoryHive);
      }).toList();
    } catch (e) {
      throw HiveDataSourceException(
        "Error retrieving contracts: $e",
      );
    }
  }

  Future<List<ContractHive>> getHiveContracts() async {
    try {
      return contractBox.values.toList();
    } catch (e) {
      throw HiveDataSourceException(
        "Error retrieving contracts: $e",
      );
    }
  }

  Contract? getContract(int key) {
    try {
      final contractHive = contractBox.get(key);
      if (contractHive == null) {
        return null;
      }
      final categoryHive = categoryBox.get(contractHive.categoryId);
      if (categoryHive == null) {
        throw HiveDataSourceException(
          "Category with ID ${contractHive.categoryId} not found!",
        );
      }
      return contractHive.toDomain(categoryHive);
    } catch (e) {
      throw HiveDataSourceException(
        "Error retrieving contract: $e",
      );
    }
  }

  Future<void> updateContract(Contract contract) async {
    try {
      final categoryHive = categoryBox.get(contract.category.id);
      if (categoryHive == null) {
        throw HiveDataSourceException(
          "Category with ID ${contract.category.id} not found!",
        );
      }

      final contractHive = ContractHive.fromDomain(contract);

      await contractBox.put(contract.id, contractHive);
    } catch (e) {
      throw HiveDataSourceException(
        "Contract couldn't be updated: $e",
      );
    }
  }

  Future<void> deleteContract(int key) async {
    try {
      await contractBox.delete(key);
    } catch (e) {
      throw HiveDataSourceException(
        "Error deleting contract: $e",
      );
    }
  }

  Future<void> deleteAllContracts() async {
    try {
      await contractBox.clear();
    } catch (e) {
      throw HiveDataSourceException(
        "Error deleting all contracts: $e",
      );
    }
  }
}
