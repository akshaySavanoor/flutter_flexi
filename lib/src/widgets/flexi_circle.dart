import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';
import '../../src/extensions/flexi_safe_scaling.dart';

/// A convenience widget for rendering a circular container that scales safely.
///
/// [FlexiCircle] ensures that its [size] scales proportionally using [FlexiSafeScaling.fs],
/// preventing distortion into an oval when width and height are scaled differently.
class FlexiCircle extends StatelessWidget {
  /// The diameter of the circle in design pixels.
  final double size;

  /// The child widget to center within the circle.
  final Widget? child;
  
  /// The background color of the circle.
  final Color? color;

  const FlexiCircle({
    super.key,
    required this.size,
    this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scaledSize = size.fs(context);

    return Container(
      width: scaledSize,
      height: scaledSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
