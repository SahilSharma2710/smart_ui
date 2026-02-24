import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/premium_theme.dart';
import '../widgets/premium_widgets.dart';

class TokensDemoPage extends StatelessWidget {
  const TokensDemoPage({super.key});

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
            StaggeredFadeIn(index: 0, child: _buildHeader(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 1, child: _buildTypographySection(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 2, child: _buildSpacingSection(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 3, child: _buildRadiusSection(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return PremiumPageHeader(
      icon: Icons.palette_rounded,
      title: 'Design Tokens',
      subtitle:
          'Consistent design tokens for typography, spacing, and border radius. '
          'Use these tokens to maintain visual consistency across your app.',
      trailing: const BreakpointIndicator(),
    );
  }

  Widget _buildTypographySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.text_fields,
              color: Theme.of(context).colorScheme.primary,
            ),
            const HGap.sm(),
            const SmartText('Typography Scale',
                style: TypographyStyle.titleLarge),
          ],
        ),
        const VGap.sm(),
        SmartText(
          '15 text styles following Material Design 3 typography scale',
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
                _TypographyCategory(
                  title: 'Display',
                  styles: [
                    ('displayLarge', TypographyStyle.displayLarge, '57px'),
                    ('displayMedium', TypographyStyle.displayMedium, '45px'),
                    ('displaySmall', TypographyStyle.displaySmall, '36px'),
                  ],
                ),
                const Divider(height: SmartSpacing.xl),
                _TypographyCategory(
                  title: 'Headline',
                  styles: [
                    ('headlineLarge', TypographyStyle.headlineLarge, '32px'),
                    ('headlineMedium', TypographyStyle.headlineMedium, '28px'),
                    ('headlineSmall', TypographyStyle.headlineSmall, '24px'),
                  ],
                ),
                const Divider(height: SmartSpacing.xl),
                _TypographyCategory(
                  title: 'Title',
                  styles: [
                    ('titleLarge', TypographyStyle.titleLarge, '22px'),
                    ('titleMedium', TypographyStyle.titleMedium, '16px'),
                    ('titleSmall', TypographyStyle.titleSmall, '14px'),
                  ],
                ),
                const Divider(height: SmartSpacing.xl),
                _TypographyCategory(
                  title: 'Body',
                  styles: [
                    ('bodyLarge', TypographyStyle.bodyLarge, '16px'),
                    ('bodyMedium', TypographyStyle.bodyMedium, '14px'),
                    ('bodySmall', TypographyStyle.bodySmall, '12px'),
                  ],
                ),
                const Divider(height: SmartSpacing.xl),
                _TypographyCategory(
                  title: 'Label',
                  styles: [
                    ('labelLarge', TypographyStyle.labelLarge, '14px'),
                    ('labelMedium', TypographyStyle.labelMedium, '12px'),
                    ('labelSmall', TypographyStyle.labelSmall, '11px'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.code, size: 18),
                    const HGap.sm(),
                    const SmartText('Usage', style: TypographyStyle.titleSmall),
                  ],
                ),
                const VGap.sm(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SmartSpacing.md),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: SmartRadius.md,
                  ),
                  child: Text(
                    '''// Using SmartText widget
SmartText('Hello', style: TypographyStyle.headlineLarge)

// Using SmartTypography directly
Text('Hello', style: SmartTypography.headlineLarge)

// Responsive typography
SmartText.responsive(
  'Hello',
  mobile: TypographyStyle.bodyMedium,
  desktop: TypographyStyle.headlineLarge,
)''',
                    style: SmartTypography.bodySmall.copyWith(
                      fontFamily: 'monospace',
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

  Widget _buildSpacingSection(BuildContext context) {
    final spacings = [
      ('zero', SmartSpacing.zero, '0px'),
      ('xs', SmartSpacing.xs, '4px'),
      ('sm', SmartSpacing.sm, '8px'),
      ('md', SmartSpacing.md, '16px'),
      ('lg', SmartSpacing.lg, '24px'),
      ('xl', SmartSpacing.xl, '32px'),
      ('xxl', SmartSpacing.xxl, '48px'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.space_bar,
              color: Theme.of(context).colorScheme.primary,
            ),
            const HGap.sm(),
            const SmartText('Spacing Scale', style: TypographyStyle.titleLarge),
          ],
        ),
        const VGap.sm(),
        SmartText(
          'Consistent spacing values for margins, padding, and gaps',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              children: spacings.map((item) {
                final (name, value, label) = item;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: SmartSpacing.sm),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          name,
                          style: SmartTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const HGap.md(),
                      Expanded(
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            borderRadius: SmartRadius.sm,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: value,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: SmartRadius.sm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const HGap.md(),
                      SizedBox(
                        width: 50,
                        child: Text(
                          label,
                          style: SmartTypography.labelSmall.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.code, size: 18),
                    const HGap.sm(),
                    const SmartText('Usage', style: TypographyStyle.titleSmall),
                  ],
                ),
                const VGap.sm(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SmartSpacing.md),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: SmartRadius.md,
                  ),
                  child: Text(
                    '''// Using SmartSpacing constants
EdgeInsets.all(SmartSpacing.md)  // 16px

// Using SmartGap widgets
VGap.md()  // 16px vertical gap
HGap.lg()  // 24px horizontal gap

// Using SmartPadding widget
SmartPadding.all(SpacingSize.md, child: ...)
SmartPadding.symmetric(
  horizontal: SpacingSize.lg,
  vertical: SpacingSize.md,
  child: ...,
)''',
                    style: SmartTypography.bodySmall.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const VGap.md(),
        const SmartText('Gap Widgets Demo', style: TypographyStyle.titleSmall),
        const VGap.sm(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Row(
              children: [
                _GapDemo(label: 'xs', gap: const HGap.xs()),
                _GapDemo(label: 'sm', gap: const HGap.sm()),
                _GapDemo(label: 'md', gap: const HGap.md()),
                _GapDemo(label: 'lg', gap: const HGap.lg()),
                _GapDemo(label: 'xl', gap: const HGap.xl()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadiusSection(BuildContext context) {
    final radii = [
      ('none', SmartRadius.none, '0px'),
      ('xs', SmartRadius.xs, '2px'),
      ('sm', SmartRadius.sm, '4px'),
      ('md', SmartRadius.md, '8px'),
      ('lg', SmartRadius.lg, '12px'),
      ('xl', SmartRadius.xl, '16px'),
      ('xxl', SmartRadius.xxl, '24px'),
      ('full', SmartRadius.full, '9999px'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.rounded_corner,
              color: Theme.of(context).colorScheme.primary,
            ),
            const HGap.sm(),
            const SmartText('Border Radius Scale',
                style: TypographyStyle.titleLarge),
          ],
        ),
        const VGap.sm(),
        SmartText(
          'Consistent border radius values for cards, buttons, and containers',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Wrap(
              spacing: SmartSpacing.lg,
              runSpacing: SmartSpacing.lg,
              children: radii.map((item) {
                final (name, radius, label) = item;
                return Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: radius,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.rounded_corner,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const VGap.sm(),
                    Text(
                      name,
                      style: SmartTypography.labelMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      label,
                      style: SmartTypography.labelSmall.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.code, size: 18),
                    const HGap.sm(),
                    const SmartText('Usage', style: TypographyStyle.titleSmall),
                  ],
                ),
                const VGap.sm(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SmartSpacing.md),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: SmartRadius.md,
                  ),
                  child: Text(
                    '''// Using SmartRadius constants
Container(
  decoration: BoxDecoration(
    borderRadius: SmartRadius.md,  // 8px
  ),
)

// Directional radius
SmartRadius.top(12)     // top corners only
SmartRadius.bottom(12)  // bottom corners only
SmartRadius.left(12)    // left corners only

// Custom corners
SmartRadius.only(
  topLeft: 8,
  bottomRight: 8,
)''',
                    style: SmartTypography.bodySmall.copyWith(
                      fontFamily: 'monospace',
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
}

class _TypographyCategory extends StatelessWidget {
  const _TypographyCategory({
    required this.title,
    required this.styles,
  });

  final String title;
  final List<(String, TypographyStyle, String)> styles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SmartSpacing.sm,
            vertical: SmartSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: SmartRadius.sm,
          ),
          child: Text(
            title,
            style: SmartTypography.labelSmall.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VGap.md(),
        ...styles.map((item) {
          final (name, style, size) = item;
          return Padding(
            padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: SmartText(name, style: style),
                ),
                Text(
                  size,
                  style: SmartTypography.labelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _GapDemo extends StatelessWidget {
  const _GapDemo({
    required this.label,
    required this.gap,
  });

  final String label;
  final Widget gap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              gap,
              Container(
                width: 24,
                height: 24,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          const VGap.sm(),
          Text(
            label,
            style: SmartTypography.labelSmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
