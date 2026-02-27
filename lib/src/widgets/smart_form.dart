/// Responsive form layout widget.
///
/// This module provides a form layout widget that automatically
/// adjusts columns based on the current breakpoint.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/spacing.dart';

/// A responsive form layout that automatically adjusts columns per breakpoint.
///
/// Use [SmartForm] to create forms that display:
/// - 1 column on mobile
/// - 2 columns on tablet
/// - 3 columns on desktop
///
/// Example:
/// ```dart
/// SmartForm(
///   children: [
///     SmartFormField(child: TextField(decoration: InputDecoration(labelText: 'Name'))),
///     SmartFormField(child: TextField(decoration: InputDecoration(labelText: 'Email'))),
///     SmartFormField(child: TextField(decoration: InputDecoration(labelText: 'Phone'))),
///     SmartFormField(
///       span: 2, // Takes 2 columns on tablet/desktop
///       child: TextField(decoration: InputDecoration(labelText: 'Address')),
///     ),
///   ],
/// )
/// ```
///
/// With custom column counts:
/// ```dart
/// SmartForm(
///   mobileColumns: 1,
///   tabletColumns: 3,
///   desktopColumns: 4,
///   children: [...],
/// )
/// ```
class SmartForm extends StatelessWidget {
  /// Creates a [SmartForm] widget.
  const SmartForm({
    required this.children,
    super.key,
    this.watchColumns = 1,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.tvColumns = 4,
    this.spacing = SpacingSize.md,
    this.runSpacing = SpacingSize.md,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.padding,
  });

  /// The form fields to display.
  final List<SmartFormField> children;

  /// Number of columns on watch-sized screens.
  final int watchColumns;

  /// Number of columns on mobile-sized screens.
  final int mobileColumns;

  /// Number of columns on tablet-sized screens.
  final int tabletColumns;

  /// Number of columns on desktop-sized screens.
  final int desktopColumns;

  /// Number of columns on TV-sized screens.
  final int tvColumns;

  /// The spacing between columns.
  final SpacingSize spacing;

  /// The spacing between rows.
  final SpacingSize runSpacing;

  /// How the children should be aligned within a row.
  final WrapCrossAlignment crossAxisAlignment;

  /// Optional padding around the form.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(screenWidth);

    final columns = _resolveColumns(breakpoint);
    final spacingValue = config.spacingTokens.fromSize(spacing);
    final runSpacingValue = config.spacingTokens.fromSize(runSpacing);

    Widget form = LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final totalSpacing = spacingValue * (columns - 1);
        final columnWidth = (availableWidth - totalSpacing) / columns;

        return Wrap(
          spacing: spacingValue,
          runSpacing: runSpacingValue,
          crossAxisAlignment: crossAxisAlignment,
          children: children.map((field) {
            final effectiveSpan = field.span.clamp(1, columns);
            final fieldWidth =
                (columnWidth * effectiveSpan) + (spacingValue * (effectiveSpan - 1));

            return SizedBox(
              width: fieldWidth,
              child: field.child,
            );
          }).toList(),
        );
      },
    );

    if (padding != null) {
      form = Padding(padding: padding!, child: form);
    }

    return form;
  }

  int _resolveColumns(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.tv => tvColumns,
      SmartBreakpoint.desktop => desktopColumns,
      SmartBreakpoint.tablet => tabletColumns,
      SmartBreakpoint.mobile => mobileColumns,
      SmartBreakpoint.watch => watchColumns,
    };
  }
}

/// A form field wrapper for use with [SmartForm].
///
/// Use [SmartFormField] to wrap individual form fields and optionally
/// specify how many columns they should span.
///
/// Example:
/// ```dart
/// SmartFormField(
///   span: 2, // Takes 2 columns
///   child: TextField(decoration: InputDecoration(labelText: 'Full Address')),
/// )
/// ```
class SmartFormField extends StatelessWidget {
  /// Creates a [SmartFormField] widget.
  const SmartFormField({
    required this.child,
    super.key,
    this.span = 1,
  }) : assert(span >= 1, 'span must be at least 1');

  /// The number of columns this field should span.
  ///
  /// If the span exceeds the available columns for the current
  /// breakpoint, it will be clamped to the maximum columns.
  final int span;

  /// The form field widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

/// A responsive form row that groups fields together.
///
/// Use [SmartFormRow] when you need more control over how fields
/// are grouped together within a form.
///
/// Example:
/// ```dart
/// SmartFormRow(
///   children: [
///     Expanded(child: TextField(decoration: InputDecoration(labelText: 'First Name'))),
///     SizedBox(width: 16),
///     Expanded(child: TextField(decoration: InputDecoration(labelText: 'Last Name'))),
///   ],
/// )
/// ```
class SmartFormRow extends StatelessWidget {
  /// Creates a [SmartFormRow] widget.
  const SmartFormRow({
    required this.children,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
  });

  /// The widgets to display in the row.
  final List<Widget> children;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

/// A responsive form section with an optional title.
///
/// Use [SmartFormSection] to group related form fields together
/// with a title and optional description.
///
/// Example:
/// ```dart
/// SmartFormSection(
///   title: 'Personal Information',
///   description: 'Enter your personal details below.',
///   children: [
///     SmartFormField(child: TextField(decoration: InputDecoration(labelText: 'Name'))),
///     SmartFormField(child: TextField(decoration: InputDecoration(labelText: 'Email'))),
///   ],
/// )
/// ```
class SmartFormSection extends StatelessWidget {
  /// Creates a [SmartFormSection] widget.
  const SmartFormSection({
    required this.children,
    super.key,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
    this.watchColumns = 1,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.tvColumns = 4,
    this.spacing = SpacingSize.md,
    this.runSpacing = SpacingSize.md,
    this.sectionSpacing = SpacingSize.lg,
  });

  /// The form fields in this section.
  final List<SmartFormField> children;

  /// Optional title for the section.
  final String? title;

  /// The text style for the title.
  final TextStyle? titleStyle;

  /// Optional description for the section.
  final String? description;

  /// The text style for the description.
  final TextStyle? descriptionStyle;

  /// Number of columns on watch-sized screens.
  final int watchColumns;

  /// Number of columns on mobile-sized screens.
  final int mobileColumns;

  /// Number of columns on tablet-sized screens.
  final int tabletColumns;

  /// Number of columns on desktop-sized screens.
  final int desktopColumns;

  /// Number of columns on TV-sized screens.
  final int tvColumns;

  /// The spacing between columns.
  final SpacingSize spacing;

  /// The spacing between rows.
  final SpacingSize runSpacing;

  /// The spacing below the title/description.
  final SpacingSize sectionSpacing;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final sectionSpacingValue = config.spacingTokens.fromSize(sectionSpacing);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (description != null) ...[
            SizedBox(height: config.spacingTokens.fromSize(SpacingSize.xs)),
            Text(
              description!,
              style: descriptionStyle ??
                  TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF666666).withValues(alpha: 0.8),
                  ),
            ),
          ],
          SizedBox(height: sectionSpacingValue),
        ],
        SmartForm(
          watchColumns: watchColumns,
          mobileColumns: mobileColumns,
          tabletColumns: tabletColumns,
          desktopColumns: desktopColumns,
          tvColumns: tvColumns,
          spacing: spacing,
          runSpacing: runSpacing,
          children: children,
        ),
      ],
    );
  }
}
