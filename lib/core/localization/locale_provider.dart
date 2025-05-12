import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    // Systemsprache holen
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    return ['en', 'de'].contains(systemLocale.languageCode)
        ? Locale(systemLocale.languageCode)
        : const Locale('en'); // Fallback
  }

  void toggleLocale() {
    state =
        state.languageCode == 'de' ? const Locale('en') : const Locale('de');
  }
}
