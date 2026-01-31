import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flexi_ui/flexi_ui.dart';

void main() {
  group('DeviceTypeConfig', () {
    test('detects Phone Portrait correctly', () {
      const info = ScreenInfo(
        width: 360,
        height: 640,
        mobilePortraitBreakpoint: 480,
        mobileLandscapeBreakpoint: 768,
        tabletLandscapeBreakpoint: 1024,
        orientation: Orientation.portrait,
      );
      const config = DeviceTypeConfig(
        screenInfo: info,
        designMinWidth: 360,
        designMaxWidth: 1440,
        designMinHeight: 480,
        designMaxHeight: 1024,
        targetDeviceType: TargetDeviceType.phonePortrait,
      );

      expect(config.isPhonePortrait, isTrue);
      expect(config.isPhoneLandscape, isFalse);
      expect(config.isTabletLandscape, isFalse);
      expect(config.isDesktop, isFalse);
    });

    test('detects Phone Landscape correctly', () {
      const info = ScreenInfo(
        width: 640,
        height: 360,
        mobilePortraitBreakpoint: 480,
        mobileLandscapeBreakpoint: 768,
        tabletLandscapeBreakpoint: 1024,
        orientation: Orientation.landscape,
      );
      const config = DeviceTypeConfig(
        screenInfo: info,
        designMinWidth: 360,
        designMaxWidth: 1440,
        designMinHeight: 480,
        designMaxHeight: 1024,
        targetDeviceType: TargetDeviceType.phonePortrait,
      );

      expect(config.isPhonePortrait, isFalse);
      expect(config.isPhoneLandscape, isTrue);
      expect(config.isTabletLandscape, isFalse);
      expect(config.isDesktop, isFalse);
    });

    test('detects Tablet Landscape correctly', () {
      const info = ScreenInfo(
        width: 800,
        height: 600,
        mobilePortraitBreakpoint: 480,
        mobileLandscapeBreakpoint: 768,
        tabletLandscapeBreakpoint: 1024,
        orientation: Orientation.landscape,
      );
      const config = DeviceTypeConfig(
        screenInfo: info,
        designMinWidth: 360,
        designMaxWidth: 1440,
        designMinHeight: 480,
        designMaxHeight: 1024,
        targetDeviceType: TargetDeviceType.phonePortrait,
      );

      expect(config.isPhonePortrait, isFalse);
      expect(config.isPhoneLandscape, isFalse);
      expect(config.isTabletLandscape, isTrue);
      expect(config.isDesktop, isFalse);
    });

    test('detects Desktop correctly', () {
      const info = ScreenInfo(
        width: 1200,
        height: 800,
        mobilePortraitBreakpoint: 480,
        mobileLandscapeBreakpoint: 768,
        tabletLandscapeBreakpoint: 1024,
        orientation: Orientation.landscape,
      );
      const config = DeviceTypeConfig(
        screenInfo: info,
        designMinWidth: 360,
        designMaxWidth: 1440,
        designMinHeight: 480,
        designMaxHeight: 1024,
        targetDeviceType: TargetDeviceType.phonePortrait,
      );

      expect(config.isPhonePortrait, isFalse);
      expect(config.isPhoneLandscape, isFalse);
      expect(config.isTabletLandscape, isFalse);
      expect(config.isDesktop, isTrue);
    });
  });

  group('BreakpointValue', () {
    testWidgets('resolves mobile value by default', (tester) async {
      const breakpointValue = BreakpointValue<int>(
        mobile: 1,
        tablet: 2,
        desktop: 4,
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(360, 640)),
            child: FlexiConfig(
              child: Builder(
                builder: (context) {
                  return Text(breakpointValue.v(context).toString());
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('resolves desktop value on large screen', (tester) async {
      const breakpointValue = BreakpointValue<int>(
        mobile: 1,
        tablet: 2,
        desktop: 4,
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: FlexiConfig(
              child: Builder(
                builder: (context) {
                  return Text(breakpointValue.v(context).toString());
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('4'), findsOneWidget);
    });
  });

  group('Fluid Scaling (Tuple2)', () {
    testWidgets('aw interpolates correctly', (tester) async {
      const fluidValue = Tuple2<double, double>(10, 20);

      // We need to set up FlexiConfig with known design range
      // Default: 360 to 1440
      
      // 1. Min boundary
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(360, 640)),
            child: FlexiConfig(
              child: Builder(
                builder: (context) {
                  return Text(fluidValue.aw(context).toStringAsFixed(0));
                },
              ),
            ),
          ),
        ),
      );
      expect(find.text('10'), findsOneWidget);

      // 2. Max boundary
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(1440, 900)),
            child: FlexiConfig(
              child: Builder(
                builder: (context) {
                  return Text(fluidValue.aw(context).toStringAsFixed(0));
                },
              ),
            ),
          ),
        ),
      );
      expect(find.text('20'), findsOneWidget);

      // 3. Middle point (50% of the way)
      // (1440 - 360) / 2 + 360 = 540 + 360 = 900
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(900, 700)),
            child: FlexiConfig(
              child: Builder(
                builder: (context) {
                  return Text(fluidValue.aw(context).toStringAsFixed(0));
                },
              ),
            ),
          ),
        ),
      );
      expect(find.text('15'), findsOneWidget);
    });
  });
}
