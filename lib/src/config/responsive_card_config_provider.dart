import 'responsive_card_config.dart';

/// Provides adaptive sizing extensions for numeric values.
///
/// This extension allows you to easily scale sizes based on the dimensions of the current
/// parent container and the target dimensions configured in [ResponsiveCardConfig].
extension AdaptiveSizeProvider on num {
  /// Calculates the adaptive width based on the current parent width and target parent width.
  ///
  /// This method scales the numeric value to the width of the current parent container compared
  /// to the target width set in [ResponsiveCardConfig].
  ///
  /// Example:
  /// ```dart
  /// double adaptiveWidth = 100.fw; // Scaled width
  /// ```
  double get fw {
    return (ResponsiveCardConfig.currentParentWidthValue * this) /
        ResponsiveCardConfig.targetParentWidthValue;
  }

  /// Calculates the adaptive height based on the current parent height and target parent height.
  ///
  /// This method scales the numeric value to the height of the current parent container compared
  /// to the target height set in [ResponsiveCardConfig].
  ///
  /// Example:
  /// ```dart
  /// double adaptiveHeight = 100.fh; // Scaled height
  /// ```
  double get fh {
    return (ResponsiveCardConfig.currentParentHeightValue * this) /
        ResponsiveCardConfig.targetParentHeightValue;
  }
}
