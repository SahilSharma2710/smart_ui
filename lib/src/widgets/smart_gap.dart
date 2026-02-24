/// Responsive gap/spacer widget.
///
/// This module provides gap widgets for consistent spacing
/// between elements using design tokens.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/spacing.dart';

/// A gap widget that creates empty space using spacing tokens.
///
/// Use [SmartGap] instead of [SizedBox] for consistent spacing
/// based on your design system tokens.
///
/// [SmartGap] automatically determines whether to add horizontal
/// or vertical space based on its parent (Row, Column, Flex).
///
/// Example:
/// ```dart
/// Column(
///   children: [
///     Text('Hello'),
///     SmartGap.md(),  // Adds 16px vertical gap
///     Text('World'),
///   ],
/// )
///
/// Row(
///   children: [
///     Icon(Icons.star),
///     SmartGap.sm(),  // Adds 8px horizontal gap
///     Text('Rating'),
///   ],
/// )
/// ```
class SmartGap extends StatelessWidget {
  /// Creates a [SmartGap] with the given spacing size.
  const SmartGap(
    this.size, {
    super.key,
  })  : _value = null,
        _responsiveValue = null;

  /// Creates a [SmartGap] with a custom value in pixels.
  const SmartGap.value(
    double value, {
    super.key,
  })  : size = SpacingSize.md,
        _value = value,
        _responsiveValue = null;

  /// Creates a zero-sized gap.
  const SmartGap.zero({super.key})
      : size = SpacingSize.zero,
        _value = null,
        _responsiveValue = null;

  /// Creates an extra small gap (4px).
  const SmartGap.xs({super.key})
      : size = SpacingSize.xs,
        _value = null,
        _responsiveValue = null;

  /// Creates a small gap (8px).
  const SmartGap.sm({super.key})
      : size = SpacingSize.sm,
        _value = null,
        _responsiveValue = null;

  /// Creates a medium gap (16px).
  const SmartGap.md({super.key})
      : size = SpacingSize.md,
        _value = null,
        _responsiveValue = null;

  /// Creates a large gap (24px).
  const SmartGap.lg({super.key})
      : size = SpacingSize.lg,
        _value = null,
        _responsiveValue = null;

  /// Creates an extra large gap (32px).
  const SmartGap.xl({super.key})
      : size = SpacingSize.xl,
        _value = null,
        _responsiveValue = null;

  /// Creates an extra extra large gap (48px).
  const SmartGap.xxl({super.key})
      : size = SpacingSize.xxl,
        _value = null,
        _responsiveValue = null;

  /// Creates a responsive gap with different sizes per breakpoint.
  const SmartGap.responsive({
    super.key,
    double? watch,
    double? mobile,
    double? tablet,
    double? desktop,
    double? tv,
  })  : size = SpacingSize.md,
        _value = null,
        _responsiveValue = (
          watch: watch,
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
          tv: tv,
        );

  /// The spacing size.
  final SpacingSize size;

  final double? _value;
  final ({
    double? watch,
    double? mobile,
    double? tablet,
    double? desktop,
    double? tv,
  })? _responsiveValue;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final gapValue = _resolveValue(context, config);

    // Determine direction from parent
    final direction = _getParentDirection(context);

    return switch (direction) {
      Axis.horizontal => SizedBox(width: gapValue),
      Axis.vertical => SizedBox(height: gapValue),
    };
  }

  double _resolveValue(BuildContext context, SmartUiData config) {
    if (_value != null) return _value!;

    if (_responsiveValue != null) {
      final width = MediaQuery.sizeOf(context).width;
      final breakpoint = config.breakpoints.breakpointForWidth(width);
      return _resolveResponsiveValue(breakpoint);
    }

    return config.spacingTokens.fromSize(size);
  }

  double _resolveResponsiveValue(SmartBreakpoint breakpoint) {
    final r = _responsiveValue!;
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv =>
        r.tv ?? r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.desktop => r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.tablet => r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.mobile => r.mobile ?? r.watch,
      SmartBreakpoint.watch =>
        r.watch ?? r.mobile ?? r.tablet ?? r.desktop ?? r.tv,
    };
    return resolved ?? 0;
  }

  Axis _getParentDirection(BuildContext context) {
    // Try to find the nearest Flex ancestor
    final flex = context.findAncestorWidgetOfExactType<Flex>();
    if (flex != null) {
      return flex.direction;
    }

    // Try Row
    final row = context.findAncestorWidgetOfExactType<Row>();
    if (row != null) {
      return Axis.horizontal;
    }

    // Try Column
    final column = context.findAncestorWidgetOfExactType<Column>();
    if (column != null) {
      return Axis.vertical;
    }

    // Default to vertical
    return Axis.vertical;
  }
}

/// A horizontal gap widget.
///
/// Use [HGap] when you specifically need horizontal spacing.
class HGap extends StatelessWidget {
  /// Creates a horizontal gap with the given spacing size.
  const HGap(
    this.size, {
    super.key,
  }) : _value = null;

  /// Creates a horizontal gap with a custom value in pixels.
  const HGap.value(
    double value, {
    super.key,
  })  : size = SpacingSize.md,
        _value = value;

  /// Creates a zero-sized horizontal gap.
  const HGap.zero({super.key})
      : size = SpacingSize.zero,
        _value = null;

  /// Creates an extra small horizontal gap (4px).
  const HGap.xs({super.key})
      : size = SpacingSize.xs,
        _value = null;

  /// Creates a small horizontal gap (8px).
  const HGap.sm({super.key})
      : size = SpacingSize.sm,
        _value = null;

  /// Creates a medium horizontal gap (16px).
  const HGap.md({super.key})
      : size = SpacingSize.md,
        _value = null;

  /// Creates a large horizontal gap (24px).
  const HGap.lg({super.key})
      : size = SpacingSize.lg,
        _value = null;

  /// Creates an extra large horizontal gap (32px).
  const HGap.xl({super.key})
      : size = SpacingSize.xl,
        _value = null;

  /// Creates an extra extra large horizontal gap (48px).
  const HGap.xxl({super.key})
      : size = SpacingSize.xxl,
        _value = null;

  /// The spacing size.
  final SpacingSize size;

  final double? _value;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final gapValue = _value ?? config.spacingTokens.fromSize(size);
    return SizedBox(width: gapValue);
  }
}

/// A vertical gap widget.
///
/// Use [VGap] when you specifically need vertical spacing.
class VGap extends StatelessWidget {
  /// Creates a vertical gap with the given spacing size.
  const VGap(
    this.size, {
    super.key,
  }) : _value = null;

  /// Creates a vertical gap with a custom value in pixels.
  const VGap.value(
    double value, {
    super.key,
  })  : size = SpacingSize.md,
        _value = value;

  /// Creates a zero-sized vertical gap.
  const VGap.zero({super.key})
      : size = SpacingSize.zero,
        _value = null;

  /// Creates an extra small vertical gap (4px).
  const VGap.xs({super.key})
      : size = SpacingSize.xs,
        _value = null;

  /// Creates a small vertical gap (8px).
  const VGap.sm({super.key})
      : size = SpacingSize.sm,
        _value = null;

  /// Creates a medium vertical gap (16px).
  const VGap.md({super.key})
      : size = SpacingSize.md,
        _value = null;

  /// Creates a large vertical gap (24px).
  const VGap.lg({super.key})
      : size = SpacingSize.lg,
        _value = null;

  /// Creates an extra large vertical gap (32px).
  const VGap.xl({super.key})
      : size = SpacingSize.xl,
        _value = null;

  /// Creates an extra extra large vertical gap (48px).
  const VGap.xxl({super.key})
      : size = SpacingSize.xxl,
        _value = null;

  /// The spacing size.
  final SpacingSize size;

  final double? _value;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final gapValue = _value ?? config.spacingTokens.fromSize(size);
    return SizedBox(height: gapValue);
  }
}
