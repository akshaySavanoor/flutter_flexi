import 'package:flutter/widgets.dart';

import '../constants/constants.dart';
import '../constants/flexi_aspect.dart';
import '../widgets/flexi_config.dart';
import '../widgets/responsive_inherited_model.dart';

/// Provides adaptive sizing extensions for numeric values within a [ResponsiveLayout].
extension AdaptiveSizeProvider on num {
  /// Calculates the adaptive width based on the current parent width and target parent width
  /// using the [ResponsiveLayout] context.
  double fw(BuildContext context) {
    final cardData = ResponsiveInheritedModel.of(context, aspect: 'width');
    if (cardData != null) {
      return (cardData.currentParentWidth * this) / cardData.targetParentWidth;
    }

    final flexiData =
        FlexiInheritedWidget.of(context, aspect: FlexiAspect.width);
    if (flexiData != null) {
      double designWidth = flexiData.deviceTypeConfig.targetDeviceType ==
              TargetDeviceType.phonePortrait
          ? flexiData.deviceTypeConfig.designMinWidth
          : flexiData.deviceTypeConfig.designMaxWidth;
      return (flexiData.screenWidth * this) / designWidth;
    }

    throw Exception(
        'Neither ResponsiveLayout nor FlexiConfig found in context. Wrap your widget accordingly.');
  }

  /// Calculates the adaptive height based on the current parent height and target parent height
  /// using the [ResponsiveLayout] or [FlexiConfig] context.
  double fh(BuildContext context) {
    final cardData = ResponsiveInheritedModel.of(context, aspect: 'height');
    if (cardData != null) {
      return (cardData.currentParentHeight * this) /
          cardData.targetParentHeight;
    }

    final flexiData =
        FlexiInheritedWidget.of(context, aspect: FlexiAspect.height);
    if (flexiData != null) {
      double designHeight = flexiData.deviceTypeConfig.targetDeviceType ==
              TargetDeviceType.phonePortrait
          ? flexiData.deviceTypeConfig.designMinHeight
          : flexiData.deviceTypeConfig.designMaxHeight;
      return (flexiData.screenHeight * this) / designHeight;
    }

    throw Exception(
        'Neither ResponsiveLayout nor FlexiConfig found in context. Wrap your widget accordingly.');
  }
}
