import 'dart:io';

import 'package:fixedfundsflows/data/datasource/local_json_data_source.dart';
import 'package:fixedfundsflows/data/models/backup_data_dto.dart';
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
  final LocalJsonDataSource jsonDataSource;
  final CategoryRepository categoryRepo;
  final ContractRepository contractRepo;

  BackupDataRepository(
      this.jsonDataSource, this.categoryRepo, this.contractRepo);

  Future<File> createBackupDataForExport() async {
    try {
      final categories = await categoryRepo.getHiveCategories();
      final contracts = await contractRepo.getHiveContracts();

      if (categories.isEmpty && contracts.isEmpty) {
        throw Exception('No Categories or Contracts found to backup.');
      }

      final backupDto = BackupDataDto(
        categories: categories,
        contracts: contracts,
      );

      final tempDir = await getTemporaryDirectory();
      final fileName = _generateBackupFileName();
      final filePath = '${tempDir.path}/$fileName';

      final file = await jsonDataSource.saveBackupToFile(backupDto, filePath);
      return file;
    } catch (e) {
      throw Exception('Error creating backup data: $e');
    }
  }

  String _generateBackupFileName() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd_HH-mm-ss');
    final formattedDate = formatter.format(now);
    return 'fffbackup_$formattedDate.json';
  }

  Future<void> importBackupDataFromFile(File file) async {
    try {
      final backupDto = await jsonDataSource.tryLoadBackup(file);

      for (final hivecategory in backupDto.categories) {
        await categoryRepo.addCategory(hivecategory.toDomain());
      }

      for (final hivecontract in backupDto.contracts) {
        final category =
            await categoryRepo.getHiveCategory(hivecontract.categoryId);
        if (category == null) {
          throw Exception(
              "category with ID ${hivecontract.categoryId} could not be found");
        }
        await contractRepo.addContract(hivecontract.toDomain(category));
      }
    } catch (e) {
      throw BackupImportException("Error importing backup data: $e");
    }
  }

  Future<void> deleteAllDataEntries() async {
    try {
      await categoryRepo.deleteAllCategories();
      await contractRepo.deleteAllContracts();
    } catch (e) {
      throw Exception("Something went wrong while deleting the data: $e");
    }
  }
}
