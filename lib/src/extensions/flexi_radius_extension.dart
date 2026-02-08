import 'package:flutter/widgets.dart';

import '../constants/flexi_aspect.dart';
import '../widgets/flexi_config.dart';

/// Extension for responsive border radius scaling.
extension FlexiRadius on num {
  /// Scales a radius value fluidly based on screen width, with dampening.
  ///
  /// Uses the formula: value * (1 + (scale - 1) * 0.5) to avoid excessive rounding.
  double fr(BuildContext context) {
    final data = Flexi.of(context, aspect: FlexiAspect.width);
    final config = data.deviceTypeConfig;

    // Calculate base scale
    final scale = data.screenWidth / config.designMinWidth;

    // Apply dampening (0.5 factor) to make radius scale slower than layout
    final dampenedScale = 1.0 + (scale - 1.0) * 0.5;

    // Clamp to avoid extreme values
    return (toDouble() * dampenedScale).clamp(0.0, toDouble() * 2.0);
  }
}
