/// Widget extensions for responsive and adaptive UI.
///
/// This module provides convenient extensions on [Widget]
/// for adding responsive behaviors and visibility.
library;

import 'package:flutter/material.dart';

import '../core/breakpoints.dart';
import '../responsive/responsive_visibility.dart';
import '../tokens/spacing.dart';
import '../widgets/smart_padding.dart';

/// Extension on [Widget] for responsive utilities.
///
/// Provides methods to add responsive padding, visibility,
/// and other behaviors to any widget.
///
/// Example:
/// ```dart
/// // Responsive visibility
/// Sidebar().showOnly([SmartBreakpoint.desktop, SmartBreakpoint.tv])
///
/// // Hide on specific breakpoints
/// MobileNav().hideOn([SmartBreakpoint.desktop])
///
/// // Responsive padding
/// Card().responsivePadding(
///   mobile: EdgeInsets.all(8),
///   tablet: EdgeInsets.all(16),
///   desktop: EdgeInsets.all(24),
/// )
/// ```
extension SmartWidgetExtension on Widget {
  // ============ Visibility ============

  /// Shows this widget only on the specified breakpoints.
  ///
  /// Example:
  /// ```dart
  /// Sidebar().showOnly([SmartBreakpoint.desktop, SmartBreakpoint.tv])
  /// ```
  Widget showOnly(List<SmartBreakpoint> breakpoints, {Widget? replacement}) =>
      SmartVisible.on(
        breakpoints: breakpoints,
        replacement: replacement,
        child: this,
      );

  /// Hides this widget on the specified breakpoints.
  ///
  /// Example:
  /// ```dart
  /// MobileMenu().hideOn([SmartBreakpoint.desktop, SmartBreakpoint.tv])
  /// ```
  Widget hideOn(List<SmartBreakpoint> breakpoints, {Widget? replacement}) =>
      SmartVisible.except(
        breakpoints: breakpoints,
        replacement: replacement,
        child: this,
      );

  /// Shows this widget only on mobile and watch breakpoints.
  Widget showOnMobile({Widget? replacement}) =>
      MobileOnly(replacement: replacement, child: this);

  /// Shows this widget only on tablet breakpoint.
  Widget showOnTablet({Widget? replacement}) =>
      TabletOnly(replacement: replacement, child: this);

  /// Shows this widget only on desktop and TV breakpoints.
  Widget showOnDesktop({Widget? replacement}) =>
      DesktopOnly(replacement: replacement, child: this);

  /// Hides this widget on mobile and watch breakpoints.
  Widget hideOnMobile({Widget? replacement}) =>
      HideOnMobile(replacement: replacement, child: this);

  /// Hides this widget on desktop and TV breakpoints.
  Widget hideOnDesktop({Widget? replacement}) =>
      HideOnDesktop(replacement: replacement, child: this);

  // ============ Padding ============

  /// Adds responsive padding to this widget.
  ///
  /// Example:
  /// ```dart
  /// Card().responsivePadding(
  ///   mobile: EdgeInsets.all(8),
  ///   tablet: EdgeInsets.all(16),
  ///   desktop: EdgeInsets.all(24),
  /// )
  /// ```
  Widget responsivePadding({
    EdgeInsets? watch,
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? tv,
  }) =>
      SmartPadding.responsive(
        watch: watch,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        tv: tv,
        child: this,
      );

  /// Adds padding using spacing tokens.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').withPadding(SpacingSize.md)
  /// ```
  Widget withPadding(SpacingSize size) => SmartPadding.all(size, child: this);

  /// Adds symmetric padding using spacing tokens.
  Widget withSymmetricPadding({
    SpacingSize? horizontal,
    SpacingSize? vertical,
  }) =>
      SmartPadding.symmetric(
        horizontal: horizontal,
        vertical: vertical,
        child: this,
      );

  /// Adds padding on specific sides using spacing tokens.
  Widget withPaddingOnly({
    SpacingSize? left,
    SpacingSize? top,
    SpacingSize? right,
    SpacingSize? bottom,
  }) =>
      SmartPadding.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        child: this,
      );

  /// Adds padding using [EdgeInsets].
  Widget padded(EdgeInsets padding) => Padding(padding: padding, child: this);

  /// Adds equal padding on all sides.
  Widget paddedAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Adds symmetric padding.
  Widget paddedSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Adds horizontal padding.
  Widget paddedHorizontal(double value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  /// Adds vertical padding.
  Widget paddedVertical(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );

  // ============ Layout ============

  /// Centers this widget.
  Widget centered() => Center(child: this);

  /// Expands this widget to fill available space.
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Makes this widget flexible.
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Wraps this widget in a [SizedBox] with the given dimensions.
  Widget sized({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  /// Wraps this widget in a [ConstrainedBox].
  Widget constrained({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
          maxWidth: maxWidth ?? double.infinity,
          minHeight: minHeight ?? 0,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: this,
      );

  /// Aligns this widget within its parent.
  Widget aligned(AlignmentGeometry alignment) =>
      Align(alignment: alignment, child: this);

  // ============ Decoration ============

  /// Wraps this widget with a [ClipRRect].
  Widget clipped({BorderRadius borderRadius = BorderRadius.zero}) =>
      ClipRRect(borderRadius: borderRadius, child: this);

  /// Wraps this widget in a [DecoratedBox].
  Widget decorated(BoxDecoration decoration) =>
      DecoratedBox(decoration: decoration, child: this);

  /// Adds opacity to this widget.
  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);

  // ============ Gestures ============

  /// Wraps this widget in a [GestureDetector].
  Widget onTap(VoidCallback? onTap) =>
      GestureDetector(onTap: onTap, child: this);

  /// Wraps this widget with [Material] and [InkWell] for ripple effects.
  Widget inkWell({
    VoidCallback? onTap,
    BorderRadius? borderRadius,
  }) {
    return Material(
      color: const Color(0x00000000),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: this,
      ),
    );
  }

  // ============ Safe Area ============

  /// Wraps this widget in a [SafeArea].
  Widget safeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
  }) =>
      SafeArea(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        child: this,
      );

  // ============ Scrolling ============

  /// Wraps this widget in a [SingleChildScrollView].
  Widget scrollable({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
  }) =>
      SingleChildScrollView(
        scrollDirection: scrollDirection,
        padding: padding,
        child: this,
      );
}
