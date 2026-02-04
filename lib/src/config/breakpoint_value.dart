import 'package:flutter/widgets.dart';

import '../constants/flexi_aspect.dart';
import '../widgets/flexi_config.dart';

/// A class that provides a value based on the current screen size breakpoints.
///
/// This allows for discrete responsive values (e.g., column counts or font sizes)
/// instead of continuous scaling. It resolves the most appropriate value based
/// on the device type detected by [FlexiConfig].
///
/// Example:
/// ```dart
/// const columnCount = BreakpointValue<int>(
///   mobile: 1,
///   tablet: 2,
///   desktop: 4,
/// );
/// ...
/// GridView.count(crossAxisCount: columnCount.v(context));
/// ```
class BreakpointValue<T> {
  /// The value used for mobile devices (portrait).
  final T mobile;

  /// The value used for tablets or landscape mobile devices.
  final T? tablet;

  /// The value used for desktop screens.
  final T? desktop;

  const BreakpointValue({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Resolves the value based on the current [BuildContext].
  ///
  /// Priority: Desktop -> Tablet/Landscape -> Mobile.
  T resolve(BuildContext context) {
    final data =
        FlexiInheritedWidget.of(context, aspect: FlexiAspect.breakpoint);
    if (data == null) return mobile;

    final config = data.deviceTypeConfig;
    if (config.isDesktop && desktop != null) return desktop!;
    if (config.isTabletLandscape && tablet != null) return tablet!;
    if (config.isPhoneLandscape && tablet != null) return tablet!;

    return mobile;
  }
}

extension BreakpointExtension<T> on BreakpointValue<T> {
  /// Shorthand for resolving the value.
  T v(BuildContext context) => resolve(context);
}
