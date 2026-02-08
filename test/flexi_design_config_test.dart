import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiDesignConfig', () {
    test('default spacing values match v1.2.0 standards', () {
      const defaults = FlexiSpacingConfig.defaultConfig;
      expect(defaults.xs.mobile, 4);
      expect(defaults.m.mobile, 16);
      expect(defaults.xxl.desktop, 72);
    });

    test('default typography values match v1.2.0 standards', () {
      const defaults = FlexiTypographyConfig.defaultConfig;
      expect(defaults.h1.mobile, 32);
      expect(defaults.body.desktop, 18);
    });
  });

  group('FlexiConfig Integration', () {
    testWidgets('uses default config when none provided', (tester) async {
      // Set surface to exactly tablet start to get integer 20.0
      tester.view.physicalSize = const Size(768, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        FlexiConfig(
          child: Builder(
            builder: (context) {
              final val = FlexiSpacing.m(context);
              return Text('Spacing: $val', textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      expect(find.text('Spacing: 20.0'), findsOneWidget);
    });

    testWidgets('uses custom config when provided', (tester) async {
      tester.view.physicalSize = const Size(768, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const customSpacing = FlexiSpacingConfig(
        xs: FlexiFluid3(mobile: 1, tablet: 1, desktop: 1),
        s: FlexiFluid3(mobile: 1, tablet: 1, desktop: 1),
        m: FlexiFluid3(mobile: 100, tablet: 200, desktop: 300),
        l: FlexiFluid3(mobile: 1, tablet: 1, desktop: 1),
        xl: FlexiFluid3(mobile: 1, tablet: 1, desktop: 1),
        xxl: FlexiFluid3(mobile: 1, tablet: 1, desktop: 1),
      );

      await tester.pumpWidget(
        FlexiConfig(
          spacing: customSpacing,
          child: Builder(
            builder: (context) {
              final val = FlexiSpacing.m(context);
              return Text('Spacing: $val', textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      expect(find.text('Spacing: 200.0'), findsOneWidget);
    });

    testWidgets('applies text scale factor to typography', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(768, 600),
            textScaler: TextScaler.linear(2.0),
          ),
          child: FlexiConfig(
            child: Builder(
              builder: (context) {
                final style = FlexiTextStyles.body(context);
                return Text('Size: ${style.fontSize}',
                    textDirection: TextDirection.ltr);
              },
            ),
          ),
        ),
      );

      expect(find.text('Size: 32.0'), findsOneWidget);
    });
  });
}
