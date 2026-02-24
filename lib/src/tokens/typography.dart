/// Typography design tokens.
///
/// This module provides consistent typography styles following
/// Material Design and Tailwind CSS patterns.
library;

import 'package:flutter/widgets.dart';

/// Provides typography constants and text styles.
///
/// Typography follows a progressive scale based on Material Design 3:
/// - Display: Large headlines (displayLarge, displayMedium, displaySmall)
/// - Headline: Section headings (headlineLarge, headlineMedium, headlineSmall)
/// - Title: Titles (titleLarge, titleMedium, titleSmall)
/// - Body: Body text (bodyLarge, bodyMedium, bodySmall)
/// - Label: Labels and captions (labelLarge, labelMedium, labelSmall)
///
/// Example:
/// ```dart
/// Text(
///   'Hello World',
///   style: SmartTypography.headlineLarge,
/// )
/// ```
abstract final class SmartTypography {
  // Display styles (57, 45, 36)

  /// Display large text style.
  ///
  /// Font size: 57, Line height: 64, Font weight: normal.
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    height: 64 / 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  /// Display medium text style.
  ///
  /// Font size: 45, Line height: 52, Font weight: normal.
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    height: 52 / 45,
    fontWeight: FontWeight.w400,
  );

  /// Display small text style.
  ///
  /// Font size: 36, Line height: 44, Font weight: normal.
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    height: 44 / 36,
    fontWeight: FontWeight.w400,
  );

  // Headline styles (32, 28, 24)

  /// Headline large text style.
  ///
  /// Font size: 32, Line height: 40, Font weight: normal.
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w400,
  );

  /// Headline medium text style.
  ///
  /// Font size: 28, Line height: 36, Font weight: normal.
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w400,
  );

  /// Headline small text style.
  ///
  /// Font size: 24, Line height: 32, Font weight: normal.
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w400,
  );

  // Title styles (22, 16, 14)

  /// Title large text style.
  ///
  /// Font size: 22, Line height: 28, Font weight: medium.
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w500,
  );

  /// Title medium text style.
  ///
  /// Font size: 16, Line height: 24, Font weight: medium.
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  /// Title small text style.
  ///
  /// Font size: 14, Line height: 20, Font weight: medium.
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // Body styles (16, 14, 12)

  /// Body large text style.
  ///
  /// Font size: 16, Line height: 24, Font weight: normal.
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  /// Body medium text style.
  ///
  /// Font size: 14, Line height: 20, Font weight: normal.
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  /// Body small text style.
  ///
  /// Font size: 12, Line height: 16, Font weight: normal.
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // Label styles (14, 12, 11)

  /// Label large text style.
  ///
  /// Font size: 14, Line height: 20, Font weight: medium.
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// Label medium text style.
  ///
  /// Font size: 12, Line height: 16, Font weight: medium.
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  /// Label small text style.
  ///
  /// Font size: 11, Line height: 16, Font weight: medium.
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  /// Returns a [TextStyle] for the given [TypographyStyle].
  static TextStyle fromStyle(TypographyStyle style) => switch (style) {
        TypographyStyle.displayLarge => displayLarge,
        TypographyStyle.displayMedium => displayMedium,
        TypographyStyle.displaySmall => displaySmall,
        TypographyStyle.headlineLarge => headlineLarge,
        TypographyStyle.headlineMedium => headlineMedium,
        TypographyStyle.headlineSmall => headlineSmall,
        TypographyStyle.titleLarge => titleLarge,
        TypographyStyle.titleMedium => titleMedium,
        TypographyStyle.titleSmall => titleSmall,
        TypographyStyle.bodyLarge => bodyLarge,
        TypographyStyle.bodyMedium => bodyMedium,
        TypographyStyle.bodySmall => bodySmall,
        TypographyStyle.labelLarge => labelLarge,
        TypographyStyle.labelMedium => labelMedium,
        TypographyStyle.labelSmall => labelSmall,
      };
}

/// Enum representing typography styles.
///
/// Use with [SmartTypography.fromStyle] to get the [TextStyle].
enum TypographyStyle {
  /// Display large style.
  displayLarge,

  /// Display medium style.
  displayMedium,

  /// Display small style.
  displaySmall,

  /// Headline large style.
  headlineLarge,

  /// Headline medium style.
  headlineMedium,

  /// Headline small style.
  headlineSmall,

  /// Title large style.
  titleLarge,

  /// Title medium style.
  titleMedium,

  /// Title small style.
  titleSmall,

  /// Body large style.
  bodyLarge,

  /// Body medium style.
  bodyMedium,

  /// Body small style.
  bodySmall,

  /// Label large style.
  labelLarge,

  /// Label medium style.
  labelMedium,

  /// Label small style.
  labelSmall;

  /// Returns the [TextStyle] for this typography style.
  TextStyle get style => SmartTypography.fromStyle(this);
}
