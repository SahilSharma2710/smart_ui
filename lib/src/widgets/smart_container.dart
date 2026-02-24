/// Responsive container widget.
///
/// This module provides a container widget with responsive
/// max-width constraints for consistent layouts.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/spacing.dart';

/// A container with responsive max-width constraints.
///
/// Use [SmartContainer] to create centered content areas with
/// appropriate max-widths for different screen sizes.
///
/// Example:
/// ```dart
/// SmartContainer(
///   maxWidth: 1200,
///   padding: EdgeInsets.symmetric(horizontal: SmartSpacing.md),
///   child: Content(),
/// )
///
/// // Responsive max-width
/// SmartContainer.responsive(
///   mobile: double.infinity,  // Full width on mobile
///   tablet: 720,
///   desktop: 960,
///   tv: 1200,
///   child: Content(),
/// )
/// ```
class SmartContainer extends StatelessWidget {
  /// Creates a [SmartContainer] with a fixed max-width.
  const SmartContainer({
    required this.child,
    super.key,
    this.maxWidth = 1200,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  }) : _responsiveMaxWidth = null;

  /// Creates a [SmartContainer] with responsive max-widths.
  const SmartContainer.responsive({
    required this.child,
    super.key,
    double? watch,
    double? mobile,
    double? tablet,
    double? desktop,
    double? tv,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  })  : maxWidth = 1200,
        _responsiveMaxWidth = (
          watch: watch,
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
          tv: tv,
        );

  /// Creates a small [SmartContainer] (max-width: 640px).
  const SmartContainer.sm({
    required this.child,
    super.key,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  })  : maxWidth = 640,
        _responsiveMaxWidth = null;

  /// Creates a medium [SmartContainer] (max-width: 768px).
  const SmartContainer.md({
    required this.child,
    super.key,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  })  : maxWidth = 768,
        _responsiveMaxWidth = null;

  /// Creates a large [SmartContainer] (max-width: 1024px).
  const SmartContainer.lg({
    required this.child,
    super.key,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  })  : maxWidth = 1024,
        _responsiveMaxWidth = null;

  /// Creates an extra-large [SmartContainer] (max-width: 1280px).
  const SmartContainer.xl({
    required this.child,
    super.key,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  })  : maxWidth = 1280,
        _responsiveMaxWidth = null;

  /// Creates an extra-extra-large [SmartContainer] (max-width: 1536px).
  const SmartContainer.xxl({
    required this.child,
    super.key,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  })  : maxWidth = 1536,
        _responsiveMaxWidth = null;

  /// Creates a full-width [SmartContainer] (no max-width constraint).
  const SmartContainer.fluid({
    required this.child,
    super.key,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.color,
    this.decoration,
  })  : maxWidth = double.infinity,
        _responsiveMaxWidth = null;

  /// The child widget.
  final Widget child;

  /// The maximum width of the container.
  final double maxWidth;

  /// The padding inside the container.
  final EdgeInsets? padding;

  /// How to align the child within the container.
  final Alignment alignment;

  /// The background color of the container.
  final Color? color;

  /// The decoration of the container.
  final BoxDecoration? decoration;

  final ({
    double? watch,
    double? mobile,
    double? tablet,
    double? desktop,
    double? tv,
  })? _responsiveMaxWidth;

  @override
  Widget build(BuildContext context) {
    final resolvedMaxWidth = _resolveMaxWidth(context);

    Widget content = child;

    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: resolvedMaxWidth),
      child: content,
    );

    if (color != null || decoration != null) {
      content = DecoratedBox(
        decoration: decoration ?? BoxDecoration(color: color),
        child: content,
      );
    }

    return Align(
      alignment: alignment,
      child: content,
    );
  }

  double _resolveMaxWidth(BuildContext context) {
    if (_responsiveMaxWidth == null) return maxWidth;

    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final r = _responsiveMaxWidth!;
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv =>
        r.tv ?? r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.desktop => r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.tablet => r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.mobile => r.mobile ?? r.watch,
      SmartBreakpoint.watch =>
        r.watch ?? r.mobile ?? r.tablet ?? r.desktop ?? r.tv,
    };

    return resolved ?? maxWidth;
  }
}

/// A container that automatically applies responsive padding.
///
/// Use [ResponsivePaddedContainer] for consistent content areas
/// with appropriate padding for each screen size.
class ResponsivePaddedContainer extends StatelessWidget {
  /// Creates a [ResponsivePaddedContainer].
  const ResponsivePaddedContainer({
    required this.child,
    super.key,
    this.maxWidth = 1200,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
  });

  /// The child widget.
  final Widget child;

  /// The maximum width of the container.
  final double maxWidth;

  /// Padding on mobile. Defaults to 16px horizontal.
  final EdgeInsets? mobilePadding;

  /// Padding on tablet. Defaults to 24px horizontal.
  final EdgeInsets? tabletPadding;

  /// Padding on desktop. Defaults to 32px horizontal.
  final EdgeInsets? desktopPadding;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final padding = switch (breakpoint) {
      SmartBreakpoint.watch ||
      SmartBreakpoint.mobile =>
        mobilePadding ?? EdgeInsets.symmetric(horizontal: SmartSpacing.md),
      SmartBreakpoint.tablet =>
        tabletPadding ?? EdgeInsets.symmetric(horizontal: SmartSpacing.lg),
      SmartBreakpoint.desktop ||
      SmartBreakpoint.tv =>
        desktopPadding ?? EdgeInsets.symmetric(horizontal: SmartSpacing.xl),
    };

    return SmartContainer(
      maxWidth: maxWidth,
      padding: padding,
      child: child,
    );
  }
}

/// A centered content container with max-width and padding.
///
/// Combines [SmartContainer] with automatic horizontal centering
/// and responsive padding.
class CenteredContent extends StatelessWidget {
  /// Creates a [CenteredContent] widget.
  const CenteredContent({
    required this.child,
    super.key,
    this.maxWidth = 1200,
    this.horizontalPadding = SmartSpacing.md,
    this.verticalPadding = 0,
  });

  /// The child widget.
  final Widget child;

  /// The maximum width of the content.
  final double maxWidth;

  /// The horizontal padding.
  final double horizontalPadding;

  /// The vertical padding.
  final double verticalPadding;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: child,
        ),
      );
}
