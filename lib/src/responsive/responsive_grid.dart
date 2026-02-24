/// Responsive grid system.
///
/// This module provides a 12-column responsive grid system
/// similar to Bootstrap or CSS Grid.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/spacing.dart';

/// A responsive 12-column grid container.
///
/// Use [SmartGrid] with [SmartCol] children to create responsive layouts
/// that adapt based on screen size.
///
/// Example:
/// ```dart
/// SmartGrid(
///   columns: 12,
///   spacing: SmartSpacing.md,
///   children: [
///     SmartCol(
///       mobile: 12,   // Full width on mobile
///       tablet: 6,    // Half width on tablet
///       desktop: 4,   // Third width on desktop
///       child: ProductCard(),
///     ),
///     SmartCol(
///       mobile: 12,
///       tablet: 6,
///       desktop: 4,
///       child: ProductCard(),
///     ),
///     SmartCol(
///       mobile: 12,
///       tablet: 12,
///       desktop: 4,
///       child: ProductCard(),
///     ),
///   ],
/// )
/// ```
class SmartGrid extends StatelessWidget {
  /// Creates a [SmartGrid] widget.
  const SmartGrid({
    required this.children,
    super.key,
    this.columns = 12,
    this.spacing = SmartSpacing.md,
    this.runSpacing,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.alignment = WrapAlignment.start,
  });

  /// The number of columns in the grid.
  ///
  /// Defaults to 12.
  final int columns;

  /// The horizontal spacing between columns.
  ///
  /// Defaults to [SmartSpacing.md] (16px).
  final double spacing;

  /// The vertical spacing between rows.
  ///
  /// Defaults to [spacing] if not provided.
  final double? runSpacing;

  /// How children are aligned within each row.
  final WrapCrossAlignment crossAxisAlignment;

  /// How the children are aligned within the grid.
  final WrapAlignment alignment;

  /// The grid columns.
  ///
  /// Should be [SmartCol] widgets.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final effectiveRunSpacing = runSpacing ?? spacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: effectiveRunSpacing,
          crossAxisAlignment: crossAxisAlignment,
          alignment: alignment,
          children: children.map((child) {
            if (child is SmartCol) {
              return _buildColumn(context, child, availableWidth);
            }
            return child;
          }).toList(),
        );
      },
    );
  }

  Widget _buildColumn(
    BuildContext context,
    SmartCol col,
    double availableWidth,
  ) {
    final config = SmartUi.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(screenWidth);

    final span = col._resolveSpan(breakpoint);
    final totalSpacing = spacing * (columns - 1);
    final columnWidth = (availableWidth - totalSpacing) / columns;
    final width = (columnWidth * span) + (spacing * (span - 1));

    return SizedBox(
      width: width.clamp(0, availableWidth),
      child: col.child,
    );
  }
}

/// A column within a [SmartGrid].
///
/// Specify how many columns this widget should span at each breakpoint.
/// Values cascade up: if a breakpoint doesn't have a value,
/// it uses the next smaller breakpoint's value.
///
/// Example:
/// ```dart
/// SmartCol(
///   mobile: 12,   // Full width on mobile
///   tablet: 6,    // Half width on tablet
///   desktop: 4,   // Third width on desktop
///   child: Card(),
/// )
/// ```
class SmartCol extends StatelessWidget {
  /// Creates a [SmartCol] widget.
  const SmartCol({
    required this.child,
    super.key,
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
  });

  /// Column span for watch-sized screens (out of 12).
  final int? watch;

  /// Column span for mobile-sized screens (out of 12).
  final int? mobile;

  /// Column span for tablet-sized screens (out of 12).
  final int? tablet;

  /// Column span for desktop-sized screens (out of 12).
  final int? desktop;

  /// Column span for TV-sized screens (out of 12).
  final int? tv;

  /// The child widget.
  final Widget child;

  int _resolveSpan(SmartBreakpoint breakpoint) {
    final span = switch (breakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch ?? mobile ?? tablet ?? desktop ?? tv,
    };

    return (span ?? 12).clamp(1, 12);
  }

  @override
  Widget build(BuildContext context) =>
      // This widget is meant to be used inside SmartGrid
      // which handles the sizing. Standalone use just returns the child.
      child;
}

/// A responsive row that contains columns.
///
/// Use [SmartRow] for simpler row-based layouts without the full grid system.
///
/// Example:
/// ```dart
/// SmartRow(
///   spacing: SmartSpacing.md,
///   children: [
///     Expanded(flex: 1, child: Sidebar()),
///     Expanded(flex: 3, child: Content()),
///   ],
/// )
/// ```
class SmartRow extends StatelessWidget {
  /// Creates a [SmartRow] widget.
  const SmartRow({
    required this.children,
    super.key,
    this.spacing = SmartSpacing.md,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  /// The horizontal spacing between children.
  final double spacing;

  /// How children are aligned horizontally.
  final MainAxisAlignment mainAxisAlignment;

  /// How children are aligned vertically.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space the row should take up horizontally.
  final MainAxisSize mainAxisSize;

  /// The row children.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final spacedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(width: spacing));
      }
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}
