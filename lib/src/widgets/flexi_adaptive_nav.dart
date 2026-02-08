import 'package:flutter/widgets.dart';
import '../widgets/flexi_config.dart';
import '../constants/flexi_aspect.dart';

/// A helper widget that switches between navigation patterns based on screen size.
/// 
/// Typically used to switch between a [BottomNavigationBar] on mobile and a 
/// [NavigationRail] or [Drawer] on desktop.
class FlexiAdaptiveNav extends StatelessWidget {
  /// The navigation widget to use for mobile and small tablet portrait.
  final Widget mobile;

  /// The navigation widget to use for desktop and large tablet landscape.
  final Widget desktop;

  /// Optional widget for tablet if a specific medium layout is needed.
  final Widget? tablet;

  const FlexiAdaptiveNav({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    final data = Flexi.of(context, aspect: FlexiAspect.breakpoint);
    final config = data.deviceTypeConfig;

    if (config.isDesktop) {
      return desktop;
    }

    if (config.isTabletLandscape) {
      return tablet ?? desktop;
    }

    return mobile;
  }
}
