// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

class AmountFormatter {
  static final NumberFormat _euroFormat = NumberFormat.currency(
    locale: 'de_DE',
    symbol: '€',
    decimalDigits: 2,
  );

  /// Converts an amount in cents (int) to a formatted Euro string.
  /// Example: 1234 -> "12,34 €"
  static String formatFromCents(int cents) {
    return _euroFormat.format(cents / 100);
  }

  /// Tries to parse a formatted Euro string input into an integer amount in cents.
  /// Returns null if parsing fails.
  ///
  /// Example: "1.234,56 €" -> 123456
  ///          "12,34"     -> 1234
  ///          "abc"       -> null
  static int? tryParseToCents(String input) {
    String sanitized = input.replaceAll(RegExp(r'[^\d.,-]'), '');
    sanitized = sanitized.replaceAll('.', '');
    final commaIndex = sanitized.lastIndexOf(',');
    if (commaIndex != -1) {
      sanitized = sanitized.replaceRange(commaIndex, commaIndex + 1, '.');
    }

    final parsed = double.tryParse(sanitized);
    if (parsed == null) return null;
    return (parsed * 100).round();
  }

  /// Converts a cent value to a pre-filled string for use in an input field.
  /// Returns a string like "12,34" instead of "12,34 €" (no currency symbol).
  /// Useful for edit/detail forms.
  ///
  /// Example: 1234 -> "12,34"
  static String getPrefilledInputFromCents(int cents) {
    final euro = cents / 100;
    // Use NumberFormat without symbol
    final formatter = NumberFormat.decimalPattern('de_DE');
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    return formatter.format(euro);
  }
}
