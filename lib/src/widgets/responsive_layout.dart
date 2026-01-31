import 'package:flutter/widgets.dart';

import '../config/responsive_card_data.dart';
import 'responsive_inherited_model.dart';

/// A widget that initializes a responsive layout.
///
/// It uses a [LayoutBuilder] to get the parent's dimensions and provides
/// a [ResponsiveCardData] to its descendants via [ResponsiveInheritedModel].
///
/// Use this widget to wrap the section of your UI that needs to be responsive
/// based on the parent's size.
class ResponsiveLayout extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The target width that the layout should adapt to.
  final double targetWidth;

  /// The target height that the layout should adapt to.
  final double targetHeight;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.targetWidth = 300,
    this.targetHeight = 400,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final data = ResponsiveCardData(
          currentParentWidth: constraints.maxWidth,
          currentParentHeight: constraints.maxHeight,
          targetParentWidth: targetWidth,
          targetParentHeight: targetHeight,
        );

        return ResponsiveInheritedModel(
          data: data,
          child: child,
        );
      },
    );
  }
}
