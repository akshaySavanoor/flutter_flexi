import 'package:flutter/widgets.dart';

import '../widgets/responsive_inherited_model.dart';

/// Provides adaptive sizing extensions for numeric values within a [ResponsiveLayout].
extension AdaptiveSizeProvider on num {
  /// Calculates the adaptive width based on the current parent width and target parent width
  /// using the [ResponsiveLayout] context.
  double fw(BuildContext context) {
    final data = ResponsiveInheritedModel.of(context, aspect: 'width');
    if (data == null) {
      throw Exception(
          'ResponsiveLayout not found in context. Wrap your widget in a ResponsiveLayout.');
    }
    return (data.currentParentWidth * this) / data.targetParentWidth;
  }

  /// Calculates the adaptive height based on the current parent height and target parent height
  /// using the [ResponsiveLayout] context.
  double fh(BuildContext context) {
    final data = ResponsiveInheritedModel.of(context, aspect: 'height');
    if (data == null) {
      throw Exception(
          'ResponsiveLayout not found in context. Wrap your widget in a ResponsiveLayout.');
    }
    return (data.currentParentHeight * this) / data.targetParentHeight;
  }
}
