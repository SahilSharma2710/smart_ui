import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/premium_theme.dart';
import '../widgets/premium_widgets.dart';

class VisibilityDemoPage extends StatelessWidget {
  const VisibilityDemoPage({super.key});

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
            StaggeredFadeIn(index: 1, child: _buildSmartVisibleDemo(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 2, child: _buildShortcutWidgetsDemo(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 3, child: _buildConditionalDemo(context)),
            const VGap.xl(),
            StaggeredFadeIn(index: 4, child: _buildReplacementDemo(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return PremiumPageHeader(
      icon: Icons.visibility_rounded,
      title: 'Responsive Visibility',
      subtitle:
          'Show or hide widgets based on the current breakpoint. '
          'Resize your window to see widgets appear and disappear.',
      trailing: const BreakpointIndicator(),
    );
  }

  Widget _buildSmartVisibleDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('SmartVisible Widget',
            style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Show widgets only on specific breakpoints using visibleOn or hiddenOn',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              children: [
                _VisibilityRow(
                  label: 'visibleOn: [mobile]',
                  child: SmartVisible(
                    visibleOn: const [SmartBreakpoint.mobile],
                    child: _VisibilityChip(
                      label: 'MOBILE ONLY',
                      color: Colors.blue,
                    ),
                  ),
                ),
                const VGap.md(),
                _VisibilityRow(
                  label: 'visibleOn: [tablet]',
                  child: SmartVisible(
                    visibleOn: const [SmartBreakpoint.tablet],
                    child: _VisibilityChip(
                      label: 'TABLET ONLY',
                      color: Colors.green,
                    ),
                  ),
                ),
                const VGap.md(),
                _VisibilityRow(
                  label: 'visibleOn: [desktop, tv]',
                  child: SmartVisible(
                    visibleOn: const [
                      SmartBreakpoint.desktop,
                      SmartBreakpoint.tv
                    ],
                    child: _VisibilityChip(
                      label: 'DESKTOP/TV ONLY',
                      color: Colors.orange,
                    ),
                  ),
                ),
                const VGap.md(),
                _VisibilityRow(
                  label: 'hiddenOn: [mobile, watch]',
                  child: SmartVisible(
                    hiddenOn: const [
                      SmartBreakpoint.mobile,
                      SmartBreakpoint.watch
                    ],
                    child: _VisibilityChip(
                      label: 'HIDDEN ON MOBILE',
                      color: Colors.purple,
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

  Widget _buildShortcutWidgetsDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Shortcut Widgets', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Convenience widgets for common visibility patterns',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SmartSpacing.md),
            child: Column(
              children: [
                _VisibilityRow(
                  label: 'MobileOnly',
                  child: MobileOnly(
                    child: _VisibilityChip(
                      label: 'MobileOnly',
                      color: Colors.blue,
                    ),
                  ),
                ),
                const VGap.md(),
                _VisibilityRow(
                  label: 'TabletOnly',
                  child: TabletOnly(
                    child: _VisibilityChip(
                      label: 'TabletOnly',
                      color: Colors.green,
                    ),
                  ),
                ),
                const VGap.md(),
                _VisibilityRow(
                  label: 'DesktopOnly',
                  child: DesktopOnly(
                    child: _VisibilityChip(
                      label: 'DesktopOnly',
                      color: Colors.orange,
                    ),
                  ),
                ),
                const VGap.md(),
                _VisibilityRow(
                  label: 'HideOnMobile',
                  child: HideOnMobile(
                    child: _VisibilityChip(
                      label: 'HideOnMobile',
                      color: Colors.red,
                    ),
                  ),
                ),
                const VGap.md(),
                _VisibilityRow(
                  label: 'HideOnDesktop',
                  child: HideOnDesktop(
                    child: _VisibilityChip(
                      label: 'HideOnDesktop',
                      color: Colors.purple,
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

  Widget _buildConditionalDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Conditional Content',
            style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Real-world example: Show different content based on screen size',
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
                Row(
                  children: [
                    const Icon(Icons.menu, size: 24),
                    const HGap.md(),
                    const SmartText('Navigation Example',
                        style: TypographyStyle.titleMedium),
                    const Spacer(),
                    // Full button on desktop
                    DesktopOnly(
                      child: SmartButton.filled(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add, size: 18),
                            const HGap.sm(),
                            const Text('Create New'),
                          ],
                        ),
                      ),
                    ),
                    // Icon button on mobile/tablet
                    HideOnDesktop(
                      child: SmartIconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                        tooltip: 'Create New',
                      ),
                    ),
                  ],
                ),
                const VGap.lg(),
                // Extended description on larger screens
                HideOnMobile(
                  child: Container(
                    padding: const EdgeInsets.all(SmartSpacing.md),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: SmartRadius.md,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const HGap.md(),
                        Expanded(
                          child: SmartText(
                            'This detailed information panel is hidden on mobile to save space. '
                            'It only appears on tablet and desktop.',
                            style: TypographyStyle.bodySmall,
                            textColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
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

  Widget _buildReplacementDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('With Replacement', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Provide a replacement widget when the main widget is hidden',
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
                SmartVisible(
                  visibleOn: const [
                    SmartBreakpoint.desktop,
                    SmartBreakpoint.tv
                  ],
                  replacement: Container(
                    padding: const EdgeInsets.all(SmartSpacing.md),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: SmartRadius.md,
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_android, color: Colors.orange),
                        const HGap.md(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmartText(
                                'Mobile/Tablet View',
                                style: TypographyStyle.titleSmall,
                              ),
                              SmartText(
                                'Simplified view for smaller screens',
                                style: TypographyStyle.bodySmall,
                                textColor: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(SmartSpacing.lg),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: SmartRadius.md,
                      border: Border.all(color: Colors.green),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.desktop_windows,
                            color: Colors.green, size: 32),
                        const HGap.lg(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmartText(
                                'Desktop View',
                                style: TypographyStyle.titleMedium,
                              ),
                              const VGap.xs(),
                              SmartText(
                                'Full-featured view with all details visible. '
                                'This layout takes advantage of the larger screen space.',
                                style: TypographyStyle.bodyMedium,
                                textColor: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              const VGap.md(),
                              Row(
                                children: [
                                  SmartButton.filled(
                                    onPressed: () {},
                                    child: const Text('Primary Action'),
                                  ),
                                  const HGap.md(),
                                  SmartButton.outlined(
                                    onPressed: () {},
                                    child: const Text('Secondary'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    '''SmartVisible(
  visibleOn: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
  replacement: MobileView(),  // Shown when hidden
  child: DesktopView(),
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

class _VisibilityRow extends StatelessWidget {
  const _VisibilityRow({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: SmartTypography.bodySmall.copyWith(
              fontFamily: 'monospace',
            ),
          ),
        ),
        const HGap.md(),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 36,
            child: Align(
              alignment: Alignment.centerLeft,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class _VisibilityChip extends StatelessWidget {
  const _VisibilityChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SmartSpacing.sm,
        vertical: SmartSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: SmartRadius.sm,
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.visibility, size: 14, color: color),
          const HGap.xs(),
          Text(
            label,
            style: SmartTypography.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
