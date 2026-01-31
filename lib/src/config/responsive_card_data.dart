import 'package:flutter/foundation.dart';

/// An immutable configuration for responsive cards.
///
/// This class holds the dimensions of the parent container and the target dimensions
/// that the card should adapt to.
@immutable
class ResponsiveCardData {
  /// The current width of the parent container.
  final double currentParentWidth;

  /// The current height of the parent container.
  final double currentParentHeight;

  /// The target width of the card, which the responsive card should adapt to.
  final double targetParentWidth;

  /// The target height of the card, which the responsive card should adapt to.
  final double targetParentHeight;

  const ResponsiveCardData({
    required this.currentParentWidth,
    required this.currentParentHeight,
    this.targetParentWidth = 300,
    this.targetParentHeight = 400,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponsiveCardData &&
        other.currentParentWidth == currentParentWidth &&
        other.currentParentHeight == currentParentHeight &&
        other.targetParentWidth == targetParentWidth &&
        other.targetParentHeight == targetParentHeight;
  }

  @override
  int get hashCode {
    return currentParentWidth.hashCode ^
        currentParentHeight.hashCode ^
        targetParentWidth.hashCode ^
        targetParentHeight.hashCode;
  }
}
