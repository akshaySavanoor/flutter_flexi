import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';

/// Provides extension methods for adapting sizes based on screen dimensions.
extension SizeExtension on num {
  /// Calculates width based on a percentage of the screen width using context.
  double w(BuildContext context) {
    final data = FlexiInheritedWidget.of(context, aspect: FlexiAspect.width);
    if (data == null) throw Exception('FlexiConfig not found in context.');
    return this * data.screenWidth;
  }

  /// Calculates height based on a percentage of the screen height using context.
  double h(BuildContext context) {
    final data = FlexiInheritedWidget.of(context, aspect: FlexiAspect.height);
    if (data == null) throw Exception('FlexiConfig not found in context.');
    return this * data.screenHeight;
  }

  /// Calculates responsive width using context.
  double rw(BuildContext context) {
    final data = FlexiInheritedWidget.of(context, aspect: FlexiAspect.width);
    if (data == null) throw Exception('FlexiConfig not found in context.');
    double designWidthValue =
        data.deviceTypeConfig.targetDeviceType == TargetDeviceType.mobilePortrait
            ? data.deviceTypeConfig.designMinWidth
            : data.deviceTypeConfig.designMaxWidth;
    assert(designWidthValue > 0, 'Design width must be greater than zero.');
    return (this * data.screenWidth) / max(1.0, designWidthValue);
  }

  /// Calculates responsive height using context.
  double rh(BuildContext context) {
    final data = FlexiInheritedWidget.of(context, aspect: FlexiAspect.height);
    if (data == null) throw Exception('FlexiConfig not found in context.');
    double designHeightValue =
        data.deviceTypeConfig.targetDeviceType == TargetDeviceType.mobilePortrait
            ? data.deviceTypeConfig.designMinHeight
            : data.deviceTypeConfig.designMaxHeight;
    assert(designHeightValue > 0, 'Design height must be greater than zero.');
    return (this * data.screenHeight) / max(1.0, designHeightValue);
  }

  /// Linearly interpolates from this value to [max] based on the current
  /// screen width relative to the design width range.
  ///
  /// Example: `16.aw(24, context)` for fluid typography.
  double aw(num max, BuildContext context) => Tuple2(this, max).aw(context);

  /// Linearly interpolates from this value to [max] based on the current
  /// screen height relative to the design height range.
  double ah(num max, BuildContext context) => Tuple2(this, max).ah(context);
}

/// Provides adaptive width extensions for [Tuple2].
///
/// Use this for continuous (fluid) scaling between two values based on screen width.
extension AdaptiveWidthExtension on Tuple2<num, num> {
  /// Linearly interpolates between [item1] and [item2] based on the current
  /// screen width relative to the design width range ([designMinWidth] to [designMaxWidth]).
  ///
  /// Useful for "Fluid Typography", spacing, or any dimension that should grow proportionally.
  /// Subscribes only to width changes for maximum performance.
  double aw(BuildContext context) {
    final data = FlexiInheritedWidget.of(context, aspect: FlexiAspect.width);
    if (data == null) throw Exception('FlexiConfig not found in context.');
    double smallScreenValue = item1.toDouble();
    double largeScreenValue = item2.toDouble();
    double minWidth = data.deviceTypeConfig.designMinWidth;
    double maxWidth = data.deviceTypeConfig.designMaxWidth;
    if (data.screenWidth <= minWidth) return smallScreenValue;
    if (data.screenWidth >= maxWidth) return largeScreenValue;

    final divisor = maxWidth - minWidth;
    assert(divisor > 0, 'Design width range must be positive.');

    return smallScreenValue +
        (largeScreenValue - smallScreenValue) *
            (data.screenWidth - minWidth) /
            max(1.0, divisor);
  }

  /// Scales two values (representing a small-screen dimension) to the current
  /// screen diagonal.
  double d(BuildContext context) {
    FlexiInheritedWidget.of(context, aspect: FlexiAspect.width);
    final data = FlexiInheritedWidget.of(context, aspect: FlexiAspect.height);
    if (data == null) throw Exception('FlexiConfig not found in context.');
    double designWidthValue =
        data.deviceTypeConfig.targetDeviceType == TargetDeviceType.mobilePortrait
            ? data.deviceTypeConfig.designMinWidth
            : data.deviceTypeConfig.designMaxWidth;
    double designHeightValue =
        data.deviceTypeConfig.targetDeviceType == TargetDeviceType.mobilePortrait
            ? data.deviceTypeConfig.designMinHeight
            : data.deviceTypeConfig.designMaxHeight;
    double smallScreenDiagonal =
        sqrt(pow(item1.toDouble(), 2) + pow(item2.toDouble(), 2));
    double screenDiagonal =
        sqrt(pow(data.screenWidth, 2) + pow(data.screenHeight, 2));
    double screenDesignDiagonal =
        sqrt(pow(designWidthValue, 2) + pow(designHeightValue, 2));
    assert(screenDesignDiagonal > 0, 'Design diagonal must be greater than zero.');

    return (smallScreenDiagonal * screenDiagonal) / max(1.0, screenDesignDiagonal);
  }
}

/// Provides adaptive height extensions for [Tuple2].
///
/// Use this for continuous (fluid) scaling between two values based on screen height.
extension AdaptiveHeightExtension on Tuple2<num, num> {
  /// Linearly interpolates between [item1] and [item2] based on the current
  /// screen height relative to the design height range ([designMinHeight] to [designMaxHeight]).
  ///
  /// Subscribes only to height changes for maximum performance.
  double ah(BuildContext context) {
    final data = FlexiInheritedWidget.of(context, aspect: FlexiAspect.height);
    if (data == null) throw Exception('FlexiConfig not found in context.');
    double minHeight = data.deviceTypeConfig.designMinHeight;
    double maxHeight = data.deviceTypeConfig.designMaxHeight;
    if (data.screenHeight <= minHeight) return item1.toDouble();
    if (data.screenHeight >= maxHeight) return item2.toDouble();
    return item1.toDouble() +
        (item2.toDouble() - item1.toDouble()) *
            (data.screenHeight - minHeight) /
            (maxHeight - minHeight);
  }
}
