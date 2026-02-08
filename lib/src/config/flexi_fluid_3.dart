import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';

/// A class that handles multi-stage fluid scaling across three breakpoints.
///
/// It interpolates values smoothly between [mobile] -> [tablet] and [tablet] -> [desktop]
/// based on the current screen width.
@immutable
class FlexiFluid3 {
  /// The value to use at the mobile breakpoint.
  final double mobile;

  /// The value to use at the tablet breakpoint.
  final double tablet;

  /// The value to use at the desktop breakpoint.
  final double desktop;

  const FlexiFluid3({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  /// Resolves the fluid value based on the current context.
  ///
  /// Uses [Flexi.of(context)] to get scaling parameters.
  double resolve(BuildContext context) {
    final flexiData = Flexi.of(context, aspect: FlexiAspect.width);

    final width = flexiData.screenWidth;
    final config = flexiData.deviceTypeConfig;

    // We define our interpolation points:
    // P1: designMinWidth (Mobile Start) -> value: mobile
    // P2: mobileLandscapeBreakpoint (Tablet Start) -> value: tablet
    // P3: designMaxWidth (Desktop End) -> value: desktop

    final p1 = config.designMinWidth;
    final p2 = config.screenInfo.mobileLandscapeBreakpoint;
    final p3 = config.designMaxWidth;

    if (width <= p1) return mobile;
    if (width >= p3) return desktop;

    if (width < p2) {
      // Interpolate Mobile -> Tablet
      // Guard against p2 <= p1
      if (p2 <= p1) return tablet;
      final t = (width - p1) / (p2 - p1);
      return lerpDouble(mobile, tablet, t.clamp(0.0, 1.0))!;
    } else {
      // Interpolate Tablet -> Desktop
      // Guard against p3 <= p2
      if (p3 <= p2) return desktop;
      final t = (width - p2) / (p3 - p2);
      return lerpDouble(tablet, desktop, t.clamp(0.0, 1.0))!;
    }
  }
}
