import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  Widget createTestWidget({
    required double width,
    required Widget child,
  }) {
    return MaterialApp(
      home: SmartUi(
        child: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: child,
        ),
      ),
    );
  }

  group('context.adaptive<T>', () {
    testWidgets('returns material value on material platforms', (tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              capturedValue = context.adaptive<double>(
                material: 4.0,
                cupertino: 8.0,
              );
              return Container();
            },
          ),
        ),
      );

      // Android platform uses material by default in tests
      expect(capturedValue, equals(4.0));
    });
  });

  group('context.adaptiveWidget', () {
    testWidgets('returns correct widget based on platform', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              return context.adaptiveWidget(
                material: Container(key: const Key('material')),
                cupertino: Container(key: const Key('cupertino')),
              );
            },
          ),
        ),
      );

      // Default test platform is Android (material)
      expect(find.byKey(const Key('material')), findsOneWidget);
    });
  });

  group('context.showOnly', () {
    testWidgets('shows child when on specified breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: Builder(
            builder: (context) {
              return context.showOnly(
                breakpoints: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
                child: Container(key: const Key('desktop-content')),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const Key('desktop-content')), findsOneWidget);
    });

    testWidgets('hides child when not on specified breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: Builder(
            builder: (context) {
              return context.showOnly(
                breakpoints: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
                child: Container(key: const Key('desktop-content')),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const Key('desktop-content')), findsNothing);
    });

    testWidgets('shows replacement when hidden', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: Builder(
            builder: (context) {
              return context.showOnly(
                breakpoints: [SmartBreakpoint.desktop],
                child: Container(key: const Key('desktop-content')),
                replacement: Container(key: const Key('replacement')),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const Key('replacement')), findsOneWidget);
    });
  });

  group('context.hideOn', () {
    testWidgets('hides child when on specified breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: Builder(
            builder: (context) {
              return context.hideOn(
                breakpoints: [SmartBreakpoint.watch, SmartBreakpoint.mobile],
                child: Container(key: const Key('content')),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const Key('content')), findsNothing);
    });

    testWidgets('shows child when not on specified breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: Builder(
            builder: (context) {
              return context.hideOn(
                breakpoints: [SmartBreakpoint.watch, SmartBreakpoint.mobile],
                child: Container(key: const Key('content')),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const Key('content')), findsOneWidget);
    });
  });

  group('context.bp<T>', () {
    testWidgets('returns correct value for mobile', (tester) async {
      int? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: Builder(
            builder: (context) {
              capturedValue = context.bp<int>(
                mobile: 1,
                tablet: 2,
                desktop: 4,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(1));
    });

    testWidgets('returns correct value for tablet', (tester) async {
      int? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: Builder(
            builder: (context) {
              capturedValue = context.bp<int>(
                mobile: 1,
                tablet: 2,
                desktop: 4,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(2));
    });

    testWidgets('returns correct value for desktop', (tester) async {
      int? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: Builder(
            builder: (context) {
              capturedValue = context.bp<int>(
                mobile: 1,
                tablet: 2,
                desktop: 4,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(4));
    });

    testWidgets('cascades from smaller breakpoint', (tester) async {
      int? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: Builder(
            builder: (context) {
              capturedValue = context.bp<int>(
                mobile: 1,
                // No tablet specified
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(1));
    });

    testWidgets('uses default value when no match', (tester) async {
      int? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 100, // watch
          child: Builder(
            builder: (context) {
              capturedValue = context.bp<int>(
                defaultValue: 0,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(0));
    });
  });

  group('context.mobileOr<T>', () {
    testWidgets('returns mobile value on mobile', (tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: Builder(
            builder: (context) {
              capturedValue = context.mobileOr<double>(
                mobile: 12,
                other: 24,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(12));
    });

    testWidgets('returns other value on tablet', (tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: Builder(
            builder: (context) {
              capturedValue = context.mobileOr<double>(
                mobile: 12,
                other: 24,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(24));
    });
  });

  group('context.desktopOr<T>', () {
    testWidgets('returns desktop value on desktop', (tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: Builder(
            builder: (context) {
              capturedValue = context.desktopOr<double>(
                desktop: 1200,
                other: double.infinity,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(1200));
    });

    testWidgets('returns other value on mobile', (tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: Builder(
            builder: (context) {
              capturedValue = context.desktopOr<double>(
                desktop: 1200,
                other: double.infinity,
              );
              return Container();
            },
          ),
        ),
      );

      expect(capturedValue, equals(double.infinity));
    });
  });
}
