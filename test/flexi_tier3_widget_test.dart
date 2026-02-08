import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tier 3 Widgets', () {
    testWidgets('FlexiAdaptiveNav switches based on breakpoint',
        (tester) async {
      // Mobile
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(300, 600)),
          child: FlexiConfig(
            child: FlexiAdaptiveNav(
              mobile: Text('MobileNav', textDirection: TextDirection.ltr),
              desktop: Text('DesktopNav', textDirection: TextDirection.ltr),
            ),
          ),
        ),
      );
      expect(find.text('MobileNav'), findsOneWidget);

      // Desktop
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(1200, 800)),
          child: FlexiConfig(
            child: FlexiAdaptiveNav(
              mobile: Text('MobileNav', textDirection: TextDirection.ltr),
              desktop: Text('DesktopNav', textDirection: TextDirection.ltr),
            ),
          ),
        ),
      );
      expect(find.text('DesktopNav'), findsOneWidget);
    });

    testWidgets('FlexiMinTapTarget enforces minimum size', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: FlexiMinTapTarget(
              minSize: 60,
              child: SizedBox(width: 20, height: 20),
            ),
          ),
        ),
      );

      final tapTarget = tester.getRect(find.byType(FlexiMinTapTarget));
      expect(tapTarget.width, 60);
      expect(tapTarget.height, 60);
    });
  });
}
