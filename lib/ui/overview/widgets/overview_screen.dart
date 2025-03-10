import 'package:fixedfundsflows/ui/overview/viewmodel/overview_viewmodel.dart';
import 'package:fixedfundsflows/ui/overview/widgets/ov_header.dart';
import 'package:fixedfundsflows/ui/overview/widgets/ov_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverviewScreen extends ConsumerWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewState = ref.watch(overviewViewModelProvider);
    final viewModel = ref.watch(overviewViewModelProvider.notifier);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          OvHeader(
            selectedPeriod: overviewState.selectedPeriod,
            onBillingPeriodChanged: viewModel.setBillingPeriod,
          ),
          OvList(contracts: overviewState.contracts),
          ElevatedButton(
              onPressed: () {
                viewModel.loadContractsForPeriod();
              },
              child: const Text('Test')),
        ],
      ),
    );
  }
}
