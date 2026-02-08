import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';

/// A centralized, responsive typography system.
///
/// [FlexiTextStyles] provides adaptive text styles where font sizes scale
/// fluidly across breakpoints using [FlexiTypographyConfig] provided by [FlexiConfig].
/// It also respects the system text scale factor for accessibility.
///
/// Usage:
/// ```dart
/// Text(
///   'Headline',
///   style: FlexiTextStyles.h1(context),
/// )
/// ```
@immutable
class FlexiTextStyles {
  const FlexiTextStyles._();

  static (FlexiTypographyConfig, TextScaler) _deps(BuildContext context) {
    final inherited = InheritedModel.inheritFrom<FlexiInheritedWidget>(
      context,
      aspect: FlexiAspect.width,
    )!;
    return (inherited.typography, MediaQuery.textScalerOf(context));
  }

  /// Returns a responsive H1 text style.
  static TextStyle h1(BuildContext context) {
    final (config, textScaler) = _deps(context);
    return TextStyle(
      fontSize: textScaler.scale(config.h1.resolve(context)),
      fontWeight: FontWeight.bold,
    );
  }

  /// Returns a responsive H2 text style.
  static TextStyle h2(BuildContext context) {
    final (config, textScaler) = _deps(context);
    return TextStyle(
      fontSize: textScaler.scale(config.h2.resolve(context)),
      fontWeight: FontWeight.w600,
    );
  }

  /// Returns a responsive H3 text style.
  static TextStyle h3(BuildContext context) {
    final (config, textScaler) = _deps(context);
    return TextStyle(
      fontSize: textScaler.scale(config.h3.resolve(context)),
      fontWeight: FontWeight.w600,
    );
  }

  /// Returns a responsive Body text style.
  static TextStyle body(BuildContext context) {
    final (config, textScaler) = _deps(context);
    return TextStyle(
      fontSize: textScaler.scale(config.body.resolve(context)),
      fontWeight: FontWeight.normal,
    );
  }

  /// Returns a responsive Small text style.
  static TextStyle small(BuildContext context) {
    final (config, textScaler) = _deps(context);
    return TextStyle(
      fontSize: textScaler.scale(config.small.resolve(context)),
      fontWeight: FontWeight.normal,
    );
  }
}
