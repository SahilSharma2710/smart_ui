import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartui/smartui.dart';

void main() {
  group('SmartUi', () {
    testWidgets('provides default configuration when no ancestor',
        (tester) async {
      late SmartUiData config;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              config = SmartUi.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(config.breakpoints, equals(SmartBreakpoints.defaults));
      expect(config.spacingTokens, equals(SmartSpacingTokens.defaults));
    });

    testWidgets('provides custom configuration from ancestor', (tester) async {
      const customBreakpoints = SmartBreakpoints(mobile: 350, tablet: 700);
      const customSpacing = SmartSpacingTokens(md: 12);
      late SmartUiData config;

      await tester.pumpWidget(
        MaterialApp(
          home: SmartUi(
            breakpoints: customBreakpoints,
            spacingTokens: customSpacing,
            child: Builder(
              builder: (context) {
                config = SmartUi.of(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(config.breakpoints, equals(customBreakpoints));
      expect(config.spacingTokens, equals(customSpacing));
    });

    testWidgets('maybeOf returns config without dependency', (tester) async {
      const customBreakpoints = SmartBreakpoints(mobile: 350);
      late SmartUiData config;

      await tester.pumpWidget(
        MaterialApp(
          home: SmartUi(
            breakpoints: customBreakpoints,
            child: Builder(
              builder: (context) {
                config = SmartUi.maybeOf(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(config.breakpoints, equals(customBreakpoints));
    });

    testWidgets('notifies when configuration changes', (tester) async {
      var buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: SmartUi(
            breakpoints: const SmartBreakpoints(mobile: 300),
            child: Builder(
              builder: (context) {
                SmartUi.of(context); // establish dependency
                buildCount++;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(buildCount, equals(1));

      await tester.pumpWidget(
        MaterialApp(
          home: SmartUi(
            breakpoints: const SmartBreakpoints(mobile: 350), // changed
            child: Builder(
              builder: (context) {
                SmartUi.of(context);
                buildCount++;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(buildCount, equals(2));
    });
  });

  group('SmartUiData', () {
    test('defaults have correct values', () {
      const data = SmartUiData.defaults;
      expect(data.breakpoints, equals(SmartBreakpoints.defaults));
      expect(data.spacingTokens, equals(SmartSpacingTokens.defaults));
      expect(data.designSize, isNull);
    });

    test('breakpointForWidth delegates to breakpoints', () {
      const data = SmartUiData.defaults;
      expect(data.breakpointForWidth(400), equals(SmartBreakpoint.mobile));
      expect(data.breakpointForWidth(700), equals(SmartBreakpoint.tablet));
      expect(data.breakpointForWidth(1000), equals(SmartBreakpoint.desktop));
    });

    test('copyWith works correctly', () {
      const original = SmartUiData.defaults;
      const newBreakpoints = SmartBreakpoints(mobile: 350);

      final copied = original.copyWith(breakpoints: newBreakpoints);

      expect(copied.breakpoints, equals(newBreakpoints));
      expect(copied.spacingTokens, equals(SmartSpacingTokens.defaults));
    });

    test('equality works correctly', () {
      const a = SmartUiData.defaults;
      const b = SmartUiData(
        breakpoints: SmartBreakpoints.defaults,
        spacingTokens: SmartSpacingTokens.defaults,
      );
      const c = SmartUiData(
        breakpoints: SmartBreakpoints(mobile: 350),
        spacingTokens: SmartSpacingTokens.defaults,
      );

      expect(a == b, isTrue);
      expect(a == c, isFalse);
      expect(a.hashCode == b.hashCode, isTrue);
    });
  });
}
