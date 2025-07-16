import 'package:fixedfundsflows/core/utils/result.dart';
import 'package:fixedfundsflows/data/datasource/hive_data_source.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/domain/category.dart';
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
  ContractRepository(this._dataSource, this._categoryRepo);

  final HiveDataSource _dataSource;
  final CategoryRepository _categoryRepo;

  // ────────────────────────────────────────────────────────────────
  // Create
  // ────────────────────────────────────────────────────────────────

  Future<Result<void>> addContract(Contract contract) async {
    try {
      final categoryResult = _categoryRepo.getCategory(contract.category.id!);
      if (categoryResult is Error<Category>) {
        return Result.error(categoryResult.error);
      }
      final category = (categoryResult as Ok<Category>).value;

      await _dataSource.addContract(contract.copyWith(category: category));
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Read
  // ────────────────────────────────────────────────────────────────

  Future<Result<List<Contract>>> getContracts() async {
    try {
      final contracts = await _dataSource.getContracts();
      return Result.ok(contracts);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<ContractHive>>> getHiveContracts() async {
    try {
      final contracts = await _dataSource.getHiveContracts();
      return Result.ok(contracts);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Result<Contract> getContract(int id) {
    try {
      final contract = _dataSource.getContract(id);
      if (contract == null) {
        return Result.error(Exception('Vertrag mit ID $id nicht gefunden!'));
      }
      return Result.ok(contract);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Update
  // ────────────────────────────────────────────────────────────────

  Future<Result<void>> updateContract(Contract contract) async {
    try {
      final categoryResult = _categoryRepo.getCategory(contract.category.id!);
      if (categoryResult is Error<Category>) {
        return Result.error(categoryResult.error);
      }
      final category = (categoryResult as Ok<Category>).value;

      await _dataSource.updateContract(
        contract.copyWith(category: category),
      );
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Helpers
  // ────────────────────────────────────────────────────────────────

  Future<Result<bool>> isCategoryInUse(int categoryId) async {
    try {
      final inUse = await _dataSource.isCategoryInUse(categoryId);
      return Result.ok(inUse);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Delete
  // ────────────────────────────────────────────────────────────────

  Future<Result<void>> deleteContract(int id) async {
    try {
      await _dataSource.deleteContract(id);
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteAllContracts() async {
    try {
      await _dataSource.deleteAllContracts();
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
