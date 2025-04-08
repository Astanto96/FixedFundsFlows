import 'package:fixedfundsflows/ui/statistic/viewmodel/statistic_viewmodel.dart';
import 'package:fixedfundsflows/ui/statistic/widgets/statistic_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticScreen extends ConsumerStatefulWidget {
  const StatisticScreen({super.key});

  @override
  ConsumerState<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends ConsumerState<StatisticScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the load after the widget is built
    Future.microtask(() {
      ref.read(statisticViewModelProvider.notifier).initializeStatisticState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final statisticState = ref.watch(statisticViewModelProvider);

    return SafeArea(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: StatisticPieChart(statisticState.catWithContracts),
          ),
        ],
      ),
    );
  }
}
