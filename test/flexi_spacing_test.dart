import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiSpacing', () {
    testWidgets('resolves default spacing values correctly', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(768, 600), // Exact Tablet Start
          ),
          child: FlexiConfig(
            child: Builder(builder: (context) {
              // Mobile (Width < 480)
              return Text(
                'XS: ${FlexiSpacing.xs(context)}',
                textDirection: TextDirection.ltr,
              );
            }),
          ),
        ),
      );

      // Default surface is 800x600 (Tablet)
      // XS Tablet Default = 6
      expect(find.text('XS: 6.0'), findsOneWidget);
    });

    testWidgets('responds to custom config', (tester) async {
      const customSpacing = FlexiSpacingConfig(
        xs: FlexiFluid3(mobile: 10, tablet: 20, desktop: 30),
        s: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
        m: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
        l: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
        xl: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
        xxl: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
      );

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(768, 600), // Exact Tablet Start
          ),
          child: FlexiConfig(
            spacing: customSpacing,
            child: Builder(builder: (context) {
              return Text(
                'XS: ${FlexiSpacing.xs(context)}',
                textDirection: TextDirection.ltr,
              );
            }),
          ),
        ),
      );

      // Default surface 800x600 (Tablet) -> Expect 20
      expect(find.text('XS: 20.0'), findsOneWidget);
    });
  });
}
