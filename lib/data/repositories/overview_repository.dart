
import 'package:fixedfundsflows/data/models/billing_period_hive.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overview_repository.g.dart';

@riverpod
OverviewRepository overviewRepository(Ref ref) {
  print("Fange an OVRepo zu bauen");
  final contractRepo = ref.watch(contractRepositoryProvider);
  return OverviewRepository(contractRepo);
}

class OverviewRepository {
  final ContractRepository contractRepository;

  OverviewRepository(this.contractRepository);

  Future<List<Contract>> getContractsForPeriod(
    BillingPeriod selectedPeriod,
  ) async {
    final contracts = contractRepository.getContracts();

    return contracts.map((contract) {
      final adjustedAmount = _calculateAmountPerPeriod(
        contract.amount,
        contract.billingPeriod,
        selectedPeriod,
      );
      return contract.copyWith(amount: adjustedAmount);
    }).toList();
  }

  int _calculateAmountPerPeriod(
    int amount,
    BillingPeriod originalPeriod,
    BillingPeriod targetPeriod,
  ) {
    const monthsPerYear = 12;
    const monthsPerQuarter = 3;

    if (originalPeriod == targetPeriod) return amount;

    if (originalPeriod == BillingPeriod.monthly) {
      if (targetPeriod == BillingPeriod.quarterly) {
        return amount * monthsPerQuarter;
      }
      if (targetPeriod == BillingPeriod.yearly) return amount * monthsPerYear;
    } else if (originalPeriod == BillingPeriod.quarterly) {
      if (targetPeriod == BillingPeriod.monthly) {
        return (amount / monthsPerQuarter).round();
      }
      if (targetPeriod == BillingPeriod.yearly) {
        return (amount * (monthsPerYear / monthsPerQuarter)).round();
      }
    } else if (originalPeriod == BillingPeriod.yearly) {
      if (targetPeriod == BillingPeriod.monthly) {
        return (amount / monthsPerYear).round();
      }
      if (targetPeriod == BillingPeriod.quarterly) {
        return (amount / (monthsPerYear / monthsPerQuarter)).round();
      }
    }

    throw ArgumentError('Unsupported BillingPeriod conversion');
  }
}
