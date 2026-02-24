/// Spacing design tokens.
///
/// This module provides consistent spacing values following
/// a design token system similar to Tailwind CSS.
library;

import 'package:flutter/widgets.dart';

/// Provides spacing constants for consistent spacing throughout the app.
///
/// Spacing values follow a progressive scale:
/// - [xs]: Extra small (4px)
/// - [sm]: Small (8px)
/// - [md]: Medium (16px)
/// - [lg]: Large (24px)
/// - [xl]: Extra large (32px)
/// - [xxl]: Extra extra large (48px)
///
/// Example:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(SmartSpacing.md),
///   child: Text('Hello'),
/// )
/// ```
abstract final class SmartSpacing {
  /// Extra small spacing: 4px.
  static const double xs = 4;

  /// Small spacing: 8px.
  static const double sm = 8;

  /// Medium spacing: 16px.
  static const double md = 16;

  /// Large spacing: 24px.
  static const double lg = 24;

  /// Extra large spacing: 32px.
  static const double xl = 32;

  /// Extra extra large spacing: 48px.
  static const double xxl = 48;

  /// Zero spacing.
  static const double zero = 0;

  /// Returns the spacing value for the given [size].
  ///
  /// Example:
  /// ```dart
  /// final spacing = SmartSpacing.fromSize(SpacingSize.md); // 16
  /// ```
  static double fromSize(SpacingSize size) => switch (size) {
        SpacingSize.zero => zero,
        SpacingSize.xs => xs,
        SpacingSize.sm => sm,
        SpacingSize.md => md,
        SpacingSize.lg => lg,
        SpacingSize.xl => xl,
        SpacingSize.xxl => xxl,
      };

  /// Creates [EdgeInsets] with equal spacing on all sides.
  static EdgeInsets all(double value) => EdgeInsets.all(value);

  /// Creates symmetric [EdgeInsets].
  static EdgeInsets symmetric({double? horizontal, double? vertical}) =>
      EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      );

  /// Creates [EdgeInsets] with only the specified sides.
  static EdgeInsets only({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      EdgeInsets.only(
        left: left ?? 0,
        top: top ?? 0,
        right: right ?? 0,
        bottom: bottom ?? 0,
      );

  /// Creates horizontal [EdgeInsets].
  static EdgeInsets horizontal(double value) =>
      EdgeInsets.symmetric(horizontal: value);

  /// Creates vertical [EdgeInsets].
  static EdgeInsets vertical(double value) =>
      EdgeInsets.symmetric(vertical: value);
}

/// Enum representing spacing sizes.
///
/// Use with [SmartSpacing.fromSize] to get the numeric value.
enum SpacingSize {
  /// Zero spacing.
  zero,

  /// Extra small spacing.
  xs,

  /// Small spacing.
  sm,

  /// Medium spacing.
  md,

  /// Large spacing.
  lg,

  /// Extra large spacing.
  xl,

  /// Extra extra large spacing.
  xxl;

  /// Returns the numeric spacing value.
  double get value => SmartSpacing.fromSize(this);
}

/// Customizable spacing token configuration.
///
/// Use this to override the default spacing values globally.
///
/// Example:
/// ```dart
/// SmartUi(
///   spacingTokens: SmartSpacingTokens.custom(
///     xs: 2,
///     sm: 4,
///     md: 8,
///     lg: 16,
///     xl: 24,
///     xxl: 32,
///   ),
///   child: MyApp(),
/// )
/// ```
@immutable
class SmartSpacingTokens {
  /// Creates custom spacing tokens.
  const SmartSpacingTokens({
    this.xs = 4,
    this.sm = 8,
    this.md = 16,
    this.lg = 24,
    this.xl = 32,
    this.xxl = 48,
  });

  /// Creates custom spacing tokens with named parameters.
  const SmartSpacingTokens.custom({
    this.xs = 4,
    this.sm = 8,
    this.md = 16,
    this.lg = 24,
    this.xl = 32,
    this.xxl = 48,
  });

  /// Default spacing tokens.
  static const SmartSpacingTokens defaults = SmartSpacingTokens();

  /// Extra small spacing.
  final double xs;

  /// Small spacing.
  final double sm;

  /// Medium spacing.
  final double md;

  /// Large spacing.
  final double lg;

  /// Extra large spacing.
  final double xl;

  /// Extra extra large spacing.
  final double xxl;

  /// Returns the spacing value for the given [size].
  double fromSize(SpacingSize size) => switch (size) {
        SpacingSize.zero => 0,
        SpacingSize.xs => xs,
        SpacingSize.sm => sm,
        SpacingSize.md => md,
        SpacingSize.lg => lg,
        SpacingSize.xl => xl,
        SpacingSize.xxl => xxl,
      };

  /// Creates a copy of this [SmartSpacingTokens] with the given values.
  SmartSpacingTokens copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) =>
      SmartSpacingTokens(
        xs: xs ?? this.xs,
        sm: sm ?? this.sm,
        md: md ?? this.md,
        lg: lg ?? this.lg,
        xl: xl ?? this.xl,
        xxl: xxl ?? this.xxl,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartSpacingTokens &&
          runtimeType == other.runtimeType &&
          xs == other.xs &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xxl == other.xxl;

  @override
  int get hashCode => Object.hash(xs, sm, md, lg, xl, xxl);

  @override
  String toString() => 'SmartSpacingTokens('
      'xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl)';
}
