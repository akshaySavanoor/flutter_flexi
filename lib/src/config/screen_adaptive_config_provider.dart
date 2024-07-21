import 'dart:math';
import 'package:tuple/tuple.dart';
import '../constants/constants.dart';
import '../../flexi_ui.dart';

/// Provides extension methods for adapting sizes based on screen dimensions in the `ScreenAdaptiveConfig`.
///
/// These extensions allow you to calculate dimensions relative to the screen width, height, and design dimensions.
extension SizeExtension on num {
  /// Calculates width based on a percentage of the screen width.
  ///
  /// This method returns the width of the screen multiplied by the current value.
  double get w {
    return this * ScreenAdaptiveConfig.instance!.screenWidth;
  }

  /// Calculates height based on a percentage of the screen height.
  ///
  /// This method returns the height of the screen multiplied by the current value.
  double get h {
    return this * ScreenAdaptiveConfig.instance!.screenHeight;
  }

  /// Calculates responsive width based on the design width values for the target device type.
  ///
  /// This method adjusts the width based on the current screen width and the design width values
  /// for either a portrait or landscape phone. It scales the width proportionally between the
  /// minimum and maximum design widths.
  double get rw {
    double designWidthValue = ScreenAdaptiveConfig.instance!.targetDeviceType ==
            TargetDeviceType.phonePortrait
        ? ScreenAdaptiveConfig.instance!.designMinWidth
        : ScreenAdaptiveConfig.instance!.designMaxWidth;
    return (this * ScreenAdaptiveConfig.instance!.screenWidth) /
        designWidthValue;
  }

  /// Calculates responsive height based on the design height values for the target device type.
  ///
  /// This method adjusts the height based on the current screen height and the design height values
  /// for either a portrait or landscape phone. It scales the height proportionally between the
  /// minimum and maximum design heights.
  double get rh {
    double designHeightValue =
        ScreenAdaptiveConfig.instance!.targetDeviceType ==
                TargetDeviceType.phonePortrait
            ? ScreenAdaptiveConfig.instance!.designMinHeight
            : ScreenAdaptiveConfig.instance!.designMaxHeight;
    return (this * ScreenAdaptiveConfig.instance!.screenHeight) /
        designHeightValue;
  }
}

/// Provides extension methods for adapting width based on a tuple of values for different screen sizes.
///
/// This extension allows you to calculate width values that adapt to screen size variations using
/// a range of design dimensions and screen width.
extension AdaptiveWidthExtension on Tuple2<num, num> {
  /// Calculates adaptive width based on the screen width and design width values.
  ///
  /// This method interpolates between a small screen value and a large screen value based on the
  /// current screen width. It returns a width that scales proportionally between the minimum and
  /// maximum design widths.
  double get aw {
    double smallScreenValue = item1.toDouble();
    double largeScreenValue = item2.toDouble();
    double minWidth = ScreenAdaptiveConfig.instance!.designMinWidth;
    double maxWidth = ScreenAdaptiveConfig.instance!.designMaxWidth;

    if (ScreenAdaptiveConfig.instance!.screenWidth < minWidth) {
      return smallScreenValue;
    } else if (ScreenAdaptiveConfig.instance!.screenWidth > maxWidth) {
      return largeScreenValue;
    } else {
      return smallScreenValue +
          (largeScreenValue - smallScreenValue) *
              (ScreenAdaptiveConfig.instance!.screenWidth - minWidth) /
              (maxWidth - minWidth);
    }
  }

  /// Calculates diagonal size based on the screen size and design dimensions.
  ///
  /// This method computes the diagonal size by scaling between a small screen diagonal and a large
  /// screen diagonal. It uses the screen's diagonal and the design dimensions to return an adapted
  /// diagonal size.
  double get d {
    double designWidthValue = ScreenAdaptiveConfig.instance!.targetDeviceType ==
            TargetDeviceType.phonePortrait
        ? ScreenAdaptiveConfig.instance!.designMinWidth
        : ScreenAdaptiveConfig.instance!.designMaxWidth;
    double designHeightValue =
        ScreenAdaptiveConfig.instance!.targetDeviceType ==
                TargetDeviceType.phonePortrait
            ? ScreenAdaptiveConfig.instance!.designMinHeight
            : ScreenAdaptiveConfig.instance!.designMaxHeight;
    num width = item1.toDouble();
    num height = item2.toDouble();
    double smallScreenDiagonal = sqrt(pow(width, 2) + pow(height, 2));
    double screenDiagonal = sqrt(
        pow(ScreenAdaptiveConfig.instance!.screenWidth, 2) +
            pow(ScreenAdaptiveConfig.instance!.screenHeight, 2));
    double screenDesignDiagonal =
        sqrt(pow(designWidthValue, 2) + pow(designHeightValue, 2));
    return (smallScreenDiagonal * screenDiagonal) / screenDesignDiagonal;
  }
}

/// Provides extension methods for adapting height based on a tuple of values for different screen sizes.
///
/// This extension allows you to calculate height values that adapt to screen size variations using
/// a range of design dimensions and screen height.
extension AdaptiveHeightExtension on Tuple2<num, num> {
  /// Calculates adaptive height based on the screen height and design height values.
  ///
  /// This method interpolates between a small screen value and a large screen value based on the
  /// current screen height. It returns a height that scales proportionally between the minimum and
  /// maximum design heights.
  double get ah {
    double smallScreenValue = item1.toDouble();
    double largeScreenValue = item2.toDouble();
    double minHeight = ScreenAdaptiveConfig.instance!.designMinHeight;
    double maxHeight = ScreenAdaptiveConfig.instance!.designMaxHeight;

    if (ScreenAdaptiveConfig.instance!.screenHeight < minHeight) {
      return smallScreenValue;
    } else if (ScreenAdaptiveConfig.instance!.screenHeight > maxHeight) {
      return largeScreenValue;
    } else {
      return smallScreenValue +
          (largeScreenValue - smallScreenValue) *
              (ScreenAdaptiveConfig.instance!.screenHeight - minHeight) /
              (maxHeight - minHeight);
    }
  }
}
