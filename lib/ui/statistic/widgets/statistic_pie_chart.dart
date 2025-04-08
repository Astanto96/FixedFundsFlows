import 'package:fixedfundsflows/domain/category_with_contracts.dart';
import 'package:fixedfundsflows/ui/statistic/widgets/chart_section_mapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticPieChart extends StatelessWidget {
  final List<CategoryWithContracts> catWithContracts;
  final Color Function(int categoryID) getColorsForCategory;

  const StatisticPieChart(this.catWithContracts, this.getColorsForCategory,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: showingSections(catWithContracts, getColorsForCategory),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 2,
        centerSpaceRadius: 90,
      ),
    );
  }
}
