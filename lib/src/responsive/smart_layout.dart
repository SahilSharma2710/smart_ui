/// Breakpoint-driven layout switching.
///
/// This module provides widgets for switching between different
/// layouts based on the current breakpoint.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// A widget that displays different children based on the current breakpoint.
///
/// Use [SmartLayout] when you need completely different widget trees
/// for different screen sizes.
///
/// Example:
/// ```dart
/// SmartLayout(
///   mobile: MobileHomeScreen(),
///   tablet: TabletHomeScreen(),
///   desktop: DesktopHomeScreen(),
/// )
/// ```
///
/// Values cascade up: if a breakpoint doesn't have a widget,
/// it uses the next smaller breakpoint's widget.
class SmartLayout extends StatelessWidget {
  /// Creates a [SmartLayout] widget.
  ///
  /// At least one of [watch], [mobile], [tablet], [desktop], or [tv]
  /// must be provided.
  const SmartLayout({
    super.key,
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
    this.builder,
  }) : assert(
          watch != null ||
              mobile != null ||
              tablet != null ||
              desktop != null ||
              tv != null,
          'At least one breakpoint widget must be provided',
        );

  /// Widget to display on watch-sized screens.
  final Widget? watch;

  /// Widget to display on mobile-sized screens.
  final Widget? mobile;

  /// Widget to display on tablet-sized screens.
  final Widget? tablet;

  /// Widget to display on desktop-sized screens.
  final Widget? desktop;

  /// Widget to display on TV-sized screens.
  final Widget? tv;

  /// Optional builder for wrapping the selected widget.
  ///
  /// Use this for fine-grained control or animations between breakpoints.
  ///
  /// Example:
  /// ```dart
  /// SmartLayout(
  ///   mobile: MobileView(),
  ///   desktop: DesktopView(),
  ///   builder: (context, breakpoint, child) {
  ///     return AnimatedSwitcher(
  ///       duration: Duration(milliseconds: 300),
  ///       child: child,
  ///     );
  ///   },
  /// )
  /// ```
  final Widget Function(
    BuildContext context,
    SmartBreakpoint breakpoint,
    Widget child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final child = _resolveChild(breakpoint);

    if (builder != null) {
      return builder!(context, breakpoint, child);
    }

    return child;
  }

  Widget _resolveChild(SmartBreakpoint breakpoint) {
    // Cascade down from current breakpoint
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch ?? mobile ?? tablet ?? desktop ?? tv,
    };

    // This should never be null due to the assertion in the constructor
    return resolved!;
  }
}

/// A widget that provides the current breakpoint to its builder.
///
/// Use [BreakpointBuilder] when you need access to the current
/// breakpoint but don't want to create separate widgets for each.
///
/// Example:
/// ```dart
/// BreakpointBuilder(
///   builder: (context, breakpoint) {
///     return Text('Current breakpoint: ${breakpoint.name}');
///   },
/// )
/// ```
class BreakpointBuilder extends StatelessWidget {
  /// Creates a [BreakpointBuilder] widget.
  const BreakpointBuilder({
    required this.builder,
    super.key,
  });

  /// Builder function that receives the current breakpoint.
  final Widget Function(BuildContext context, SmartBreakpoint breakpoint)
      builder;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    return builder(context, breakpoint);
  }
}
