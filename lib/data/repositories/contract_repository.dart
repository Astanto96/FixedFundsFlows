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
    await dataSource.addContract(
      ContractHive(
        description: contract.description,
        billingPeriod: contract.billingPeriod,
        category: categoryRepo.getCategory(contract.id),
        amount: contract.amount,
      ),
    );
  }
}
