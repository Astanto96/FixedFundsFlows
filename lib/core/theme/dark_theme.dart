// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme {
    const surface = Color(0xFF212121);
    const primary = Color(0xFF424242);
    const secondary = Color(0xFF616161);
    const inversePrimary = Color(0xFFEEEEEE);

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
      scaffoldBackgroundColor: surface,
    );
  }
}
