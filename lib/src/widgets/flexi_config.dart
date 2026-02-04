import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../config/device_type_config.dart';
import '../config/screen_adaptive_data.dart';
import '../constants/constants.dart';
import '../constants/flexi_aspect.dart';
import '../constants/flexi_breakpoint.dart';
import 'flexi_debug_overlay.dart';

/// A widget that provides [ScreenAdaptiveData] to its descendants using an [InheritedModel].
///
/// This widget should be placed at the root of your application (usually wrapping [MaterialApp])
/// to enable responsive scaling across the entire project. It captures [MediaQuery] changes
/// and provides granular rebuilds via the 'width', 'height', 'pixelRatio', and 'breakpoint' aspects.
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

  /// If `true`, this widget will wrap its child in a [LayoutBuilder] to derive
  /// dimensions from parent constraints instead of [MediaQuery].
  ///
  /// This is useful when [FlexiConfig] is used inside nested responsive layouts
  /// (e.g., inside a dialog, bottom sheet, or split-pane).
  ///
  /// Defaults to `false` (uses [MediaQuery]).
  final bool useParentConstraints;

  /// If `true`, displays a debug overlay with screen metrics.
  ///
  /// This overlay is only visible in debug mode.
  /// Defaults to `false`.
  final bool showDebugOverlay;

  /// If `true`, allows widgets to rebuild without specifying an aspect.
  ///
  /// **Performance Warning**: Setting this to `true` may cause unnecessary rebuilds
  /// when *any* aspect of the responsive data changes. It is strictly recommended
  /// to set this to `false` and always specify aspects (e.g., `Flexi.of(context, aspect: 'width')`).
  ///
  /// Defaults to `false`.
  final bool allowImplicitRebuilds;

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
    this.useParentConstraints = false,
    this.showDebugOverlay = false,
    this.allowImplicitRebuilds = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useParentConstraints) {
      return LayoutBuilder(
        builder: (context, constraints) {
          // If constraints are unbounded (e.g., inside a ScrollView), fallback to MediaQuery.
          if (constraints.maxWidth.isInfinite ||
              constraints.maxHeight.isInfinite) {
            return _buildWithMediaQuery(context);
          }
          return _buildWithDimensions(
            context,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
        },
      );
    }
    return _buildWithMediaQuery(context);
  }

  Widget _buildWithMediaQuery(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return _buildWithDimensions(
      context,
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height,
    );
  }

  Widget _buildWithDimensions(
    BuildContext context, {
    required double width,
    required double height,
  }) {
    final mediaQueryData = MediaQuery.of(context);
    // Derive orientation from current dimensions for better support in nested layouts
    final orientation =
        width > height ? Orientation.landscape : Orientation.portrait;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;

    final screenInfo = ScreenInfo(
      width: width,
      height: height,
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

    // Calculate semantic breakpoint
    FlexiBreakpoint breakpoint;
    if (orientation == Orientation.portrait) {
      breakpoint = width < mobilePortraitBreakpoint
          ? FlexiBreakpoint.phonePortrait
          : FlexiBreakpoint.tablet;
    } else {
      if (width < mobileLandscapeBreakpoint) {
        breakpoint = FlexiBreakpoint.phoneLandscape;
      } else if (width < tabletLandscapeBreakpoint) {
        breakpoint = FlexiBreakpoint.tablet;
      } else {
        breakpoint = FlexiBreakpoint.desktop;
      }
    }

    final blockSizeHorizontal = width / 100;
    final blockSizeVertical = height / 100;
    final safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    final safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    final safeBlockHorizontal = (width - safeAreaHorizontal) / 100;
    final safeBlockVertical = (height - safeAreaVertical) / 100;

    final data = ScreenAdaptiveData(
      screenWidth: width,
      screenHeight: height,
      orientation: orientation,
      devicePixelRatio: devicePixelRatio,
      blockSizeHorizontal: blockSizeHorizontal,
      blockSizeVertical: blockSizeVertical,
      safeBlockHorizontal: safeBlockHorizontal,
      safeBlockVertical: safeBlockVertical,
      deviceTypeConfig: deviceTypeConfig,
      breakpoint: breakpoint,
    );

    var content = child;
    if (showDebugOverlay && (kDebugMode || kProfileMode)) {
      content = FlexiDebugOverlay(child: child);
    }

    return FlexiInheritedWidget(
      data: data,
      allowImplicitRebuilds: allowImplicitRebuilds,
      child: content,
    );
  }
}

/// Convenience class for accessing [ScreenAdaptiveData] from the widget tree.
class Flexi {
  /// Accesses the [ScreenAdaptiveData] provided by the nearest [FlexiConfig].
  ///
  /// Using this method with an [aspect] ensures that your widget only rebuilds
  /// when the specific dimension or property changes.
  static ScreenAdaptiveData? of(BuildContext context, {FlexiAspect? aspect}) {
    return FlexiInheritedWidget.of(context, aspect: aspect);
  }
}

class FlexiInheritedWidget extends InheritedModel<FlexiAspect> {
  final ScreenAdaptiveData data;
  final bool allowImplicitRebuilds;

  const FlexiInheritedWidget({
    super.key,
    required this.data,
    required this.allowImplicitRebuilds,
    required super.child,
  });

  static ScreenAdaptiveData? of(BuildContext context, {FlexiAspect? aspect}) {
    // If no aspect is provided, we use FlexiAspect.implicit to allow
    // updateShouldNotifyDependent to manage rebuilds based on strict mode.
    return InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
            aspect: aspect ?? FlexiAspect.implicit)
        ?.data;
  }

  @override
  bool updateShouldNotify(FlexiInheritedWidget oldWidget) {
    // Return true if data has changed to allow updateShouldNotifyDependent to run.
    return data != oldWidget.data;
  }

  @override
  bool updateShouldNotifyDependent(
    FlexiInheritedWidget oldWidget,
    Set<FlexiAspect> dependencies,
  ) {
    if (dependencies.contains(FlexiAspect.width) &&
        data.screenWidth != oldWidget.data.screenWidth) {
      return true;
    }
    if (dependencies.contains(FlexiAspect.height) &&
        data.screenHeight != oldWidget.data.screenHeight) {
      return true;
    }
    if (dependencies.contains(FlexiAspect.pixelRatio) &&
        data.devicePixelRatio != oldWidget.data.devicePixelRatio) {
      return true;
    }
    if (dependencies.contains(FlexiAspect.breakpoint) &&
        data.breakpoint != oldWidget.data.breakpoint) {
      return true;
    }

    if (dependencies.contains(FlexiAspect.implicit)) {
      if (allowImplicitRebuilds) {
        return data != oldWidget.data;
      }

      // Assert/Warning in debug mode if implicit rebuilds are disabled.
      // We only show this if there are no OTHER explicit aspects being tracked.
      // (InheritedModel merges aspects into a single set).
      if (dependencies.length == 1) {
        assert(() {
          debugPrint(
              'Flexi UI: Widget is listening without aspect. This will not rebuild. '
              'Use context.flexi... or Flexi.of(context, aspect: FlexiAspect.width)');
          return true;
        }());
      }

      return false;
    }

    return false;
  }
}
