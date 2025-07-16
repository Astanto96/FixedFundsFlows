import 'dart:io';

import 'package:fixedfundsflows/core/utils/result.dart';
import 'package:fixedfundsflows/data/datasource/local_json_data_source.dart';
import 'package:fixedfundsflows/data/models/backup_data_dto.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:fixedfundsflows/data/repositories/backup_import_exception.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_data_repository.g.dart';

@riverpod
BackupDataRepository backupDataRepository(Ref ref) {
  final jsonDataSource = ref.watch(localJsonDataSourceProvider);
  final categoryRepo = ref.watch(categoryRepositoryProvider);
  final contractRepo = ref.watch(contractRepositoryProvider);

  return BackupDataRepository(jsonDataSource, categoryRepo, contractRepo);
}

class BackupDataRepository {
  BackupDataRepository(
      this._jsonDataSource, this._categoryRepo, this._contractRepo);

  final LocalJsonDataSource _jsonDataSource;
  final CategoryRepository _categoryRepo;
  final ContractRepository _contractRepo;

  // ────────────────────────────────────────────────────────────────
  // Export
  // ────────────────────────────────────────────────────────────────

  Future<Result<File>> createBackupDataForExport() async {
    try {
      // Categories
      final categoriesResult = await _categoryRepo.getHiveCategories();
      if (categoriesResult is Error<List<CategoryHive>>) {
        return Result.error(categoriesResult.error);
      }
      final categories = (categoriesResult as Ok<List<CategoryHive>>).value;

      // Contracts
      final contractsResult = await _contractRepo.getHiveContracts();
      if (contractsResult is Error<List<ContractHive>>) {
        return Result.error(contractsResult.error);
      }
      final contracts = (contractsResult as Ok<List<ContractHive>>).value;

      // No categories or contracts found to backup
      if (categories.isEmpty && contracts.isEmpty) {
        return Result.error(
            Exception('No Categories or Contracts found to backup.'));
      }

      // DTO & File
      final backupDto =
          BackupDataDto(categories: categories, contracts: contracts);

      final tempDir = await getTemporaryDirectory();
      final fileName = _generateBackupFileName();
      final filePath = '${tempDir.path}/$fileName';

      final file = await _jsonDataSource.saveBackupToFile(backupDto, filePath);
      return Result.ok(file);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  String _generateBackupFileName() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd_HH-mm-ss');
    final formattedDate = formatter.format(now);
    return 'fffbackup_$formattedDate.json';
  }

  // ────────────────────────────────────────────────────────────────
  // Import
  // ────────────────────────────────────────────────────────────────

  Future<Result<void>> importBackupDataFromFile(File file) async {
    try {
      final backupDto = await _jsonDataSource.tryLoadBackup(file);

      // Kategorien importieren
      for (final hiveCategory in backupDto.categories) {
        final catRes = await _categoryRepo.addCategory(hiveCategory.toDomain());
        if (catRes is Error<void>) {
          return Result.error(catRes.error);
        }
      }

      // Verträge importieren
      for (final hiveContract in backupDto.contracts) {
        // Kategorie nachschlagen
        final categoryRes =
            await _categoryRepo.getHiveCategory(hiveContract.categoryId);
        if (categoryRes is Error<CategoryHive>) {
          return Result.error(categoryRes.error);
        }
        final category = (categoryRes as Ok<CategoryHive>).value;

        final contractRes =
            await _contractRepo.addContract(hiveContract.toDomain(category));
        if (contractRes is Error<void>) {
          return Result.error(contractRes.error);
        }
      }

      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(
          BackupImportException('Error importing backup data: $e'));
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Delete all data
  // ────────────────────────────────────────────────────────────────

  Future<Result<void>> deleteAllDataEntries() async {
    try {
      final catDelRes = await _categoryRepo.deleteAllCategories();
      if (catDelRes is Error<void>) {
        return Result.error(catDelRes.error);
      }

      final contractDelRes = await _contractRepo.deleteAllContracts();
      if (contractDelRes is Error<void>) {
        return Result.error(contractDelRes.error);
      }

      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(
          Exception('Something went wrong while deleting the data: $e'));
    }
  }
}
