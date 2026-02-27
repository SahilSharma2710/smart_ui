/// Breakpoint-driven layout switching.
///
/// This module provides widgets for switching between different
/// layouts based on the current breakpoint.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// Transition types for animated breakpoint changes.
///
/// Use with [SmartLayout] to animate transitions between breakpoints.
enum SmartTransition {
  /// No animation, instant switch.
  none,

  /// Fade between layouts.
  fade,

  /// Fade with a slide animation.
  fadeSlide,

  /// Cross-fade between layouts.
  crossFade,

  /// Scale transition.
  scale,
}

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
/// With animated transitions:
/// ```dart
/// SmartLayout(
///   mobile: MobileHomeScreen(),
///   desktop: DesktopHomeScreen(),
///   transition: SmartTransition.fadeSlide,
///   transitionDuration: Duration(milliseconds: 300),
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
    this.transition = SmartTransition.none,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionCurve = Curves.easeInOut,
    this.transitionBuilder,
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

  /// The type of transition animation to use.
  ///
  /// Defaults to [SmartTransition.none] for instant switching.
  final SmartTransition transition;

  /// The duration of the transition animation.
  ///
  /// Defaults to 300 milliseconds.
  final Duration transitionDuration;

  /// The curve to use for the transition animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve transitionCurve;

  /// Custom transition builder for advanced animations.
  ///
  /// If provided, overrides [transition].
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    var child = _resolveChild(breakpoint);

    // Add a key based on the breakpoint to trigger AnimatedSwitcher
    child = KeyedSubtree(
      key: ValueKey(breakpoint),
      child: child,
    );

    if (builder != null) {
      return builder!(context, breakpoint, child);
    }

    if (transition == SmartTransition.none && transitionBuilder == null) {
      return child;
    }

    return AnimatedSwitcher(
      duration: transitionDuration,
      switchInCurve: transitionCurve,
      switchOutCurve: transitionCurve,
      transitionBuilder: transitionBuilder ?? _buildTransition,
      child: child,
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    switch (transition) {
      case SmartTransition.none:
        return child;

      case SmartTransition.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );

      case SmartTransition.fadeSlide:
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );

      case SmartTransition.crossFade:
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.5),
          ),
          child: child,
        );

      case SmartTransition.scale:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.95,
            end: 1.0,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
    }
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
