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

  static const textBodyColor = Color.fromARGB(255, 224, 224, 224);
  static const textDisplayColor = Colors.white;

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
            foregroundColor: textBodyColor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: base.textTheme.bodyLarge,
          prefixStyle: base.textTheme.bodyLarge,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: inversePrimary,
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
