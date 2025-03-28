// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class ContractDeleteDialog {
  static Future<bool> show({
    required BuildContext context,
    required String itemName,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text('Delete Confirmation'),
            content: Text('Are you sure you want to delete "$itemName"?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
