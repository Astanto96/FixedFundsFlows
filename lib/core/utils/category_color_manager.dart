import 'dart:math';
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
  final Random _random = Random();

  /// Returns always the same color for CategoryID
  Color getColorForCategory(int categoryId) {
    if (_categoryColorMap.containsKey(categoryId)) {
      return _categoryColorMap[categoryId]!;
    }

    final color = _generatePastelColor();
    _categoryColorMap[categoryId] = color;
    return color;
  }

  /// Optional: Returns complete Map of CategoryID and Color
  Map<int, Color> getColorMap() => _categoryColorMap;

  /// creates a random pastel color
  Color _generatePastelColor() {
    final hue = _random.nextDouble() * 360;
    const saturation = 0.4; // low for pastell
    const value = 0.9; // bright

    return HSVColor.fromAHSV(1, hue, saturation, value).toColor();
  }
}
