import 'package:flexi_ui/flexi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flexi UI v2 Features', () {
    testWidgets('Strict Mode: No rebuild without aspect by default',
        (tester) async {
      int rebuildCount = 0;
      final child = Builder(
        builder: (context) {
          FlexiInheritedWidget.of(context);
          rebuildCount++;
          return const SizedBox();
        },
      );

      // Initial pump
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: FlexiConfig(child: child),
          ),
        ),
      );

      expect(rebuildCount, 1);

      // Change size (but still listening without aspect)
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: FlexiConfig(child: child),
          ),
        ),
      );

      // Should NOT rebuild
      expect(rebuildCount, 1);
    });

    testWidgets('Strict Mode: Rebuilds with correct aspect', (tester) async {
      int rebuildCount = 0;
      final child = Builder(
        builder: (context) {
          FlexiInheritedWidget.of(context, aspect: FlexiAspect.width);
          rebuildCount++;
          return const SizedBox();
        },
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: FlexiConfig(child: child),
          ),
        ),
      );

      expect(rebuildCount, 1);

      // Change WIDTH
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: FlexiConfig(child: child),
          ),
        ),
      );

      // Should rebuild
      expect(rebuildCount, 2);

      // Change HEIGHT (but listening to width)
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(500, 900)),
            child: FlexiConfig(child: child),
          ),
        ),
      );

      // Should NOT rebuild
      expect(rebuildCount, 2);
    });

    testWidgets('Implicit Mode: Rebuilds allowed if flag enabled',
        (tester) async {
      int rebuildCount = 0;
      final child = Builder(
        builder: (context) {
          FlexiInheritedWidget.of(context);
          rebuildCount++;
          return const SizedBox();
        },
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: FlexiConfig(
              allowImplicitRebuilds: true,
              child: child,
            ),
          ),
        ),
      );

      expect(rebuildCount, 1);

      // Change size
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: FlexiConfig(
              allowImplicitRebuilds: true,
              child: child,
            ),
          ),
        ),
      );

      // Should rebuild
      expect(rebuildCount, 2);
    });

    testWidgets('Semantic Breakpoints: Calculates correctly', (tester) async {
      FlexiBreakpoint? breakpoint;

      // Mobile Portrait (Width 300 < 480)
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(300, 800)),
            child: FlexiConfig(child: Builder(
              builder: (context) {
                breakpoint = context.flexi.breakpoint;
                return const SizedBox();
              },
            )),
          ),
        ),
      );
      expect(breakpoint, FlexiBreakpoint.phonePortrait);

      // Landscape Phone (Width 600 < 768, height 400)
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(600, 400)),
            child: FlexiConfig(child: Builder(
              builder: (context) {
                breakpoint = context.flexi.breakpoint;
                return const SizedBox();
              },
            )),
          ),
        ),
      );
      expect(breakpoint, FlexiBreakpoint.phoneLandscape);

      // Desktop (Width 1200 > 1024)
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: FlexiConfig(child: Builder(
              builder: (context) {
                breakpoint = context.flexi.breakpoint;
                return const SizedBox();
              },
            )),
          ),
        ),
      );
      expect(breakpoint, FlexiBreakpoint.desktop);
    });

    testWidgets('Nested Responsive Support: Uses parent constraints',
        (tester) async {
      double? width;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          // Need MediaQuery for inner calculations even if parent constraints used
          child: MediaQuery(
            data: const MediaQueryData(size: Size(1000, 1000)),
            child: Center(
              child: SizedBox(
                width: 500,
                height: 500,
                child: FlexiConfig(
                  useParentConstraints: true,
                  child: Builder(
                    builder: (context) {
                      final data = FlexiInheritedWidget.of(context,
                          aspect: FlexiAspect.width);
                      width = data?.screenWidth;
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Should be 500 (from SizedBox), not 1000 (screen)
      expect(width, 500);
    });

    testWidgets('Debug Overlay: Appears when enabled', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQueryData(size: Size(800, 600)),
            child: FlexiConfig(
              showDebugOverlay: true,
              child: SizedBox(),
            ),
          ),
        ),
      );

      expect(find.byType(FlexiDebugOverlay), findsOneWidget);
      expect(find.text('Flexi Debug'), findsOneWidget);
    });
  });
}
