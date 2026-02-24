import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_ui/smart_ui.dart';

void main() {
  group('SmartSpacing', () {
    test('constants have correct values', () {
      expect(SmartSpacing.zero, equals(0));
      expect(SmartSpacing.xs, equals(4));
      expect(SmartSpacing.sm, equals(8));
      expect(SmartSpacing.md, equals(16));
      expect(SmartSpacing.lg, equals(24));
      expect(SmartSpacing.xl, equals(32));
      expect(SmartSpacing.xxl, equals(48));
    });

    test('fromSize returns correct values', () {
      expect(SmartSpacing.fromSize(SpacingSize.zero), equals(0));
      expect(SmartSpacing.fromSize(SpacingSize.xs), equals(4));
      expect(SmartSpacing.fromSize(SpacingSize.sm), equals(8));
      expect(SmartSpacing.fromSize(SpacingSize.md), equals(16));
      expect(SmartSpacing.fromSize(SpacingSize.lg), equals(24));
      expect(SmartSpacing.fromSize(SpacingSize.xl), equals(32));
      expect(SmartSpacing.fromSize(SpacingSize.xxl), equals(48));
    });

    test('all creates correct EdgeInsets', () {
      final padding = SmartSpacing.all(16);
      expect(padding, equals(const EdgeInsets.all(16)));
    });

    test('symmetric creates correct EdgeInsets', () {
      final padding = SmartSpacing.symmetric(horizontal: 16, vertical: 8);
      expect(
        padding,
        equals(const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      );
    });

    test('only creates correct EdgeInsets', () {
      final padding =
          SmartSpacing.only(left: 8, top: 16, right: 24, bottom: 32);
      expect(
        padding,
        equals(const EdgeInsets.only(left: 8, top: 16, right: 24, bottom: 32)),
      );
    });

    test('horizontal creates correct EdgeInsets', () {
      final padding = SmartSpacing.horizontal(16);
      expect(padding, equals(const EdgeInsets.symmetric(horizontal: 16)));
    });

    test('vertical creates correct EdgeInsets', () {
      final padding = SmartSpacing.vertical(16);
      expect(padding, equals(const EdgeInsets.symmetric(vertical: 16)));
    });
  });

  group('SpacingSize', () {
    test('value getter returns correct values', () {
      expect(SpacingSize.zero.value, equals(0));
      expect(SpacingSize.xs.value, equals(4));
      expect(SpacingSize.sm.value, equals(8));
      expect(SpacingSize.md.value, equals(16));
      expect(SpacingSize.lg.value, equals(24));
      expect(SpacingSize.xl.value, equals(32));
      expect(SpacingSize.xxl.value, equals(48));
    });
  });

  group('SmartSpacingTokens', () {
    test('default values are correct', () {
      const tokens = SmartSpacingTokens.defaults;
      expect(tokens.xs, equals(4));
      expect(tokens.sm, equals(8));
      expect(tokens.md, equals(16));
      expect(tokens.lg, equals(24));
      expect(tokens.xl, equals(32));
      expect(tokens.xxl, equals(48));
    });

    test('custom values work correctly', () {
      const tokens = SmartSpacingTokens.custom(
        xs: 2,
        sm: 4,
        md: 8,
        lg: 16,
        xl: 24,
        xxl: 32,
      );
      expect(tokens.xs, equals(2));
      expect(tokens.sm, equals(4));
      expect(tokens.md, equals(8));
      expect(tokens.lg, equals(16));
      expect(tokens.xl, equals(24));
      expect(tokens.xxl, equals(32));
    });

    test('fromSize returns correct values', () {
      const tokens = SmartSpacingTokens.custom(
        xs: 2,
        sm: 4,
        md: 8,
        lg: 16,
        xl: 24,
        xxl: 32,
      );
      expect(tokens.fromSize(SpacingSize.zero), equals(0));
      expect(tokens.fromSize(SpacingSize.xs), equals(2));
      expect(tokens.fromSize(SpacingSize.md), equals(8));
    });

    test('copyWith works correctly', () {
      const original = SmartSpacingTokens.defaults;
      final copied = original.copyWith(md: 12, lg: 20);

      expect(copied.xs, equals(4));
      expect(copied.sm, equals(8));
      expect(copied.md, equals(12));
      expect(copied.lg, equals(20));
      expect(copied.xl, equals(32));
      expect(copied.xxl, equals(48));
    });

    test('equality works correctly', () {
      const a = SmartSpacingTokens.defaults;
      const b = SmartSpacingTokens();
      const c = SmartSpacingTokens(md: 12);

      expect(a == b, isTrue);
      expect(a == c, isFalse);
      expect(a.hashCode == b.hashCode, isTrue);
    });
  });
}
