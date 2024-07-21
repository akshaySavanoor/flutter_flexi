import 'package:flutter/material.dart';

import '../constants/constants.dart';

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

  ScreenAdaptiveConfig({
    required this.mediaQueryData,
    required this.screenInfo,
    required this.deviceTypeConfig,
  });

  static ScreenAdaptiveConfig? _instance;

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

    _safeAreaHorizontal = mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical = mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;
  }

  static bool checkAndResetScreenSizeChange(MediaQueryData mediaQueryData) {
    bool hasScreenSizeChanged = (_lastMediaQueryData == null ||
        _lastMediaQueryData!.size != mediaQueryData.size ||
        _lastMediaQueryData!.devicePixelRatio != mediaQueryData.devicePixelRatio);

    if (hasScreenSizeChanged) {
      _lastMediaQueryData = mediaQueryData;
      _isScreenSizeChanged = true;
    }
    bool wasScreenSizeChanged = _isScreenSizeChanged;
    _isScreenSizeChanged = false;
    return wasScreenSizeChanged;
  }

  bool _hasScreenInfoChanged(ScreenInfo newInfo) {
    return screenInfo.width != newInfo.width ||
        screenInfo.height != newInfo.height ||
        screenInfo.orientation != newInfo.orientation;
  }

  static ScreenAdaptiveConfig? get instance => _instance;

  double get screenWidth => screenInfo.width;
  double get screenHeight => screenInfo.height;
  double get designMinWidth => deviceTypeConfig.designMinWidth;
  double get designMaxWidth => deviceTypeConfig.designMaxWidth;
  double get designMinHeight => deviceTypeConfig.designMinHeight;
  double get designMaxHeight => deviceTypeConfig.designMaxHeight;
  TargetDeviceType get targetDeviceType => deviceTypeConfig.targetDeviceType;
  bool get isPhonePortrait => deviceTypeConfig.isPhonePortrait;
  bool get isPhoneLandscape => deviceTypeConfig.isPhoneLandscape;
  bool get isTabletLandscape => deviceTypeConfig.isTabletLandscape;
  bool get isDesktop => deviceTypeConfig.isDesktop;
}

class ScreenInfo {
  final double width;
  final double height;
  final Orientation orientation;

  ScreenInfo({
    required this.width,
    required this.height,
    required this.orientation,
  });
}

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
