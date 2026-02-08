import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiGrid Context Verification', () {
    testWidgets(
        'FlexiGrid renders as a grid inside a Dialog (unbounded constraints)',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: SizedBox(
                          width: 400,
                          child: FlexiGrid(
                            minItemWidth: 100,
                            children: List.generate(4, (i) => Text('Item $i')),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify it's a grid with 4 columns (width 400 / min 100 = 4)
      // If it were a Wrap, it would also fit, but we want to ensure
      // the internal GridView is used.
      // We can check for GridView's presence.
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets(
        'FlexiGrid handles infinite constraints by falling back to screen width',
        (tester) async {
      // Using UnconstrainedBox produces infinite constraints for child
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UnconstrainedBox(
              child: SizedBox(
                height: 100,
                child: FlexiGrid(
                  minItemWidth: 200,
                  children: List.generate(10, (i) => Text('Item $i')),
                ),
              ),
            ),
          ),
        ),
      );

      // Default tester size is 800x600.
      // If FlexiGrid falls back to 800, crossAxisCount = 800 / 200 = 4.
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 4);
    });

    testWidgets('FlexiGrid works inside a Row (unbounded width)',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: FlexiGrid(
                    minItemWidth: 200,
                    children: List.generate(2, (i) => Text('Item $i')),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
