// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    const surface = Color(0xFFEEEEEE);
    const primary = Color(0xFFE0E0E0);
    const secondary = Color(0xFFBDBDBD);
    const inversePrimary = Color(0xFF424242);

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
          backgroundColor: surface,
          indicatorColor: secondary,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: inversePrimary,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: surface,
          elevation: 2,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: inversePrimary,
          elevation: 0,
        ),
        scaffoldBackgroundColor: primary);
  }
}
