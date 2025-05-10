import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  bool get isGerman => locale.languageCode == 'de';

  String get appTitle => isGerman ? 'Meine App' : 'My App';
  String get welcome => isGerman ? 'Willkommen!' : 'Welcome!';
  String get toggleLang => isGerman ? 'Sprache wechseln' : 'Toggle Language';
  String get logout => isGerman ? 'Abmelden' : 'Logout';

  String greeting(String name) => isGerman ? 'Hallo $name' : 'Hello $name';
}
