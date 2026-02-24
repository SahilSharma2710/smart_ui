/// Responsive value utilities.
///
/// This module provides extensions for getting breakpoint-specific
/// values from BuildContext.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// Extension on [BuildContext] for responsive value selection.
///
/// Use these methods to select different values based on the
/// current breakpoint.
///
/// Example:
/// ```dart
/// final fontSize = context.responsive<double>(
///   mobile: 14,
///   tablet: 16,
///   desktop: 18,
/// );
/// ```
extension ResponsiveValueExtension on BuildContext {
  /// Returns a value based on the current breakpoint.
  ///
  /// Values cascade up: if a breakpoint doesn't have a value,
  /// it uses the next smaller breakpoint's value.
  ///
  /// Example:
  /// ```dart
  /// final columns = context.responsive<int>(
  ///   mobile: 1,
  ///   tablet: 2,
  ///   desktop: 4,
  /// );
  /// // On watch: 1 (falls back to mobile)
  /// // On mobile: 1
  /// // On tablet: 2
  /// // On desktop: 4
  /// // On tv: 4 (falls back to desktop)
  /// ```
  T responsive<T>({
    T? watch,
    T? mobile,
    T? tablet,
    T? desktop,
    T? tv,
    T? defaultValue,
  }) {
    final breakpoint = _currentBreakpoint;

    // Cascade down from current breakpoint
    final value = switch (breakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch,
    };

    if (value != null) return value;
    if (defaultValue != null) return defaultValue;

    throw ArgumentError(
      'No value provided for breakpoint $breakpoint and no defaultValue set',
    );
  }

  /// Returns an integer value based on the current breakpoint.
  ///
  /// Convenience method for [responsive<int>].
  int responsiveInt({
    int? watch,
    int? mobile,
    int? tablet,
    int? desktop,
    int? tv,
    int? defaultValue,
  }) =>
      responsive<int>(
        watch: watch,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        tv: tv,
        defaultValue: defaultValue,
      );

  /// Returns a double value based on the current breakpoint.
  ///
  /// Convenience method for [responsive<double>].
  double responsiveDouble({
    double? watch,
    double? mobile,
    double? tablet,
    double? desktop,
    double? tv,
    double? defaultValue,
  }) =>
      responsive<double>(
        watch: watch,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        tv: tv,
        defaultValue: defaultValue,
      );

  /// Returns a boolean value based on the current breakpoint.
  ///
  /// Convenience method for [responsive<bool>].
  bool responsiveBool({
    bool? watch,
    bool? mobile,
    bool? tablet,
    bool? desktop,
    bool? tv,
    bool? defaultValue,
  }) =>
      responsive<bool>(
        watch: watch,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        tv: tv,
        defaultValue: defaultValue,
      );

  /// Returns an [EdgeInsets] value based on the current breakpoint.
  ///
  /// Convenience method for [responsive<EdgeInsets>].
  EdgeInsets responsivePadding({
    EdgeInsets? watch,
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? tv,
    EdgeInsets? defaultValue,
  }) =>
      responsive<EdgeInsets>(
        watch: watch,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        tv: tv,
        defaultValue: defaultValue,
      );

  SmartBreakpoint get _currentBreakpoint {
    final config = SmartUi.of(this);
    final width = MediaQuery.sizeOf(this).width;
    return config.breakpoints.breakpointForWidth(width);
  }
}

/// A value that can vary based on breakpoint.
///
/// Use this class when you need to define responsive values
/// that can be resolved later with a [BuildContext].
///
/// Example:
/// ```dart
/// const fontSize = ResponsiveValue<double>(
///   mobile: 14,
///   tablet: 16,
///   desktop: 18,
/// );
///
/// // Later, resolve with context
/// final resolvedSize = fontSize.resolve(context);
/// ```
@immutable
class ResponsiveValue<T> {
  /// Creates a responsive value with breakpoint-specific values.
  const ResponsiveValue({
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
    this.defaultValue,
  });

  /// Value for watch breakpoint.
  final T? watch;

  /// Value for mobile breakpoint.
  final T? mobile;

  /// Value for tablet breakpoint.
  final T? tablet;

  /// Value for desktop breakpoint.
  final T? desktop;

  /// Value for TV breakpoint.
  final T? tv;

  /// Default value when no breakpoint matches.
  final T? defaultValue;

  /// Resolves this responsive value using the given [context].
  T resolve(BuildContext context) => context.responsive<T>(
        watch: watch,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        tv: tv,
        defaultValue: defaultValue,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponsiveValue<T> &&
          runtimeType == other.runtimeType &&
          watch == other.watch &&
          mobile == other.mobile &&
          tablet == other.tablet &&
          desktop == other.desktop &&
          tv == other.tv &&
          defaultValue == other.defaultValue;

  @override
  int get hashCode =>
      Object.hash(watch, mobile, tablet, desktop, tv, defaultValue);
}
