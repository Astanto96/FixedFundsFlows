import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/data/repositories/settings_repository.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/overview_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_start_service.g.dart';

@riverpod
AppStartService appStartService(Ref ref) {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  final categoryRepo = ref.watch(categoryRepositoryProvider);
  final contractRepo = ref.watch(contractRepositoryProvider);

  return AppStartService(ref, settingsRepo, categoryRepo, contractRepo);
}

class AppStartService {
  final Ref ref;
  final SettingsRepository settingsRepo;
  final CategoryRepository categoryRepo;
  final ContractRepository contractRepo;

  AppStartService(
    this.ref,
    this.settingsRepo,
    this.categoryRepo,
    this.contractRepo,
  );

  static const boxCategories = 'categories';
  static const boxContracts = 'contracts';

  Future<void> initializeHive() async {
    if (!Hive.isBoxOpen(boxCategories)) {
      await Hive.openBox<CategoryHive>(boxCategories);
    }

    if (!Hive.isBoxOpen(boxContracts)) {
      await Hive.openBox<ContractHive>(boxContracts);
    }
  }

  Future<void> initializeAppIfNeeded() async {
    final isInitialized = await settingsRepo.isAppInitialized();

    if (isInitialized) return;

    // 1. create Categories
    final createdCategories = await categoryRepo.insertDefaultCategories();

    // 2. Map from Description to Category
    final categoryMap = {
      for (final cat in createdCategories) cat.description: cat,
    };
    await _insertDefaultContracts(categoryMap);
    ref.read(overviewViewModelProvider.notifier).loadContractsForPeriod();

    //5. Set App Initialized Flag
    await settingsRepo.setAppInitialized(true);
  }

  Future<void> _insertDefaultContracts(
      Map<String, Category> categoryMap) async {
    final contracts = [
      Contract(
        description: 'Rent',
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap['Housing']!,
        amount: 72000,
      ),
      Contract(
        description: 'Car Payment',
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap['Mobility']!,
        amount: 27000,
      ),
      Contract(
        description: 'Netflix',
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap['Entertainment']!,
        amount: 1399,
      ),
      Contract(
        description: 'Car Insurance',
        billingPeriod: BillingPeriod.yearly,
        category: categoryMap['Insurance']!,
        amount: 65000,
      ),
      Contract(
        description: 'Cellphone',
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap['Telecommunication']!,
        amount: 3500,
      ),
    ];
    for (final contract in contracts) {
      await contractRepo.addContract(contract);
    }
  }
}
