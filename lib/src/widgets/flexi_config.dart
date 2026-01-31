import 'package:flutter/widgets.dart';

import '../config/device_type_config.dart';
import '../config/screen_adaptive_data.dart';
import '../constants/constants.dart';

/// A widget that provides [ScreenAdaptiveData] to its descendants using an [InheritedModel].
///
/// This widget should be placed at the root of your application (usually wrapping [MaterialApp])
/// to enable responsive scaling across the entire project. It captures [MediaQuery] changes
/// and provides granular rebuilds via the 'width', 'height', and 'pixelRatio' aspects.
class FlexiConfig extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The minimum width used during the design phase (default: 360).
  final double designMinWidth;

  /// The maximum width used during the design phase (default: 1440).
  final double designMaxWidth;

  /// The minimum height used during the design phase (default: 480).
  final double designMinHeight;

  /// The maximum height used during the design phase (default: 1024).
  final double designMaxHeight;

  /// The breakpoint below which a device in portrait mode is considered a phone (default: 480).
  final double mobilePortraitBreakpoint;

  /// The breakpoint below which a device in landscape mode is considered a phone (default: 768).
  final double mobileLandscapeBreakpoint;

  /// The breakpoint above which a device in landscape mode is considered a desktop (default: 1024).
  final double tabletLandscapeBreakpoint;

  /// The primary device type this application was designed for.
  final TargetDeviceType targetDevice;

  const FlexiConfig({
    super.key,
    required this.child,
    this.designMinWidth = 360,
    this.designMaxWidth = 1440,
    this.designMinHeight = 480,
    this.designMaxHeight = 1024,
    this.mobilePortraitBreakpoint = 480,
    this.mobileLandscapeBreakpoint = 768,
    this.tabletLandscapeBreakpoint = 1024,
    this.targetDevice = TargetDeviceType.phonePortrait,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final orientation = mediaQueryData.orientation;
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;

    final screenInfo = ScreenInfo(
      width: screenWidth,
      height: screenHeight,
      mobilePortraitBreakpoint: mobilePortraitBreakpoint,
      mobileLandscapeBreakpoint: mobileLandscapeBreakpoint,
      tabletLandscapeBreakpoint: tabletLandscapeBreakpoint,
      orientation: orientation,
    );

    final deviceTypeConfig = DeviceTypeConfig(
      screenInfo: screenInfo,
      designMinWidth: designMinWidth,
      designMaxWidth: designMaxWidth,
      designMinHeight: designMinHeight,
      designMaxHeight: designMaxHeight,
      targetDeviceType: targetDevice,
    );

    final blockSizeHorizontal = screenWidth / 100;
    final blockSizeVertical = screenHeight / 100;
    final safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    final safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    final safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    final safeBlockVertical = (screenHeight - safeAreaVertical) / 100;

    final data = ScreenAdaptiveData(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      orientation: orientation,
      devicePixelRatio: devicePixelRatio,
      blockSizeHorizontal: blockSizeHorizontal,
      blockSizeVertical: blockSizeVertical,
      safeBlockHorizontal: safeBlockHorizontal,
      safeBlockVertical: safeBlockVertical,
      deviceTypeConfig: deviceTypeConfig,
    );

    return FlexiInheritedWidget(
      data: data,
      child: child,
    );
  }
}

class FlexiInheritedWidget extends InheritedModel<String> {
  final ScreenAdaptiveData data;

  const FlexiInheritedWidget({
    super.key,
    required this.data,
    required super.child,
  });

  static ScreenAdaptiveData? of(BuildContext context, {String? aspect}) {
    return InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
            aspect: aspect)
        ?.data;
  }

  @override
  bool updateShouldNotify(FlexiInheritedWidget oldWidget) {
    return data != oldWidget.data;
  }

  @override
  bool updateShouldNotifyDependent(
    FlexiInheritedWidget oldWidget,
    Set<String> dependencies,
  ) {
    if (dependencies.contains('width') &&
        data.screenWidth != oldWidget.data.screenWidth) {
      return true;
    }
    if (dependencies.contains('height') &&
        data.screenHeight != oldWidget.data.screenHeight) {
      return true;
    }
    if (dependencies.contains('pixelRatio') &&
        data.devicePixelRatio != oldWidget.data.devicePixelRatio) {
      return true;
    }
    if (dependencies.isEmpty) {
      return data != oldWidget.data;
    }
    return false;
  }
}
