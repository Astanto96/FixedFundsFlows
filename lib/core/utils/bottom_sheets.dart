// ignore_for_file: avoid_classes_with_only_static_members

import 'package:fixedfundsflows/domain/contract.dart';
import 'package:fixedfundsflows/ui/categorys/widgets/category_bottomsheet.dart';
import 'package:fixedfundsflows/ui/overview/widgets/contract_bottomsheet.dart';
import 'package:flutter/material.dart';

class AppBottomSheets {
  static Future<void> showCreateContract(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.91,
        child: ContractBottomsheet(
          isDetailsMode: false,
        ),
      ),
    );
  }

  static Future<void> showDetailsToContract(
    BuildContext context,
    Contract contract,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.91,
        child: ContractBottomsheet(
          isDetailsMode: true,
          contractForDetails: contract,
        ),
      ),
    );
  }

  static Future<void> showCreateCategory(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.91,
        child: CategoryBottomsheet(),
      ),
    );
  }
}
