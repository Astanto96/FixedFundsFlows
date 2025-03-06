// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade300,
          primary: Colors.grey.shade200,
          secondary: Colors.grey.shade400,
          inversePrimary: Colors.grey.shade800,
        ),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.grey[800],
              displayColor: Colors.black,
            ),
      );
}
