/// Responsive wrap widget.
///
/// This module provides a Wrap widget with responsive maxItemsPerRow.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/spacing.dart';

/// A responsive Wrap widget that limits items per row based on breakpoints.
///
/// Use [SmartWrap] when you want to control the maximum number of items
/// displayed per row at different screen sizes.
///
/// Example:
/// ```dart
/// SmartWrap(
///   mobileItemsPerRow: 2,
///   tabletItemsPerRow: 4,
///   desktopItemsPerRow: 6,
///   spacing: 16,
///   runSpacing: 16,
///   children: items.map((item) => ItemChip(item)).toList(),
/// )
/// ```
///
/// Items will wrap to the next row when the maxItemsPerRow is reached
/// for the current breakpoint.
class SmartWrap extends StatelessWidget {
  /// Creates a [SmartWrap] widget.
  const SmartWrap({
    required this.children,
    super.key,
    this.watchItemsPerRow,
    this.mobileItemsPerRow,
    this.tabletItemsPerRow,
    this.desktopItemsPerRow,
    this.tvItemsPerRow,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.clipBehavior = Clip.none,
    this.fillRow = false,
  });

  /// Creates a [SmartWrap] with token-based spacing.
  SmartWrap.spaced({
    required this.children,
    super.key,
    this.watchItemsPerRow,
    this.mobileItemsPerRow,
    this.tabletItemsPerRow,
    this.desktopItemsPerRow,
    this.tvItemsPerRow,
    SpacingSize spacingSize = SpacingSize.sm,
    SpacingSize runSpacingSize = SpacingSize.sm,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.clipBehavior = Clip.none,
    this.fillRow = false,
  })  : spacing = spacingSize.value,
        runSpacing = runSpacingSize.value;

  /// The widgets to display in the wrap.
  final List<Widget> children;

  /// Maximum items per row on watch-sized screens.
  ///
  /// If null, no limit is applied for this breakpoint.
  final int? watchItemsPerRow;

  /// Maximum items per row on mobile-sized screens.
  ///
  /// If null, no limit is applied for this breakpoint.
  final int? mobileItemsPerRow;

  /// Maximum items per row on tablet-sized screens.
  ///
  /// If null, no limit is applied for this breakpoint.
  final int? tabletItemsPerRow;

  /// Maximum items per row on desktop-sized screens.
  ///
  /// If null, no limit is applied for this breakpoint.
  final int? desktopItemsPerRow;

  /// Maximum items per row on TV-sized screens.
  ///
  /// If null, no limit is applied for this breakpoint.
  final int? tvItemsPerRow;

  /// The spacing between children in the main axis.
  final double spacing;

  /// The spacing between runs.
  final double runSpacing;

  /// How the children should be placed along the main axis.
  final WrapAlignment alignment;

  /// How the runs should be placed along the cross axis.
  final WrapAlignment runAlignment;

  /// How the children within a run should be aligned.
  final WrapCrossAlignment crossAxisAlignment;

  /// The direction to use as the main axis.
  final Axis direction;

  /// The direction in which runs are placed.
  final VerticalDirection verticalDirection;

  /// The text direction to use for resolving alignment.
  final TextDirection? textDirection;

  /// How to clip overflowing children.
  final Clip clipBehavior;

  /// Whether to expand items to fill the row width.
  ///
  /// When true, items will be expanded to take equal width
  /// within each row up to maxItemsPerRow.
  final bool fillRow;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(screenWidth);

    final maxItems = _resolveMaxItems(breakpoint);

    if (!fillRow || maxItems == null) {
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: alignment,
        runAlignment: runAlignment,
        crossAxisAlignment: crossAxisAlignment,
        direction: direction,
        verticalDirection: verticalDirection,
        textDirection: textDirection,
        clipBehavior: clipBehavior,
        children: children,
      );
    }

    // When fillRow is true, we need to calculate item widths
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final effectiveMaxItems = maxItems.clamp(1, children.length);
        final totalSpacing = spacing * (effectiveMaxItems - 1);
        final itemWidth = (availableWidth - totalSpacing) / effectiveMaxItems;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          alignment: alignment,
          runAlignment: runAlignment,
          crossAxisAlignment: crossAxisAlignment,
          direction: direction,
          verticalDirection: verticalDirection,
          textDirection: textDirection,
          clipBehavior: clipBehavior,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }

  int? _resolveMaxItems(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.tv =>
        tvItemsPerRow ?? desktopItemsPerRow ?? tabletItemsPerRow ?? mobileItemsPerRow ?? watchItemsPerRow,
      SmartBreakpoint.desktop =>
        desktopItemsPerRow ?? tabletItemsPerRow ?? mobileItemsPerRow ?? watchItemsPerRow,
      SmartBreakpoint.tablet =>
        tabletItemsPerRow ?? mobileItemsPerRow ?? watchItemsPerRow,
      SmartBreakpoint.mobile => mobileItemsPerRow ?? watchItemsPerRow,
      SmartBreakpoint.watch =>
        watchItemsPerRow ?? mobileItemsPerRow ?? tabletItemsPerRow ?? desktopItemsPerRow ?? tvItemsPerRow,
    };
  }
}

/// A responsive chip wrap that displays chips with breakpoint-aware layout.
///
/// Use [SmartChipWrap] for displaying tags, filters, or categories
/// with automatic responsive wrapping.
///
/// Example:
/// ```dart
/// SmartChipWrap(
///   mobileItemsPerRow: 2,
///   desktopItemsPerRow: 5,
///   labels: ['Flutter', 'Dart', 'Responsive', 'UI', 'Adaptive'],
///   onSelected: (label) => print('Selected: $label'),
/// )
/// ```
class SmartChipWrap extends StatelessWidget {
  /// Creates a [SmartChipWrap] widget.
  const SmartChipWrap({
    required this.labels,
    super.key,
    this.watchItemsPerRow,
    this.mobileItemsPerRow,
    this.tabletItemsPerRow,
    this.desktopItemsPerRow,
    this.tvItemsPerRow,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.chipBuilder,
    this.onSelected,
    this.selectedLabels = const {},
  });

  /// The labels to display as chips.
  final List<String> labels;

  /// Maximum items per row on watch-sized screens.
  final int? watchItemsPerRow;

  /// Maximum items per row on mobile-sized screens.
  final int? mobileItemsPerRow;

  /// Maximum items per row on tablet-sized screens.
  final int? tabletItemsPerRow;

  /// Maximum items per row on desktop-sized screens.
  final int? desktopItemsPerRow;

  /// Maximum items per row on TV-sized screens.
  final int? tvItemsPerRow;

  /// The spacing between chips.
  final double spacing;

  /// The spacing between rows.
  final double runSpacing;

  /// Custom builder for chip widgets.
  ///
  /// If null, a default chip style is used.
  final Widget Function(BuildContext context, String label, bool isSelected)?
      chipBuilder;

  /// Called when a chip is selected.
  final void Function(String label)? onSelected;

  /// The currently selected labels.
  final Set<String> selectedLabels;

  @override
  Widget build(BuildContext context) {
    return SmartWrap(
      watchItemsPerRow: watchItemsPerRow,
      mobileItemsPerRow: mobileItemsPerRow,
      tabletItemsPerRow: tabletItemsPerRow,
      desktopItemsPerRow: desktopItemsPerRow,
      tvItemsPerRow: tvItemsPerRow,
      spacing: spacing,
      runSpacing: runSpacing,
      children: labels.map((label) {
        final isSelected = selectedLabels.contains(label);

        if (chipBuilder != null) {
          return chipBuilder!(context, label, isSelected);
        }

        return GestureDetector(
          onTap: onSelected != null ? () => onSelected!(label) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF2196F3)
                  : const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF424242),
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
