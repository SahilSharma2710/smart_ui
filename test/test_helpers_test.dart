import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  group('BreakpointTestConfig', () {
    test('creates config with all parameters', () {
      const config = BreakpointTestConfig(
        breakpoint: SmartBreakpoint.mobile,
        width: 375,
        height: 812,
        name: 'iphone_x',
      );

      expect(config.breakpoint, equals(SmartBreakpoint.mobile));
      expect(config.width, equals(375));
      expect(config.height, equals(812));
      expect(config.displayName, equals('iphone_x'));
    });

    test('uses default display name when name not provided', () {
      const config = BreakpointTestConfig(
        breakpoint: SmartBreakpoint.tablet,
        width: 768,
      );

      expect(config.displayName, equals('tablet_768x800'));
    });
  });

  group('SmartTestConfigs', () {
    test('all contains 4 configs', () {
      expect(SmartTestConfigs.all.length, equals(4));
    });

    test('extended contains 8 configs', () {
      expect(SmartTestConfigs.extended.length, equals(8));
    });

    test('watch config is correct', () {
      expect(SmartTestConfigs.watch.breakpoint, equals(SmartBreakpoint.watch));
      expect(SmartTestConfigs.watch.width, equals(280));
    });

    test('mobilePortrait config is correct', () {
      expect(SmartTestConfigs.mobilePortrait.breakpoint, equals(SmartBreakpoint.mobile));
      expect(SmartTestConfigs.mobilePortrait.width, equals(375));
      expect(SmartTestConfigs.mobilePortrait.height, equals(812));
    });

    test('desktop config is correct', () {
      expect(SmartTestConfigs.desktop.breakpoint, equals(SmartBreakpoint.desktop));
      expect(SmartTestConfigs.desktop.width, equals(1440));
    });
  });

  group('createSmartTestWidget', () {
    testWidgets('creates widget with correct size', (tester) async {
      double? capturedWidth;

      await tester.pumpWidget(
        createSmartTestWidget(
          width: 375,
          child: Builder(
            builder: (context) {
              capturedWidth = MediaQuery.sizeOf(context).width;
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedWidth, equals(375));
    });

    testWidgets('wraps with SmartUi', (tester) async {
      SmartUiData? capturedConfig;

      await tester.pumpWidget(
        createSmartTestWidget(
          width: 375,
          child: Builder(
            builder: (context) {
              capturedConfig = SmartUi.of(context);
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedConfig, isNotNull);
    });

    testWidgets('accepts custom breakpoints', (tester) async {
      SmartUiData? capturedConfig;
      const customBreakpoints = SmartBreakpoints(
        mobile: 400,
        tablet: 800,
        desktop: 1100,
      );

      await tester.pumpWidget(
        createSmartTestWidget(
          width: 375,
          breakpoints: customBreakpoints,
          child: Builder(
            builder: (context) {
              capturedConfig = SmartUi.of(context);
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedConfig!.breakpoints, equals(customBreakpoints));
    });

    testWidgets('sets device pixel ratio', (tester) async {
      double? capturedDpr;

      await tester.pumpWidget(
        createSmartTestWidget(
          width: 375,
          devicePixelRatio: 3.0,
          child: Builder(
            builder: (context) {
              capturedDpr = MediaQuery.devicePixelRatioOf(context);
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedDpr, equals(3.0));
    });
  });

  group('createSmartTestWidgetForConfig', () {
    testWidgets('uses config dimensions', (tester) async {
      Size? capturedSize;

      await tester.pumpWidget(
        createSmartTestWidgetForConfig(
          config: SmartTestConfigs.mobilePortrait,
          child: Builder(
            builder: (context) {
              capturedSize = MediaQuery.sizeOf(context);
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedSize!.width, equals(375));
      expect(capturedSize!.height, equals(812));
    });
  });

  group('BreakpointCapture', () {
    testWidgets('captures mobile breakpoint', (tester) async {
      SmartBreakpoint? capturedBreakpoint;

      await tester.pumpWidget(
        createSmartTestWidget(
          width: 400,
          child: BreakpointCapture(
            onCapture: (bp) => capturedBreakpoint = bp,
            child: Container(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(capturedBreakpoint, equals(SmartBreakpoint.mobile));
    });

    testWidgets('captures tablet breakpoint', (tester) async {
      SmartBreakpoint? capturedBreakpoint;

      await tester.pumpWidget(
        createSmartTestWidget(
          width: 700,
          child: BreakpointCapture(
            onCapture: (bp) => capturedBreakpoint = bp,
            child: Container(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(capturedBreakpoint, equals(SmartBreakpoint.tablet));
    });

    testWidgets('captures desktop breakpoint', (tester) async {
      SmartBreakpoint? capturedBreakpoint;

      await tester.pumpWidget(
        createSmartTestWidget(
          width: 1000,
          child: BreakpointCapture(
            onCapture: (bp) => capturedBreakpoint = bp,
            child: Container(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(capturedBreakpoint, equals(SmartBreakpoint.desktop));
    });
  });

  group('BreakpointDebugOverlay', () {
    testWidgets('displays breakpoint name', (tester) async {
      await tester.pumpWidget(
        createSmartTestWidget(
          width: 400,
          child: const Stack(
            children: [
              Text('Content'),
              BreakpointDebugOverlay(),
            ],
          ),
        ),
      );

      expect(find.textContaining('MOBILE'), findsOneWidget);
    });

    testWidgets('displays screen dimensions', (tester) async {
      await tester.pumpWidget(
        createSmartTestWidget(
          width: 400,
          height: 800,
          child: const Stack(
            children: [
              Text('Content'),
              BreakpointDebugOverlay(),
            ],
          ),
        ),
      );

      expect(find.textContaining('400x800'), findsOneWidget);
    });

    testWidgets('positions at specified alignment', (tester) async {
      await tester.pumpWidget(
        createSmartTestWidget(
          width: 400,
          child: const Stack(
            children: [
              BreakpointDebugOverlay(position: Alignment.topLeft),
            ],
          ),
        ),
      );

      final Align align = tester.widget(find.byType(Align));
      expect(align.alignment, equals(Alignment.topLeft));
    });
  });
}
