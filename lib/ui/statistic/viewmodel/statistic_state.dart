import 'package:fixedfundsflows/domain/category_with_contracts.dart';

class StatisticState {
  final List<CategoryWithContracts> catWithContracts;
  final bool isLoading;
  final String? error;
  final int? totalAmount;

  StatisticState({
    this.catWithContracts = const [],
    this.isLoading = false,
    this.error,
    this.totalAmount,
  });

  StatisticState copyWith({
    List<CategoryWithContracts>? catWithContracts,
    bool? isLoading,
    String? error,
    int? totalAmount,
  }) {
    return StatisticState(
      catWithContracts: catWithContracts ?? this.catWithContracts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
