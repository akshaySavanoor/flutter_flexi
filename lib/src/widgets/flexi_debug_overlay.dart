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

    // Subscribe to width and height for live updates
    final data = Flexi.of(context, aspect: FlexiAspect.width);
    Flexi.of(context, aspect: FlexiAspect.height);

    final config = data.deviceTypeConfig;
    final scaleW = data.screenWidth / config.designMinWidth;
    final scaleH = data.screenHeight / config.designMinHeight;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withAlpha(80)),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontFamily: 'monospace',
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
                fontSize: 11,
              ),
            ),
            const Divider(color: Colors.white24, height: 8),
            _Row('Size',
                '${data.screenWidth.toInt()} x ${data.screenHeight.toInt()}'),
            _Row('Breakpoint', data.breakpoint.name),
            _Row('Scale W', scaleW.toStringAsFixed(2)),
            _Row('Scale H', scaleH.toStringAsFixed(2)),
            _Row('DPR', data.devicePixelRatio.toStringAsFixed(1)),
            _Row('Orient', data.orientation.name),
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
            style: const TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
          ),
          Text(value),
        ],
      ),
    );
  }
}
