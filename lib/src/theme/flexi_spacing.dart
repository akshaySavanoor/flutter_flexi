import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';

/// A centralized, responsive spacing system for uniform layout scaling.
///
/// [FlexiSpacing] provides a set of standardized spacing values that adapt fluidly 
/// across mobile, tablet, and desktop breakpoints using [FlexiSpacingConfig] provided
/// by [FlexiConfig].
///
/// Usage:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(FlexiSpacing.m(context)),
///   child: ...
/// )
/// ```
@immutable
class FlexiSpacing {
  const FlexiSpacing._();

  /// Extra small spacing (Mobile: 4, Tablet: 6, Desktop: 8)
  static double xs(BuildContext context) =>
      InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
              aspect: FlexiAspect.width)!
          .spacing
          .xs
          .resolve(context);

  /// Small spacing (Mobile: 8, Tablet: 10, Desktop: 12)
  static double s(BuildContext context) =>
      InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
              aspect: FlexiAspect.width)!
          .spacing
          .s
          .resolve(context);

  /// Medium spacing (Mobile: 16, Tablet: 20, Desktop: 24)
  static double m(BuildContext context) =>
      InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
              aspect: FlexiAspect.width)!
          .spacing
          .m
          .resolve(context);

  /// Large spacing (Mobile: 24, Tablet: 30, Desktop: 36)
  static double l(BuildContext context) =>
      InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
              aspect: FlexiAspect.width)!
          .spacing
          .l
          .resolve(context);

  /// Extra large spacing (Mobile: 32, Tablet: 40, Desktop: 48)
  static double xl(BuildContext context) =>
      InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
              aspect: FlexiAspect.width)!
          .spacing
          .xl
          .resolve(context);

  /// Extra extra large spacing (Mobile: 48, Tablet: 60, Desktop: 72)
  static double xxl(BuildContext context) =>
      InheritedModel.inheritFrom<FlexiInheritedWidget>(context,
              aspect: FlexiAspect.width)!
          .spacing
          .xxl
          .resolve(context);
}
