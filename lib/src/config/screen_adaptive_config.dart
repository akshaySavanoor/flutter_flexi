import 'package:flutter/material.dart';
import '../constants/constants.dart';

/// A class that provides screen size and orientation adaptation utilities.
///
/// This class allows for adaptive layout calculations based on the screen size,
/// orientation, and target device configuration. It should be initialized with
/// context and orientation to adjust the layout accordingly.
class ScreenAdaptiveConfig {
  final MediaQueryData mediaQueryData;
  final ScreenInfo screenInfo;
  final DeviceTypeConfig deviceTypeConfig;

  static MediaQueryData? _lastMediaQueryData;
  static bool _isScreenSizeChanged = false;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double _screenWidth;
  static late double _screenHeight;

  /// Constructs a [ScreenAdaptiveConfig] instance with the given parameters.
  ///
  /// [mediaQueryData] provides the media query data for the current context.
  /// [screenInfo] provides information about the screen dimensions and orientation.
  /// [deviceTypeConfig] provides configuration details for adapting to different device types.
  ScreenAdaptiveConfig({
    required this.mediaQueryData,
    required this.screenInfo,
    required this.deviceTypeConfig,
  });

  static ScreenAdaptiveConfig? _instance;

  /// Initializes the [ScreenAdaptiveConfig] with the given context and orientation.
  ///
  /// This method sets up the configuration for screen adaptation, including design
  /// dimensions and the target device type.
  ///
  /// [context] provides the build context for media query data.
  /// [orientation] provides the current device orientation.
  /// [designMinWidth] and [designMaxWidth] define the minimum and maximum design widths.
  /// [designMinHeight] and [designMaxHeight] define the minimum and maximum design heights.
  /// [targetDevice] specifies the target device type for adaptation.
  static void init({
    required BuildContext context,
    required Orientation orientation,
    double designMinWidth = 360,
    double designMaxWidth = 1440,
    double designMinHeight = 480,
    double designMaxHeight = 1024,
    TargetDeviceType targetDevice = TargetDeviceType.phonePortrait,
  }) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;

    final screenInfo = ScreenInfo(
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height,
      orientation: orientation,
    );

    if (_instance == null || _instance!._hasScreenInfoChanged(screenInfo)) {
      _instance = ScreenAdaptiveConfig(
        mediaQueryData: mediaQueryData,
        screenInfo: screenInfo,
        deviceTypeConfig: DeviceTypeConfig(
          screenInfo: screenInfo,
          designMinWidth: designMinWidth,
          designMaxWidth: designMaxWidth,
          designMinHeight: designMinHeight,
          designMaxHeight: designMaxHeight,
          targetDeviceType: targetDevice,
        ),
      );
    }

    blockSizeHorizontal = _screenWidth / 100;
    blockSizeVertical = _screenHeight / 100;

    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;
  }

  /// Checks if the screen size has changed since the last check.
  ///
  /// [mediaQueryData] provides the current media query data to compare against previous values.
  /// Returns `true` if the screen size has changed, `false` otherwise.
  static bool checkAndResetScreenSizeChange(MediaQueryData mediaQueryData) {
    bool hasScreenSizeChanged = (_lastMediaQueryData == null ||
        _lastMediaQueryData!.size != mediaQueryData.size ||
        _lastMediaQueryData!.devicePixelRatio !=
            mediaQueryData.devicePixelRatio);

    if (hasScreenSizeChanged) {
      _lastMediaQueryData = mediaQueryData;
      _isScreenSizeChanged = true;
    }
    bool wasScreenSizeChanged = _isScreenSizeChanged;
    _isScreenSizeChanged = false;
    return wasScreenSizeChanged;
  }

  /// Checks if the screen information has changed compared to the new [ScreenInfo].
  ///
  /// [newInfo] contains the updated screen dimensions and orientation.
  /// Returns `true` if any of the screen dimensions or orientation have changed, `false` otherwise.
  bool _hasScreenInfoChanged(ScreenInfo newInfo) {
    return screenInfo.width != newInfo.width ||
        screenInfo.height != newInfo.height ||
        screenInfo.orientation != newInfo.orientation;
  }

  /// The singleton instance of [ScreenAdaptiveConfig].
  ///
  /// Returns `null` if the configuration has not been initialized.
  static ScreenAdaptiveConfig? get instance => _instance;

  /// The width of the current screen.
  double get screenWidth => screenInfo.width;

  /// The height of the current screen.
  double get screenHeight => screenInfo.height;

  /// The minimum design width.
  double get designMinWidth => deviceTypeConfig.designMinWidth;

  /// The maximum design width.
  double get designMaxWidth => deviceTypeConfig.designMaxWidth;

  /// The minimum design height.
  double get designMinHeight => deviceTypeConfig.designMinHeight;

  /// The maximum design height.
  double get designMaxHeight => deviceTypeConfig.designMaxHeight;

  /// The target device type for adaptation.
  TargetDeviceType get targetDeviceType => deviceTypeConfig.targetDeviceType;

  /// `true` if the device is a phone in portrait orientation.
  bool get isPhonePortrait => deviceTypeConfig.isPhonePortrait;

  /// `true` if the device is a phone in landscape orientation.
  bool get isPhoneLandscape => deviceTypeConfig.isPhoneLandscape;

  /// `true` if the device is a tablet in landscape orientation.
  bool get isTabletLandscape => deviceTypeConfig.isTabletLandscape;

  /// `true` if the device is a desktop.
  bool get isDesktop => deviceTypeConfig.isDesktop;
}

/// Represents information about the screen.
///
/// Contains the screen dimensions and orientation.
class ScreenInfo {
  final double width;
  final double height;
  final Orientation orientation;

  /// Constructs a [ScreenInfo] instance with the given parameters.
  ///
  /// [width] provides the screen width.
  /// [height] provides the screen height.
  /// [orientation] provides the screen orientation.
  ScreenInfo({
    required this.width,
    required this.height,
    required this.orientation,
  });
}

/// Provides configuration details for different device types.
///
/// This class determines the device type based on screen dimensions and orientation,
/// and initializes relevant flags to indicate the device type.
class DeviceTypeConfig {
  final ScreenInfo screenInfo;
  final double designMinWidth;
  final double designMaxWidth;
  final double designMinHeight;
  final double designMaxHeight;
  final TargetDeviceType targetDeviceType;

  late bool isPhonePortrait;
  late bool isPhoneLandscape;
  late bool isTabletLandscape;
  late bool isDesktop;
  late UserDeviceType deviceType;

  /// Constructs a [DeviceTypeConfig] instance with the given parameters.
  ///
  /// [screenInfo] provides information about the screen dimensions and orientation.
  /// [designMinWidth], [designMaxWidth], [designMinHeight], and [designMaxHeight] specify the
  /// design dimensions for adaptation.
  /// [targetDeviceType] specifies the target device type for adaptation.
  DeviceTypeConfig({
    required this.screenInfo,
    required this.designMinWidth,
    required this.designMaxWidth,
    required this.designMinHeight,
    required this.designMaxHeight,
    required this.targetDeviceType,
  }) {
    _initializeDeviceType();
  }

  /// Initializes device type flags based on the screen dimensions and orientation.
  ///
  /// Sets flags for phone portrait, phone landscape, tablet landscape, and desktop device types.
  void _initializeDeviceType() {
    isPhonePortrait = screenInfo.width <= 480;
    isPhoneLandscape = screenInfo.width <= 768 && !isPhonePortrait;
    isTabletLandscape = screenInfo.width <= 1024 && !isPhoneLandscape;
    isDesktop = !isTabletLandscape;

    if (screenInfo.orientation == Orientation.portrait) {
      isPhonePortrait = true;
      isPhoneLandscape = false;
    } else {
      isPhonePortrait = false;
      isPhoneLandscape = true;
    }

    deviceType = isPhonePortrait
        ? UserDeviceType.phonePortrait
        : isPhoneLandscape
            ? UserDeviceType.phoneLandscape
            : isTabletLandscape
                ? UserDeviceType.tabletLandscape
                : UserDeviceType.desktop;
  }
}
