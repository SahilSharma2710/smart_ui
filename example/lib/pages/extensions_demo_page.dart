import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

class ExtensionsDemoPage extends StatelessWidget {
  const ExtensionsDemoPage({super.key});

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
            _buildContextExtensionsDemo(context),
            const VGap.xl(),
            _buildResponsiveValueDemo(context),
            const VGap.xl(),
            _buildWidgetExtensionsDemo(context),
            const VGap.xl(),
            _buildNumberExtensionsDemo(context),
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
          'Extensions',
          style: TypographyStyle.headlineMedium,
        ),
        const VGap.sm(),
        SmartText(
          'Powerful context and widget extensions for cleaner, more expressive code.',
          style: TypographyStyle.bodyLarge,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _buildContextExtensionsDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Theme.of(context).colorScheme.primary),
            const HGap.sm(),
            const SmartText('Context Extensions',
                style: TypographyStyle.titleLarge),
          ],
        ),
        const VGap.sm(),
        SmartText(
          'Access screen info, breakpoints, and platform details via context',
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
                const SmartText('Screen Dimensions',
                    style: TypographyStyle.titleSmall),
                const VGap.sm(),
                _ExtensionRow(
                  name: 'context.screenWidth',
                  value: '${context.screenWidth.toInt()}',
                ),
                _ExtensionRow(
                  name: 'context.screenHeight',
                  value: '${context.screenHeight.toInt()}',
                ),
                _ExtensionRow(
                  name: 'context.aspectRatio',
                  value: context.aspectRatio.toStringAsFixed(2),
                ),
                _ExtensionRow(
                  name: 'context.devicePixelRatio',
                  value: context.devicePixelRatio.toStringAsFixed(2),
                ),
                const Divider(height: SmartSpacing.lg),
                const SmartText('Orientation',
                    style: TypographyStyle.titleSmall),
                const VGap.sm(),
                _ExtensionRow(
                  name: 'context.isPortrait',
                  value: '${context.isPortrait}',
                  isHighlighted: context.isPortrait,
                ),
                _ExtensionRow(
                  name: 'context.isLandscape',
                  value: '${context.isLandscape}',
                  isHighlighted: context.isLandscape,
                ),
                const Divider(height: SmartSpacing.lg),
                const SmartText('Breakpoint',
                    style: TypographyStyle.titleSmall),
                const VGap.sm(),
                _ExtensionRow(
                  name: 'context.breakpoint',
                  value: context.breakpoint.name,
                ),
                _ExtensionRow(
                  name: 'context.isMobileOrSmaller',
                  value: '${context.isMobileOrSmaller}',
                  isHighlighted: context.isMobileOrSmaller,
                ),
                _ExtensionRow(
                  name: 'context.isTabletOrLarger',
                  value: '${context.isTabletOrLarger}',
                  isHighlighted: context.isTabletOrLarger,
                ),
                const Divider(height: SmartSpacing.lg),
                const SmartText('Platform', style: TypographyStyle.titleSmall),
                const VGap.sm(),
                _ExtensionRow(
                  name: 'context.platform',
                  value: context.platform.name,
                ),
                _ExtensionRow(
                  name: 'context.usesMaterial',
                  value: '${context.usesMaterial}',
                  isHighlighted: context.usesMaterial,
                ),
                _ExtensionRow(
                  name: 'context.usesCupertino',
                  value: '${context.usesCupertino}',
                  isHighlighted: context.usesCupertino,
                ),
                _ExtensionRow(
                  name: 'context.isWeb',
                  value: '${context.isWeb}',
                  isHighlighted: context.isWeb,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveValueDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: Theme.of(context).colorScheme.primary),
            const HGap.sm(),
            const SmartText('context.responsive()',
                style: TypographyStyle.titleLarge),
          ],
        ),
        const VGap.sm(),
        SmartText(
          'Get different values based on the current breakpoint',
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
                Container(
                  padding: EdgeInsets.all(context.responsive(
                    mobile: SmartSpacing.sm,
                    tablet: SmartSpacing.md,
                    desktop: SmartSpacing.lg,
                  )),
                  decoration: BoxDecoration(
                    color: context.responsive<Color>(
                      mobile: Colors.blue.withOpacity(0.2),
                      tablet: Colors.green.withOpacity(0.2),
                      desktop: Colors.orange.withOpacity(0.2),
                    ),
                    borderRadius: SmartRadius.md,
                    border: Border.all(
                      color: context.responsive<Color>(
                        mobile: Colors.blue,
                        tablet: Colors.green,
                        desktop: Colors.orange,
                      ),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      SmartText.responsive(
                        'Responsive Box',
                        mobile: TypographyStyle.titleSmall,
                        tablet: TypographyStyle.titleMedium,
                        desktop: TypographyStyle.titleLarge,
                      ),
                      const VGap.sm(),
                      Text(
                        'Padding: ${context.responsive(mobile: "8px", tablet: "16px", desktop: "24px")}\n'
                        'Color: ${context.responsive(mobile: "Blue", tablet: "Green", desktop: "Orange")}\n'
                        'Font: ${context.responsive(mobile: "Small", tablet: "Medium", desktop: "Large")}',
                        style: SmartTypography.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const VGap.md(),
                Container(
                  padding: const EdgeInsets.all(SmartSpacing.md),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: SmartRadius.md,
                  ),
                  child: Text(
                    '''final padding = context.responsive<double>(
  mobile: 8,
  tablet: 16,
  desktop: 24,
);

final columns = context.responsiveInt(
  mobile: 1,
  tablet: 2,
  desktop: 4,
);

final showSidebar = context.responsiveBool(
  mobile: false,
  desktop: true,
);''',
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

  Widget _buildWidgetExtensionsDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.widgets, color: Theme.of(context).colorScheme.primary),
            const HGap.sm(),
            const SmartText('Widget Extensions',
                style: TypographyStyle.titleLarge),
          ],
        ),
        const VGap.sm(),
        SmartText(
          'Chain common widget wrappers with fluent syntax',
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
                const SmartText('Padding Extensions',
                    style: TypographyStyle.titleSmall),
                const VGap.md(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.blue.withOpacity(0.2),
                        child: const Text('Normal').paddedAll(16),
                      ),
                    ),
                    const HGap.md(),
                    Expanded(
                      child: Container(
                        color: Colors.green.withOpacity(0.2),
                        child: const Text('Symmetric').paddedSymmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                const VGap.lg(),
                const SmartText('Layout Extensions',
                    style: TypographyStyle.titleSmall),
                const VGap.md(),
                Container(
                  height: 60,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Row(
                    children: [
                      Container(
                        color: Colors.blue.withOpacity(0.3),
                        child: const Text('Expanded').centered().expanded(),
                      ),
                      Container(
                        color: Colors.green.withOpacity(0.3),
                        child: const Text('Flexible').centered().flexible(),
                      ),
                    ],
                  ),
                ),
                const VGap.lg(),
                const SmartText('Decoration Extensions',
                    style: TypographyStyle.titleSmall),
                const VGap.md(),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(SmartSpacing.md),
                      color: Colors.purple.withOpacity(0.3),
                      child: const Text('Clipped'),
                    ).clipped(borderRadius: SmartRadius.lg),
                    const HGap.md(),
                    Container(
                      padding: const EdgeInsets.all(SmartSpacing.md),
                      color: Colors.orange.withOpacity(0.3),
                      child: const Text('Opacity 50%'),
                    ).opacity(0.5),
                  ],
                ),
                const VGap.lg(),
                Container(
                  padding: const EdgeInsets.all(SmartSpacing.md),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: SmartRadius.md,
                  ),
                  child: Text(
                    '''// Padding
widget.paddedAll(16)
widget.paddedSymmetric(horizontal: 16)
widget.withPadding(SpacingSize.md)

// Layout
widget.centered()
widget.expanded()
widget.flexible()
widget.sized(width: 100, height: 50)

// Decoration
widget.clipped(borderRadius: SmartRadius.md)
widget.opacity(0.5)
widget.decorated(BoxDecoration(...))

// Visibility
widget.showOnMobile()
widget.hideOnDesktop()''',
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

  Widget _buildNumberExtensionsDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.numbers, color: Theme.of(context).colorScheme.primary),
            const HGap.sm(),
            const SmartText('Number Extensions',
                style: TypographyStyle.titleLarge),
          ],
        ),
        const VGap.sm(),
        SmartText(
          'Quick access to spacing, padding, and durations from numbers',
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
                const SmartText('Spacing', style: TypographyStyle.titleSmall),
                const VGap.md(),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.blue,
                    ),
                    16.horizontalSpace,
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.green,
                    ),
                    24.horizontalSpace,
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.orange,
                    ),
                  ],
                ),
                const VGap.md(),
                SmartText(
                  '16.horizontalSpace and 24.horizontalSpace between boxes',
                  style: TypographyStyle.bodySmall,
                  textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const VGap.lg(),
                const SmartText('Padding & Radius',
                    style: TypographyStyle.titleSmall),
                const VGap.md(),
                Row(
                  children: [
                    Container(
                      padding: 16.paddingAll,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.2),
                        borderRadius: 8.borderRadius,
                      ),
                      child: const Text('16.paddingAll\n8.borderRadius'),
                    ),
                    const HGap.md(),
                    Container(
                      padding: 12.paddingHorizontal,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
                        borderRadius: 16.borderRadius,
                      ),
                      child: const Text('12.paddingHorizontal'),
                    ),
                  ],
                ),
                const VGap.lg(),
                Container(
                  padding: const EdgeInsets.all(SmartSpacing.md),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: SmartRadius.md,
                  ),
                  child: Text(
                    '''// Spacing
16.horizontalSpace  // SizedBox(width: 16)
8.verticalSpace     // SizedBox(height: 8)

// Padding
16.paddingAll          // EdgeInsets.all(16)
8.paddingHorizontal    // EdgeInsets.symmetric(horizontal: 8)
12.paddingVertical     // EdgeInsets.symmetric(vertical: 12)

// Border Radius
8.borderRadius   // BorderRadius.circular(8)
12.radius        // Radius.circular(12)

// Duration
300.ms       // Duration(milliseconds: 300)
2.seconds    // Duration(seconds: 2)''',
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

class _ExtensionRow extends StatelessWidget {
  const _ExtensionRow({
    required this.name,
    required this.value,
    this.isHighlighted = false,
  });

  final String name;
  final String value;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SmartSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: SmartTypography.bodySmall.copyWith(
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
              color: isHighlighted
                  ? Colors.green.withOpacity(0.2)
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: SmartRadius.sm,
            ),
            child: Text(
              value,
              style: SmartTypography.labelMedium.copyWith(
                color: isHighlighted ? Colors.green : null,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
