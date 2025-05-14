// ignore_for_file: avoid_redundant_argument_values

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/repositories/backup_data_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_calculator_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/categories/viewmodel/categories_viewmodel.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/overview_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'overview_viewmodel.g.dart';

//_$OverviewViewModel is a "class annotation" from riverpod generator
//it returns an Object with State
@riverpod
class OverviewViewModel extends _$OverviewViewModel {
  late final ContractCalculatorRepository _repository;
  late final BackupDataRepository _backupRepo;
  late final ContractRepository _contractRepo;

  @override
  OverviewState build() {
    _repository = ref.watch(contractCalculatorRepositoryProvider);
    _backupRepo = ref.watch(backupDataRepositoryProvider);
    _contractRepo = ref.watch(contractRepositoryProvider);
    return OverviewState();
  }

  void setBillingPeriod(BillingPeriod period) {
    state = state.copyWith(selectedPeriod: period);
    loadContractsForPeriod();
  }

  Future<bool> deleteAllContracts() async {
    state = state.copyWith(isLoading: true);

    try {
      await _contractRepo.deleteAllContracts();
      state = state.copyWith(isLoading: false);
      await loadContractsForPeriod();
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      await loadContractsForPeriod();
      return false;
    }
  }

  Future<bool> deleteAllDataEntries() async {
    state = state.copyWith(isLoading: true);

    try {
      await _backupRepo.deleteAllDataEntries();
      state = state.copyWith(isLoading: false);
      await loadContractsForPeriod();
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      await loadContractsForPeriod();
      return false;
    }
  }

  Future<void> exportBackupData() async {
    state = state.copyWith(isLoading: true);

    try {
      final file = await _backupRepo.createBackupDataForExport();
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
        ),
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> importBackupData() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);

        await _backupRepo.importBackupDataFromFile(file);

        // update the categories in the app
        await ref.read(categoriesViewmodelProvider.notifier).loadCategories();
        //update the contracts in the app
        await loadContractsForPeriod();
        state = state.copyWith(isLoading: false, error: null);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'No file selected',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadContractsForPeriod() async {
    state = state.copyWith(isLoading: true);

    try {
      final contracts =
          await _repository.getContractsForPeriod(state.selectedPeriod);
      // Sort contracts by amount in descending order
      contracts.sort((a, b) => b.amount.compareTo(a.amount));

      state = state.copyWith(
        contracts: contracts,
        totalAmountForSelectedPeriod:
            _calculateTotalAmountForSelectedPeriod(contracts),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        totalAmountForSelectedPeriod: 0,
      );
    }
  }

  int _calculateTotalAmountForSelectedPeriod(List<Contract> contracts) {
    return contracts.fold(0, (sum, contract) => sum + contract.amount);
  }
}
