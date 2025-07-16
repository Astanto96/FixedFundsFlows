import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/core/utils/result.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contract_calculator_repository.g.dart';

@riverpod
ContractCalculatorRepository contractCalculatorRepository(Ref ref) {
  final contractRepo = ref.watch(contractRepositoryProvider);
  return ContractCalculatorRepository(contractRepo);
}

class ContractCalculatorRepository {
  ContractCalculatorRepository(this._contractRepository);

  final ContractRepository _contractRepository;

  // ────────────────────────────────────────────────────────────────
  // Public API
  // ────────────────────────────────────────────────────────────────

  Future<Result<List<Contract>>> getContractsForPeriod(
    BillingPeriod selectedPeriod,
  ) async {
    try {
      final contractsRes = await _contractRepository.getContracts();
      if (contractsRes is Error<List<Contract>>) {
        return Result.error(contractsRes.error);
      }
      final contracts = (contractsRes as Ok<List<Contract>>).value;

      final mapped = <Contract>[];
      for (final contract in contracts) {
        try {
          final adjustedAmount = _calculateAmountPerPeriod(
            contract.amount,
            contract.billingPeriod,
            selectedPeriod,
          );
          mapped.add(contract.copyWith(amount: adjustedAmount));
        } on Exception catch (e) {
          // Propagate conversion errors immediately
          return Result.error(Exception(e));
        }
      }

      return Result.ok(mapped);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Helpers
  // ────────────────────────────────────────────────────────────────

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
