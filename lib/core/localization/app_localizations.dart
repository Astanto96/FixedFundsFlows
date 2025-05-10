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

//Bottomsheets
  String get createContract =>
      isGerman ? 'Erstelle Vertrag' : 'Create Contract';
  String get detailsContract =>
      isGerman ? 'Vertragsdetails' : 'Contract details';
  String get descripction => isGerman ? 'Beschreibung' : 'Description';
  String get billingPeriod =>
      isGerman ? 'Abrechnungszeitraum' : 'billing period';
  String get category => isGerman ? 'Kategorie' : 'Category';
  String get amount => isGerman ? 'Betrag' : 'Amount';
  String get currency => isGerman ? '€' : '\$';
  String get submit => isGerman ? 'Aktualisieren' : 'Submit';
  String get create => isGerman ? 'Erstellen' : 'Create';

//snackbar
  String sncSuccDeleted(String name) {
    return isGerman
        ? '$name erfolgreich gelöscht'
        : '$name successfully deleted';
  }

  String sncSuccUpdated(String name) {
    return isGerman
        ? '$name erfolgreich aktualisiert'
        : '$name successfully updated';
  }

  String sncSuccCreated(String name) {
    return isGerman
        ? '$name erfolgreich erstellt'
        : '$name successfully created';
  }

  //Ohters
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
