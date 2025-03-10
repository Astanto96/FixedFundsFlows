import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/domain/contract_extensions.dart';
import 'package:flutter/material.dart';

class OvList extends StatelessWidget {
  final List<Contract> contracts;

  const OvList({super.key, required this.contracts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.padding24,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: AppSpacing.padding16,
              child: Text(
                'Verträge',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SingleChildScrollView(
              child: Column(
                children: contracts.map((contract) {
                  return ListTile(
                    leading: Icon(contract.billingIcon),
                    title: Text(contract.description),
                    subtitle: Text(contract.category.description),
                    trailing: Text(contract.amount.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
