import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';

/// A controller that manages the state of [FlexiConfig] parameters.
/// 
/// This controller allows for dynamic updates to design anchors, breakpoints,
/// and targeting strategies, facilitating real-time experimentation within
/// the example application.
class FlexiConfigController extends ChangeNotifier {
  /// The baseline minimum width used for responsive scaling calculations.
  double designMinWidth = 360;

  /// The baseline maximum width used for responsive scaling calculations.
  double designMaxWidth = 1440;

  /// The baseline minimum height used for responsive scaling calculations.
  double designMinHeight = 480;

  /// The baseline maximum height used for responsive scaling calculations.
  double designMaxHeight = 1024;

  /// The breakpoint threshold for mobile devices in portrait orientation.
  double mobilePortraitBreakpoint = 600;

  /// The breakpoint threshold for mobile devices in landscape orientation.
  double mobileLandscapeBreakpoint = 768;

  /// The breakpoint threshold above which a device is categorized as a desktop.
  double tabletLandscapeBreakpoint = 1100;

  /// The primary device type this application was originally designed for.
  TargetDeviceType targetDevice = TargetDeviceType.mobilePortrait;

  /// Determines whether the visual debug overlay is visible.
  bool showDebugOverlay = true;

  /// Updates the [designMinWidth] and notifies listeners.
  void updateDesignMinWidth(double value) {
    designMinWidth = value;
    notifyListeners();
  }

  /// Updates the [designMaxWidth] and notifies listeners.
  void updateDesignMaxWidth(double value) {
    designMaxWidth = value;
    notifyListeners();
  }

  /// Updates the [designMinHeight] and notifies listeners.
  void updateDesignMinHeight(double value) {
    designMinHeight = value;
    notifyListeners();
  }

  /// Updates the [designMaxHeight] and notifies listeners.
  void updateDesignMaxHeight(double value) {
    designMaxHeight = value;
    notifyListeners();
  }

  /// Updates the [mobilePortraitBreakpoint] and notifies listeners.
  void updateMobilePortraitBreakpoint(double value) {
    mobilePortraitBreakpoint = value;
    notifyListeners();
  }

  /// Updates the [mobileLandscapeBreakpoint] and notifies listeners.
  void updateMobileLandscapeBreakpoint(double value) {
    mobileLandscapeBreakpoint = value;
    notifyListeners();
  }

  /// Updates the [tabletLandscapeBreakpoint] and notifies listeners.
  void updateTabletLandscapeBreakpoint(double value) {
    tabletLandscapeBreakpoint = value;
    notifyListeners();
  }

  /// Updates the [targetDevice] and notifies listeners.
  void updateTargetDevice(TargetDeviceType type) {
    targetDevice = type;
    notifyListeners();
  }

  /// Toggles the visibility of the debug overlay and notifies listeners.
  void toggleDebugOverlay(bool value) {
    showDebugOverlay = value;
    notifyListeners();
  }

  /// Resets all configuration parameters to their default production values.
  void reset() {
    designMinWidth = 360;
    designMaxWidth = 1440;
    designMinHeight = 480;
    designMaxHeight = 1024;
    mobilePortraitBreakpoint = 600;
    mobileLandscapeBreakpoint = 768;
    tabletLandscapeBreakpoint = 1100;
    targetDevice = TargetDeviceType.mobilePortrait;
    showDebugOverlay = true;
    notifyListeners();
  }
}
