import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/premium_theme.dart';
import '../widgets/premium_widgets.dart';

class LayoutDemoPage extends StatelessWidget {
  const LayoutDemoPage({super.key});

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
            StaggeredFadeIn(index: 1, child: _buildSmartLayoutDemo(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 2, child: _buildResponsiveBuilderDemo(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 3, child: _buildBreakpointObserverDemo(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return PremiumPageHeader(
      icon: Icons.view_quilt_rounded,
      title: 'Responsive Layouts',
      subtitle:
          'SmartLayout provides declarative layout switching based on breakpoints. '
          'Define different layouts for each screen size and the widget handles the rest.',
      trailing: const BreakpointIndicator(),
    );
  }

  Widget _buildSmartLayoutDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('SmartLayout Demo', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Resize your window to see different layouts for mobile, tablet, and desktop',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          clipBehavior: Clip.antiAlias,
          child: SmartLayout(
            mobile: _MobileLayout(),
            tablet: _TabletLayout(),
            desktop: _DesktopLayout(),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveBuilderDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('ResponsiveBuilder', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Access detailed responsive information in your builder',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        ResponsiveBuilder(
          builder: (context, info) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(SmartSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const HGap.sm(),
                        const SmartText(
                          'ResponsiveInfo Properties',
                          style: TypographyStyle.titleMedium,
                        ),
                      ],
                    ),
                    const VGap.md(),
                    Wrap(
                      spacing: SmartSpacing.sm,
                      runSpacing: SmartSpacing.sm,
                      children: [
                        _InfoChip(
                          label: 'breakpoint',
                          value: info.breakpoint.name,
                        ),
                        _InfoChip(
                          label: 'screenWidth',
                          value: '${info.screenWidth.toInt()}',
                        ),
                        _InfoChip(
                          label: 'screenHeight',
                          value: '${info.screenHeight.toInt()}',
                        ),
                        _InfoChip(
                          label: 'isPortrait',
                          value: '${info.isPortrait}',
                        ),
                        _InfoChip(
                          label: 'aspectRatio',
                          value: info.aspectRatio.toStringAsFixed(2),
                        ),
                      ],
                    ),
                    const VGap.md(),
                    Container(
                      padding: const EdgeInsets.all(SmartSpacing.md),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: SmartRadius.md,
                      ),
                      child: Text(
                        '''ResponsiveBuilder(
  builder: (context, info) {
    return Text('Breakpoint: \${info.breakpoint.name}');
  },
)''',
                        style: SmartTypography.bodySmall.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBreakpointObserverDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('BreakpointObserver',
            style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Only rebuilds when the breakpoint actually changes, not on every pixel',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        BreakpointObserver(
          builder: (context, breakpoint) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(SmartSpacing.md),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(SmartSpacing.md),
                      decoration: BoxDecoration(
                        color: _getBreakpointColor(breakpoint).withOpacity(0.2),
                        borderRadius: SmartRadius.md,
                      ),
                      child: Icon(
                        _getBreakpointIcon(breakpoint),
                        color: _getBreakpointColor(breakpoint),
                        size: 32,
                      ),
                    ),
                    const HGap.md(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmartText(
                            'Current: ${breakpoint.name.toUpperCase()}',
                            style: TypographyStyle.titleMedium,
                          ),
                          SmartText(
                            'This widget only rebuilds when breakpoint changes',
                            style: TypographyStyle.bodySmall,
                            textColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getBreakpointColor(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.watch => Colors.purple,
      SmartBreakpoint.mobile => Colors.blue,
      SmartBreakpoint.tablet => Colors.green,
      SmartBreakpoint.desktop => Colors.orange,
      SmartBreakpoint.tv => Colors.red,
    };
  }

  IconData _getBreakpointIcon(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.watch => Icons.watch,
      SmartBreakpoint.mobile => Icons.phone_android,
      SmartBreakpoint.tablet => Icons.tablet_android,
      SmartBreakpoint.desktop => Icons.desktop_windows,
      SmartBreakpoint.tv => Icons.tv,
    };
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SmartSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SmartSpacing.md,
              vertical: SmartSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: SmartRadius.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone_android, color: Colors.blue, size: 18),
                const HGap.sm(),
                Text(
                  'MOBILE LAYOUT',
                  style: SmartTypography.labelMedium.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const VGap.md(),
          const SmartText(
            'Single Column',
            style: TypographyStyle.titleMedium,
          ),
          const VGap.sm(),
          SmartText(
            'Content stacks vertically on mobile devices for optimal readability.',
            style: TypographyStyle.bodyMedium,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const VGap.md(),
          ...List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
              child: _DemoCard(
                title: 'Item ${index + 1}',
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SmartSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SmartSpacing.md,
              vertical: SmartSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: SmartRadius.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.tablet_android, color: Colors.green, size: 18),
                const HGap.sm(),
                Text(
                  'TABLET LAYOUT',
                  style: SmartTypography.labelMedium.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const VGap.md(),
          const SmartText(
            'Two Columns',
            style: TypographyStyle.titleMedium,
          ),
          const VGap.sm(),
          SmartText(
            'Content is arranged in two columns for better use of space.',
            style: TypographyStyle.bodyMedium,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const VGap.md(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
                      child: _DemoCard(
                        title: 'Left ${index + 1}',
                        color: Colors
                            .primaries[(index * 2) % Colors.primaries.length],
                      ),
                    );
                  }),
                ),
              ),
              const HGap.md(),
              Expanded(
                child: Column(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
                      child: _DemoCard(
                        title: 'Right ${index + 1}',
                        color: Colors.primaries[
                            (index * 2 + 1) % Colors.primaries.length],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SmartSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SmartSpacing.md,
              vertical: SmartSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: SmartRadius.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.desktop_windows,
                    color: Colors.orange, size: 18),
                const HGap.sm(),
                Text(
                  'DESKTOP LAYOUT',
                  style: SmartTypography.labelMedium.copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const VGap.md(),
          const SmartText(
            'Three Columns',
            style: TypographyStyle.titleMedium,
          ),
          const VGap.sm(),
          SmartText(
            'Content uses three columns to maximize the available screen space.',
            style: TypographyStyle.bodyMedium,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const VGap.md(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(3, (colIndex) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: colIndex == 0 ? 0 : SmartSpacing.sm,
                    right: colIndex == 2 ? 0 : SmartSpacing.sm,
                  ),
                  child: Column(
                    children: List.generate(2, (rowIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
                        child: _DemoCard(
                          title: 'Col ${colIndex + 1}, Row ${rowIndex + 1}',
                          color: Colors.primaries[(colIndex * 2 + rowIndex) %
                              Colors.primaries.length],
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SmartSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: SmartRadius.md,
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(title, style: TypographyStyle.titleSmall),
          const VGap.xs(),
          SmartText(
            'Sample content',
            style: TypographyStyle.bodySmall,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SmartSpacing.sm,
        vertical: SmartSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: SmartRadius.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: SmartTypography.labelSmall.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          Text(
            value,
            style: SmartTypography.labelMedium.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
