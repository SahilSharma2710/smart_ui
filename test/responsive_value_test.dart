import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartui/smartui.dart';

void main() {
  Widget createTestWidget({
    required double width,
    required Widget child,
    SmartBreakpoints breakpoints = SmartBreakpoints.defaults,
  }) {
    return MaterialApp(
      home: SmartUi(
        breakpoints: breakpoints,
        child: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: child,
        ),
      ),
    );
  }

  group('ResponsiveValueExtension', () {
    testWidgets('responsive returns mobile value on mobile', (tester) async {
      late int result;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              result = context.responsive<int>(
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(1));
    });

    testWidgets('responsive returns tablet value on tablet', (tester) async {
      late int result;

      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: Builder(
            builder: (context) {
              result = context.responsive<int>(
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(2));
    });

    testWidgets('responsive returns desktop value on desktop', (tester) async {
      late int result;

      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: Builder(
            builder: (context) {
              result = context.responsive<int>(
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(3));
    });

    testWidgets('responsive cascades values', (tester) async {
      late int result;

      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: Builder(
            builder: (context) {
              // Only mobile is set, should cascade to desktop
              result = context.responsive<int>(mobile: 1);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(1));
    });

    testWidgets('responsive uses defaultValue when no match', (tester) async {
      late int result;

      await tester.pumpWidget(
        createTestWidget(
          width: 200, // watch
          child: Builder(
            builder: (context) {
              result = context.responsive<int>(
                mobile: 1,
                defaultValue: 0,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(0));
    });

    testWidgets('responsiveInt works correctly', (tester) async {
      late int result;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              result = context.responsiveInt(mobile: 1, tablet: 2);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(1));
    });

    testWidgets('responsiveDouble works correctly', (tester) async {
      late double result;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              result = context.responsiveDouble(mobile: 1.5, tablet: 2.5);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(1.5));
    });

    testWidgets('responsiveBool works correctly', (tester) async {
      late bool result;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              result = context.responsiveBool(mobile: true, tablet: false);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isTrue);
    });

    testWidgets('responsivePadding works correctly', (tester) async {
      late EdgeInsets result;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              result = context.responsivePadding(
                mobile: const EdgeInsets.all(8),
                tablet: const EdgeInsets.all(16),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(const EdgeInsets.all(8)));
    });
  });

  group('ResponsiveValue', () {
    testWidgets('resolve returns correct value', (tester) async {
      const responsive = ResponsiveValue<int>(
        mobile: 1,
        tablet: 2,
        desktop: 3,
      );

      late int result;

      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: Builder(
            builder: (context) {
              result = responsive.resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, equals(2));
    });

    test('equality works correctly', () {
      const a = ResponsiveValue<int>(mobile: 1, tablet: 2);
      const b = ResponsiveValue<int>(mobile: 1, tablet: 2);
      const c = ResponsiveValue<int>(mobile: 1, tablet: 3);

      expect(a == b, isTrue);
      expect(a == c, isFalse);
      expect(a.hashCode == b.hashCode, isTrue);
    });
  });
}
