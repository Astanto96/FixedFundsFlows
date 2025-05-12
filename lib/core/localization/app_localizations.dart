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

//Overview
  String get contracts => isGerman ? 'Verträge' : 'Contracts';
  String get darkmode => isGerman ? "Dunkelmodus" : "Darkmode";
  String get lightmode => isGerman ? "Hellmodus" : "Lightmode";
  String get german => isGerman ? "Deutsch" : "German";
  String get english => isGerman ? "Englisch" : "English";

//Bottomsheet Contract
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

//Bottomsheet Category
  String get categories => isGerman ? 'Kategorien' : 'Categories';
  String get cantDeleteCat => isGerman
      ? 'Kategorie kann nicht gelöscht werden - sie wird noch verwendet.'
      : 'Cannot delete category – it is still in use.';

//snackbar
  String succDeleted(String name) {
    return isGerman
        ? '$name erfolgreich gelöscht'
        : '$name successfully deleted';
  }

  String succUpdated(String name) {
    return isGerman
        ? '$name erfolgreich aktualisiert'
        : '$name successfully updated';
  }

  String succCreated(String name) {
    return isGerman
        ? '$name erfolgreich erstellt'
        : '$name successfully created';
  }

  //Ohters

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
