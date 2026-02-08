import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponsiveCard', () {
    testWidgets('provides local responsive context via ResponsiveCardData',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1000));
      late ResponsiveCardData? data;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 600,
              height: 400,
              child: ResponsiveCard(
                targetWidth: 300,
                targetHeight: 200,
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
      expect(data!.currentParentHeight, 400);
      expect(data!.targetParentWidth, 300);
      expect(data!.targetParentHeight, 200);
    });

    testWidgets('scales child widgets relative to parent constraints',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1000));
      // Parent 600, Target 300 -> scale factor 2.0
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 600,
              height: 400,
              child: ResponsiveCard(
                targetWidth: 300,
                targetHeight: 200,
                child: Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 100.fw(context), // Should be 200
                      height: 50.fh(context), // Should be 100
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // find.byType(SizedBox).last is the one inside the card
      final container = tester.widget<SizedBox>(find.byType(SizedBox).last);
      expect(container.width, 200);
      expect(container.height, 100);
    });

    testWidgets('granularity: rebuilds only on relevant aspect change',
        (tester) async {
      int widthBuilds = 0;
      int heightBuilds = 0;

      late StateSetter setState;
      double currentWidth = 600;
      double currentHeight = 400;

      // Use a stable child to avoid rebuilding the subtree due to parent rebuild
      final cardChild = Column(
        children: [
          Builder(builder: (context) {
            ResponsiveInheritedModel.of(context, aspect: FlexiAspect.width);
            widthBuilds++;
            return const Text('Width Listener');
          }),
          Builder(builder: (context) {
            ResponsiveInheritedModel.of(context, aspect: FlexiAspect.height);
            heightBuilds++;
            return const Text('Height Listener');
          }),
        ],
      );

      await tester.pumpWidget(StatefulBuilder(builder: (context, setter) {
        setState = setter;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: currentWidth,
              height: currentHeight,
              child: ResponsiveCard(
                targetWidth: 300,
                targetHeight: 200,
                child: cardChild,
              ),
            ),
          ),
        );
      }));

      expect(widthBuilds, 1);
      expect(heightBuilds, 1);

      // Change only width
      setState(() {
        currentWidth = 900;
      });
      await tester.pump();

      expect(widthBuilds, 2);
      expect(heightBuilds, 1); // Should NOT rebuild

      // Change only height
      setState(() {
        currentHeight = 600;
      });
      await tester.pump();

      expect(widthBuilds, 2);
      expect(heightBuilds, 2);
    });
  });
}
