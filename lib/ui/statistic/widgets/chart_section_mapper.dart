import 'package:fixedfundsflows/domain/category_with_contracts.dart';
import 'package:fl_chart/fl_chart.dart';

List<PieChartSectionData> showingSections(
  List<CategoryWithContracts> categoriesWithContracts,
) {
  return categoriesWithContracts.map((category) {
    final amount = category.totalAmount! / 100;

    return PieChartSectionData(
      value: amount,
      title: '$amount €',
      radius: 80,
      badgePositionPercentageOffset: 1.2,
    );
  }).toList();
}
