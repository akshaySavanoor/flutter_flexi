import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiTextStyles', () {
    testWidgets('resolves default typography values correctly', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(768, 600), // Exact Tablet Start
          ),
          child: FlexiConfig(
            child: Builder(builder: (context) {
              final style = FlexiTextStyles.h1(context);
              return Text(
                'H1Size: ${style.fontSize}',
                textDirection: TextDirection.ltr,
              );
            }),
          ),
        ),
      );

      // Default surface 800x600 (Tablet)
      // H1 Tablet Default = 40
      expect(find.text('H1Size: 40.0'), findsOneWidget);
    });

    testWidgets('respects custom typography config', (tester) async {
      const customTypography = FlexiTypographyConfig(
        h1: FlexiFluid3(mobile: 100, tablet: 200, desktop: 300),
        h2: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
        h3: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
        body: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
        small: FlexiFluid3(mobile: 0, tablet: 0, desktop: 0),
      );

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(768, 600), // Exact Tablet Start
          ),
          child: FlexiConfig(
            typography: customTypography,
            child: Builder(builder: (context) {
              final style = FlexiTextStyles.h1(context);
              return Text(
                'H1Size: ${style.fontSize}',
                textDirection: TextDirection.ltr,
              );
            }),
          ),
        ),
      );

      // Default surface 800x600 (Tablet) -> Expect 200
      expect(find.text('H1Size: 200.0'), findsOneWidget);
    });
  });
}
