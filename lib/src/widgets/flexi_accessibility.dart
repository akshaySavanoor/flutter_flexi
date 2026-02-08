import 'package:flutter/widgets.dart';

/// Ensures a minimum tap target size (Default: 48x48) for accessibility.
class FlexiMinTapTarget extends StatelessWidget {
  final Widget child;
  final double minSize;

  const FlexiMinTapTarget({
    super.key,
    required this.child,
    this.minSize = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize,
        minHeight: minSize,
      ),
      child: Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: child,
      ),
    );
  }
}

/// Clamps the text scale factor to prevent extreme overflow on large accessibility settings.
class FlexiTextClamp extends StatelessWidget {
  final Widget child;
  final double maxScaleFactor;

  const FlexiTextClamp({
    super.key,
    required this.child,
    this.maxScaleFactor = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    // Aspect lookup: We listen only to what's necessary (textScaler)
    // In newer Flutter, we can use MediaQuery.textScalerOf(context).
    // For universal compatibility, we use the model but copy it.
    final data = MediaQuery.of(context);
    final clampedScale = data.textScaler.clamp(
      maxScaleFactor: maxScaleFactor,
    );

    if (data.textScaler == clampedScale) return child;

    return MediaQuery(
      data: data.copyWith(textScaler: clampedScale),
      child: child,
    );
  }
}
