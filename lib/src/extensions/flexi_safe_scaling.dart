import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';

extension FlexiSafeScaling on num {
  /// Scales the value safely to maintain aspect ratio within a responsive layout.
  ///
  /// It uses [ResponsiveInheritedModel] to find the minimum scale factor between width and height.
  /// If forced to scale differently in width and height, circular elements would oval.
  /// This extension uses `min(scaleW, scaleH)` to ensure the element fits within both constraints
  /// while maintaining 1:1 aspect ratio relative to the design.
  ///
  /// Usage:
  /// ```dart
  /// Container(
  ///   width: 50.fs(context),
  ///   height: 50.fs(context),
  /// )
  /// ```
  double fs(BuildContext context) {
    // Only works within ResponsiveLayout context which provides target/current dims.
    final responsiveData =
        ResponsiveInheritedModel.of(context, aspect: FlexiAspect.implicit);

    if (responsiveData != null) {
      final scaleW =
          responsiveData.currentParentWidth / responsiveData.targetParentWidth;
      final scaleH = responsiveData.currentParentHeight /
          responsiveData.targetParentHeight;

      // Use the smaller scale to ensure it fits in both dimensions without distortion
      return this * min(scaleW, scaleH);
    }

    // Fallback: If not in ResponsiveLayout, use Global Width Scaling (.w equivalent)
    // This is generally safe if we consistently use width scaling for "size".
    // We delegate to .fw(context) logic but explicitly re-implement for clarity or code reuse.
    // Ideally we reuse the existing extension logic if available, but let's keep it self-contained.

    final flexiData = Flexi.of(context, aspect: FlexiAspect.width);
    // Simple width scaling fallback
    final config = flexiData.deviceTypeConfig;
    return this * (flexiData.screenWidth / config.designMinWidth);
  }
}
