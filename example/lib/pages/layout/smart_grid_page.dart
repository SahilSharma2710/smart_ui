import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartGrid and SmartCol widgets
class SmartGridPage extends StatefulWidget {
  const SmartGridPage({super.key});

  @override
  State<SmartGridPage> createState() => _SmartGridPageState();
}

class _SmartGridPageState extends State<SmartGridPage> {
  // Grid configuration
  int _columns = 12;
  double _spacing = 16.0;
  int _itemCount = 6;

  // Column spans
  int _mobileSpan = 12;
  int _tabletSpan = 6;
  int _desktopSpan = 4;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsive(
        mobile: PlaygroundTheme.spaceMd,
        desktop: PlaygroundTheme.spaceLg,
      )),
      child: SmartContainer.lg(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'SmartGrid',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'A responsive 12-column grid system similar to Bootstrap or CSS Grid. Perfect for creating responsive layouts.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Adjust the controls to see how the grid responds',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            SmartGrid(
              spacing: SmartSpacing.md,
              children: [
                SmartCol(
                  mobile: 12,
                  desktop: 4,
                  child: InteractiveControls(
                    children: [
                      SliderControl(
                        label: 'Grid Columns',
                        value: _columns.toDouble(),
                        min: 4,
                        max: 12,
                        divisions: 8,
                        valueLabel: '$_columns cols',
                        onChanged: (value) =>
                            setState(() => _columns = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Spacing',
                        value: _spacing,
                        min: 0,
                        max: 32,
                        divisions: 8,
                        valueLabel: '${_spacing.toInt()}px',
                        onChanged: (value) => setState(() => _spacing = value),
                      ),
                      SliderControl(
                        label: 'Item Count',
                        value: _itemCount.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        valueLabel: '$_itemCount items',
                        onChanged: (value) =>
                            setState(() => _itemCount = value.toInt()),
                      ),
                      const Divider(),
                      Text(
                        'Column Spans',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: PlaygroundTheme.spaceSm),
                      SliderControl(
                        label: 'Mobile Span',
                        value: _mobileSpan.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        valueLabel: '$_mobileSpan / $_columns',
                        onChanged: (value) =>
                            setState(() => _mobileSpan = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Tablet Span',
                        value: _tabletSpan.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        valueLabel: '$_tabletSpan / $_columns',
                        onChanged: (value) =>
                            setState(() => _tabletSpan = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Desktop Span',
                        value: _desktopSpan.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        valueLabel: '$_desktopSpan / $_columns',
                        onChanged: (value) =>
                            setState(() => _desktopSpan = value.toInt()),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _GridDemo(
                    columns: _columns,
                    spacing: _spacing,
                    itemCount: _itemCount,
                    mobileSpan: _mobileSpan,
                    tabletSpan: _tabletSpan,
                    desktopSpan: _desktopSpan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getGridCode(),
              title: 'grid_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Visual Grid Section
            SectionHeader(
              title: '12-Column System Visualization',
              subtitle: 'See how the grid columns work',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _GridVisualization(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Mixed Spans Example
            SectionHeader(
              title: 'Mixed Column Spans',
              subtitle: 'Combine different spans for complex layouts',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _MixedSpansExample(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartCol Reference
            SectionHeader(
              title: 'SmartCol Widget',
              subtitle: 'Column wrapper with responsive span values',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: '''SmartCol(
  watch: 12,   // Full width on watch
  mobile: 12,  // Full width on mobile
  tablet: 6,   // Half width on tablet
  desktop: 4,  // Third width on desktop
  tv: 3,       // Quarter width on TV
  child: YourWidget(),
)''',
              title: 'smart_col.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Spacing Options
            SectionHeader(
              title: 'Spacing Options',
              subtitle: 'Control horizontal and vertical spacing',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _SpacingDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartGrid parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getGridCode() {
    return '''SmartGrid(
  columns: $_columns,
  spacing: $_spacing,
  children: [
    // $_itemCount items with responsive spans
    SmartCol(
      mobile: $_mobileSpan,
      tablet: $_tabletSpan,
      desktop: $_desktopSpan,
      child: Card(),
    ),
    // ... more items
  ],
)''';
  }
}

class _GridDemo extends StatelessWidget {
  const _GridDemo({
    required this.columns,
    required this.spacing,
    required this.itemCount,
    required this.mobileSpan,
    required this.tabletSpan,
    required this.desktopSpan,
  });

  final int columns;
  final double spacing;
  final int itemCount;
  final int mobileSpan;
  final int tabletSpan;
  final int desktopSpan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current breakpoint indicator
          BreakpointBuilder(
            builder: (context, breakpoint) {
              final color = PlaygroundTheme.colorForBreakpoint(breakpoint.name);
              final currentSpan = switch (breakpoint) {
                SmartBreakpoint.mobile => mobileSpan,
                SmartBreakpoint.tablet => tabletSpan,
                SmartBreakpoint.desktop => desktopSpan,
                _ => mobileSpan,
              };
              return Container(
                margin: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      PlaygroundTheme.iconForBreakpoint(breakpoint.name),
                      size: 16,
                      color: color,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Current: ${breakpoint.name.toUpperCase()} - Span: $currentSpan / $columns',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Grid
          SmartGrid(
            columns: columns,
            spacing: spacing,
            children: List.generate(
              itemCount,
              (index) => SmartCol(
                mobile: mobileSpan,
                tablet: tabletSpan,
                desktop: desktopSpan,
                child: _GridItem(index: index + 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = [
      PlaygroundTheme.primary,
      PlaygroundTheme.accent,
      PlaygroundTheme.success,
      PlaygroundTheme.warning,
      PlaygroundTheme.error,
      PlaygroundTheme.info,
    ];
    final color = colors[(index - 1) % colors.length];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(
          'Item $index',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _GridVisualization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column numbers
          Row(
            children: List.generate(
              12,
              (index) => Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      right: index < 11
                          ? BorderSide(
                              color: context.borderColor.withValues(alpha: 0.3),
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: context.textMutedColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          // Visual grid rows
          _VisualizationRow(spans: [12], label: 'span: 12 (full width)'),
          const SizedBox(height: 8),
          _VisualizationRow(spans: [6, 6], label: 'span: 6 (half width)'),
          const SizedBox(height: 8),
          _VisualizationRow(spans: [4, 4, 4], label: 'span: 4 (third width)'),
          const SizedBox(height: 8),
          _VisualizationRow(spans: [3, 3, 3, 3], label: 'span: 3 (quarter width)'),
          const SizedBox(height: 8),
          _VisualizationRow(spans: [8, 4], label: 'span: 8 + 4'),
          const SizedBox(height: 8),
          _VisualizationRow(spans: [3, 6, 3], label: 'span: 3 + 6 + 3'),
        ],
      ),
    );
  }
}

class _VisualizationRow extends StatelessWidget {
  const _VisualizationRow({required this.spans, required this.label});

  final List<int> spans;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: context.textMutedColor,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: spans.asMap().entries.map((entry) {
            final index = entry.key;
            final span = entry.value;
            final color = [
              PlaygroundTheme.primary,
              PlaygroundTheme.accent,
              PlaygroundTheme.success,
              PlaygroundTheme.warning,
            ][index % 4];

            return Expanded(
              flex: span,
              child: Container(
                height: 40,
                margin: EdgeInsets.only(
                  right: index < spans.length - 1 ? 4 : 0,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                  border: Border.all(color: color.withValues(alpha: 0.4)),
                ),
                child: Center(
                  child: Text(
                    '$span',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MixedSpansExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: SmartGrid(
            spacing: SmartSpacing.sm,
            children: [
              SmartCol(
                mobile: 12,
                tablet: 8,
                desktop: 8,
                child: _MixedItem(span: 'mobile: 12, tablet: 8', height: 100),
              ),
              SmartCol(
                mobile: 12,
                tablet: 4,
                desktop: 4,
                child: _MixedItem(span: 'mobile: 12, tablet: 4', height: 100),
              ),
              SmartCol(
                mobile: 6,
                tablet: 4,
                desktop: 3,
                child: _MixedItem(span: 'mobile: 6, tablet: 4, desktop: 3', height: 80),
              ),
              SmartCol(
                mobile: 6,
                tablet: 4,
                desktop: 3,
                child: _MixedItem(span: 'mobile: 6, tablet: 4, desktop: 3', height: 80),
              ),
              SmartCol(
                mobile: 6,
                tablet: 4,
                desktop: 3,
                child: _MixedItem(span: 'mobile: 6, tablet: 4, desktop: 3', height: 80),
              ),
              SmartCol(
                mobile: 6,
                tablet: 12,
                desktop: 3,
                child: _MixedItem(span: 'mobile: 6, tablet: 12, desktop: 3', height: 80),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartGrid(
  spacing: SmartSpacing.sm,
  children: [
    // Header: full width on mobile, 8 cols on tablet+
    SmartCol(
      mobile: 12,
      tablet: 8,
      child: HeaderCard(),
    ),
    // Sidebar: full width on mobile, 4 cols on tablet+
    SmartCol(
      mobile: 12,
      tablet: 4,
      child: SidebarCard(),
    ),
    // Cards: 2 per row on mobile, 3 on tablet, 4 on desktop
    SmartCol(
      mobile: 6,
      tablet: 4,
      desktop: 3,
      child: ProductCard(),
    ),
    // ... more cards
  ],
)''',
          title: 'mixed_spans.dart',
        ),
      ],
    );
  }
}

class _MixedItem extends StatelessWidget {
  const _MixedItem({required this.span, required this.height});

  final String span;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(PlaygroundTheme.spaceSm),
      decoration: BoxDecoration(
        color: PlaygroundTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(
          color: PlaygroundTheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Center(
        child: Text(
          span,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: PlaygroundTheme.primary,
          ),
        ),
      ),
    );
  }
}

class _SpacingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SmartSpacing Tokens',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _SpacingChip(name: 'xs', value: SmartSpacing.xs),
                  _SpacingChip(name: 'sm', value: SmartSpacing.sm),
                  _SpacingChip(name: 'md', value: SmartSpacing.md),
                  _SpacingChip(name: 'lg', value: SmartSpacing.lg),
                  _SpacingChip(name: 'xl', value: SmartSpacing.xl),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartGrid(
  spacing: SmartSpacing.md,  // Horizontal spacing (16px)
  runSpacing: SmartSpacing.lg, // Vertical spacing (24px)
  children: [...],
)''',
          title: 'spacing_example.dart',
        ),
      ],
    );
  }
}

class _SpacingChip extends StatelessWidget {
  const _SpacingChip({required this.name, required this.value});

  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: PlaygroundTheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${value.toInt()}px',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: context.textMutedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiReference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          _ApiRow(
            param: 'columns',
            type: 'int',
            description: 'Number of columns in the grid (default: 12)',
          ),
          _ApiRow(
            param: 'spacing',
            type: 'double',
            description: 'Horizontal spacing between columns (default: SmartSpacing.md)',
          ),
          _ApiRow(
            param: 'runSpacing',
            type: 'double?',
            description: 'Vertical spacing between rows (defaults to spacing)',
          ),
          _ApiRow(
            param: 'crossAxisAlignment',
            type: 'WrapCrossAlignment',
            description: 'How children align within each row',
          ),
          _ApiRow(
            param: 'alignment',
            type: 'WrapAlignment',
            description: 'How children are aligned within the grid',
          ),
          _ApiRow(
            param: 'children',
            type: 'List<Widget>',
            description: 'Grid columns (should be SmartCol widgets)',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({
    required this.param,
    required this.type,
    required this.description,
    this.isLast = false,
  });

  final String param;
  final String type;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: context.borderColor.withValues(alpha: 0.3),
                ),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              param,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: context.textMutedColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
