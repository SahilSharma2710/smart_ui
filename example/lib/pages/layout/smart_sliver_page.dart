import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartSliver widgets
class SmartSliverPage extends StatefulWidget {
  const SmartSliverPage({super.key});

  @override
  State<SmartSliverPage> createState() => _SmartSliverPageState();
}

class _SmartSliverPageState extends State<SmartSliverPage> {
  // Grid configuration
  int _mobileColumns = 2;
  int _tabletColumns = 3;
  int _desktopColumns = 4;
  double _mainAxisSpacing = 16.0;
  double _crossAxisSpacing = 16.0;
  double _childAspectRatio = 1.0;
  int _itemCount = 12;

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
              'SmartSliver',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'Responsive sliver widgets for use in CustomScrollView. Includes SmartSliverGrid, SliverSmartPadding, SliverSmartVisible, and SliverSmartList.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartSliverGrid Section
            SectionHeader(
              title: 'SmartSliverGrid',
              subtitle: 'Responsive grid that adjusts columns per breakpoint',
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
                        label: 'Mobile Columns',
                        value: _mobileColumns.toDouble(),
                        min: 1,
                        max: 4,
                        divisions: 3,
                        valueLabel: '$_mobileColumns',
                        onChanged: (value) =>
                            setState(() => _mobileColumns = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Tablet Columns',
                        value: _tabletColumns.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        valueLabel: '$_tabletColumns',
                        onChanged: (value) =>
                            setState(() => _tabletColumns = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Desktop Columns',
                        value: _desktopColumns.toDouble(),
                        min: 1,
                        max: 6,
                        divisions: 5,
                        valueLabel: '$_desktopColumns',
                        onChanged: (value) =>
                            setState(() => _desktopColumns = value.toInt()),
                      ),
                      const Divider(),
                      SliderControl(
                        label: 'Item Count',
                        value: _itemCount.toDouble(),
                        min: 4,
                        max: 24,
                        divisions: 5,
                        valueLabel: '$_itemCount',
                        onChanged: (value) =>
                            setState(() => _itemCount = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Main Axis Spacing',
                        value: _mainAxisSpacing,
                        min: 0,
                        max: 32,
                        divisions: 8,
                        valueLabel: '${_mainAxisSpacing.toInt()}px',
                        onChanged: (value) =>
                            setState(() => _mainAxisSpacing = value),
                      ),
                      SliderControl(
                        label: 'Cross Axis Spacing',
                        value: _crossAxisSpacing,
                        min: 0,
                        max: 32,
                        divisions: 8,
                        valueLabel: '${_crossAxisSpacing.toInt()}px',
                        onChanged: (value) =>
                            setState(() => _crossAxisSpacing = value),
                      ),
                      SliderControl(
                        label: 'Aspect Ratio',
                        value: _childAspectRatio,
                        min: 0.5,
                        max: 2.0,
                        divisions: 6,
                        valueLabel: _childAspectRatio.toStringAsFixed(1),
                        onChanged: (value) =>
                            setState(() => _childAspectRatio = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _SliverGridDemo(
                    mobileColumns: _mobileColumns,
                    tabletColumns: _tabletColumns,
                    desktopColumns: _desktopColumns,
                    mainAxisSpacing: _mainAxisSpacing,
                    crossAxisSpacing: _crossAxisSpacing,
                    childAspectRatio: _childAspectRatio,
                    itemCount: _itemCount,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getSliverGridCode(),
              title: 'sliver_grid_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SliverSmartPadding Section
            SectionHeader(
              title: 'SliverSmartPadding',
              subtitle: 'Apply responsive padding to slivers',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _SliverPaddingDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SliverSmartVisible Section
            SectionHeader(
              title: 'SliverSmartVisible',
              subtitle: 'Conditionally show slivers based on breakpoints',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _SliverVisibleDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SliverSmartList Section
            SectionHeader(
              title: 'SliverSmartList',
              subtitle: 'Build different list items per breakpoint',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _SliverListDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Complete Example
            SectionHeader(
              title: 'Complete CustomScrollView Example',
              subtitle: 'Combining multiple sliver widgets',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _CompleteExample(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartSliverGrid parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getSliverGridCode() {
    return '''CustomScrollView(
  slivers: [
    SmartSliverGrid(
      mobileColumns: $_mobileColumns,
      tabletColumns: $_tabletColumns,
      desktopColumns: $_desktopColumns,
      mainAxisSpacing: $_mainAxisSpacing,
      crossAxisSpacing: $_crossAxisSpacing,
      childAspectRatio: $_childAspectRatio,
      children: List.generate($_itemCount, (index) => GridItem(index)),
    ),
  ],
)''';
  }
}

class _SliverGridDemo extends StatelessWidget {
  const _SliverGridDemo({
    required this.mobileColumns,
    required this.tabletColumns,
    required this.desktopColumns,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childAspectRatio,
    required this.itemCount,
  });

  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        child: Column(
          children: [
            // Breakpoint indicator
            BreakpointBuilder(
              builder: (context, breakpoint) {
                final color = PlaygroundTheme.colorForBreakpoint(breakpoint.name);
                final columns = switch (breakpoint) {
                  SmartBreakpoint.mobile => mobileColumns,
                  SmartBreakpoint.tablet => tabletColumns,
                  SmartBreakpoint.desktop => desktopColumns,
                  _ => mobileColumns,
                };
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    border: Border(
                      bottom: BorderSide(
                        color: color.withValues(alpha: 0.3),
                      ),
                    ),
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
                        '${breakpoint.name.toUpperCase()}: $columns columns',
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
            // Sliver Grid
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                    sliver: SmartSliverGrid(
                      mobileColumns: mobileColumns,
                      tabletColumns: tabletColumns,
                      desktopColumns: desktopColumns,
                      mainAxisSpacing: mainAxisSpacing,
                      crossAxisSpacing: crossAxisSpacing,
                      childAspectRatio: childAspectRatio,
                      children: List.generate(
                        itemCount,
                        (index) => _GridItem(index: index + 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grid_view, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              '$index',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverPaddingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            child: CustomScrollView(
              slivers: [
                SliverSmartPadding(
                  mobile: const EdgeInsets.all(8),
                  tablet: const EdgeInsets.all(16),
                  desktop: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: BreakpointBuilder(
                      builder: (context, breakpoint) {
                        final padding = switch (breakpoint) {
                          SmartBreakpoint.mobile => '8px',
                          SmartBreakpoint.tablet => '16px',
                          SmartBreakpoint.desktop => '24px',
                          _ => '8px',
                        };
                        final color =
                            PlaygroundTheme.colorForBreakpoint(breakpoint.name);
                        return Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(PlaygroundTheme.radiusMd),
                            border: Border.all(
                              color: color.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  PlaygroundTheme.iconForBreakpoint(
                                      breakpoint.name),
                                  size: 32,
                                  color: color,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Padding: $padding',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Resize to see padding change',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: color.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// EdgeInsets-based padding
SliverSmartPadding(
  mobile: EdgeInsets.all(8),
  tablet: EdgeInsets.all(16),
  desktop: EdgeInsets.all(24),
  sliver: SliverList(...),
)

// Token-based padding
SliverSmartPadding.all(
  SpacingSize.md,
  sliver: SliverGrid(...),
)

// Responsive token padding
SliverSmartPadding.responsive(
  mobileToken: SpacingSize.sm,
  tabletToken: SpacingSize.md,
  desktopToken: SpacingSize.lg,
  sliver: SliverGrid(...),
)''',
          title: 'sliver_padding_example.dart',
        ),
      ],
    );
  }
}

class _SliverVisibleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BreakpointBuilder(
                          builder: (context, breakpoint) {
                            final isDesktop =
                                breakpoint == SmartBreakpoint.desktop ||
                                    breakpoint == SmartBreakpoint.tv;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _VisibilityIndicator(
                                  label: 'Desktop Banner',
                                  visibleOn: 'desktop, tv',
                                  isVisible: isDesktop,
                                ),
                                const SizedBox(height: 8),
                                _VisibilityIndicator(
                                  label: 'Mobile Compact View',
                                  visibleOn: 'watch, mobile',
                                  isVisible: breakpoint == SmartBreakpoint.watch ||
                                      breakpoint == SmartBreakpoint.mobile,
                                ),
                                const SizedBox(height: 8),
                                _VisibilityIndicator(
                                  label: 'Tablet+ Features',
                                  visibleOn: 'tablet, desktop, tv',
                                  isVisible:
                                      breakpoint != SmartBreakpoint.watch &&
                                          breakpoint != SmartBreakpoint.mobile,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Show only on specific breakpoints
SliverSmartVisible.on(
  breakpoints: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
  sliver: SliverToBoxAdapter(child: DesktopBanner()),
)

// Hide on specific breakpoints
SliverSmartVisible.except(
  breakpoints: [SmartBreakpoint.watch, SmartBreakpoint.mobile],
  sliver: SliverGrid(...),
)

// With replacement sliver
SliverSmartVisible(
  visibleOn: [SmartBreakpoint.desktop],
  sliver: DesktopSliver(),
  replacement: MobileSliver(),
)''',
          title: 'sliver_visible_example.dart',
        ),
      ],
    );
  }
}

class _VisibilityIndicator extends StatelessWidget {
  const _VisibilityIndicator({
    required this.label,
    required this.visibleOn,
    required this.isVisible,
  });

  final String label;
  final String visibleOn;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final color = isVisible ? PlaygroundTheme.success : PlaygroundTheme.error;

    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                Text(
                  'Visible on: $visibleOn',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textMutedColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              isVisible ? 'VISIBLE' : 'HIDDEN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            child: CustomScrollView(
              slivers: [
                SliverSmartList(
                  itemCount: 5,
                  mobile: (context, index) => _MobileListItem(index: index),
                  desktop: (context, index) => _DesktopListItem(index: index),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SliverSmartList(
  itemCount: items.length,
  mobile: (context, index) => MobileItemTile(items[index]),
  tablet: (context, index) => TabletItemCard(items[index]),
  desktop: (context, index) => DesktopItemRow(items[index]),
)''',
          title: 'sliver_list_example.dart',
        ),
      ],
    );
  }
}

class _MobileListItem extends StatelessWidget {
  const _MobileListItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: PlaygroundTheme.mobileColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: PlaygroundTheme.mobileColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile Item ${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                Text(
                  'Compact list tile layout',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textMutedColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: context.textMutedColor,
          ),
        ],
      ),
    );
  }
}

class _DesktopListItem extends StatelessWidget {
  const _DesktopListItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(
          color: PlaygroundTheme.desktopColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  PlaygroundTheme.desktopColor.withValues(alpha: 0.2),
                  PlaygroundTheme.desktopColor.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: PlaygroundTheme.desktopColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Desktop Item ${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Expanded card layout with more details and actions',
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            onPressed: () {},
            child: const Text('View'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}

class _CompleteExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CodePreview(
      code: '''CustomScrollView(
  slivers: [
    // Responsive app bar padding
    SliverSmartPadding.responsive(
      mobileToken: SpacingSize.sm,
      desktopToken: SpacingSize.lg,
      sliver: SliverAppBar(
        title: Text('Products'),
        floating: true,
      ),
    ),

    // Desktop-only banner
    SliverSmartVisible.on(
      breakpoints: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
      sliver: SliverToBoxAdapter(
        child: PromoBanner(),
      ),
    ),

    // Responsive grid
    SliverSmartPadding(
      mobile: EdgeInsets.all(8),
      tablet: EdgeInsets.all(16),
      desktop: EdgeInsets.all(24),
      sliver: SmartSliverGrid(
        mobileColumns: 2,
        tabletColumns: 3,
        desktopColumns: 4,
        children: products.map((p) => ProductCard(p)).toList(),
      ),
    ),

    // Responsive list with different layouts
    SliverSmartList(
      itemCount: reviews.length,
      mobile: (context, index) => CompactReviewTile(reviews[index]),
      desktop: (context, index) => ExpandedReviewCard(reviews[index]),
    ),
  ],
)''',
      title: 'complete_example.dart',
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
            param: 'watchColumns',
            type: 'int',
            description: 'Columns on watch screens (default: 1)',
          ),
          _ApiRow(
            param: 'mobileColumns',
            type: 'int',
            description: 'Columns on mobile screens (default: 2)',
          ),
          _ApiRow(
            param: 'tabletColumns',
            type: 'int',
            description: 'Columns on tablet screens (default: 3)',
          ),
          _ApiRow(
            param: 'desktopColumns',
            type: 'int',
            description: 'Columns on desktop screens (default: 4)',
          ),
          _ApiRow(
            param: 'tvColumns',
            type: 'int',
            description: 'Columns on TV screens (default: 5)',
          ),
          _ApiRow(
            param: 'mainAxisSpacing',
            type: 'double',
            description: 'Vertical spacing between items (default: 16)',
          ),
          _ApiRow(
            param: 'crossAxisSpacing',
            type: 'double',
            description: 'Horizontal spacing between items (default: 16)',
          ),
          _ApiRow(
            param: 'childAspectRatio',
            type: 'double',
            description: 'Width/height ratio of children (default: 1.0)',
          ),
          _ApiRow(
            param: 'mainAxisExtent',
            type: 'double?',
            description: 'Fixed height for children (overrides aspectRatio)',
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
            width: 150,
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
            width: 100,
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
