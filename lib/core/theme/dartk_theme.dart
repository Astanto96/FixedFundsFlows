// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: Colors.grey.shade800,
          secondary: Colors.grey.shade700,
          inversePrimary: Colors.grey.shade300,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.grey[300],
              displayColor: Colors.white,
            ),
      );
}
