import 'dart:math';
import 'package:tuple/tuple.dart';
import '../constants/constants.dart';
import '../flexi_ui.dart';

extension SizeExtension on num {
  double get w {
    return this * ScreenAdaptiveConfig.instance!.screenWidth;
  }

  double get h {
    return this * ScreenAdaptiveConfig.instance!.screenHeight;
  }

  double get rw {
    double designWidthValue =
    ScreenAdaptiveConfig.instance!.targetDeviceType == TargetDeviceType.phonePortrait
        ? ScreenAdaptiveConfig.instance!.designMinWidth
        : ScreenAdaptiveConfig.instance!.designMaxWidth;
    return (this * ScreenAdaptiveConfig.instance!.screenWidth) / designWidthValue;
  }

  double get rh {
    double designHeightValue =
    ScreenAdaptiveConfig.instance!.targetDeviceType == TargetDeviceType.phonePortrait
        ? ScreenAdaptiveConfig.instance!.designMinHeight
        : ScreenAdaptiveConfig.instance!.designMaxHeight;
    return (this * ScreenAdaptiveConfig.instance!.screenHeight) / designHeightValue;
  }
}

extension AdaptiveWidthExtension on Tuple2<num, num> {
  double get aw {
    ScreenAdaptiveConfig.instance!.targetDeviceType == TargetDeviceType.phonePortrait
        ? ScreenAdaptiveConfig.instance!.designMinWidth
        : ScreenAdaptiveConfig.instance!.designMaxWidth;
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

  double get d {
    double designWidthValue =
    ScreenAdaptiveConfig.instance!.targetDeviceType == TargetDeviceType.phonePortrait
        ? ScreenAdaptiveConfig.instance!.designMinWidth
        : ScreenAdaptiveConfig.instance!.designMaxWidth;
    double designHeightValue =
    ScreenAdaptiveConfig.instance!.targetDeviceType == TargetDeviceType.phonePortrait
        ? ScreenAdaptiveConfig.instance!.designMinHeight
        : ScreenAdaptiveConfig.instance!.designMaxHeight;
    num width = item1.toDouble();
    num height = item2.toDouble();
    double smallScreenDiagonal = sqrt(pow(width, 2) + pow(height, 2));
    double screenDiagonal =
    sqrt(pow(ScreenAdaptiveConfig.instance!.screenWidth, 2) + pow(ScreenAdaptiveConfig.instance!.screenHeight, 2));
    double screenDesignDiagonal = sqrt(pow(designWidthValue, 2) +
        pow(designHeightValue, 2));
    return (smallScreenDiagonal * screenDiagonal) / screenDesignDiagonal;
  }
}

extension AdaptiveHeightExtension on Tuple2<num, num> {
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