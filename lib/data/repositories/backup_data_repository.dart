import 'dart:convert';
import 'dart:io';

import 'package:fixedfundsflows/data/datasource/local_json_data_source.dart';
import 'package:fixedfundsflows/data/models/backup_data_dto.dart';
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
    final backupDto = BackupDataDto(
      categories: await categoryRepo.getHiveCategories(),
      contracts: await contractRepo.getHiveContracts(),
    );
    await jsonDataSource.saveToFile(backupDto);

    final tempDir = await getTemporaryDirectory();
    final fileName = _generateBackupFileName();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsString(jsonEncode(backupDto.toJson()));
    return file;
  }

  String _generateBackupFileName() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd_HH-mm-ss');
    final formattedDate = formatter.format(now);
    return 'fffbackup_$formattedDate.json';
  }

  Future<void> importBackupData() async {
    try {
      //get all the Data from the json file
      final backupDto = await jsonDataSource.loadFromFile();
      //add all the categories in the json file to the hive database
      for (final hivecategory in backupDto.categories) {
        categoryRepo.addCategory(hivecategory.toDomain());
      }
      //add all the contracts in the json file to the hive database
      for (final hivecontract in backupDto.contracts) {
        final category =
            await categoryRepo.getHiveCategory(hivecontract.categoryId);
        contractRepo.addContract(hivecontract.toDomain(category));
      }
    } catch (e) {
      throw Exception("Something went wrong while loading the backup data: $e");
    }
  }
}
