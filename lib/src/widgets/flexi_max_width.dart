import 'package:flutter/widgets.dart';

/// A container that constrains its child's width on large screens and centers it.
/// 
/// This is typical for "Main Content" areas that shouldn't stretch infinitely.
class FlexiMaxWidth extends StatelessWidget {
  /// The maximum width the child can occupy.
  final double maxWidth;

  /// The child to constrain and center.
  final Widget child;

  /// Alignment of the child within the constraints (Default: center).
  final AlignmentGeometry alignment;

  const FlexiMaxWidth({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
