import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flexi UI Rebuild Scope Tests', () {
    testWidgets('FlexiSpacing rebuilds on width change but NOT on height change', (tester) async {
      int buildCount = 0;

      // Stable builder instance to ensure Flutter's element reuse 
      // allows InheritedModel to control rebuilds.
      final builderWidget = Builder(
        builder: (context) {
          buildCount++;
          FlexiSpacing.m(context); // Listen to width
          return const SizedBox.shrink();
        },
      );

      Widget buildTestTree(Size size) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQueryData(size: size),
            child: FlexiConfig(
              child: builderWidget,
            ),
          ),
        );
      }

      await tester.pumpWidget(buildTestTree(const Size(800, 600)));
      expect(buildCount, 1);

      // Change height only
      await tester.pumpWidget(buildTestTree(const Size(800, 1000)));
      
      // Should NOT rebuild Builder because width is the same
      expect(buildCount, 1);

      // Change width
      await tester.pumpWidget(buildTestTree(const Size(900, 1000)));

      // SHOULD rebuild Builder because width changed
      expect(buildCount, 2);
    });
  });
}
