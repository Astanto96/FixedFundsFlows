import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/contract_state.dart';
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
//Validation -----------------------------------------------

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    if (int.tryParse(value) == null) {
      return 'Enter a valid number';
    }
    return null;
  }

  String? validateCategory(Category? value) {
    if (value == null) {
      return 'Category is required';
    }
    return null;
  }

  bool validateForm() {
    final descriptionError = validateDescription(state.description);
    final amountError = validateAmount(state.amount.toString());
    final categoryError = validateCategory(state.selectedCategory);

    // Update state with validation errors
    state = state.copyWith(
      descriptionError: descriptionError,
      amountError: amountError,
      categoryError: categoryError,
    );

    // Form is valid if there are no errors
    return descriptionError == null &&
        amountError == null &&
        categoryError == null;
  }

//Loading -----------------------------------------------

  Future<void> loadCategories() async {
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
    state = state.copyWith(
      description: value,
      descriptionError: validateDescription(value),
    );
  }

  void updatePeriod(BillingPeriod period) {
    state = state.copyWith(selectedPeriod: period);
  }

  void updateCategory(Category? category) {
    state = state.copyWith(
      selectedCategory: category,
      categoryError: validateCategory(category),
    );
  }

  void updateAmount(int value) {
    state = state.copyWith(
      amount: value,
      amountError: validateAmount(value.toString()),
    );
  }

  //Saving-----------------------------------------

  Future<bool> saveContract() async {
    if (!validateForm()) {
      return false;
    }

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
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //Deleting----------------------------------------------

  Future<bool> deleteContract(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      await _contractRepo.deleteContract(id);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      return false;
    }
  }

  void initializeWithContract(Contract contract) {
    state = state.copyWith(
      id: contract.id,
      description: contract.description,
      selectedPeriod: contract.billingPeriod,
      selectedCategory: contract.category,
      income: contract.income,
      amount: contract.amount,
    );
  }
}
