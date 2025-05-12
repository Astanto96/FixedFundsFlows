import 'package:fixedfundsflows/core/localization/app_localizations.dart';
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
    // Using ref.read() here to access localized strings once during app initialization.
    // This avoids making the service reactive while still supporting localization for dummy data.

    final loc = ref.read(appLocationsProvider);
    final createdCategories = await categoryRepo.insertDefaultCategories([
      loc.housing,
      loc.insurance,
      loc.mobility,
      loc.entertainment,
    ]);

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
    // Using ref.read() here to access localized strings once during app initialization.
    // This avoids making the service reactive while still supporting localization for dummy data.
    final loc = ref.read(appLocationsProvider);
    final contracts = [
      Contract(
        description: loc.rent,
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap[loc.housing]!,
        amount: 72000,
      ),
      Contract(
        description: loc.carPayment,
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap[loc.mobility]!,
        amount: 27000,
      ),
      Contract(
        description: loc.netflix,
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap[loc.entertainment]!,
        amount: 1399,
      ),
      Contract(
        description: loc.carInsurance,
        billingPeriod: BillingPeriod.yearly,
        category: categoryMap[loc.insurance]!,
        amount: 65000,
      ),
      Contract(
        description: loc.spotify,
        billingPeriod: BillingPeriod.monthly,
        category: categoryMap[loc.entertainment]!,
        amount: 1099,
      ),
    ];
    for (final contract in contracts) {
      await contractRepo.addContract(contract);
    }
  }
}
