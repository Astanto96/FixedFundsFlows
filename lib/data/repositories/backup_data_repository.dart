import 'package:fixedfundsflows/data/datasource/local_json_data_source.dart';
import 'package:fixedfundsflows/data/models/backup_data_dto.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> saveBackupData() async {
    final backupDto = BackupDataDto(
      categories: await categoryRepo.getHiveCategories(),
      contracts: await contractRepo.getHiveContracts(),
    );
    await jsonDataSource.saveToFile(backupDto);
  }

  Future loadBackupData() async {
    return await jsonDataSource.loadFromFile();
  }
}
