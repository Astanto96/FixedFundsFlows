import 'package:fixedfundsflows/data/datasource/hive_data_source.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contract_repository.g.dart';

@riverpod
ContractRepository contractRepository(Ref ref) {
  final dataSource = ref.watch(hiveDataSourceProvider);
  final categoryRepo = ref.watch(categoryRepositoryProvider);
  return ContractRepository(dataSource, categoryRepo);
}

class ContractRepository {
  final HiveDataSource dataSource;
  final CategoryRepository categoryRepo;

  ContractRepository(this.dataSource, this.categoryRepo);

  Future<void> addContract(Contract contract) async {
    final category = categoryRepo.getCategory(contract.category.id!);

    await dataSource.addContract(contract.copyWith(category: category));
  }

  Future<List<Contract>> getContracts() async {
    return await dataSource.getContracts();
  }

  Future<List<ContractHive>> getHiveContracts() async {
    return await dataSource.getHiveContracts();
  }

  Contract getContract(int id) {
    final contract = dataSource.getContract(id);
    if (contract == null) {
      throw Exception("Vertrag mit ID $id nicht gefunden!");
    }
    return contract;
  }

  Future<void> updateContract(Contract contract) async {
    final category = categoryRepo.getCategory(contract.category.id!);

    await dataSource.updateContract(
      contract.copyWith(category: category),
    );
  }

  Future<bool> isCategoryInUse(int categoryId) async {
    return await dataSource.isCategoryInUse(categoryId);
  }

  Future<void> deleteContract(int id) async {
    await dataSource.deleteContract(id);
  }

  Future<void> deleteAllContracts() async {
    await dataSource.deleteAllContracts();
  }
}
