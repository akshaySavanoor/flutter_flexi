import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tier 3 Scaling Logic', () {
    testWidgets('FlexiMotion resolves durations based on breakpoint',
        (tester) async {
      // Mobile
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(300, 600)),
          child: FlexiConfig(
            child: Builder(builder: (context) {
              final d = FlexiMotion.durationShort(context);
              return Text('D: ${d.inMilliseconds}',
                  textDirection: TextDirection.ltr);
            }),
          ),
        ),
      );
      expect(find.text('D: 150'), findsOneWidget);

      // Desktop
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1200, 800)),
          child: FlexiConfig(
            child: Builder(builder: (context) {
              final d = FlexiMotion.durationShort(context);
              return Text('D: ${d.inMilliseconds}',
                  textDirection: TextDirection.ltr);
            }),
          ),
        ),
      );
      expect(find.text('D: 200'), findsOneWidget);
    });

    testWidgets('FlexiTextClamp restricts textScaler', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(800, 600),
            textScaler: TextScaler.linear(2.0),
          ),
          child: FlexiTextClamp(
            maxScaleFactor: 1.5,
            child: Builder(builder: (context) {
              final scale = MediaQuery.textScalerOf(context).scale(10) / 10;
              return Text('Scale: $scale', textDirection: TextDirection.ltr);
            }),
          ),
        ),
      );
      // Expected clamped scale is 1.5
      expect(find.text('Scale: 1.5'), findsOneWidget);
    });
  });
}
