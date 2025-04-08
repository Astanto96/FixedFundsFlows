import 'package:fixedfundsflows/domain/category_with_contracts.dart';
import 'package:fixedfundsflows/ui/statistic/widgets/chart_section_mapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticPieChart extends StatelessWidget {
  final List<CategoryWithContracts> catWithContracts;

  const StatisticPieChart(this.catWithContracts, {super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: showingSections(catWithContracts),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 2,
        centerSpaceRadius: 90,
      ),
    );
  }
}
