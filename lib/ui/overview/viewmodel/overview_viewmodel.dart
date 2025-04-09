import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/repositories/contract_calculator_repository.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/overview_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overview_viewmodel.g.dart';

//_$OverviewViewModel is a "class annotation" from riverpod generator
//it returns an Object with State
@riverpod
class OverviewViewModel extends _$OverviewViewModel {
  late final ContractCalculatorRepository _repository;

  @override
  OverviewState build() {
    _repository = ref.watch(contractCalculatorRepositoryProvider);
    return OverviewState();
  }

  void setBillingPeriod(BillingPeriod period) {
    state = state.copyWith(selectedPeriod: period);
    loadContractsForPeriod();
  }

  Future<void> loadContractsForPeriod() async {
    state = state.copyWith(isLoading: true);

    try {
      final contracts =
          await _repository.getContractsForPeriod(state.selectedPeriod);
      // Sort contracts by amount in descending order
      contracts.sort((a, b) => b.amount.compareTo(a.amount));
      state = state.copyWith(contracts: contracts);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        totalAmountForSelectedPeriod: 0,
      );
    }
    state = state.copyWith(
        totalAmountForSelectedPeriod: _calculateTotalAmountForSelectedPeriod(),
        isLoading: false);
  }

  int _calculateTotalAmountForSelectedPeriod() {
    int totalAmount = 0;
    for (final contract in state.contracts) {
      totalAmount += contract.amount;
    }
    return totalAmount;
  }
}
