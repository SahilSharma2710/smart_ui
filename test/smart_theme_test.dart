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

  group('SmartTheme', () {
    testWidgets('provides theme data to descendants', (tester) async {
      SmartThemeData? capturedTheme;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartTheme(
            mobile: SmartThemeData.mobile,
            desktop: SmartThemeData.desktop,
            child: Builder(
              builder: (context) {
                capturedTheme = SmartTheme.of(context);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      expect(capturedTheme, isNotNull);
      expect(capturedTheme, equals(SmartThemeData.mobile));
    });

    testWidgets('uses correct theme for breakpoint', (tester) async {
      SmartThemeData? capturedTheme;

      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: SmartTheme(
            mobile: SmartThemeData.mobile,
            desktop: SmartThemeData.desktop,
            child: Builder(
              builder: (context) {
                capturedTheme = SmartTheme.of(context);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      expect(capturedTheme, equals(SmartThemeData.desktop));
    });

    testWidgets('cascades theme from smaller breakpoint', (tester) async {
      SmartThemeData? capturedTheme;

      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: SmartTheme(
            mobile: SmartThemeData.mobile,
            // No tablet specified, should cascade from mobile
            child: Builder(
              builder: (context) {
                capturedTheme = SmartTheme.of(context);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      expect(capturedTheme, equals(SmartThemeData.mobile));
    });

    testWidgets('returns defaults when no ancestor', (tester) async {
      SmartThemeData? capturedTheme;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: Builder(
            builder: (context) {
              capturedTheme = SmartTheme.of(context);
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedTheme, equals(SmartThemeData.defaults));
    });
  });

  group('SmartThemeData', () {
    test('has default values', () {
      const theme = SmartThemeData();

      expect(theme.baseFontSize, equals(16.0));
      expect(theme.baseSpacing, equals(16.0));
      expect(theme.baseRadius, equals(8.0));
      expect(theme.gridColumns, equals(12));
    });

    test('mobile preset has smaller values', () {
      const theme = SmartThemeData.mobile;

      expect(theme.baseFontSize, equals(14));
      expect(theme.baseSpacing, equals(12));
      expect(theme.gridColumns, equals(4));
    });

    test('desktop preset has larger values', () {
      const theme = SmartThemeData.desktop;

      expect(theme.baseFontSize, equals(16));
      expect(theme.baseSpacing, equals(16));
      expect(theme.containerMaxWidth, equals(1200));
      expect(theme.gridColumns, equals(12));
    });

    test('copyWith creates modified copy', () {
      const original = SmartThemeData();
      final modified = original.copyWith(baseFontSize: 20);

      expect(modified.baseFontSize, equals(20));
      expect(modified.baseSpacing, equals(original.baseSpacing));
    });

    test('lerp interpolates between themes', () {
      const a = SmartThemeData(baseFontSize: 14, baseSpacing: 8);
      const b = SmartThemeData(baseFontSize: 20, baseSpacing: 16);

      final mid = SmartThemeData.lerp(a, b, 0.5);

      expect(mid.baseFontSize, equals(17));
      expect(mid.baseSpacing, equals(12));
    });

    test('token returns custom token value', () {
      const theme = SmartThemeData(
        customTokens: {'cardElevation': 4.0, 'headerHeight': 64},
      );

      expect(theme.token<double>('cardElevation'), equals(4.0));
      expect(theme.token<int>('headerHeight'), equals(64));
      expect(theme.token<double>('nonExistent'), isNull);
    });

    test('equality works correctly', () {
      const theme1 = SmartThemeData(baseFontSize: 16);
      const theme2 = SmartThemeData(baseFontSize: 16);
      const theme3 = SmartThemeData(baseFontSize: 18);

      expect(theme1, equals(theme2));
      expect(theme1, isNot(equals(theme3)));
    });

    test('hashCode is consistent', () {
      const theme1 = SmartThemeData(baseFontSize: 16);
      const theme2 = SmartThemeData(baseFontSize: 16);

      expect(theme1.hashCode, equals(theme2.hashCode));
    });
  });

  group('SmartThemeExtension', () {
    testWidgets('context.smartTheme returns current theme', (tester) async {
      SmartThemeData? capturedTheme;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartTheme(
            mobile: SmartThemeData.mobile,
            child: Builder(
              builder: (context) {
                capturedTheme = context.smartTheme;
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      expect(capturedTheme, equals(SmartThemeData.mobile));
    });
  });
}
