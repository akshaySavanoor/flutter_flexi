import 'package:flutter/widgets.dart';

import '../constants/constants.dart';

/// Information about the current screen dimensions and breakpoints.
///
/// This class is used to pass raw screen attributes to the [DeviceTypeConfig]
/// for categorization.
@immutable
class ScreenInfo {
  /// The physical width of the screen in logical pixels.
  final double width;

  /// The physical height of the screen in logical pixels.
  final double height;

  /// The breakpoint below which a device in portrait mode is considered a phone.
  final double mobilePortraitBreakpoint;

  /// The breakpoint below which a device in landscape mode is considered a phone.
  final double mobileLandscapeBreakpoint;

  /// The breakpoint below which a device in landscape mode is considered a tablet.
  final double tabletLandscapeBreakpoint;

  /// Current screen orientation.
  final Orientation orientation;

  const ScreenInfo({
    required this.width,
    required this.height,
    required this.mobilePortraitBreakpoint,
    required this.mobileLandscapeBreakpoint,
    required this.tabletLandscapeBreakpoint,
    required this.orientation,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScreenInfo &&
        other.width == width &&
        other.height == height &&
        other.orientation == orientation &&
        other.mobilePortraitBreakpoint == mobilePortraitBreakpoint &&
        other.mobileLandscapeBreakpoint == mobileLandscapeBreakpoint &&
        other.tabletLandscapeBreakpoint == tabletLandscapeBreakpoint;
  }

  @override
  int get hashCode => Object.hash(
        width,
        height,
        orientation,
        mobilePortraitBreakpoint,
        mobileLandscapeBreakpoint,
        tabletLandscapeBreakpoint,
      );
}

/// Configuration class for determining device types and design constraints.
///
/// This class encapsulates the logic for deciding if the current environment
/// is a phone, tablet, or desktop based on the provided [ScreenInfo].
@immutable
class DeviceTypeConfig {
  /// The underlying screen information.
  final ScreenInfo screenInfo;

  /// The minimum width used during the design phase (usually for mobile).
  final double designMinWidth;

  /// The maximum width used during the design phase (usually for desktop).
  final double designMaxWidth;

  /// The minimum height used during the design phase.
  final double designMinHeight;

  /// The maximum height used during the design phase.
  final double designMaxHeight;

  /// The target device type this design was primarily built for.
  final TargetDeviceType targetDeviceType;

  const DeviceTypeConfig({
    required this.screenInfo,
    required this.designMinWidth,
    required this.designMaxWidth,
    required this.designMinHeight,
    required this.designMaxHeight,
    required this.targetDeviceType,
  });

  /// Returns `true` if the device is a phone in portrait orientation.
  bool get isPhonePortrait =>
      screenInfo.orientation == Orientation.portrait &&
      screenInfo.width < screenInfo.mobilePortraitBreakpoint;

  /// Returns `true` if the device is a phone in landscape orientation.
  bool get isPhoneLandscape =>
      screenInfo.orientation == Orientation.landscape &&
      screenInfo.width < screenInfo.mobileLandscapeBreakpoint;

  /// Returns `true` if the device is a tablet in landscape orientation.
  bool get isTabletLandscape =>
      screenInfo.orientation == Orientation.landscape &&
      screenInfo.width >= screenInfo.mobileLandscapeBreakpoint &&
      screenInfo.width < screenInfo.tabletLandscapeBreakpoint;

  /// Returns `true` if the device screen width meets or exceeds the desktop breakpoint.
  bool get isDesktop =>
      screenInfo.width >= screenInfo.tabletLandscapeBreakpoint;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeviceTypeConfig &&
        other.screenInfo == screenInfo &&
        other.designMinWidth == designMinWidth &&
        other.designMaxWidth == designMaxWidth &&
        other.targetDeviceType == targetDeviceType;
  }

  @override
  int get hashCode => Object.hash(
        screenInfo,
        designMinWidth,
        designMaxWidth,
        targetDeviceType,
      );
}
