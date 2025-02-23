import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:fixedfundsflows/data/provider/box_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_data_source.g.dart';

@riverpod
HiveDataSource hiveDataSource(Ref ref) {
  final categoryBox = ref.watch(categoryBoxProvider).value;
  final contractBox = ref.watch(contractBoxProvider).value;

  if (categoryBox == null || contractBox == null) {
    throw Exception("Hive boxes not initialized yet!");
  }

  return HiveDataSource(categoryBox: categoryBox, contractBox: contractBox);
}

class HiveDataSource {
  final Box<CategoryHive> categoryBox;
  final Box<ContractHive> contractBox;

  HiveDataSource({required this.categoryBox, required this.contractBox});

  // Category Funktionen

  Future<int> addCategory(CategoryHive category) async =>
      await categoryBox.add(category);
  List<CategoryHive> getCategories() => categoryBox.values.toList();
  CategoryHive? getCategory(int key) => categoryBox.get(key);
  Future<void> deleteCategory(int key) async => await categoryBox.delete(key);

  // Contract Funktionen
  Future<int> addContract(ContractHive contract) async =>
      await contractBox.add(contract);
  List<ContractHive> getContracts() => contractBox.values.toList();
  Future<void> deleteContract(int key) async => await contractBox.delete(key);
}
