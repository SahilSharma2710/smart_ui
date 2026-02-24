/// Token-based padding widget.
///
/// This module provides a padding widget that uses design tokens
/// for consistent spacing.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/spacing.dart';

/// A padding widget that uses spacing tokens.
///
/// Use [SmartPadding] instead of [Padding] for consistent spacing
/// based on your design system tokens.
///
/// Example:
/// ```dart
/// // Using token size
/// SmartPadding.all(
///   SpacingSize.md,
///   child: Text('Hello'),
/// )
///
/// // Using numeric value
/// SmartPadding(
///   padding: EdgeInsets.all(SmartSpacing.md),
///   child: Text('Hello'),
/// )
///
/// // Responsive padding
/// SmartPadding.responsive(
///   mobile: EdgeInsets.all(SmartSpacing.sm),
///   tablet: EdgeInsets.all(SmartSpacing.md),
///   desktop: EdgeInsets.all(SmartSpacing.lg),
///   child: Text('Hello'),
/// )
/// ```
class SmartPadding extends StatelessWidget {
  /// Creates a [SmartPadding] widget with the given [EdgeInsets].
  const SmartPadding({
    required this.child,
    required this.padding,
    super.key,
  })  : _size = null,
        _horizontal = null,
        _vertical = null,
        _left = null,
        _top = null,
        _right = null,
        _bottom = null,
        _responsivePadding = null;

  /// Creates a [SmartPadding] with equal padding on all sides using a token.
  const SmartPadding.all(
    SpacingSize size, {
    required this.child,
    super.key,
  })  : _size = size,
        _horizontal = null,
        _vertical = null,
        _left = null,
        _top = null,
        _right = null,
        _bottom = null,
        padding = EdgeInsets.zero,
        _responsivePadding = null;

  /// Creates a [SmartPadding] with symmetric padding using tokens.
  const SmartPadding.symmetric({
    required this.child,
    SpacingSize? horizontal,
    SpacingSize? vertical,
    super.key,
  })  : _size = null,
        _horizontal = horizontal,
        _vertical = vertical,
        _left = null,
        _top = null,
        _right = null,
        _bottom = null,
        padding = EdgeInsets.zero,
        _responsivePadding = null;

  /// Creates a [SmartPadding] with specific sides using tokens.
  const SmartPadding.only({
    required this.child,
    SpacingSize? left,
    SpacingSize? top,
    SpacingSize? right,
    SpacingSize? bottom,
    super.key,
  })  : _size = null,
        _horizontal = null,
        _vertical = null,
        _left = left,
        _top = top,
        _right = right,
        _bottom = bottom,
        padding = EdgeInsets.zero,
        _responsivePadding = null;

  /// Creates a [SmartPadding] with responsive padding.
  const SmartPadding.responsive({
    required this.child,
    EdgeInsets? watch,
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? tv,
    super.key,
  })  : _size = null,
        _horizontal = null,
        _vertical = null,
        _left = null,
        _top = null,
        _right = null,
        _bottom = null,
        padding = EdgeInsets.zero,
        _responsivePadding = (
          watch: watch,
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
          tv: tv,
        );

  /// The child widget.
  final Widget child;

  /// The padding to apply.
  final EdgeInsets padding;

  final SpacingSize? _size;
  final SpacingSize? _horizontal;
  final SpacingSize? _vertical;
  final SpacingSize? _left;
  final SpacingSize? _top;
  final SpacingSize? _right;
  final SpacingSize? _bottom;
  final ({
    EdgeInsets? watch,
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? tv,
  })? _responsivePadding;

  @override
  Widget build(BuildContext context) {
    final resolvedPadding = _resolvePadding(context);
    return Padding(
      padding: resolvedPadding,
      child: child,
    );
  }

  EdgeInsets _resolvePadding(BuildContext context) {
    final config = SmartUi.of(context);
    final tokens = config.spacingTokens;

    // Responsive padding
    if (_responsivePadding != null) {
      final width = MediaQuery.sizeOf(context).width;
      final breakpoint = config.breakpoints.breakpointForWidth(width);
      return _resolveResponsivePadding(breakpoint);
    }

    // Token-based all
    if (_size != null) {
      return EdgeInsets.all(tokens.fromSize(_size!));
    }

    // Token-based symmetric
    if (_horizontal != null || _vertical != null) {
      return EdgeInsets.symmetric(
        horizontal: _horizontal != null ? tokens.fromSize(_horizontal!) : 0,
        vertical: _vertical != null ? tokens.fromSize(_vertical!) : 0,
      );
    }

    // Token-based only
    if (_left != null || _top != null || _right != null || _bottom != null) {
      return EdgeInsets.only(
        left: _left != null ? tokens.fromSize(_left!) : 0,
        top: _top != null ? tokens.fromSize(_top!) : 0,
        right: _right != null ? tokens.fromSize(_right!) : 0,
        bottom: _bottom != null ? tokens.fromSize(_bottom!) : 0,
      );
    }

    // Direct EdgeInsets
    return padding;
  }

  EdgeInsets _resolveResponsivePadding(SmartBreakpoint breakpoint) {
    final r = _responsivePadding!;
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv =>
        r.tv ?? r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.desktop => r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.tablet => r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.mobile => r.mobile ?? r.watch,
      SmartBreakpoint.watch =>
        r.watch ?? r.mobile ?? r.tablet ?? r.desktop ?? r.tv,
    };
    return resolved ?? EdgeInsets.zero;
  }
}

/// A horizontal padding widget using spacing tokens.
class SmartHorizontalPadding extends StatelessWidget {
  /// Creates a [SmartHorizontalPadding] widget.
  const SmartHorizontalPadding(
    this.size, {
    required this.child,
    super.key,
  });

  /// The spacing size.
  final SpacingSize size;

  /// The child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      SmartPadding.symmetric(horizontal: size, child: child);
}

/// A vertical padding widget using spacing tokens.
class SmartVerticalPadding extends StatelessWidget {
  /// Creates a [SmartVerticalPadding] widget.
  const SmartVerticalPadding(
    this.size, {
    required this.child,
    super.key,
  });

  /// The spacing size.
  final SpacingSize size;

  /// The child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      SmartPadding.symmetric(vertical: size, child: child);
}
