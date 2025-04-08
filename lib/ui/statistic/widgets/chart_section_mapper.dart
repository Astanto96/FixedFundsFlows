import 'dart:ui';

import 'package:fixedfundsflows/domain/category_with_contracts.dart';
import 'package:fl_chart/fl_chart.dart';

List<PieChartSectionData> showingSections(
  List<CategoryWithContracts> categoriesWithContracts,
  Color Function(int categoryID) getColorsForCategory,
  int totalAmountofEverything,
) {
  return categoriesWithContracts.map((category) {
    final amount = category.totalAmount! / 100;
    final percentage = 100 / (totalAmountofEverything / 100) * amount;
    ;

    return PieChartSectionData(
      color: getColorsForCategory(category.category.id!),
      value: amount,
      title: '${percentage.toStringAsFixed(1)}%',
      titlePositionPercentageOffset: 1.3,
      showTitle: true,
      radius: 70,
    );
  }).toList();
}
