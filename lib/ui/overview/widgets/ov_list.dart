import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/core/utils/amount_formatter.dart';
import 'package:fixedfundsflows/core/utils/bottom_sheets.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/domain/contract_extensions.dart';
import 'package:flutter/material.dart';

class OvList extends StatelessWidget {
  final List<Contract> contracts;

  const OvList({super.key, required this.contracts});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: AppSpacing.padding24,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: AppSpacing.padding16,
              child: Text(
                'Verträge',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contracts.length,
                itemBuilder: (context, index) {
                  final contract = contracts[index];
                  return ListTile(
                    leading: Icon(contract.billingIcon),
                    title: Text(contract.description),
                    subtitle: Text(contract.category.description),
                    trailing:
                        Text(AmountFormatter.formatFromCents(contract.amount)),
                    onTap: () => AppBottomSheets.showDetailsToContract(
                      context,
                      contract,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
