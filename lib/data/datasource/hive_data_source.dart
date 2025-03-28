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

  // Category Funktionen
  Future<Category> addCategory(Category category) async {
    final key = await categoryBox.add(CategoryHive.fromDomain(category));
    final savedCategoryHive = categoryBox.get(key);
    if (savedCategoryHive == null) {
      throw Exception("Fehler beim Speichern der Kategorie mit ID $key");
    }
    return savedCategoryHive.toDomain();
  }

  Future<void> updateCategory(int key, Category category) async {
    await categoryBox.put(
      key,
      CategoryHive.fromDomain(category),
    );
  }

  Future<List<Category>> getCategories() async {
    return categoryBox.values.map((categoryHive) {
      return Category(
        id: categoryHive.key as int,
        description: categoryHive.description,
      );
    }).toList();
  }

  Category? getCategory(int key) {
    final categoryHive = categoryBox.get(key);
    if (categoryHive == null) {
      return null;
    }
    return Category(
      id: key,
      description: categoryHive.description,
    );
  }

  Future<void> deleteCategory(int key) async => await categoryBox.delete(key);

  // Contract Funktionen

  Future<bool> isCategoryInUse(int categoryId) async {
    return contractBox.values
        .any((contractHive) => contractHive.categoryId == categoryId);
  }

  Future<Contract> addContract(Contract contract) async {
    final key = await contractBox.add(ContractHive.fromDomain(contract));
    final savedContractHive = contractBox.get(key);
    if (savedContractHive == null) {
      throw Exception("Fehler beim Speichern des Vertrags mit ID $key");
    }
    final categoryHive = categoryBox.get(contract.category.id);
    if (categoryHive == null) {
      throw Exception(
        "Kategorie mit ID ${contract.category.id} nicht gefunden!",
      );
    }
    return savedContractHive.toDomain(categoryHive);
  }

  List<Contract> getContracts() {
    return contractBox.values.map((contractHive) {
      final categoryHive = categoryBox.get(contractHive.categoryId);
      if (categoryHive == null) {
        throw Exception(
          "Kategorie mit ID ${contractHive.categoryId} nicht gefunden!",
        );
      }
      return contractHive.toDomain(categoryHive);
    }).toList();
  }

  Contract? getContract(int key) {
    final contractHive = contractBox.get(key);
    if (contractHive == null) {
      return null;
    }

    final categoryHive = categoryBox.get(contractHive.categoryId);
    if (categoryHive == null) {
      throw Exception(
        "Kategorie mit ID ${contractHive.categoryId} nicht gefunden!",
      );
    }

    return contractHive.toDomain(categoryHive);
  }

  Future<void> updateContract(Contract contract) async {
    final categoryHive = categoryBox.get(contract.category.id);
    if (categoryHive == null) {
      throw Exception(
        "Kategorie mit ID ${contract.category.id} nicht gefunden!",
      );
    }

    final contractHive = ContractHive.fromDomain(contract);

    await contractBox.put(contract.id, contractHive);
  }

  Future<void> deleteContract(int key) async => await contractBox.delete(key);
}
