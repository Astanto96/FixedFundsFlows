import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/domain/category.dart';

class ContractState {
  final bool isLoading;
  final String? error;
  final String? descriptionError;
  final String? amountError;
  final String? categoryError;

  final int? id;
  final String description;
  final BillingPeriod selectedPeriod;
  final Category? selectedCategory;
  final bool income;
  final int? amount;

  final List<Category> categories;

  ContractState({
    this.isLoading = false,
    this.error,
    this.descriptionError,
    this.amountError,
    this.categoryError,
    this.id,
    this.description = '',
    this.selectedPeriod = BillingPeriod.monthly,
    this.selectedCategory,
    this.income = false,
    this.amount,
    this.categories = const [],
  });

  ContractState copyWith({
    bool? isLoading,
    String? error,
    String? descriptionError,
    String? amountError,
    String? categoryError,
    int? id,
    String? description,
    BillingPeriod? selectedPeriod,
    Category? selectedCategory,
    bool? income,
    int? amount,
    List<Category>? categories,
  }) {
    return ContractState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      descriptionError: descriptionError ?? this.descriptionError,
      amountError: amountError ?? this.amountError,
      categoryError: categoryError ?? this.categoryError,
      id: id ?? this.id,
      description: description ?? this.description,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      income: income ?? this.income,
      amount: amount ?? this.amount,
      categories: categories ?? this.categories,
    );
  }
}
