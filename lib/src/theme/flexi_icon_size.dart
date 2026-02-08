import 'package:flutter/widgets.dart';
import '../widgets/flexi_config.dart';

/// Provides responsive icon sizes that scale fluidly across breakpoints.
class FlexiIconSize {
  const FlexiIconSize._();

  /// Small icon size (Default: 16 -> 20).
  static double s(BuildContext context) =>
      FlexiConfig.of(context).icons.s.resolve(context);

  /// Medium icon size (Default: 20 -> 24).
  static double m(BuildContext context) =>
      FlexiConfig.of(context).icons.m.resolve(context);

  /// Large icon size (Default: 24 -> 32).
  static double l(BuildContext context) =>
      FlexiConfig.of(context).icons.l.resolve(context);
}
