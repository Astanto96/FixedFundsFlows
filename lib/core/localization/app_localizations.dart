import 'package:fixedfundsflows/core/localization/locale_provider.dart';
import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_localizations.g.dart';

@riverpod
AppLocalizations appLocations(Ref ref) {
  final locale = ref.watch(localeNotifierProvider);
  return AppLocalizations(locale);
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  bool get isGerman => locale.languageCode == 'de';

  String get appTitle => isGerman ? 'Meine App' : 'My App';
  String get welcome => isGerman ? 'Willkommen!' : 'Welcome!';
  String get toggleLang => isGerman ? 'Sprache wechseln' : 'Toggle Language';
  String get logout => isGerman ? 'Abmelden' : 'Logout';

  String greeting(String name) => isGerman ? 'Hallo $name' : 'Hello $name';

  String billingLabel(BillingPeriod period) {
    switch (period) {
      case BillingPeriod.monthly:
        return isGerman ? 'Monatlich' : 'Monthly';
      case BillingPeriod.quarterly:
        return isGerman ? 'Vierteljährlich' : 'Quarterly';
      case BillingPeriod.yearly:
        return isGerman ? 'Jährlich' : 'Yearly';
    }
  }
}
