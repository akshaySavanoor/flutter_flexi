import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../flexi_ui.dart';

/// A debug overlay that displays current screen metrics and responsive data.
///
/// This widget is automatically enabled when [FlexiConfig.showDebugOverlay] is true.
/// It ignores pointer events so it doesn't interfere with the app's interactivity.
class FlexiDebugOverlay extends StatelessWidget {
  final Widget child;

  const FlexiDebugOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) return child;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          child,
          Positioned(
            top: 0,
            right: 0,
            child: IgnorePointer(
              child: SafeArea(
                child: _OverlayContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverlayContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // We use a Builder to ensure we have the correct context for Flexi.of
    // but FlexiDebugOverlay is child of FlexiConfig, so context is valid?
    // Actually FlexiConfig wraps child in FlexiInheritedWidget, then that child
    // might be FlexiDebugOverlay. So FlexiDebugOverlay is INSIDE FlexiInheritedWidget.
    // Yes, FlexiConfig structure: FlexiInheritedWidget(child: FlexiDebugOverlay(child: userChild))
    // So context here can access FlexiInheritedWidget.

    // Subscribe to all aspects to ensure the overlay always shows current data
    final data = Flexi.of(context, aspect: FlexiAspect.breakpoint);
    if (data == null) return const SizedBox.shrink();
    data.screenWidth;
    data.screenHeight;
    data.devicePixelRatio;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Courier',
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Flexi Debug',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 4),
            _Row('Size',
                '${data.screenWidth.toStringAsFixed(1)} x ${data.screenHeight.toStringAsFixed(1)}'),
            _Row('Breakpoint', data.breakpoint.name),
            _Row('Device', data.deviceTypeConfig.targetDeviceType.name),
            _Row('Orient', data.orientation.name),
            _Row('DPR', data.devicePixelRatio.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          Text(value),
        ],
      ),
    );
  }
}
