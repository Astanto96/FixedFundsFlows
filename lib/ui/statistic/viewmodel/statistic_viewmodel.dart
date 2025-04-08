import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/category_with_contracts.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/statistic/viewmodel/statistic_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistic_viewmodel.g.dart';

@riverpod
class StatisticViewModel extends _$StatisticViewModel {
  late final CategoryRepository _categoryRepo;
  late final ContractRepository _contractRepo;

  @override
  StatisticState build() {
    _categoryRepo = ref.watch(categoryRepositoryProvider);
    _contractRepo = ref.watch(contractRepositoryProvider);
    return StatisticState();
  }

  Future<void> initialiseStatisticState() async {
    state = state.copyWith(isLoading: true);

    try {
      final categories = await _categoryRepo.getCategories();
      final contracts = await _contractRepo.getContracts();
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
}
