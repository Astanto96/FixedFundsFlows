import 'package:fixedfundsflows/data/models/billing_period_hive.dart';
import 'package:fixedfundsflows/data/repositories/overview_repository.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/overview_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overview_viewmodel.g.dart';

//_$OverviewViewModel is a "class annotation" from riverpod generator
//it returns an Object with State
@riverpod
class OverviewViewModel extends _$OverviewViewModel {
  late final OverviewRepository _repository;

  @override
  OverviewState build() {
    _repository = ref.watch(overviewRepositoryProvider);
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
      state = state.copyWith(contracts: contracts, isLoading: false);
    } catch (e, st) {
      print(e);
      print(st);
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
