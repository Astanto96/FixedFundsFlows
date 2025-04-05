// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class DarkTheme {
  static const surface = Color.fromARGB(255, 42, 42, 42);
  static const primary = Color(0xFF424242);
  static const secondary = Color(0xFF616161);
  static const inversePrimary = Color(0xFFEEEEEE);

  static const snackbarSuccess = Color.fromARGB(255, 14, 87, 16);
  static const snackbarError = Color.fromARGB(255, 122, 30, 23);
  static const snackbarInfo = Color.fromARGB(255, 17, 78, 128);

  static ThemeData get theme {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        surface: surface,
        primary: primary,
        secondary: secondary,
        inversePrimary: inversePrimary,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.grey[300],
        displayColor: Colors.white,
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondary,
          foregroundColor: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: primary,
    );
  }
}
