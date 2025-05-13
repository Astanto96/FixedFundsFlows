import 'package:fixedfundsflows/core/localization/app_localizations.dart';
import 'package:fixedfundsflows/ui/overview/viewmodel/overview_viewmodel.dart';
import 'package:fixedfundsflows/ui/overview/widgets/ov_header.dart';
import 'package:fixedfundsflows/ui/overview/widgets/ov_list.dart';
import 'package:fixedfundsflows/ui/widgets/custom_global_snackbar.dart';
import 'package:fixedfundsflows/ui/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverviewScreen extends ConsumerStatefulWidget {
  const OverviewScreen({super.key});

  @override
  ConsumerState<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends ConsumerState<OverviewScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the load after the widget is built
    Future.microtask(() {
      ref.read(overviewViewModelProvider.notifier).loadContractsForPeriod();
    });
  }

  @override
  Widget build(BuildContext context) {
    final overviewState = ref.watch(overviewViewModelProvider);
    final viewModel = ref.read(overviewViewModelProvider.notifier);
    final loc = ref.watch(appLocationsProvider);

    if (overviewState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomGlobalSnackBar.show(
          context: context,
          isItGood: false,
          text: overviewState.error!,
        );
      });
    }

    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              OvHeader(
                selectedPeriod: overviewState.selectedPeriod,
                onBillingPeriodChanged: viewModel.setBillingPeriod,
                totalAmountForSelectedPeriod:
                    overviewState.totalAmountForSelectedPeriod,
                importBackupData: viewModel.importBackupData,
                exportBackupData: viewModel.exportBackupData,
                deleteAllData: viewModel.deleteAllDataEntries,
              ),
              Expanded(
                child: LoadingOverlay(
                  isLoading: overviewState.isLoading,
                  child: OvList(
                    contracts: overviewState.contracts,
                    loc: loc,
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
