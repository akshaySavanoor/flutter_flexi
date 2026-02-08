import 'package:flutter/widgets.dart';

import 'responsive_layout.dart';

/// A convenience widget for creating responsive cards that scale relative
/// to their parent container.
///
/// This widget wraps [ResponsiveLayout] and provides a simplified interface
/// for building components that need to be adaptive based on the space
/// they occupy rather than the entire screen size.
///
/// **Note**: [ResponsiveCard] (and the underlying [ResponsiveLayout]) requires
/// a bounded parent width to correctly calculate its children's relative sizes.
class ResponsiveCard extends StatelessWidget {
  /// The widget to be made responsive.
  final Widget child;

  /// The design width that this card was originally designed for (default: 300).
  ///
  /// This serves as the reference point for the `.fw(context)` extension.
  final double targetWidth;

  /// The design height that this card was originally designed for (default: 400).
  ///
  /// This serves as the reference point for the `.fh(context)` extension.
  final double targetHeight;

  /// Creates a [ResponsiveCard].
  const ResponsiveCard({
    super.key,
    required this.child,
    this.targetWidth = 300,
    this.targetHeight = 400,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      targetWidth: targetWidth,
      targetHeight: targetHeight,
      child: child,
    );
  }
}
