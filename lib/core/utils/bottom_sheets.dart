// ignore_for_file: avoid_classes_with_only_static_members

import 'package:fixedfundsflows/ui/widgets/contract_bottomsheet.dart/sheets/contract_bottomsheet.dart';
import 'package:flutter/material.dart';

class AppBottomSheets {
  static Future<void> showCreateContract(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.91,
        child: CreateContractBottomSheet(),
      ),
    );
  }
}
