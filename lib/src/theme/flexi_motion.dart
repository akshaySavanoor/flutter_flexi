import 'package:flutter/widgets.dart';
import '../widgets/flexi_config.dart';
import '../constants/flexi_aspect.dart';
import '../constants/flexi_breakpoint.dart';

/// Provides responsive animation durations based on the current device.
/// 
/// Generally, desktop animations are slightly slower to feel more substantial,
/// while mobile animations are faster to feel snappy.
class FlexiMotion {
  const FlexiMotion._();

  /// Short duration (e.g., hover, micro-interactions).
  /// Mobile: 150ms | Tablet: 180ms | Desktop: 200ms
  static Duration durationShort(BuildContext context) =>
      _resolve(context, mobile: 150, tablet: 180, desktop: 200);

  /// Medium duration (e.g., page transitions, expansion).
  /// Mobile: 250ms | Tablet: 300ms | Desktop: 350ms
  static Duration durationMedium(BuildContext context) =>
      _resolve(context, mobile: 250, tablet: 300, desktop: 350);

  /// Long duration (e.g., complex illustrations).
  /// Mobile: 400ms | Tablet: 500ms | Desktop: 600ms
  static Duration durationLong(BuildContext context) =>
      _resolve(context, mobile: 400, tablet: 500, desktop: 600);

  static Duration _resolve(
    BuildContext context, {
    required int mobile,
    required int tablet,
    required int desktop,
  }) {
    final breakpoint =
        Flexi.of(context, aspect: FlexiAspect.breakpoint).breakpoint;

    return switch (breakpoint) {
      FlexiBreakpoint.desktop => Duration(milliseconds: desktop),
      FlexiBreakpoint.tablet => Duration(milliseconds: tablet),
      FlexiBreakpoint.mobilePortrait ||
      FlexiBreakpoint.mobileLandscape =>
        Duration(milliseconds: mobile),
    };
  }
}
