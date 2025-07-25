import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_calculator_repository.dart';

import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/category_with_contracts.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/statistic/viewmodel/statistic_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistic_viewmodel.g.dart';

@riverpod
class StatisticViewModel extends _$StatisticViewModel {
  late final CategoryRepository _categoryRepo;
  late final ContractCalculatorRepository _calcRepo;

  @override
  StatisticState build() {
    _categoryRepo = ref.watch(categoryRepositoryProvider);
    _calcRepo = ref.watch(contractCalculatorRepositoryProvider);
    return StatisticState();
  }

  void setBillingPeriod(BillingPeriod period) {
    state = state.copyWith(selectedPeriod: period);
    initializeStatisticState();
  }

  Future<void> initializeStatisticState() async {
    state = state.copyWith(isLoading: true);

    try {
      final categories = await _categoryRepo.getCategories();
      final contracts =
          await _calcRepo.getContractsForPeriod(state.selectedPeriod);
      final catWithContracts = _buildCatWithContracts(categories, contracts);
      final totalAmount = _calculateTotalAmount(catWithContracts);

      state = state.copyWith(
        catWithContracts: catWithContracts,
        totalAmount: totalAmount,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  List<CategoryWithContracts> _buildCatWithContracts(
      List<Category> categories, List<Contract> contracts) {
    final categoriesWithContracts = categories
        .map((category) {
          // Filter contracts for the current category
          final contractsForCategory = contracts
              .where(
                (contract) => contract.category.id == category.id,
              )
              .toList()
            // Sort contracts by amount in descending order
            //.. is cascading operator -> is called on the .toList() result
            ..sort((a, b) => b.amount.compareTo(a.amount));

          return CategoryWithContracts(
            category: category,
            contracts: contractsForCategory,
            // Calculate total amount for the current category
            totalAmount: contractsForCategory.fold<int>(
              0,
              (sum, contract) => sum + contract.amount,
            ),
            contractCount: contractsForCategory.length,
          );
        })
        // Filter out categories with no contracts
        .where((cwc) => cwc.contracts.isNotEmpty)
        .toList();
    return categoriesWithContracts;
  }

  int _calculateTotalAmount(
      List<CategoryWithContracts> categoriesWithContracts) {
    final totalAmount = categoriesWithContracts.fold(
        0,
        (totalAmount, categoryWithContracts) =>
            totalAmount + categoryWithContracts.totalAmount!);
    return totalAmount;
  }

  double getCategoryPercentage(int categoryTotalAmount) {
    if (state.totalAmount == null || state.totalAmount == 0) {
      return 0;
    }
    final categoryAmountInEuro = categoryTotalAmount / 100;
    return (100 / (state.totalAmount! / 100)) * categoryAmountInEuro;
  }

  double getContractPercentage(int contractAmount) {
    if (state.totalAmount == null || state.totalAmount == 0) {
      return 0;
    }
    final contractAmountinEuro = contractAmount / 100;
    return (100 / (state.totalAmount! / 100)) * contractAmountinEuro;
  }

  void clearError() {
    if (state.error != null) {
      // ignore: avoid_redundant_argument_values
      state = state.copyWith(clearError: true);
    }
  }

  String doubleToStringPercentage(double percentage) {
    return percentage.toStringAsFixed(1);
  }
}
