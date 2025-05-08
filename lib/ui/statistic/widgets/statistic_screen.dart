import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/core/utils/amount_formatter.dart';
import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/core/utils/category_color_manager.dart';
import 'package:fixedfundsflows/ui/categories/viewmodel/categories_viewmodel.dart';
import 'package:fixedfundsflows/ui/statistic/viewmodel/statistic_viewmodel.dart';
import 'package:fixedfundsflows/ui/statistic/widgets/statistic_pie_chart.dart';
import 'package:fixedfundsflows/ui/widgets/custom_global_snackbar.dart';
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
      ref.read(categoriesViewmodelProvider.notifier).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final statisticState = ref.watch(statisticViewModelProvider);
    final viewmodel = ref.read(statisticViewModelProvider.notifier);
    final colorManager = ref.watch(categoryColorManagerProvider);

    if (statisticState.totalAmount == null ||
        statisticState.catWithContracts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (statisticState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomGlobalSnackBar.show(
          context: context,
          isItGood: false,
          text: statisticState.error!,
        );
      });
    }

    return SafeArea(
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final chartHeight = width / 1.1;

                return Column(
                  children: [
                    AppSpacing.sbh16,
                    SizedBox(
                      width: width,
                      height: chartHeight,
                      child: StatisticPieChart(
                        statisticState.totalAmount!,
                        statisticState.catWithContracts,
                        colorManager.getColorForCategory,
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<BillingPeriod>(
                  iconSize: 20,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyLarge?.color),
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  value: statisticState.selectedPeriod,
                  onChanged: (value) {
                    viewmodel.setBillingPeriod(value!);
                  },
                  items: BillingPeriod.values
                      .map(
                        (period) => DropdownMenuItem(
                          value: period,
                          child: Text(period.label),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: statisticState.catWithContracts.length,
                itemBuilder: (context, index) {
                  final category = statisticState.catWithContracts[index];
                  return Material(
                    color: Colors.transparent,
                    child: ExpansionTile(
                      leading: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorManager
                              .getColorForCategory(category.category.id!),
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                              child: Text(
                            category.category.description,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          )),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${viewmodel.doubleToStringPercentage(viewmodel.getCategoryPercentage(category.totalAmount!))}%',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 85,
                            child: Text(
                              AmountFormatter.formatToStringWithSymbol(
                                  category.totalAmount!),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: category.contracts.length,
                          itemBuilder: (context, index) {
                            final contract = category.contracts[index];
                            return ListTile(
                              leading: const SizedBox(
                                width: 20,
                                height: 20,
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      contract.description,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    child: Text(
                                        '${viewmodel.doubleToStringPercentage(viewmodel.getCategoryPercentage(contract.amount))}%',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(fontSize: 14)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      AmountFormatter.formatToStringWithSymbol(
                                        contract.amount,
                                      ),
                                      style: const TextStyle(fontSize: 14),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
