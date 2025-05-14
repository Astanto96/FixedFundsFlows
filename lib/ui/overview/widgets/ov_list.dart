import 'package:fixedfundsflows/core/localization/app_localizations.dart';
import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:fixedfundsflows/core/utils/amount_formatter.dart';
import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/core/utils/bottom_sheets.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:flutter/material.dart';

class OvList extends StatelessWidget {
  final List<Contract> contracts;
  final AppLocalizations loc;

  const OvList({super.key, required this.contracts, required this.loc});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppSpacing.padding16,
            child: Text(
              loc.contracts,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Expanded(
            child: contracts.isEmpty
                ? Center(
                    child: Text(
                      loc.noContracts,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: contracts.length,
                    itemBuilder: (context, index) {
                      final contract = contracts[index];
                      return Material(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: Icon(contract.billingPeriod.billingIcon),
                          title: Text(contract.description),
                          subtitle: Text(contract.category.description),
                          trailing: Text(
                              AmountFormatter.formatToStringWithSymbol(
                                  contract.amount),
                              style: const TextStyle(fontSize: 16)),
                          onTap: () => AppBottomSheets.showDetailsToContract(
                            context,
                            contract,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
