import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/widgets/contract_bottomsheet.dart/contract_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contract_viewmodel.g.dart';

@riverpod
class ContractViewModel extends _$ContractViewModel {
  late final ContractRepository _contractRepo;
  late final CategoryRepository _categoryRepo;

  @override
  ContractState build() {
    _contractRepo = ref.watch(contractRepositoryProvider);
    _categoryRepo = ref.watch(categoryRepositoryProvider);
    return ContractState();
  }

//Loading -----------------------------------------------

  Future<void> loadCategorys() async {
    state = state.copyWith(isLoading: true);

    try {
      final categories = await _categoryRepo.getCategories();
      state = state.copyWith(categories: categories, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadContractForDetails(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      final contract = _contractRepo.getContract(id);
      state = state.copyWith(
        id: contract.id,
        description: contract.description,
        selectedPeriod: contract.billingPeriod,
        selectedCategory: contract.category,
        income: contract.income,
        amount: contract.amount,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  //Updating -----------------------------------------

  void updateDescription(String value) {
    state = state.copyWith(description: value);
  }

  void updatePeriod(BillingPeriod period) {
    state = state.copyWith(selectedPeriod: period);
  }

  void updateCategory(Category? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updateIncome(bool income) {
    state = state.copyWith(income: income);
  }

  void updateAmount(int value) {
    state = state.copyWith(amount: value);
  }

  //Saving-----------------------------------------

  Future<void> saveContract() async {
    state = state.copyWith(isLoading: true);

    try {
      if (state.id == null) {
        await _contractRepo.addContract(
          Contract(
            description: state.description,
            billingPeriod: state.selectedPeriod,
            category: state.selectedCategory!,
            income: state.income,
            amount: state.amount,
          ),
        );
      } else {
        await _contractRepo.updateContract(
          Contract(
            id: state.id,
            description: state.description,
            billingPeriod: state.selectedPeriod,
            category: state.selectedCategory!,
            income: state.income,
            amount: state.amount,
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false); // Wird in jedem Fall ausgeführt
    }
  }

  //Deleting----------------------------------------------

  Future<void> deleteContract(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      await _contractRepo.deleteContract(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
