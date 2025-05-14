// ignore_for_file: avoid_classes_with_only_static_members

import 'package:fixedfundsflows/core/localization/app_localizations.dart';
import 'package:fixedfundsflows/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class DeleteAllDataDialog {
  static Future<bool?> show({
    required BuildContext context,
    required AppLocalizations loc,
  }) async {
    return await showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(loc.beforeUWipeAllData),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: loc.uWantDeleteAllData1,
                  ),
                  TextSpan(
                    text: loc.uWantDeleteAllData2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: loc.uWantDeleteAllData3,
                  ),
                ],
              ),
            ),
            AppSpacing.sbh16,
            Text(loc.dataWillBeAdded),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(loc.okDelete),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(loc.no),
          ),
        ],
      ),
    );
  }
}
