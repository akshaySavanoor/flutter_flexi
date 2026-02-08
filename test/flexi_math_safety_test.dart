import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flexi UI Math Safety Tests', () {
    testWidgets('FlexiFluid3 handles identical breakpoints safely',
        (tester) async {
      const fluid = FlexiFluid3(mobile: 10, tablet: 20, desktop: 40);

      await tester.pumpWidget(
        FlexiConfig(
          designMinWidth: 360,
          designMaxWidth: 360, // Edge case: Identical breakpoints
          mobilePortraitBreakpoint: 600,
          child: Builder(
            builder: (context) {
              final val = fluid.resolve(context);
              return Text('Value: $val', textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      // Should return mobile value (10) since width (800 default) is >= p3
      // Wait, default tester size is 800x600.
      // If p3 is 360, and width is 800, it should return desktop value (40).
      expect(find.text('Value: 40.0'), findsOneWidget);
    });

    testWidgets('Scaling extensions throw assertion for zero design dimensions',
        (tester) async {
      await tester.pumpWidget(
        FlexiConfig(
          designMinWidth: 0, // Incorrect config
          designMaxWidth: 0, // Incorrect config
          child: Builder(
            builder: (context) {
              return const Text('Safe', textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      // The build itself should trigger the assert in buildWithDimensions
      expect(tester.takeException(), isAssertionError);
    });

    testWidgets('FlexiFluid3 handles narrow ranges safely', (tester) async {
      // Use very small but positive range to avoid asserts but check math
      const fluid = FlexiFluid3(mobile: 10, tablet: 20, desktop: 40);

      await tester.pumpWidget(
        FlexiConfig(
          designMinWidth: 360,
          designMaxWidth: 360.1,
          mobilePortraitBreakpoint: 600,
          child: Builder(
            builder: (context) {
              final val = fluid.resolve(context);
              return Text('Value: $val', textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      // Width 800 >= p3 (360.1) -> return desktop (40)
      expect(find.text('Value: 40.0'), findsOneWidget);
    });
  });
}
