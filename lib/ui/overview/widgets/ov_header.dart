import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/core/theme/light_theme.dart';
import 'package:fixedfundsflows/core/theme/theme_provider.dart';
import 'package:fixedfundsflows/core/utils/amount_formatter.dart';
import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OvHeader extends ConsumerWidget {
  final BillingPeriod selectedPeriod;
  final void Function(BillingPeriod) onBillingPeriodChanged;
  final int totalAmountForSelectedPeriod;

  const OvHeader({
    super.key,
    required this.selectedPeriod,
    required this.onBillingPeriodChanged,
    required this.totalAmountForSelectedPeriod,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(currentThemeProvider);
    final themeMode = ref.read(themeNotifierProvider.notifier);

    return Container(
      padding: const EdgeInsets.fromLTRB(4, 16, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MenuAnchor(
                builder: (context, controller, child) => IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                ),
                menuChildren: [
                  MenuItemButton(
                    closeOnActivate: false,
                    leadingIcon: theme == LightTheme.theme
                        ? const Icon(Icons.nights_stay)
                        : const Icon(Icons.sunny),
                    onPressed: () {
                      themeMode.toggleTheme();
                    },
                    child: theme == LightTheme.theme
                        ? const Text('Dark Mode')
                        : const Text('Light Mode'),
                  ),
                  MenuItemButton(
                    closeOnActivate: false,
                    leadingIcon: Text(theme == LightTheme.theme ? 'DE' : 'EN',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      themeMode.toggleTheme();
                    },
                    child: theme == LightTheme.theme
                        ? const Text('Deutsch')
                        : const Text('English'),
                  ),
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.ios_share_rounded),
                    child: const Text('JSON Export'),
                    onPressed: () {},
                  )
                ],
              ),
              const Spacer(),
              MenuAnchor(
                builder: (context, controller, _) => TextButton(
                  onPressed: () {
                    controller.isOpen ? controller.close() : controller.open();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedPeriod.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      AppSpacing.sbw4,
                      Icon(
                          controller.isOpen
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          size: 20),
                    ],
                  ),
                ),
                menuChildren: BillingPeriod.values.map((period) {
                  return MenuItemButton(
                    onPressed: () {
                      onBillingPeriodChanged(period);
                    },
                    trailingIcon: selectedPeriod == period
                        ? const Icon(
                            Icons.check,
                            size: 16,
                          )
                        : null,
                    child: Text(period.label),
                  );
                }).toList(),
              ),
              AppSpacing.sbw16,
              Text(
                AmountFormatter.formatToStringWithSymbol(
                    totalAmountForSelectedPeriod),
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
