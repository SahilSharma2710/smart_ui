/// Breakpoint system for responsive layouts.
///
/// This module provides the breakpoint definitions and utilities for
/// building responsive Flutter applications.
library;

import 'package:flutter/widgets.dart';

/// Represents the different screen size breakpoints.
///
/// Breakpoints are ordered from smallest to largest:
/// - [watch]: Wearable devices (0-299px)
/// - [mobile]: Mobile phones (300-599px)
/// - [tablet]: Tablets (600-899px)
/// - [desktop]: Desktop screens (900-1199px)
/// - [tv]: Large screens/TVs (1200px+)
///
/// Example:
/// ```dart
/// final breakpoint = SmartBreakpoint.fromWidth(context.screenWidth);
/// if (breakpoint >= SmartBreakpoint.tablet) {
///   // Show tablet or larger layout
/// }
/// ```
enum SmartBreakpoint implements Comparable<SmartBreakpoint> {
  /// Wearable devices (0-299px).
  watch,

  /// Mobile phones (300-599px).
  mobile,

  /// Tablets (600-899px).
  tablet,

  /// Desktop screens (900-1199px).
  desktop,

  /// Large screens/TVs (1200px+).
  tv;

  /// Returns `true` if this breakpoint is smaller than [other].
  bool operator <(SmartBreakpoint other) => index < other.index;

  /// Returns `true` if this breakpoint is smaller than or equal to [other].
  bool operator <=(SmartBreakpoint other) => index <= other.index;

  /// Returns `true` if this breakpoint is larger than [other].
  bool operator >(SmartBreakpoint other) => index > other.index;

  /// Returns `true` if this breakpoint is larger than or equal to [other].
  bool operator >=(SmartBreakpoint other) => index >= other.index;

  @override
  int compareTo(SmartBreakpoint other) => index.compareTo(other.index);
}

/// Configuration class for breakpoint values.
///
/// Defines the minimum width thresholds for each breakpoint.
/// All values represent the minimum width in logical pixels.
///
/// Default breakpoints:
/// - watch: 0px
/// - mobile: 300px
/// - tablet: 600px
/// - desktop: 900px
/// - tv: 1200px
///
/// Example:
/// ```dart
/// // Use custom breakpoints
/// SmartUi(
///   breakpoints: SmartBreakpoints.custom(
///     mobile: 320,
///     tablet: 768,
///     desktop: 1024,
///     tv: 1440,
///   ),
///   child: MyApp(),
/// )
/// ```
@immutable
class SmartBreakpoints {
  /// Creates a [SmartBreakpoints] with the given threshold values.
  const SmartBreakpoints({
    this.watch = 0,
    this.mobile = 300,
    this.tablet = 600,
    this.desktop = 900,
    this.tv = 1200,
  }) : assert(
          watch <= mobile &&
              mobile <= tablet &&
              tablet <= desktop &&
              desktop <= tv,
          'Breakpoints must be in ascending order',
        );

  /// Creates custom breakpoints with specified values.
  ///
  /// Unspecified values use the defaults.
  const SmartBreakpoints.custom({
    this.watch = 0,
    this.mobile = 300,
    this.tablet = 600,
    this.desktop = 900,
    this.tv = 1200,
  }) : assert(
          watch <= mobile &&
              mobile <= tablet &&
              tablet <= desktop &&
              desktop <= tv,
          'Breakpoints must be in ascending order',
        );

  /// Default breakpoints following common responsive design patterns.
  static const SmartBreakpoints defaults = SmartBreakpoints();

  /// Minimum width for watch breakpoint (default: 0).
  final double watch;

  /// Minimum width for mobile breakpoint (default: 300).
  final double mobile;

  /// Minimum width for tablet breakpoint (default: 600).
  final double tablet;

  /// Minimum width for desktop breakpoint (default: 900).
  final double desktop;

  /// Minimum width for TV breakpoint (default: 1200).
  final double tv;

  /// Returns the [SmartBreakpoint] for the given [width].
  ///
  /// Example:
  /// ```dart
  /// final breakpoint = breakpoints.breakpointForWidth(800);
  /// // Returns SmartBreakpoint.tablet
  /// ```
  SmartBreakpoint breakpointForWidth(double width) {
    if (width >= tv) return SmartBreakpoint.tv;
    if (width >= desktop) return SmartBreakpoint.desktop;
    if (width >= tablet) return SmartBreakpoint.tablet;
    if (width >= mobile) return SmartBreakpoint.mobile;
    return SmartBreakpoint.watch;
  }

  /// Returns the minimum width value for the given [breakpoint].
  double minWidthFor(SmartBreakpoint breakpoint) => switch (breakpoint) {
        SmartBreakpoint.watch => watch,
        SmartBreakpoint.mobile => mobile,
        SmartBreakpoint.tablet => tablet,
        SmartBreakpoint.desktop => desktop,
        SmartBreakpoint.tv => tv,
      };

  /// Returns the maximum width value for the given [breakpoint].
  ///
  /// Returns [double.infinity] for the largest breakpoint (tv).
  double maxWidthFor(SmartBreakpoint breakpoint) => switch (breakpoint) {
        SmartBreakpoint.watch => mobile - 1,
        SmartBreakpoint.mobile => tablet - 1,
        SmartBreakpoint.tablet => desktop - 1,
        SmartBreakpoint.desktop => tv - 1,
        SmartBreakpoint.tv => double.infinity,
      };

  /// Creates a copy of this [SmartBreakpoints] with the given values replaced.
  SmartBreakpoints copyWith({
    double? watch,
    double? mobile,
    double? tablet,
    double? desktop,
    double? tv,
  }) =>
      SmartBreakpoints(
        watch: watch ?? this.watch,
        mobile: mobile ?? this.mobile,
        tablet: tablet ?? this.tablet,
        desktop: desktop ?? this.desktop,
        tv: tv ?? this.tv,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartBreakpoints &&
          runtimeType == other.runtimeType &&
          watch == other.watch &&
          mobile == other.mobile &&
          tablet == other.tablet &&
          desktop == other.desktop &&
          tv == other.tv;

  @override
  int get hashCode => Object.hash(watch, mobile, tablet, desktop, tv);

  @override
  String toString() => 'SmartBreakpoints('
      'watch: $watch, '
      'mobile: $mobile, '
      'tablet: $tablet, '
      'desktop: $desktop, '
      'tv: $tv)';
}
