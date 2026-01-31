import 'package:flutter/widgets.dart';

import 'device_type_config.dart';

/// Immutable data holding screen adaptation values provided by [FlexiConfig].
///
/// This class contains all the necessary dimensions and classification data
/// used by adaptive scaling extensions like `.w(context)` or `.rw(context)`.
@immutable
class ScreenAdaptiveData {
  /// The current screen width in logical pixels.
  final double screenWidth;

  /// The current screen height in logical pixels.
  final double screenHeight;

  /// The current orientation of the device.
  final Orientation orientation;

  /// The device pixel ratio (DPR) of the current display.
  final double devicePixelRatio;

  /// Horizontal block size (1% of screen width).
  final double blockSizeHorizontal;

  /// Vertical block size (1% of screen height).
  final double blockSizeVertical;

  /// Horizontal block size excluding safe area padding.
  final double safeBlockHorizontal;

  /// Vertical block size excluding safe area padding.
  final double safeBlockVertical;

  /// Detailed configuration and classification for the current device.
  final DeviceTypeConfig deviceTypeConfig;

  const ScreenAdaptiveData({
    required this.screenWidth,
    required this.screenHeight,
    required this.orientation,
    required this.devicePixelRatio,
    required this.blockSizeHorizontal,
    required this.blockSizeVertical,
    required this.safeBlockHorizontal,
    required this.safeBlockVertical,
    required this.deviceTypeConfig,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScreenAdaptiveData &&
        other.screenWidth == screenWidth &&
        other.screenHeight == screenHeight &&
        other.orientation == orientation &&
        other.devicePixelRatio == devicePixelRatio;
  }

  @override
  int get hashCode =>
      Object.hash(screenWidth, screenHeight, orientation, devicePixelRatio);
}
