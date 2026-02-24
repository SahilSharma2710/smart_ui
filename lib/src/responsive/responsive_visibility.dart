/// Responsive visibility utilities.
///
/// This module provides widgets for showing or hiding content
/// based on the current breakpoint.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// A widget that conditionally shows its child based on breakpoints.
///
/// Use [SmartVisible] to show content only on specific breakpoints.
///
/// Example:
/// ```dart
/// // Show only on tablet and desktop
/// SmartVisible(
///   visibleOn: [SmartBreakpoint.tablet, SmartBreakpoint.desktop],
///   child: Sidebar(),
/// )
///
/// // Hide on mobile
/// SmartVisible(
///   hiddenOn: [SmartBreakpoint.mobile, SmartBreakpoint.watch],
///   child: AdvancedOptions(),
/// )
/// ```
class SmartVisible extends StatelessWidget {
  /// Creates a [SmartVisible] widget.
  ///
  /// Either [visibleOn] or [hiddenOn] must be provided, but not both.
  const SmartVisible({
    required this.child,
    super.key,
    this.visibleOn,
    this.hiddenOn,
    this.replacement,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
  }) : assert(
          (visibleOn != null) != (hiddenOn != null),
          'Either visibleOn or hiddenOn must be provided, but not both',
        );

  /// Creates a [SmartVisible] that shows on specific breakpoints.
  const SmartVisible.on({
    required this.child,
    required List<SmartBreakpoint> breakpoints,
    super.key,
    this.replacement,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
  })  : visibleOn = breakpoints,
        hiddenOn = null;

  /// Creates a [SmartVisible] that hides on specific breakpoints.
  const SmartVisible.except({
    required this.child,
    required List<SmartBreakpoint> breakpoints,
    super.key,
    this.replacement,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
  })  : hiddenOn = breakpoints,
        visibleOn = null;

  /// The child widget to conditionally show.
  final Widget child;

  /// The breakpoints on which to show the child.
  ///
  /// Cannot be used with [hiddenOn].
  final List<SmartBreakpoint>? visibleOn;

  /// The breakpoints on which to hide the child.
  ///
  /// Cannot be used with [visibleOn].
  final List<SmartBreakpoint>? hiddenOn;

  /// Widget to show when the child is hidden.
  ///
  /// Defaults to [SizedBox.shrink].
  final Widget? replacement;

  /// Whether to maintain the state of the child when hidden.
  final bool maintainState;

  /// Whether to maintain animations when hidden.
  final bool maintainAnimation;

  /// Whether to maintain the size when hidden.
  final bool maintainSize;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final isVisible = _isVisibleAt(breakpoint);

    if (maintainSize || maintainState || maintainAnimation) {
      return Visibility(
        visible: isVisible,
        maintainState: maintainState,
        maintainAnimation: maintainAnimation,
        maintainSize: maintainSize,
        replacement: replacement ?? const SizedBox.shrink(),
        child: child,
      );
    }

    return isVisible ? child : (replacement ?? const SizedBox.shrink());
  }

  bool _isVisibleAt(SmartBreakpoint breakpoint) {
    if (visibleOn != null) {
      return visibleOn!.contains(breakpoint);
    }
    if (hiddenOn != null) {
      return !hiddenOn!.contains(breakpoint);
    }
    return true;
  }
}

/// A widget that shows its child only on mobile and watch breakpoints.
///
/// Shorthand for [SmartVisible.on] with mobile breakpoints.
class MobileOnly extends StatelessWidget {
  /// Creates a [MobileOnly] widget.
  const MobileOnly({
    required this.child,
    super.key,
    this.replacement,
  });

  /// The child widget to show on mobile.
  final Widget child;

  /// Widget to show on other breakpoints.
  final Widget? replacement;

  @override
  Widget build(BuildContext context) => SmartVisible.on(
        breakpoints: const [SmartBreakpoint.watch, SmartBreakpoint.mobile],
        replacement: replacement,
        child: child,
      );
}

/// A widget that shows its child only on tablet breakpoint.
class TabletOnly extends StatelessWidget {
  /// Creates a [TabletOnly] widget.
  const TabletOnly({
    required this.child,
    super.key,
    this.replacement,
  });

  /// The child widget to show on tablet.
  final Widget child;

  /// Widget to show on other breakpoints.
  final Widget? replacement;

  @override
  Widget build(BuildContext context) => SmartVisible.on(
        breakpoints: const [SmartBreakpoint.tablet],
        replacement: replacement,
        child: child,
      );
}

/// A widget that shows its child only on desktop and TV breakpoints.
class DesktopOnly extends StatelessWidget {
  /// Creates a [DesktopOnly] widget.
  const DesktopOnly({
    required this.child,
    super.key,
    this.replacement,
  });

  /// The child widget to show on desktop.
  final Widget child;

  /// Widget to show on other breakpoints.
  final Widget? replacement;

  @override
  Widget build(BuildContext context) => SmartVisible.on(
        breakpoints: const [SmartBreakpoint.desktop, SmartBreakpoint.tv],
        replacement: replacement,
        child: child,
      );
}

/// A widget that hides its child on mobile and watch breakpoints.
///
/// Shows on tablet, desktop, and TV.
class HideOnMobile extends StatelessWidget {
  /// Creates a [HideOnMobile] widget.
  const HideOnMobile({
    required this.child,
    super.key,
    this.replacement,
  });

  /// The child widget to hide on mobile.
  final Widget child;

  /// Widget to show on mobile.
  final Widget? replacement;

  @override
  Widget build(BuildContext context) => SmartVisible.except(
        breakpoints: const [SmartBreakpoint.watch, SmartBreakpoint.mobile],
        replacement: replacement,
        child: child,
      );
}

/// A widget that hides its child on desktop and TV breakpoints.
///
/// Shows on watch, mobile, and tablet.
class HideOnDesktop extends StatelessWidget {
  /// Creates a [HideOnDesktop] widget.
  const HideOnDesktop({
    required this.child,
    super.key,
    this.replacement,
  });

  /// The child widget to hide on desktop.
  final Widget child;

  /// Widget to show on desktop.
  final Widget? replacement;

  @override
  Widget build(BuildContext context) => SmartVisible.except(
        breakpoints: const [SmartBreakpoint.desktop, SmartBreakpoint.tv],
        replacement: replacement,
        child: child,
      );
}
