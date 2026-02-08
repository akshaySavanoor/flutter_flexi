import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiSafeScaling (.fs)', () {
    testWidgets('uses width scaling when only global context available',
        (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(300, 800)),
          child: FlexiConfig(
            designMinWidth: 100,
            mobileLandscapeBreakpoint: 768,
            designMaxWidth: 1440,
            child: Builder(
              builder: (context) {
                // Screen 300, Design 100 -> Scale 3.0
                // 10.fs -> 30.0
                final val = 10.0.fs(context);
                expect(val, 30.0);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses min(scaleW, scaleH) inside ResponsiveLayout',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ResponsiveLayout(
            targetWidth: 100,
            targetHeight: 200,
            child: Builder(
              builder: (context) {
                // LayoutBuilder will provide constraints
                // Let's force constraints via parent
                return LayoutBuilder(builder: (context, constraints) {
                  // This inner builder is just to ensure we are inside ResponsiveLayout
                  // But ResponsiveLayout creates the context.
                  // We need to access .fs(context) where context is CHILD of ResponsiveLayout.

                  // Inside ResponsiveLayout, we typically have a child.
                  // Let's rely on the child builder.
                  return Container();
                });
              },
            ),
          ),
        ),
      );

      // Re-do test properly with a child builder that verifies
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 200, // 2x targetWidth
              height: 200, // 1x targetHeight
              child: ResponsiveLayout(
                targetWidth: 100,
                targetHeight: 200,
                child: Builder(
                  builder: (context) {
                    // scaleW = 200/100 = 2.0
                    // scaleH = 200/200 = 1.0
                    // min(2.0, 1.0) = 1.0
                    // 10.fs -> 10.0

                    final val = 10.0.fs(context);
                    expect(val, 10.0);

                    return SizedBox(width: val, height: val);
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('uses min(scaleW, scaleH) when height is constrained more',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 100, // 1x targetWidth
              height: 400, // 2x targetHeight
              child: ResponsiveLayout(
                targetWidth: 100,
                targetHeight: 200,
                child: Builder(
                  builder: (context) {
                    // scaleW = 100/100 = 1.0
                    // scaleH = 400/200 = 2.0
                    // min(1.0, 2.0) = 1.0

                    final val = 10.0.fs(context);
                    expect(val, 10.0);
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  });

  group('FlexiCircle', () {
    testWidgets('renders a circular container', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: FlexiConfig(
            child: FlexiCircle(size: 50, color: Color(0xFFFF0000)),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, const Color(0xFFFF0000));
    });
  });
}
