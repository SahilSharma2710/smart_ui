/// Safe area wrapper with responsive options.
///
/// This module provides a safe area widget with responsive padding
/// and convenient extensions.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// A responsive safe area wrapper.
///
/// Use [SmartSafeArea] to apply safe area insets with responsive options.
/// On desktop, safe area padding is typically not needed, so you can
/// disable it for larger breakpoints.
///
/// Example:
/// ```dart
/// SmartSafeArea(
///   child: MyContent(),
/// )
/// ```
///
/// With responsive safe area:
/// ```dart
/// SmartSafeArea(
///   mobileTop: true,
///   mobileBottom: true,
///   desktopTop: false,
///   desktopBottom: false,
///   child: MyContent(),
/// )
/// ```
///
/// With minimum padding:
/// ```dart
/// SmartSafeArea(
///   minimum: EdgeInsets.all(16),
///   child: MyContent(),
/// )
/// ```
class SmartSafeArea extends StatelessWidget {
  /// Creates a [SmartSafeArea] widget.
  const SmartSafeArea({
    required this.child,
    super.key,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
    // Responsive options
    this.watchLeft,
    this.watchTop,
    this.watchRight,
    this.watchBottom,
    this.mobileLeft,
    this.mobileTop,
    this.mobileRight,
    this.mobileBottom,
    this.tabletLeft,
    this.tabletTop,
    this.tabletRight,
    this.tabletBottom,
    this.desktopLeft,
    this.desktopTop,
    this.desktopRight,
    this.desktopBottom,
    this.tvLeft,
    this.tvTop,
    this.tvRight,
    this.tvBottom,
  });

  /// Creates a [SmartSafeArea] that only applies safe area on mobile.
  const SmartSafeArea.mobileOnly({
    required this.child,
    super.key,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  })  : left = false,
        top = false,
        right = false,
        bottom = false,
        watchLeft = true,
        watchTop = true,
        watchRight = true,
        watchBottom = true,
        mobileLeft = true,
        mobileTop = true,
        mobileRight = true,
        mobileBottom = true,
        tabletLeft = false,
        tabletTop = false,
        tabletRight = false,
        tabletBottom = false,
        desktopLeft = false,
        desktopTop = false,
        desktopRight = false,
        desktopBottom = false,
        tvLeft = false,
        tvTop = false,
        tvRight = false,
        tvBottom = false;

  /// Creates a [SmartSafeArea] that only applies top safe area on mobile.
  const SmartSafeArea.topOnlyMobile({
    required this.child,
    super.key,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  })  : left = false,
        top = false,
        right = false,
        bottom = false,
        watchLeft = false,
        watchTop = true,
        watchRight = false,
        watchBottom = false,
        mobileLeft = false,
        mobileTop = true,
        mobileRight = false,
        mobileBottom = false,
        tabletLeft = false,
        tabletTop = false,
        tabletRight = false,
        tabletBottom = false,
        desktopLeft = false,
        desktopTop = false,
        desktopRight = false,
        desktopBottom = false,
        tvLeft = false,
        tvTop = false,
        tvRight = false,
        tvBottom = false;

  /// The child widget.
  final Widget child;

  // Default values
  /// Whether to apply left safe area padding by default.
  final bool left;

  /// Whether to apply top safe area padding by default.
  final bool top;

  /// Whether to apply right safe area padding by default.
  final bool right;

  /// Whether to apply bottom safe area padding by default.
  final bool bottom;

  /// Minimum padding to apply.
  final EdgeInsets minimum;

  /// Whether to maintain the bottom view padding.
  final bool maintainBottomViewPadding;

  // Watch breakpoint overrides
  /// Override left safe area for watch.
  final bool? watchLeft;

  /// Override top safe area for watch.
  final bool? watchTop;

  /// Override right safe area for watch.
  final bool? watchRight;

  /// Override bottom safe area for watch.
  final bool? watchBottom;

  // Mobile breakpoint overrides
  /// Override left safe area for mobile.
  final bool? mobileLeft;

  /// Override top safe area for mobile.
  final bool? mobileTop;

  /// Override right safe area for mobile.
  final bool? mobileRight;

  /// Override bottom safe area for mobile.
  final bool? mobileBottom;

  // Tablet breakpoint overrides
  /// Override left safe area for tablet.
  final bool? tabletLeft;

  /// Override top safe area for tablet.
  final bool? tabletTop;

  /// Override right safe area for tablet.
  final bool? tabletRight;

  /// Override bottom safe area for tablet.
  final bool? tabletBottom;

  // Desktop breakpoint overrides
  /// Override left safe area for desktop.
  final bool? desktopLeft;

  /// Override top safe area for desktop.
  final bool? desktopTop;

  /// Override right safe area for desktop.
  final bool? desktopRight;

  /// Override bottom safe area for desktop.
  final bool? desktopBottom;

  // TV breakpoint overrides
  /// Override left safe area for TV.
  final bool? tvLeft;

  /// Override top safe area for TV.
  final bool? tvTop;

  /// Override right safe area for TV.
  final bool? tvRight;

  /// Override bottom safe area for TV.
  final bool? tvBottom;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final (resolvedLeft, resolvedTop, resolvedRight, resolvedBottom) =
        _resolveEdges(breakpoint);

    return SafeArea(
      left: resolvedLeft,
      top: resolvedTop,
      right: resolvedRight,
      bottom: resolvedBottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child,
    );
  }

  (bool, bool, bool, bool) _resolveEdges(SmartBreakpoint breakpoint) {
    switch (breakpoint) {
      case SmartBreakpoint.watch:
        return (
          watchLeft ?? left,
          watchTop ?? top,
          watchRight ?? right,
          watchBottom ?? bottom,
        );
      case SmartBreakpoint.mobile:
        return (
          mobileLeft ?? left,
          mobileTop ?? top,
          mobileRight ?? right,
          mobileBottom ?? bottom,
        );
      case SmartBreakpoint.tablet:
        return (
          tabletLeft ?? left,
          tabletTop ?? top,
          tabletRight ?? right,
          tabletBottom ?? bottom,
        );
      case SmartBreakpoint.desktop:
        return (
          desktopLeft ?? left,
          desktopTop ?? top,
          desktopRight ?? right,
          desktopBottom ?? bottom,
        );
      case SmartBreakpoint.tv:
        return (
          tvLeft ?? left,
          tvTop ?? top,
          tvRight ?? right,
          tvBottom ?? bottom,
        );
    }
  }
}

/// A sliver version of [SmartSafeArea].
///
/// Use [SliverSmartSafeArea] in a [CustomScrollView] to apply
/// responsive safe area padding to slivers.
///
/// Example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverSmartSafeArea(
///       sliver: SliverList(...),
///     ),
///   ],
/// )
/// ```
class SliverSmartSafeArea extends StatelessWidget {
  /// Creates a [SliverSmartSafeArea] widget.
  const SliverSmartSafeArea({
    required this.sliver,
    super.key,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
  });

  /// The sliver to wrap.
  final Widget sliver;

  /// Whether to apply left safe area padding.
  final bool left;

  /// Whether to apply top safe area padding.
  final bool top;

  /// Whether to apply right safe area padding.
  final bool right;

  /// Whether to apply bottom safe area padding.
  final bool bottom;

  /// Minimum padding to apply.
  final EdgeInsets minimum;

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      minimum: minimum,
      sliver: sliver,
    );
  }
}

// Safe area extensions are provided in context_extensions.dart:
// - context.safeAreaPadding
// - context.safeAreaTop (new in v2.0)
// - context.safeAreaBottom (new in v2.0)
// - context.safeAreaLeft (new in v2.0)
// - context.safeAreaRight (new in v2.0)
// - context.safeAreaHorizontal (new in v2.0)
// - context.safeAreaVertical (new in v2.0)
// - context.hasSafeAreaPadding (new in v2.0)
// - context.hasTopSafeArea (new in v2.0)
// - context.hasBottomSafeArea (new in v2.0)
