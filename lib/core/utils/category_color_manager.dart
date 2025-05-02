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

  // Configuration for pastel color generation
  static const int _hueStepSize = 30; // More distinct hue spacing
  static const double _saturation = 0.45; // Slightly more vivid pastels
  static const int maxSupportedColors = 24;

  /// Reassigns colors to the given list of category IDs.
  /// Alternates brightness to improve distinguishability.
  void updateCategories(List<int> categoryIds) {
    _categoryColorMap.clear();
    _usedColors.clear();

    int hueStep = 0;

    for (final id in categoryIds) {
      final hue = (hueStep * _hueStepSize) % 360;

      // Alternate brightness (value): 0.8, 0.65, 0.8, ...
      final double value = hueStep.isEven ? 0.75 : 0.88;

      final color =
          HSVColor.fromAHSV(1, hue.toDouble(), _saturation, value).toColor();

      _categoryColorMap[id] = color;
      _usedColors.add(color);
      hueStep++;
    }
  }

  /// Returns the color assigned to a specific category ID.
  /// `updateCategories` must be called before using this.
  Color getColorForCategory(int categoryId) {
    final color = _categoryColorMap[categoryId];
    if (color == null) {
      throw Exception(
        'Category ID $categoryId not registered. Call updateCategories() first.',
      );
    }
    return color;
  }

  /// Returns the full map of assigned category IDs and their colors.
  Map<int, Color> getColorMap() => _categoryColorMap;
}
