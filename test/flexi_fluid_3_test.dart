import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiFluid3', () {
    testWidgets('resolves mobile value on small screens', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(300, 800)),
          child: FlexiConfig(
            designMinWidth: 360,
            mobileLandscapeBreakpoint: 768,
            designMaxWidth: 1440,
            child: Builder(
              builder: (context) {
                final val =
                    const FlexiFluid3(mobile: 10, tablet: 20, desktop: 30)
                        .resolve(context);
                expect(val, 10.0);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('resolves desktop value on large screens', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1500, 1000)),
          child: FlexiConfig(
            designMinWidth: 360,
            mobileLandscapeBreakpoint: 768,
            designMaxWidth: 1440,
            child: Builder(
              builder: (context) {
                final val =
                    const FlexiFluid3(mobile: 10, tablet: 20, desktop: 30)
                        .resolve(context);
                expect(val, 30.0);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('interpolates between mobile and tablet', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(564, 800)),
          child: FlexiConfig(
            designMinWidth: 360,
            mobileLandscapeBreakpoint: 768,
            designMaxWidth: 1440,
            child: Builder(
              builder: (context) {
                final val =
                    const FlexiFluid3(mobile: 10, tablet: 20, desktop: 30)
                        .resolve(context);
                expect(val, closeTo(15.0, 0.1));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('interpolates between tablet and desktop', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1104, 800)),
          child: FlexiConfig(
            designMinWidth: 360,
            mobileLandscapeBreakpoint: 768,
            designMaxWidth: 1440,
            child: Builder(
              builder: (context) {
                final val =
                    const FlexiFluid3(mobile: 10, tablet: 20, desktop: 30)
                        .resolve(context);
                expect(val, closeTo(25.0, 0.1));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns tablet value exactly at tablet start', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(768, 800)),
          child: FlexiConfig(
            designMinWidth: 360,
            mobileLandscapeBreakpoint: 768,
            designMaxWidth: 1440,
            child: Builder(
              builder: (context) {
                final val =
                    const FlexiFluid3(mobile: 10, tablet: 20, desktop: 30)
                        .resolve(context);
                debugPrint('Test Value: $val');
                expect(val, closeTo(20.0, 0.1));
                return Container();
              },
            ),
          ),
        ),
      );
    });
  });
}
