import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/data/repositories/settings_repository.dart';
import 'package:fixedfundsflows/domain/contract.dart';

class AppStartService {
  final SettingsRepository settingsRepo;
  final CategoryRepository categoryRepo;
  final ContractRepository contractRepo;

  AppStartService(this.settingsRepo, this.categoryRepo, this.contractRepo);

  Future<void> initializeAppIfNeeded() async {
    final isInitialized = await settingsRepo.isAppInitialized();

    if (isInitialized) return;

    // 1. create Categories
    final createdCategories = await categoryRepo.insertDefaultCategories();

    // 2. Map from Description to Category
    final categoryMap = {
      for (final cat in createdCategories) cat.description: cat,
    };

    // 3. Create Contracts with the Categories
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
        billingPeriod: BillingPeriod.quarterly,
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

    // 4. Save Contracts
    for (final contract in contracts) {
      await contractRepo.addContract(contract);
    }

    //5. Set App Initialized Flag
    await settingsRepo.setAppInitialized(true);
  }
}
