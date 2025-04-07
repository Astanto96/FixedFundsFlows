import 'package:fixedfundsflows/core/theme/dark_theme.dart';
import 'package:fixedfundsflows/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  late final VoidCallback _brightnessListener;

  @override
  ThemeMode build() {
    // Chose Theme based on system brightness
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final mode =
        brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;

    // register listener for system brightness changes
    _brightnessListener = () {
      final newBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final newMode =
          newBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;

      if (state != newMode) {
        state = newMode;
      }
    };

    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        _brightnessListener;

    ref.onDispose(() {
      //Unregister the listener when the provider is disposed
      WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
          null;
    });

    return mode;
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

@riverpod
ThemeData currentTheme(Ref ref) {
  final mode = ref.watch(themeNotifierProvider);
  return mode == ThemeMode.light ? LightTheme.theme : DarkTheme.theme;
}
