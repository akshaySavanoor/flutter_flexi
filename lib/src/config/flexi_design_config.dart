import 'package:flutter/foundation.dart';
import '../../src/config/flexi_fluid_3.dart';

@immutable
class FlexiSpacingConfig {
  final FlexiFluid3 xs;
  final FlexiFluid3 s;
  final FlexiFluid3 m;
  final FlexiFluid3 l;
  final FlexiFluid3 xl;
  final FlexiFluid3 xxl;

  const FlexiSpacingConfig({
    required this.xs,
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
    required this.xxl,
  });

  static const defaultConfig = FlexiSpacingConfig(
    xs: FlexiFluid3(mobile: 4, tablet: 6, desktop: 8),
    s: FlexiFluid3(mobile: 8, tablet: 10, desktop: 12),
    m: FlexiFluid3(mobile: 16, tablet: 20, desktop: 24),
    l: FlexiFluid3(mobile: 24, tablet: 30, desktop: 36),
    xl: FlexiFluid3(mobile: 32, tablet: 40, desktop: 48),
    xxl: FlexiFluid3(mobile: 48, tablet: 60, desktop: 72),
  );
}

@immutable
class FlexiTypographyConfig {
  final FlexiFluid3 h1;
  final FlexiFluid3 h2;
  final FlexiFluid3 h3;
  final FlexiFluid3 body;
  final FlexiFluid3 small;

  const FlexiTypographyConfig({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.body,
    required this.small,
  });

  static const defaultConfig = FlexiTypographyConfig(
    h1: FlexiFluid3(mobile: 32, tablet: 40, desktop: 48),
    h2: FlexiFluid3(mobile: 24, tablet: 30, desktop: 36),
    h3: FlexiFluid3(mobile: 20, tablet: 24, desktop: 28),
    body: FlexiFluid3(mobile: 14, tablet: 16, desktop: 18),
    small: FlexiFluid3(mobile: 12, tablet: 13, desktop: 14),
  );
}

@immutable
class FlexiIconConfig {
  final FlexiFluid3 s;
  final FlexiFluid3 m;
  final FlexiFluid3 l;

  const FlexiIconConfig({
    required this.s,
    required this.m,
    required this.l,
  });

  static const defaultConfig = FlexiIconConfig(
    s: FlexiFluid3(mobile: 16, tablet: 18, desktop: 20),
    m: FlexiFluid3(mobile: 20, tablet: 22, desktop: 24),
    l: FlexiFluid3(mobile: 24, tablet: 28, desktop: 32),
  );
}
