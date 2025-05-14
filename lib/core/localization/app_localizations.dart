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
  String get darkmode => isGerman ? "Dunkel" : "Dark";
  String get lightmode => isGerman ? "Hell" : "Light";
  String get german => isGerman ? "Deutsch" : "German";
  String get english => isGerman ? "Englisch" : "English";
  String get deleteContracts =>
      isGerman ? 'Verträge löschen' : 'Delete contracts';
  String get addDeleteAllData => isGerman ? 'alle Verträge' : 'all contracts';

//Bottomsheet Contract
  String get createContract =>
      isGerman ? 'Vertrag erstellen' : 'Create Contract';
  String get detailsContract =>
      isGerman ? 'Vertragsdetails' : 'Contract details';
  String get descripction => isGerman ? 'Beschreibung' : 'Description';
  String get billingPeriod =>
      isGerman ? 'Abrechnungszeitraum' : 'Billing period';
  String get category => isGerman ? 'Kategorie' : 'Category';
  String get amount => isGerman ? 'Betrag' : 'Amount';
  String get currency => isGerman ? '€' : '\$';
  String get submit => isGerman ? 'Aktualisieren' : 'Submit';
  String get create => isGerman ? 'Erstellen' : 'Create';

//Bottomsheet Category
  String get maxReached24 => isGerman
      ? 'Die maximale Anzahl von 24 Kategorien wurde erreicht'
      : 'You reached the maximum number of 24 categories';
  String get maxIs24 => isGerman
      ? 'Es können bis zu 24 Kategorien erstellt werden'
      : 'You can create up to 24 categories';

//Cateogries Screen
  String get categories => isGerman ? 'Kategorien' : 'Categories';
  String get cantDeleteCat => isGerman
      ? 'Kategorie kann nicht gelöscht werden - sie wird noch verwendet.'
      : 'Cannot delete category – it is still in use.';

//showDeleteDialog
  String get deleteConfirm =>
      isGerman ? 'Löschen bestätigen' : 'Delete confirmation';
  String get ok => isGerman ? 'OK' : 'OK';

  String get cancel => isGerman ? 'Abbrechen' : 'Cancel';

  String uRlyWantToDelete(String name) {
    return isGerman
        ? 'Sind Sie sicher, dass Sie $name löschen möchten?'
        : 'Are you sure you want to delete $name';
  }

//showDeleteAllDataDialog
  String get beforeUWipeAllData =>
      isGerman ? 'Bevor Sie importieren...' : 'Before you import...';
  String get uWantDeleteAllData1 =>
      isGerman ? 'Möchten Sie ' : 'Do you want to ';
  String get uWantDeleteAllData2 => isGerman
      ? 'alle bisher erstellen Verträge & Kategorien löschen'
      : 'delete all contracts & categories ';
  String get uWantDeleteAllData3 => isGerman ? '?' : 'created so far?';
  String get dataWillBeAdded => isGerman
      ? 'Wenn nicht, werden alle importierte Daten zu den bestehenden hinzugefügt'
      : 'If not, all imported data will be added to the existing ones';
  String get succImport =>
      isGerman ? 'Daten erfolgreich importiert' : 'Data successfully imported';
  String get cantImport => isGerman
      ? 'Daten konnten nicht importiert werden'
      : 'Data could not be imported';
  String get succDeletedAllData => isGerman
      ? 'Alle Verträge & Kategorien erfolgreich gelöscht'
      : 'All contracts & categories successfully deleted';
  String get cantDeleteAllData => isGerman
      ? 'Es konnten nicht alle Verträge & Kategorien gelöscht werden'
      : 'Could not delete all contracts & categories';

  String get okDelete => isGerman ? 'OK, löschen' : 'OK, delete';
  String get no => isGerman ? 'Nein' : 'No';
  //others
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

  //DummyData
  //Descriptions
  String get rent => isGerman ? 'Miete' : 'Rent';
  String get carPayment => isGerman ? 'Autokredit' : 'Car Payment';
  String get netflix => isGerman ? 'Netflix' : 'Netflix';
  String get carInsurance => isGerman ? 'Autoversicherung' : 'Car Insurance';
  String get spotify => isGerman ? 'Spotify' : 'Spotify';

  //Categories
  String get housing => isGerman ? 'Wohnen' : 'Housing';
  String get insurance => isGerman ? 'Versicherung' : 'Insurance';
  String get entertainment => isGerman ? 'Unterhaltung' : 'Entertainment';
  String get mobility => isGerman ? 'Mobilität' : 'Mobility';
}
