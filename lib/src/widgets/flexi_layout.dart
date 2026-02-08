import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';

/// A widget that switches its content based on the current breakpoint.
///
/// [FlexiLayout] allows you to provide different widget trees for mobile,
/// tablet, and desktop breakpoints. It uses [Flexi.of(context)] to listen specifically
/// to breakpoint changes (aspect: [FlexiAspect.breakpoint]), ensuring efficient rebuilds.
///
/// If a specific layout is not provided, it falls back gracefully:
/// - Desktop falls back to Tablet, then Mobile.
/// - Tablet falls back to Mobile.
/// - Mobile is required (or inferred if others are missing, but practically required).
class FlexiLayout extends StatelessWidget {
  /// The widget to display on mobile devices (phone portrait/landscape).
  final Widget mobile;

  /// The widget to display on tablet devices (landscape).
  /// If null, [mobile] will be used.
  final Widget? tablet;

  /// The widget to display on desktop devices.
  /// If null, [tablet] (if available) or [mobile] will be used.
  final Widget? desktop;

  const FlexiLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    // Listen only to breakpoint changes to avoid unnecessary rebuilds on small resizes.
    final flexiData = Flexi.of(context, aspect: FlexiAspect.breakpoint);

    final breakpoint = flexiData.breakpoint;

    return switch (breakpoint) {
      FlexiBreakpoint.desktop => desktop ?? tablet ?? mobile,
      FlexiBreakpoint.tablet => tablet ?? mobile,
      FlexiBreakpoint.mobilePortrait ||
      FlexiBreakpoint.mobileLandscape =>
        mobile,
    };
  }
}
