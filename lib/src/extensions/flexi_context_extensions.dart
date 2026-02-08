import 'package:flutter/widgets.dart';

import '../constants/constants.dart';
import '../constants/flexi_aspect.dart';
import '../constants/flexi_breakpoint.dart';
import '../widgets/flexi_config.dart';

/// Semantic extensions for [BuildContext] to simplify access to Flexi UI data.
extension FlexiContext on BuildContext {
  /// Access the [FlexiHelper] to get responsive data without manually specifying aspects.
  ///
  /// **Note**: Accessing properties via `context.flexi...` will usually behave like
  /// a full data dependency unless the internal implementation is optimized.
  /// However, for cleaner syntax, this is preferred.
  ///
  /// Currently, accessing `context.flexi` does NOT trigger a rebuild itself,
  /// but accessing properties on the helper MIGHT if we wired it that way.
  /// But `FlexiHelper` is just a wrapper.
  ///
  /// To ensure efficient rebuilds, continue to use `Flexi.of(context, aspect: ...)`
  /// or this helper if it internally delegates correctly.
  ///
  /// Actually, for strictly granular rebuilds, `InheritedModel` requires `inheritFrom`
  /// with an aspect.
  ///
  /// If we want `context.flexi.breakpoint` to only rebuild on breakpoint changes,
  /// this extension needs to be careful.
  ///
  /// Proposed design:
  /// `context.flexi` returns a lightweight helper.
  /// `helper.breakpoint` calls `FlexiInheritedWidget.of(context, aspect: 'breakpoint')`.
  FlexiHelper get flexi => FlexiHelper(this);
}

/// Helper class to provide semantic access to [FlexiConfig] data.
class FlexiHelper {
  final BuildContext _context;

  FlexiHelper(this._context);

  /// The current semantic breakpoint (e.g., phone, tablet, desktop).
  ///
  /// Triggers a rebuild ONLY when the breakpoint changes.
  FlexiBreakpoint get breakpoint {
    // Explicitly listen to 'breakpoint' aspect
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.breakpoint);
    if (data == null) {
      // Fallback or throw? Ideally this shouldn't happen if FlexiConfig is present.
      // If null, we can't really do much. Return a default or throw helpful error.
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.breakpoint;
  }

  /// The current target device type (phone vs desktop design target).
  ///
  /// Triggers a rebuild if the configuration changes (rare).
  TargetDeviceType get deviceType {
    // We listen to breakpoint aspect since device type categorization 
    // is tied to screen dimension categories.
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.breakpoint);
    if (data == null) {
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.deviceTypeConfig.targetDeviceType;
  }

  /// The current screen size in logical pixels.
  Size get screenSize => Size(screenWidth, screenHeight);

  /// The current screen width in logical pixels.
  double get screenWidth {
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.width);
    if (data == null) {
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.screenWidth;
  }

  /// The current screen height in logical pixels.
  double get screenHeight {
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.height);
    if (data == null) {
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.screenHeight;
  }

  /// The current device pixel ratio.
  double get devicePixelRatio {
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.pixelRatio);
    if (data == null) {
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.devicePixelRatio;
  }

  /// The current device orientation.
  Orientation get orientation {
    // Orientation depends on width/height implicitly in our model
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.width);
    if (data == null) {
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.orientation;
  }

  /// Whether the current device is categorized as mobile.
  bool get isMobile => breakpoint == FlexiBreakpoint.mobilePortrait || 
                       breakpoint == FlexiBreakpoint.mobileLandscape;

  /// Whether the current device is categorized as a tablet.
  bool get isTablet => breakpoint == FlexiBreakpoint.tablet;

  /// Whether the current device is categorized as a desktop.
  bool get isDesktop => breakpoint == FlexiBreakpoint.desktop;

  /// Whether the screen is in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Whether the screen is in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;
}
