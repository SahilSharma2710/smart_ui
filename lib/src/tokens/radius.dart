/// Border radius design tokens.
///
/// This module provides consistent border radius values following
/// a design token system.
library;

import 'package:flutter/widgets.dart';

/// Provides border radius constants for consistent rounding.
///
/// Radius values follow a progressive scale:
/// - [none]: No radius (0)
/// - [xs]: Extra small (2px)
/// - [sm]: Small (4px)
/// - [md]: Medium (8px)
/// - [lg]: Large (12px)
/// - [xl]: Extra large (16px)
/// - [xxl]: Extra extra large (24px)
/// - [full]: Fully rounded (9999px)
///
/// Example:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: SmartRadius.md,
///   ),
/// )
/// ```
abstract final class SmartRadius {
  /// No border radius.
  static const BorderRadius none = BorderRadius.zero;

  /// Extra small border radius: 2px.
  static const BorderRadius xs = BorderRadius.all(Radius.circular(2));

  /// Small border radius: 4px.
  static const BorderRadius sm = BorderRadius.all(Radius.circular(4));

  /// Medium border radius: 8px.
  static const BorderRadius md = BorderRadius.all(Radius.circular(8));

  /// Large border radius: 12px.
  static const BorderRadius lg = BorderRadius.all(Radius.circular(12));

  /// Extra large border radius: 16px.
  static const BorderRadius xl = BorderRadius.all(Radius.circular(16));

  /// Extra extra large border radius: 24px.
  static const BorderRadius xxl = BorderRadius.all(Radius.circular(24));

  /// Fully rounded border radius.
  static const BorderRadius full = BorderRadius.all(Radius.circular(9999));

  // Raw values for custom usage

  /// Extra small radius value: 2.
  static const double xsValue = 2;

  /// Small radius value: 4.
  static const double smValue = 4;

  /// Medium radius value: 8.
  static const double mdValue = 8;

  /// Large radius value: 12.
  static const double lgValue = 12;

  /// Extra large radius value: 16.
  static const double xlValue = 16;

  /// Extra extra large radius value: 24.
  static const double xxlValue = 24;

  /// Returns the [BorderRadius] for the given [RadiusSize].
  static BorderRadius fromSize(RadiusSize size) => switch (size) {
        RadiusSize.none => none,
        RadiusSize.xs => xs,
        RadiusSize.sm => sm,
        RadiusSize.md => md,
        RadiusSize.lg => lg,
        RadiusSize.xl => xl,
        RadiusSize.xxl => xxl,
        RadiusSize.full => full,
      };

  /// Returns the radius value for the given [RadiusSize].
  static double valueFromSize(RadiusSize size) => switch (size) {
        RadiusSize.none => 0,
        RadiusSize.xs => xsValue,
        RadiusSize.sm => smValue,
        RadiusSize.md => mdValue,
        RadiusSize.lg => lgValue,
        RadiusSize.xl => xlValue,
        RadiusSize.xxl => xxlValue,
        RadiusSize.full => 9999,
      };

  /// Creates a [BorderRadius] with the given [radius] on all corners.
  static BorderRadius all(double radius) =>
      BorderRadius.all(Radius.circular(radius));

  /// Creates a [BorderRadius] with circular radius on the top corners.
  static BorderRadius top(double radius) => BorderRadius.vertical(
        top: Radius.circular(radius),
      );

  /// Creates a [BorderRadius] with circular radius on the bottom corners.
  static BorderRadius bottom(double radius) => BorderRadius.vertical(
        bottom: Radius.circular(radius),
      );

  /// Creates a [BorderRadius] with circular radius on the left corners.
  static BorderRadius left(double radius) => BorderRadius.horizontal(
        left: Radius.circular(radius),
      );

  /// Creates a [BorderRadius] with circular radius on the right corners.
  static BorderRadius right(double radius) => BorderRadius.horizontal(
        right: Radius.circular(radius),
      );

  /// Creates a [BorderRadius] with the given radius on specific corners.
  static BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      );
}

/// Enum representing radius sizes.
///
/// Use with [SmartRadius.fromSize] to get the [BorderRadius].
enum RadiusSize {
  /// No radius.
  none,

  /// Extra small radius.
  xs,

  /// Small radius.
  sm,

  /// Medium radius.
  md,

  /// Large radius.
  lg,

  /// Extra large radius.
  xl,

  /// Extra extra large radius.
  xxl,

  /// Fully rounded.
  full;

  /// Returns the [BorderRadius] for this size.
  BorderRadius get borderRadius => SmartRadius.fromSize(this);

  /// Returns the radius value for this size.
  double get value => SmartRadius.valueFromSize(this);
}
