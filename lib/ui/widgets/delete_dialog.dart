// ignore_for_file: avoid_classes_with_only_static_members

import 'package:fixedfundsflows/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class DeleteDialog {
  static Future<bool> show({
    required BuildContext context,
    required String itemName,
    required AppLocalizations loc,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(loc.deleteConfirm),
            content: Text(loc.uRlyWantToDelete(
              itemName,
            )),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(loc.delete),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(loc.cancel),
              ),
            ],
          ),
        ) ??
        false;
  }
}
