import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponsiveLayout', () {
    testWidgets('provides ResponsiveCardData to descendants', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1000));
      late ResponsiveCardData? data;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 600,
              height: 800,
              child: ResponsiveLayout(
                targetWidth: 300,
                targetHeight: 400,
                child: Builder(
                  builder: (context) {
                    data = ResponsiveInheritedModel.of(context);
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(data, isNotNull);
      expect(data!.currentParentWidth, 600);
      expect(data!.currentParentHeight, 800);
      expect(data!.targetParentWidth, 300);
      expect(data!.targetParentHeight, 400);
    });

    testWidgets('fw(context) calculates correct width', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1000));
      // Parent 600, Target 300 -> scale factor 2.0
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 600,
              height: 800,
              child: ResponsiveLayout(
                targetWidth: 300,
                targetHeight: 400,
                child: Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 100.fw(context), // Should be 200
                      height: 50.fh(
                          context), // Should be 100 (800/400 = 2.0 * 50 = 100)
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<SizedBox>(find.byType(SizedBox).last);
      expect(container.width, 200);
      expect(container.height, 100);
    });

    testWidgets('updates when parent size changes', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1000));
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 600,
              height: 800,
              child: ResponsiveLayout(
                targetWidth: 300,
                targetHeight: 400,
                child: Builder(
                  builder: (context) {
                    return Text(
                      '${100.fw(context)}',
                      textDirection: TextDirection.ltr,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('200.0'), findsOneWidget);

      // Resize parent
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 900, // 3x target
              height: 800,
              child: ResponsiveLayout(
                targetWidth: 300,
                targetHeight: 400,
                child: Builder(
                  builder: (context) {
                    return Text(
                      '${100.fw(context)}',
                      textDirection: TextDirection.ltr,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('300.0'), findsOneWidget);
    });

    testWidgets(
        'const widgets in tree do not block updates if they are not the boundary',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1000));
      // In this architecture, ResponsiveLayout builder runs, rebuilding the inherited model.
      // A const intermediate widget might block propagation if it doesn't depend on inherited widget,
      // but the Leaf node calling .fw(context) DOES depend on it, so it should rebuild.

      await tester.pumpWidget(const Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
                width: 600,
                height: 800,
                child: ResponsiveLayout(
                  targetWidth: 300,
                  targetHeight: 400,
                  child: ConstWrapper(),
                )),
          )));

      expect(find.text('200.0'), findsOneWidget);

      await tester.pumpWidget(const Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
                width: 300, // 1x target
                height: 800,
                child: ResponsiveLayout(
                  targetWidth: 300,
                  targetHeight: 400,
                  child: ConstWrapper(),
                )),
          )));

      expect(find.text('100.0'), findsOneWidget);
    });
  });
}

class ConstWrapper extends StatelessWidget {
  const ConstWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        // This builder creates a context that is a child of ConstWrapper
        // But we want to test if ConstWrapper blocks the update?
        // InheritedWidget updates flow THROUGH const widgets.
        Builder(builder: (context) {
          return Text('${100.fw(context)}', textDirection: TextDirection.ltr);
        })
      ],
    );
  }
}
