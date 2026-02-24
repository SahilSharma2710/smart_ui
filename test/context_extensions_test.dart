import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_ui/smart_ui.dart';

void main() {
  Widget createTestWidget({
    required double width,
    required double height,
    required Widget child,
  }) {
    return MaterialApp(
      home: SmartUi(
        child: MediaQuery(
          data: MediaQueryData(size: Size(width, height)),
          child: child,
        ),
      ),
    );
  }

  group('SmartContextExtension - Screen Dimensions', () {
    testWidgets('screenWidth returns correct value', (tester) async {
      late double width;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              width = context.screenWidth;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(width, equals(400));
    });

    testWidgets('screenHeight returns correct value', (tester) async {
      late double height;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              height = context.screenHeight;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(height, equals(800));
    });

    testWidgets('screenSize returns correct value', (tester) async {
      late Size size;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              size = context.screenSize;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(size, equals(const Size(400, 800)));
    });
  });

  group('SmartContextExtension - Orientation', () {
    testWidgets('isPortrait returns true for portrait', (tester) async {
      late bool isPortrait;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              isPortrait = context.isPortrait;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isPortrait, isTrue);
    });

    testWidgets('isLandscape returns true for landscape', (tester) async {
      late bool isLandscape;

      await tester.pumpWidget(
        createTestWidget(
          width: 800,
          height: 400,
          child: Builder(
            builder: (context) {
              isLandscape = context.isLandscape;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isLandscape, isTrue);
    });

    testWidgets('aspectRatio is calculated correctly', (tester) async {
      late double aspectRatio;

      await tester.pumpWidget(
        createTestWidget(
          width: 800,
          height: 400,
          child: Builder(
            builder: (context) {
              aspectRatio = context.aspectRatio;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(aspectRatio, equals(2.0));
    });
  });

  group('SmartContextExtension - Breakpoints', () {
    testWidgets('breakpoint returns correct value', (tester) async {
      late SmartBreakpoint breakpoint;

      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          height: 800,
          child: Builder(
            builder: (context) {
              breakpoint = context.breakpoint;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(breakpoint, equals(SmartBreakpoint.tablet));
    });

    testWidgets('isMobile returns true on mobile', (tester) async {
      late bool isMobile;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              isMobile = context.isMobile;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isMobile, isTrue);
    });

    testWidgets('isTablet returns true on tablet', (tester) async {
      late bool isTablet;

      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          height: 800,
          child: Builder(
            builder: (context) {
              isTablet = context.isTablet;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isTablet, isTrue);
    });

    testWidgets('isDesktop returns true on desktop', (tester) async {
      late bool isDesktop;

      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          height: 800,
          child: Builder(
            builder: (context) {
              isDesktop = context.isDesktop;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isDesktop, isTrue);
    });

    testWidgets('isMobileOrSmaller returns true on mobile', (tester) async {
      late bool isMobileOrSmaller;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              isMobileOrSmaller = context.isMobileOrSmaller;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isMobileOrSmaller, isTrue);
    });

    testWidgets('isTabletOrLarger returns true on tablet', (tester) async {
      late bool isTabletOrLarger;

      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          height: 800,
          child: Builder(
            builder: (context) {
              isTabletOrLarger = context.isTabletOrLarger;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isTabletOrLarger, isTrue);
    });

    testWidgets('isDesktopOrLarger returns true on desktop', (tester) async {
      late bool isDesktopOrLarger;

      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          height: 800,
          child: Builder(
            builder: (context) {
              isDesktopOrLarger = context.isDesktopOrLarger;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isDesktopOrLarger, isTrue);
    });
  });

  group('SmartContextExtension - Configuration', () {
    testWidgets('smartUiConfig returns config', (tester) async {
      late SmartUiData config;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              config = context.smartUiConfig;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(config, isNotNull);
      expect(config.breakpoints, equals(SmartBreakpoints.defaults));
    });

    testWidgets('breakpoints returns breakpoints config', (tester) async {
      late SmartBreakpoints breakpoints;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          height: 800,
          child: Builder(
            builder: (context) {
              breakpoints = context.breakpoints;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(breakpoints, equals(SmartBreakpoints.defaults));
    });
  });
}
