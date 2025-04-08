import 'dart:ui';

import 'package:fixedfundsflows/domain/category_with_contracts.dart';
import 'package:fl_chart/fl_chart.dart';

List<PieChartSectionData> showingSections(
  List<CategoryWithContracts> categoriesWithContracts,
  Color Function(int categoryID) getColorsForCategory,
) {
  return categoriesWithContracts.map((category) {
    final amount = category.totalAmount! / 100;

    return PieChartSectionData(
      color: getColorsForCategory(category.category.id!),
      value: amount,
      showTitle: false,
      radius: 90,
    );
  }).toList();
}
