import 'package:flutter/widgets.dart';

import '../constants/flexi_aspect.dart';
import '../widgets/flexi_config.dart';

/// Extension for responsive stroke/border width scaling.
extension FlexiStroke on num {
  /// Scales a stroke value fluidly based on screen width, with heavy dampening.
  ///
  /// Since borders shouldn't become too thick on large screens, this uses
  /// a 0.3 dampening factor and ensures hairlines remain visible.
  double fStroke(BuildContext context) {
    final data = Flexi.of(context, aspect: FlexiAspect.width);
    final config = data.deviceTypeConfig;

    // Calculate base scale
    final scale = data.screenWidth / config.designMinWidth;

    // Apply heavy dampening (0.3 factor)
    final dampenedScale = 1.0 + (scale - 1.0) * 0.3;

    final result = toDouble() * dampenedScale;

    // Ensure we don't go below the original value and don't scale too much
    return result.clamp(toDouble(), toDouble() * 1.5);
  }
}
