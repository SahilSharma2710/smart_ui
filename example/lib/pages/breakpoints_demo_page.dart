import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

class BreakpointsDemoPage extends StatelessWidget {
  const BreakpointsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsive(
        mobile: SmartSpacing.md,
        tablet: SmartSpacing.lg,
        desktop: SmartSpacing.xl,
      )),
      child: SmartContainer(
        maxWidth: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const VGap.xl(),
            _buildCurrentBreakpointInfo(context),
            const VGap.xl(),
            _buildBreakpointScale(context),
            const VGap.xl(),
            _buildOrientationInfo(context),
            const VGap.xl(),
            _buildBreakpointComparison(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText(
          'Breakpoints',
          style: TypographyStyle.headlineMedium,
        ),
        const VGap.sm(),
        SmartText(
          'adaptive_kit uses a five-tier breakpoint system: watch, mobile, tablet, desktop, and TV. '
          'Resize your window to see breakpoints change in real-time.',
          style: TypographyStyle.bodyLarge,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _buildCurrentBreakpointInfo(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        final breakpointColor = _getBreakpointColor(info.breakpoint);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SmartSpacing.md,
                        vertical: SmartSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: breakpointColor.withOpacity(0.2),
                        borderRadius: SmartRadius.md,
                        border: Border.all(color: breakpointColor, width: 2),
                      ),
                      child: Text(
                        info.breakpoint.name.toUpperCase(),
                        style: SmartTypography.titleLarge.copyWith(
                          color: breakpointColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const HGap.lg(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmartText(
                            'Current Breakpoint',
                            style: TypographyStyle.labelMedium,
                          ),
                          SmartText(
                            _getBreakpointDescription(info.breakpoint),
                            style: TypographyStyle.bodySmall,
                            textColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const VGap.lg(),
                const Divider(),
                const VGap.md(),
                SmartGrid(
                  columns: 12,
                  spacing: SmartSpacing.md,
                  runSpacing: SmartSpacing.md,
                  children: [
                    SmartCol(
                      mobile: 6,
                      tablet: 3,
                      desktop: 3,
                      child: _InfoTile(
                        label: 'Width',
                        value: '${info.screenWidth.toInt()}px',
                        icon: Icons.width_normal,
                      ),
                    ),
                    SmartCol(
                      mobile: 6,
                      tablet: 3,
                      desktop: 3,
                      child: _InfoTile(
                        label: 'Height',
                        value: '${info.screenHeight.toInt()}px',
                        icon: Icons.height,
                      ),
                    ),
                    SmartCol(
                      mobile: 6,
                      tablet: 3,
                      desktop: 3,
                      child: _InfoTile(
                        label: 'Aspect Ratio',
                        value: info.aspectRatio.toStringAsFixed(2),
                        icon: Icons.aspect_ratio,
                      ),
                    ),
                    SmartCol(
                      mobile: 6,
                      tablet: 3,
                      desktop: 3,
                      child: _InfoTile(
                        label: 'Orientation',
                        value: info.isPortrait ? 'Portrait' : 'Landscape',
                        icon: info.isPortrait
                            ? Icons.stay_current_portrait
                            : Icons.stay_current_landscape,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBreakpointScale(BuildContext context) {
    final breakpoints = SmartBreakpoints.defaults;
    final breakpointData = [
      ('watch', breakpoints.watch, breakpoints.mobile - 1, Colors.purple),
      ('mobile', breakpoints.mobile, breakpoints.tablet - 1, Colors.blue),
      ('tablet', breakpoints.tablet, breakpoints.desktop - 1, Colors.green),
      ('desktop', breakpoints.desktop, breakpoints.tv - 1, Colors.orange),
      ('tv', breakpoints.tv, double.infinity, Colors.red),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Breakpoint Scale', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Default breakpoint thresholds used by adaptive_kit',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        ...breakpointData.map((data) {
          final (name, min, max, color) = data;
          final maxText = max == double.infinity ? '+' : '${max.toInt()}px';

          return ResponsiveBuilder(
            builder: (context, info) {
              final isActive = info.breakpoint.name == name;

              return Padding(
                padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(SmartSpacing.md),
                  decoration: BoxDecoration(
                    color: isActive
                        ? color.withOpacity(0.15)
                        : Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withOpacity(0.5),
                    borderRadius: SmartRadius.md,
                    border: Border.all(
                      color: isActive ? color : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(
                          horizontal: SmartSpacing.sm,
                          vertical: SmartSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: SmartRadius.sm,
                        ),
                        child: Text(
                          name.toUpperCase(),
                          style: SmartTypography.labelMedium.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const HGap.md(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${min.toInt()}px - $maxText',
                              style: SmartTypography.bodyMedium.copyWith(
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            Text(
                              _getBreakpointDescription(SmartBreakpoint.values
                                  .firstWhere((b) => b.name == name)),
                              style: SmartTypography.bodySmall.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SmartSpacing.sm,
                            vertical: SmartSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: SmartRadius.full,
                          ),
                          child: Text(
                            'ACTIVE',
                            style: SmartTypography.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildOrientationInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Orientation Detection',
            style: TypographyStyle.titleLarge),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(SmartSpacing.lg),
                    decoration: BoxDecoration(
                      color: context.isPortrait
                          ? Colors.blue.withOpacity(0.1)
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: SmartRadius.md,
                      border: Border.all(
                        color: context.isPortrait
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.stay_current_portrait,
                          size: 48,
                          color: context.isPortrait
                              ? Colors.blue
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const VGap.sm(),
                        SmartText(
                          'Portrait',
                          style: TypographyStyle.titleMedium,
                          textColor: context.isPortrait ? Colors.blue : null,
                        ),
                        SmartText(
                          'Height > Width',
                          style: TypographyStyle.bodySmall,
                          textColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
                const HGap.md(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(SmartSpacing.lg),
                    decoration: BoxDecoration(
                      color: context.isLandscape
                          ? Colors.green.withOpacity(0.1)
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: SmartRadius.md,
                      border: Border.all(
                        color: context.isLandscape
                            ? Colors.green
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.stay_current_landscape,
                          size: 48,
                          color: context.isLandscape
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const VGap.sm(),
                        SmartText(
                          'Landscape',
                          style: TypographyStyle.titleMedium,
                          textColor: context.isLandscape ? Colors.green : null,
                        ),
                        SmartText(
                          'Width > Height',
                          style: TypographyStyle.bodySmall,
                          textColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreakpointComparison(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Breakpoint Checks', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Use context extensions for quick breakpoint checks',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              children: [
                _CheckRow(label: 'context.isWatch', value: context.isWatch),
                _CheckRow(label: 'context.isMobile', value: context.isMobile),
                _CheckRow(label: 'context.isTablet', value: context.isTablet),
                _CheckRow(label: 'context.isDesktop', value: context.isDesktop),
                _CheckRow(label: 'context.isTv', value: context.isTv),
                const Divider(height: SmartSpacing.lg),
                _CheckRow(
                    label: 'context.isMobileOrSmaller',
                    value: context.isMobileOrSmaller),
                _CheckRow(
                    label: 'context.isTabletOrLarger',
                    value: context.isTabletOrLarger),
                _CheckRow(
                    label: 'context.isDesktopOrLarger',
                    value: context.isDesktopOrLarger),
              ],
            ),
          ),
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

  String _getBreakpointDescription(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.watch => 'Wearables and very small screens',
      SmartBreakpoint.mobile => 'Phones and small devices',
      SmartBreakpoint.tablet => 'Tablets and medium screens',
      SmartBreakpoint.desktop => 'Desktop and laptop screens',
      SmartBreakpoint.tv => 'Large screens and TVs',
    };
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SmartSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: SmartRadius.md,
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
          const VGap.sm(),
          SmartText(value, style: TypographyStyle.titleMedium),
          SmartText(
            label,
            style: TypographyStyle.labelSmall,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({required this.label, required this.value});

  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SmartSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: SmartTypography.bodyMedium.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SmartSpacing.sm,
              vertical: SmartSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: value
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: SmartRadius.sm,
            ),
            child: Text(
              value ? 'true' : 'false',
              style: SmartTypography.labelMedium.copyWith(
                color: value ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
