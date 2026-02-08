import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiLayout', () {
    testWidgets('renders mobile widget on phone', (tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(300, 800)),
          child: FlexiConfig(
              child: FlexiLayout(
            mobile: Text('Mobile View', textDirection: TextDirection.ltr),
            tablet: Text('Tablet View', textDirection: TextDirection.ltr),
            desktop: Text('Desktop View', textDirection: TextDirection.ltr),
          )),
        ),
      );

      expect(find.text('Mobile View'), findsOneWidget);
      expect(find.text('Tablet View'), findsNothing);
      expect(find.text('Desktop View'), findsNothing);
    });

    testWidgets('renders tablet widget on tablet', (tester) async {
      // 800 > 768 (mobileLandscapeBreakpoint)
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(800, 600)),
          child: FlexiConfig(
              child: FlexiLayout(
            mobile: Text('Mobile View', textDirection: TextDirection.ltr),
            tablet: Text('Tablet View', textDirection: TextDirection.ltr),
            desktop: Text('Desktop View', textDirection: TextDirection.ltr),
          )),
        ),
      );

      expect(find.text('Mobile View'), findsNothing);
      expect(find.text('Tablet View'), findsOneWidget);
      expect(find.text('Desktop View'), findsNothing);
    });

    testWidgets('renders desktop widget on desktop', (tester) async {
      // 1500 > 1024 (tabletLandscapeBreakpoint)
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(1500, 1000)),
          child: FlexiConfig(
              child: FlexiLayout(
            mobile: Text('Mobile View', textDirection: TextDirection.ltr),
            tablet: Text('Tablet View', textDirection: TextDirection.ltr),
            desktop: Text('Desktop View', textDirection: TextDirection.ltr),
          )),
        ),
      );

      expect(find.text('Mobile View'), findsNothing);
      expect(find.text('Tablet View'), findsNothing);
      expect(find.text('Desktop View'), findsOneWidget);
    });

    testWidgets('falls back to mobile if tablet missing', (tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(800, 600)),
          child: FlexiConfig(
              child: FlexiLayout(
            mobile: Text('Mobile View', textDirection: TextDirection.ltr),
            // tablet: null
            desktop: Text('Desktop View', textDirection: TextDirection.ltr),
          )),
        ),
      );

      expect(find.text('Mobile View'), findsOneWidget);
    });

    testWidgets('falls back to tablet if desktop missing', (tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(1500, 1000)),
          child: FlexiConfig(
              child: FlexiLayout(
            mobile: Text('Mobile View', textDirection: TextDirection.ltr),
            tablet: Text('Tablet View', textDirection: TextDirection.ltr),
            // desktop: null
          )),
        ),
      );

      expect(find.text('Tablet View'), findsOneWidget);
    });
  });
}
