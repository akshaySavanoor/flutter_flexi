import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flexi_ui/flexi_ui.dart';

class RebuildTracker extends StatefulWidget {
  final FlexiAspect aspect;
  final VoidCallback onRebuild;

  const RebuildTracker({super.key, required this.aspect, required this.onRebuild});

  @override
  State<RebuildTracker> createState() => _RebuildTrackerState();
}

class _RebuildTrackerState extends State<RebuildTracker> {
  @override
  Widget build(BuildContext context) {
    Flexi.of(context, aspect: widget.aspect);
    widget.onRebuild();
    return const SizedBox.shrink();
  }
}

void main() {
  testWidgets('Rebuild Performance Audit: Granular Scoping', (WidgetTester tester) async {
    int rebuildCount = 0;

    // We use a stable key and a builder to avoid full tree rebuilds from pumpWidget
    final widget = FlexiConfig(
      child: MaterialApp(
        home: Scaffold(
          body: RebuildTracker(
            aspect: FlexiAspect.width,
            onRebuild: () => rebuildCount++,
          ),
        ),
      ),
    );

    await tester.pumpWidget(widget);
    expect(rebuildCount, 1);

    // Change height ONLY
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    
    // We PUMP the existing tree. FlexiConfig should catch the MediaQuery change.
    await tester.pump(const Duration(milliseconds: 100));
    
    expect(rebuildCount, 1, reason: 'Height change should not rebuild width-dependent widget');

    // Change width
    tester.view.physicalSize = const Size(1000, 1200);
    await tester.pump(const Duration(milliseconds: 100));
    
    expect(rebuildCount, 2, reason: 'Width change SHOULD rebuild width-dependent widget');
  });
}
