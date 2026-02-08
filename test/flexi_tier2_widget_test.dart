import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tier 2 Widgets', () {
    testWidgets('FlexiVisibility shows/hides children based on breakpoint',
        (tester) async {
      // Mobile
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(300, 600)),
          child: FlexiConfig(
            child: FlexiVisibility(
              mobile: true,
              tablet: false,
              desktop: false,
              child: Text('Visible', textDirection: TextDirection.ltr),
            ),
          ),
        ),
      );
      expect(find.text('Visible'), findsOneWidget);

      // Tablet
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(800, 600)),
          child: FlexiConfig(
            child: FlexiVisibility(
              mobile: true,
              tablet: false,
              desktop: false,
              child: Text('Visible', textDirection: TextDirection.ltr),
            ),
          ),
        ),
      );
      expect(find.text('Visible'), findsNothing);
    });

    testWidgets('FlexiMaxWidth constrains width', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: FlexiMaxWidth(
            maxWidth: 500,
            child: SizedBox(width: 1000, height: 100, child: Text('Content')),
          ),
        ),
      );

      final container = tester.getRect(find.byType(SizedBox));
      expect(container.width, 500);
    });
  });
}
