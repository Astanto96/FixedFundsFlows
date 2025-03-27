// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class LightTheme {
  static const surface = Color(0xFFEEEEEE);
  static const primary = Color(0xFFE0E0E0);
  static const secondary = Color(0xFFBDBDBD);
  static const inversePrimary = Color(0xFF424242);

  static const snackbarSuccess = Color.fromARGB(255, 33, 208, 39);
  static const snackbarError = Color.fromARGB(255, 231, 56, 43);
  static const snackbarInfo = Color.fromARGB(255, 30, 140, 230);

  static ThemeData get theme {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        surface: surface,
        primary: primary,
        secondary: secondary,
        inversePrimary: inversePrimary,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.grey[800],
        displayColor: Colors.black,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: primary,
        indicatorColor: secondary,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: surface,
        foregroundColor: inversePrimary,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: primary,
        elevation: 2,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: inversePrimary,
        elevation: 0,
      ),
      scaffoldBackgroundColor: primary,
    );
  }
}
