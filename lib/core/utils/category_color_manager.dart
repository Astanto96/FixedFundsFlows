import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_color_manager.g.dart';

@riverpod
CategoryColorManager categoryColorManager(Ref ref) {
  return CategoryColorManager();
}

class CategoryColorManager {
  final Map<int, Color> _categoryColorMap = {};
  final Set<Color> _usedColors = {};

  int _hueStep = 0;

  // Configuration for pastel color generation
  static const int _hueStepSize = 30; // Degrees between hues
  static const double _saturation = 0.45; // Soft, pastel-like saturation
  static const double _value = 0.8; // Brightness (value)

  /// Returns the color assigned to a specific category ID.
  /// Generates a unique pastel color if not already assigned.
  Color getColorForCategory(int categoryId) {
    return _categoryColorMap.putIfAbsent(categoryId, () {
      Color color;
      int tries = 0;

      // Ensure color uniqueness
      do {
        color = _generateNextPastelColor();
        tries++;
        if (tries > 1000) {
          throw Exception('Too many similar colors generated');
        }
      } while (_usedColors.contains(color));

      _usedColors.add(color);
      return color;
    });
  }

  /// Generates the next pastel color using stepped hue values.
  Color _generateNextPastelColor() {
    final hue = (_hueStep * _hueStepSize) % 360;
    _hueStep++;

    return HSVColor.fromAHSV(1, hue.toDouble(), _saturation, _value).toColor();
  }

  /// Returns the entire map of category IDs to assigned colors.
  Map<int, Color> getColorMap() => _categoryColorMap;
}
