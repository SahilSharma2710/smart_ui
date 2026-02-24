import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/premium_theme.dart';
import '../widgets/premium_widgets.dart';

class GridDemoPage extends StatefulWidget {
  const GridDemoPage({super.key});

  @override
  State<GridDemoPage> createState() => _GridDemoPageState();
}

class _GridDemoPageState extends State<GridDemoPage> {
  int _mobileSpan = 12;
  int _tabletSpan = 6;
  int _desktopSpan = 4;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsive(
        mobile: SmartSpacing.md,
        tablet: SmartSpacing.lg,
        desktop: SmartSpacing.xl,
      )),
      child: SmartContainer(
        maxWidth: 1400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StaggeredFadeIn(index: 0, child: _buildHeader(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 1, child: _buildInteractiveGrid(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 2, child: _buildFixedGrid(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 3, child: _buildProductGrid(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return PremiumPageHeader(
      icon: Icons.grid_view_rounded,
      title: 'Responsive Grid',
      subtitle:
          'SmartGrid provides a flexible 12-column grid system. '
          'Use SmartCol to define how many columns each child spans at different breakpoints.',
      trailing: const BreakpointIndicator(),
    );
  }

  Widget _buildInteractiveGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Interactive Grid', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Adjust the sliders to change column spans for each breakpoint',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              children: [
                _SliderRow(
                  label: 'Mobile Span',
                  value: _mobileSpan,
                  color: Colors.blue,
                  icon: Icons.phone_android,
                  onChanged: (value) => setState(() => _mobileSpan = value),
                ),
                const VGap.md(),
                _SliderRow(
                  label: 'Tablet Span',
                  value: _tabletSpan,
                  color: Colors.green,
                  icon: Icons.tablet_android,
                  onChanged: (value) => setState(() => _tabletSpan = value),
                ),
                const VGap.md(),
                _SliderRow(
                  label: 'Desktop Span',
                  value: _desktopSpan,
                  color: Colors.orange,
                  icon: Icons.desktop_windows,
                  onChanged: (value) => setState(() => _desktopSpan = value),
                ),
              ],
            ),
          ),
        ),
        const VGap.md(),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(SmartSpacing.sm),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Row(
                  children: [
                    const Icon(Icons.grid_on, size: 18),
                    const HGap.sm(),
                    const SmartText('12-Column Grid',
                        style: TypographyStyle.labelMedium),
                    const Spacer(),
                    ResponsiveBuilder(
                      builder: (context, info) {
                        final currentSpan = switch (info.breakpoint) {
                          SmartBreakpoint.watch ||
                          SmartBreakpoint.mobile =>
                            _mobileSpan,
                          SmartBreakpoint.tablet => _tabletSpan,
                          SmartBreakpoint.desktop ||
                          SmartBreakpoint.tv =>
                            _desktopSpan,
                        };
                        final columns = (12 / currentSpan).floor();
                        return Text(
                          '$columns items per row',
                          style: SmartTypography.labelSmall.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SmartSpacing.md),
                child: SmartGrid(
                  columns: 12,
                  spacing: SmartSpacing.md,
                  runSpacing: SmartSpacing.md,
                  children: List.generate(6, (index) {
                    return SmartCol(
                      mobile: _mobileSpan,
                      tablet: _tabletSpan,
                      desktop: _desktopSpan,
                      child: _GridItem(
                        index: index,
                        mobileSpan: _mobileSpan,
                        tabletSpan: _tabletSpan,
                        desktopSpan: _desktopSpan,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFixedGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Column Visualization',
            style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Visual representation of the 12-column grid',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartGrid(
                  columns: 12,
                  spacing: 4,
                  children: List.generate(12, (index) {
                    return SmartCol(
                      mobile: 1,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: SmartRadius.xs,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: SmartTypography.labelSmall.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const VGap.lg(),
                const SmartText('Common Span Patterns:',
                    style: TypographyStyle.labelMedium),
                const VGap.sm(),
                _SpanExample(spans: [12], label: 'span-12 (full width)'),
                _SpanExample(spans: [6, 6], label: 'span-6 (2 columns)'),
                _SpanExample(spans: [4, 4, 4], label: 'span-4 (3 columns)'),
                _SpanExample(spans: [3, 3, 3, 3], label: 'span-3 (4 columns)'),
                _SpanExample(spans: [8, 4], label: 'span-8 + span-4'),
                _SpanExample(
                    spans: [3, 6, 3], label: 'span-3 + span-6 + span-3'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Product Grid Example',
            style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Real-world example: mobile: 12, tablet: 6, desktop: 4',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        SmartGrid(
          columns: 12,
          spacing: SmartSpacing.md,
          runSpacing: SmartSpacing.md,
          children: List.generate(6, (index) {
            return SmartCol(
              mobile: 12,
              tablet: 6,
              desktop: 4,
              child: _ProductCard(index: index),
            );
          }),
        ),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    required this.onChanged,
  });

  final String label;
  final int value;
  final Color color;
  final IconData icon;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const HGap.sm(),
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: SmartTypography.labelMedium,
          ),
        ),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: 1,
            max: 12,
            divisions: 11,
            activeColor: color,
            onChanged: (v) => onChanged(v.round()),
          ),
        ),
        Container(
          width: 40,
          padding: const EdgeInsets.symmetric(
            horizontal: SmartSpacing.sm,
            vertical: SmartSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: SmartRadius.sm,
          ),
          child: Text(
            '$value',
            style: SmartTypography.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    required this.index,
    required this.mobileSpan,
    required this.tabletSpan,
    required this.desktopSpan,
  });

  final int index;
  final int mobileSpan;
  final int tabletSpan;
  final int desktopSpan;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    return Container(
      padding: const EdgeInsets.all(SmartSpacing.md),
      decoration: BoxDecoration(
        color: colors[index % colors.length].withOpacity(0.15),
        borderRadius: SmartRadius.md,
        border: Border.all(
          color: colors[index % colors.length].withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.widgets,
            color: colors[index % colors.length],
            size: 32,
          ),
          const VGap.sm(),
          SmartText(
            'Item ${index + 1}',
            style: TypographyStyle.titleSmall,
          ),
          const VGap.xs(),
          ResponsiveBuilder(
            builder: (context, info) {
              final span = switch (info.breakpoint) {
                SmartBreakpoint.watch || SmartBreakpoint.mobile => mobileSpan,
                SmartBreakpoint.tablet => tabletSpan,
                SmartBreakpoint.desktop || SmartBreakpoint.tv => desktopSpan,
              };
              return Text(
                'span: $span/12',
                style: SmartTypography.labelSmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SpanExample extends StatelessWidget {
  const _SpanExample({
    required this.spans,
    required this.label,
  });

  final List<int> spans;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: SmartTypography.labelSmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const VGap.xs(),
          SmartGrid(
            columns: 12,
            spacing: 4,
            children: spans.asMap().entries.map((entry) {
              final colors = [
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.purple
              ];
              return SmartCol(
                mobile: entry.value,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: colors[entry.key % colors.length].withOpacity(0.3),
                    borderRadius: SmartRadius.xs,
                  ),
                  child: Center(
                    child: Text(
                      '${entry.value}',
                      style: SmartTypography.labelSmall.copyWith(
                        color: colors[entry.key % colors.length],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: colors[index % colors.length].withOpacity(0.2),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 48,
                color: colors[index % colors.length],
              ),
            ),
          ),
          SmartPadding.all(
            SpacingSize.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(
                  'Product ${index + 1}',
                  style: TypographyStyle.titleMedium,
                ),
                const VGap.xs(),
                SmartText(
                  'A great product description goes here.',
                  style: TypographyStyle.bodySmall,
                  textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const VGap.sm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmartText(
                      '\$${(index + 1) * 29.99}',
                      style: TypographyStyle.titleLarge,
                      textColor: Theme.of(context).colorScheme.primary,
                    ),
                    SmartButton.filled(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
