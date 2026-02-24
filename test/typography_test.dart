import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  group('SmartTypography', () {
    test('display styles have correct font sizes', () {
      expect(SmartTypography.displayLarge.fontSize, equals(57));
      expect(SmartTypography.displayMedium.fontSize, equals(45));
      expect(SmartTypography.displaySmall.fontSize, equals(36));
    });

    test('headline styles have correct font sizes', () {
      expect(SmartTypography.headlineLarge.fontSize, equals(32));
      expect(SmartTypography.headlineMedium.fontSize, equals(28));
      expect(SmartTypography.headlineSmall.fontSize, equals(24));
    });

    test('title styles have correct font sizes', () {
      expect(SmartTypography.titleLarge.fontSize, equals(22));
      expect(SmartTypography.titleMedium.fontSize, equals(16));
      expect(SmartTypography.titleSmall.fontSize, equals(14));
    });

    test('body styles have correct font sizes', () {
      expect(SmartTypography.bodyLarge.fontSize, equals(16));
      expect(SmartTypography.bodyMedium.fontSize, equals(14));
      expect(SmartTypography.bodySmall.fontSize, equals(12));
    });

    test('label styles have correct font sizes', () {
      expect(SmartTypography.labelLarge.fontSize, equals(14));
      expect(SmartTypography.labelMedium.fontSize, equals(12));
      expect(SmartTypography.labelSmall.fontSize, equals(11));
    });

    test('title styles have medium font weight', () {
      expect(SmartTypography.titleLarge.fontWeight, equals(FontWeight.w500));
      expect(SmartTypography.titleMedium.fontWeight, equals(FontWeight.w500));
      expect(SmartTypography.titleSmall.fontWeight, equals(FontWeight.w500));
    });

    test('label styles have medium font weight', () {
      expect(SmartTypography.labelLarge.fontWeight, equals(FontWeight.w500));
      expect(SmartTypography.labelMedium.fontWeight, equals(FontWeight.w500));
      expect(SmartTypography.labelSmall.fontWeight, equals(FontWeight.w500));
    });

    test('fromStyle returns correct TextStyle', () {
      expect(
        SmartTypography.fromStyle(TypographyStyle.displayLarge),
        equals(SmartTypography.displayLarge),
      );
      expect(
        SmartTypography.fromStyle(TypographyStyle.bodyMedium),
        equals(SmartTypography.bodyMedium),
      );
      expect(
        SmartTypography.fromStyle(TypographyStyle.labelSmall),
        equals(SmartTypography.labelSmall),
      );
    });
  });

  group('TypographyStyle', () {
    test('style getter returns correct TextStyle', () {
      expect(
        TypographyStyle.displayLarge.style,
        equals(SmartTypography.displayLarge),
      );
      expect(
        TypographyStyle.bodyMedium.style,
        equals(SmartTypography.bodyMedium),
      );
    });

    test('all enum values have corresponding styles', () {
      for (final style in TypographyStyle.values) {
        expect(style.style, isA<TextStyle>());
        expect(style.style.fontSize, isNotNull);
      }
    });
  });
}
