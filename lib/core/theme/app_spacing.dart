import 'package:flutter/material.dart';

/// Central class for defining spacing (margins, paddings) used throughout the entire app.
/// This class provides both `SizedBox` widgets for fixed spacing,
/// and `EdgeInsets` for padding configurations.
///
/// Benefit: Consistent spacing across the app -> cleaner and more maintainable UI.
abstract class AppSpacing {
  // -------------------------------------------------
  // Horizontal Spacing (Width)
  // -------------------------------------------------

  /// Very small horizontal spacing, e.g., between an icon and text.
  static const SizedBox sbw4 = SizedBox(width: 4);

  /// Small horizontal spacing, e.g., between two buttons in a row.
  static const SizedBox sbw8 = SizedBox(width: 8);

  /// Medium horizontal spacing, e.g., between items inside a card.
  static const SizedBox sbw12 = SizedBox(width: 12);

  /// Standard horizontal spacing, e.g., between cards.
  static const SizedBox sbw16 = SizedBox(width: 16);

  /// Large horizontal spacing, e.g., for larger layout sections.
  static const SizedBox sbw24 = SizedBox(width: 24);

  // -------------------------------------------------
  // Vertical Spacing (Height)
  // -------------------------------------------------

  /// Very small vertical spacing, e.g., between an icon and text.
  static const SizedBox sbh4 = SizedBox(height: 4);

  /// Small vertical spacing, e.g., between two text widgets in a section.
  static const SizedBox sbh8 = SizedBox(height: 8);

  /// Medium vertical spacing, e.g., between form fields.
  static const SizedBox sbh12 = SizedBox(height: 12);

  /// Standard vertical spacing, e.g., between content sections.
  static const SizedBox sbh16 = SizedBox(height: 16);

  /// Large vertical spacing, e.g., between cards or larger sections.
  static const SizedBox sbh24 = SizedBox(height: 24);

  /// Extra large vertical spacing, e.g., before or after a main headline.
  static const SizedBox sbh32 = SizedBox(height: 32);

  // -------------------------------------------------
  // EdgeInsets for Padding (Inside spacing)
  // -------------------------------------------------

  /// Very small padding, e.g., for compact buttons.
  static const EdgeInsets padding4 = EdgeInsets.all(4);

  /// Small padding, e.g., for sections with minimal content.
  static const EdgeInsets padding8 = EdgeInsets.all(8);

  /// Medium padding, suitable for most containers.
  static const EdgeInsets padding12 = EdgeInsets.all(12);

  /// Standard padding for cards or page content.
  static const EdgeInsets padding16 = EdgeInsets.all(16);

  /// Large padding, e.g., for outer containers or modal dialogs.
  static const EdgeInsets padding24 = EdgeInsets.all(24);

  // -------------------------------------------------
  // EdgeInsets for Specific Axes
  // -------------------------------------------------

  /// Small horizontal padding, e.g., for narrow containers.
  static const EdgeInsets paddingHorizontal8 =
      EdgeInsets.symmetric(horizontal: 8);

  /// Standard horizontal padding, e.g., for entire page layouts.
  static const EdgeInsets paddingHorizontal16 =
      EdgeInsets.symmetric(horizontal: 16);

  /// Small vertical padding, e.g., between content sections.
  static const EdgeInsets paddingVertical8 = EdgeInsets.symmetric(vertical: 8);

  /// Standard vertical padding, e.g., for spacing between list items.
  static const EdgeInsets paddingVertical16 =
      EdgeInsets.symmetric(vertical: 16);
}
