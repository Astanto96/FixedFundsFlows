import 'package:fixedfundsflows/core/theme/dark_theme.dart';
import 'package:fixedfundsflows/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

class CustomGlobalSnackBar {
  //true == green, false == red, null == default
  final bool? isItGood;
  final String text;
  const CustomGlobalSnackBar({this.isItGood, required this.text});

  static void show({
    required BuildContext context,
    bool? isItGood,
    required String text,
  }) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    Color backgroundColor;
    switch (isItGood) {
      case true:
        backgroundColor =
            isDarkMode ? DarkTheme.snackbarSuccess : LightTheme.snackbarSuccess;
      case false:
        backgroundColor =
            isDarkMode ? DarkTheme.snackbarError : LightTheme.snackbarError;
      case null:
        backgroundColor =
            isDarkMode ? DarkTheme.snackbarInfo : LightTheme.snackbarInfo;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: (isItGood ?? false)
            ? const Duration(seconds: 2)
            : const Duration(seconds: 4),
      ),
    );
  }
}
