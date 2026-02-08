import 'package:flutter/widgets.dart';
import '../widgets/flexi_config.dart';
import '../constants/flexi_aspect.dart';
import '../constants/flexi_breakpoint.dart';

/// A widget that efficiently hides/shows its child based on breakpoints.
/// 
/// Unlike [Visibility] or [Offstage], this widget does not build the child at all
/// if it is marked as hidden for the current breakpoint, reducing layout cost.
class FlexiVisibility extends StatelessWidget {
  /// The widget to show.
  final Widget child;

  /// Whether to show the child on mobile breakpoints.
  final bool mobile;

  /// Whether to show the child on tablet breakpoints.
  final bool tablet;

  /// Whether to show the child on desktop breakpoints.
  final bool desktop;

  const FlexiVisibility({
    super.key,
    required this.child,
    this.mobile = true,
    this.tablet = true,
    this.desktop = true,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = Flexi.of(context, aspect: FlexiAspect.breakpoint).breakpoint;

    final isVisible = switch (breakpoint) {
      FlexiBreakpoint.mobilePortrait || FlexiBreakpoint.mobileLandscape => mobile,
      FlexiBreakpoint.tablet => tablet,
      FlexiBreakpoint.desktop => desktop,
    };

    if (!isVisible) {
      return const SizedBox.shrink();
    }

    return child;
  }
}
