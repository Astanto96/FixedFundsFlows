import 'package:fixedfundsflows/core/theme/dartk_theme.dart';
import 'package:fixedfundsflows/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() => ThemeMode.light;

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

@riverpod
ThemeData currentTheme(Ref ref) {
  final mode = ref.watch(themeNotifierProvider);

  return mode == ThemeMode.light ? LightTheme.theme : DarkTheme.theme;
}
