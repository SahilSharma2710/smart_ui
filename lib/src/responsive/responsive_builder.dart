/// Responsive builder widget.
///
/// This module provides a builder widget that gives access to
/// breakpoint information and screen metrics.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// Information about the current responsive context.
///
/// Contains the current breakpoint, screen dimensions, and
/// helper methods for responsive decisions.
@immutable
class ResponsiveInfo {
  /// Creates a [ResponsiveInfo] instance.
  const ResponsiveInfo({
    required this.breakpoint,
    required this.screenWidth,
    required this.screenHeight,
    required this.breakpoints,
  });

  /// The current breakpoint.
  final SmartBreakpoint breakpoint;

  /// The current screen width in logical pixels.
  final double screenWidth;

  /// The current screen height in logical pixels.
  final double screenHeight;

  /// The breakpoint configuration.
  final SmartBreakpoints breakpoints;

  /// Returns `true` if the current breakpoint is watch.
  bool get isWatch => breakpoint == SmartBreakpoint.watch;

  /// Returns `true` if the current breakpoint is mobile.
  bool get isMobile => breakpoint == SmartBreakpoint.mobile;

  /// Returns `true` if the current breakpoint is tablet.
  bool get isTablet => breakpoint == SmartBreakpoint.tablet;

  /// Returns `true` if the current breakpoint is desktop.
  bool get isDesktop => breakpoint == SmartBreakpoint.desktop;

  /// Returns `true` if the current breakpoint is TV.
  bool get isTv => breakpoint == SmartBreakpoint.tv;

  /// Returns `true` if the current breakpoint is mobile or smaller.
  bool get isMobileOrSmaller =>
      breakpoint == SmartBreakpoint.watch ||
      breakpoint == SmartBreakpoint.mobile;

  /// Returns `true` if the current breakpoint is tablet or larger.
  bool get isTabletOrLarger =>
      breakpoint == SmartBreakpoint.tablet ||
      breakpoint == SmartBreakpoint.desktop ||
      breakpoint == SmartBreakpoint.tv;

  /// Returns `true` if the current breakpoint is desktop or larger.
  bool get isDesktopOrLarger =>
      breakpoint == SmartBreakpoint.desktop || breakpoint == SmartBreakpoint.tv;

  /// Returns `true` if the screen is in portrait orientation.
  bool get isPortrait => screenHeight > screenWidth;

  /// Returns `true` if the screen is in landscape orientation.
  bool get isLandscape => screenWidth > screenHeight;

  /// The aspect ratio of the screen (width / height).
  double get aspectRatio => screenWidth / screenHeight;

  /// Returns a value based on the current breakpoint.
  ///
  /// Values cascade up: if a breakpoint doesn't have a value,
  /// it uses the next smaller breakpoint's value.
  T responsive<T>({
    T? watch,
    T? mobile,
    T? tablet,
    T? desktop,
    T? tv,
    T? defaultValue,
  }) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponsiveInfo &&
          runtimeType == other.runtimeType &&
          breakpoint == other.breakpoint &&
          screenWidth == other.screenWidth &&
          screenHeight == other.screenHeight;

  @override
  int get hashCode => Object.hash(breakpoint, screenWidth, screenHeight);

  @override
  String toString() => 'ResponsiveInfo('
      'breakpoint: $breakpoint, '
      'screenWidth: $screenWidth, '
      'screenHeight: $screenHeight)';
}

/// A builder widget that provides responsive information.
///
/// Use [ResponsiveBuilder] when you need access to breakpoint
/// information and screen metrics in your widget tree.
///
/// Example:
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, info) {
///     return Column(
///       children: [
///         Text('Breakpoint: ${info.breakpoint.name}'),
///         Text('Screen: ${info.screenWidth} x ${info.screenHeight}'),
///         if (info.isTabletOrLarger) Sidebar(),
///       ],
///     );
///   },
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a [ResponsiveBuilder] widget.
  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  /// The builder function that receives responsive information.
  final Widget Function(BuildContext context, ResponsiveInfo info) builder;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final size = MediaQuery.sizeOf(context);
    final breakpoint = config.breakpoints.breakpointForWidth(size.width);

    final info = ResponsiveInfo(
      breakpoint: breakpoint,
      screenWidth: size.width,
      screenHeight: size.height,
      breakpoints: config.breakpoints,
    );

    return builder(context, info);
  }
}

/// A widget that rebuilds when the breakpoint changes.
///
/// Unlike [ResponsiveBuilder], this widget caches the child and only
/// rebuilds when the breakpoint actually changes, not on every pixel
/// change in screen size.
///
/// Example:
/// ```dart
/// BreakpointObserver(
///   builder: (context, breakpoint) {
///     return Text('Current: ${breakpoint.name}');
///   },
/// )
/// ```
class BreakpointObserver extends StatefulWidget {
  /// Creates a [BreakpointObserver] widget.
  const BreakpointObserver({
    required this.builder,
    super.key,
    this.onBreakpointChanged,
  });

  /// The builder function called when the breakpoint changes.
  final Widget Function(BuildContext context, SmartBreakpoint breakpoint)
      builder;

  /// Optional callback when the breakpoint changes.
  final void Function(SmartBreakpoint newBreakpoint)? onBreakpointChanged;

  @override
  State<BreakpointObserver> createState() => _BreakpointObserverState();
}

class _BreakpointObserverState extends State<BreakpointObserver> {
  SmartBreakpoint? _lastBreakpoint;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    if (_lastBreakpoint != breakpoint) {
      _lastBreakpoint = breakpoint;
      widget.onBreakpointChanged?.call(breakpoint);
    }

    return widget.builder(context, breakpoint);
  }
}
