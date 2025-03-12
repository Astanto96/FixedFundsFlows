import 'package:fixedfundsflows/ui/overview/viewmodel/overview_viewmodel.dart';
import 'package:fixedfundsflows/ui/overview/widgets/ov_header.dart';
import 'package:fixedfundsflows/ui/overview/widgets/ov_list.dart';
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
          Expanded(
            child: SingleChildScrollView(
              child: OvList(contracts: overviewState.contracts),
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text('Keine Funktion',
                  style: TextStyle(fontSize: 24, color: Colors.red))),
        ],
      ),
    );
  }
}
