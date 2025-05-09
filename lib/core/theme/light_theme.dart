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

  static const textBodyColor = Color.fromARGB(255, 62, 62, 62);
  static const textDisplayColor = Colors.black;

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
          bodyColor: textBodyColor,
          displayColor: textDisplayColor,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: primary,
          indicatorColor: secondary,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: surface,
          foregroundColor: textBodyColor,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: primary,
          elevation: 2,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: textBodyColor,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondary,
            foregroundColor: textBodyColor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: base.textTheme.bodyLarge,
          prefixStyle: base.textTheme.bodyLarge,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: secondary,
            ),
          ),
        ),
        scaffoldBackgroundColor: primary,
        menuTheme: MenuThemeData(
          style: MenuStyle(
            backgroundColor: WidgetStateProperty.all<Color>(primary),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(
                  color: secondary,
                ),
              ),
            ),
          ),
        ));
  }
}
