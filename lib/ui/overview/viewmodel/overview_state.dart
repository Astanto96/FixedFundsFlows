import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/domain/contract.dart';

class OverviewState {
  final List<Contract> contracts;
  final BillingPeriod selectedPeriod;
  final bool isLoading;
  final String? error;
  final int totalAmountForSelectedPeriod;

  OverviewState({
    this.contracts = const [],
    this.selectedPeriod = BillingPeriod.monthly,
    this.isLoading = false,
    this.error,
    this.totalAmountForSelectedPeriod = 0,
  });

  OverviewState copyWith({
    List<Contract>? contracts,
    BillingPeriod? selectedPeriod,
    bool? isLoading,
    String? error,
    int? totalAmountForSelectedPeriod,
  }) {
    return OverviewState(
      contracts: contracts ?? this.contracts,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      totalAmountForSelectedPeriod:
          totalAmountForSelectedPeriod ?? this.totalAmountForSelectedPeriod,
    );
  }
}
