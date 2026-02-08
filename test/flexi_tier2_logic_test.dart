import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tier 2 Scaling Logic', () {
    testWidgets('FlexiRadius (.fr) applies dampened scaling', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(720, 600), // 2.0x scale (relative to 360)
          ),
          child: FlexiConfig(
            child: Builder(builder: (context) {
              final radius = 10.fr(context);
              // Base = 10. Scale = 2.0. Dampening = 0.5.
              // Dampened Scale = 1 + (2-1)*0.5 = 1.5.
              // Expected = 10 * 1.5 = 15.0.
              return Text('Radius: $radius', textDirection: TextDirection.ltr);
            }),
          ),
        ),
      );
      expect(find.text('Radius: 15.0'), findsOneWidget);
    });

    testWidgets('FlexiStroke (.fStroke) applies heavy dampening',
        (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(720, 600), // 2.0x scale
          ),
          child: FlexiConfig(
            child: Builder(builder: (context) {
              final stroke = 2.fStroke(context);
              // Base = 2. Scale = 2.0. Dampening = 0.3.
              // Dampened Scale = 1 + (2-1)*0.3 = 1.3.
              // Expected = 2 * 1.3 = 2.6.
              return Text('Stroke: $stroke', textDirection: TextDirection.ltr);
            }),
          ),
        ),
      );
      expect(find.text('Stroke: 2.6'), findsOneWidget);
    });

    testWidgets('FlexiIconSize resolves from config', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(360, 600), // Mobile
          ),
          child: FlexiConfig(
            child: Builder(builder: (context) {
              final s = FlexiIconSize.s(context);
              return Text('IconS: $s', textDirection: TextDirection.ltr);
            }),
          ),
        ),
      );
      // Default s mobile = 16.
      expect(find.text('IconS: 16.0'), findsOneWidget);
    });
  });
}
