import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            _buildHeader(context),
            const VGap.xl(),
            _buildFeatureGrid(context),
            const VGap.xl(),
            _buildQuickStats(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText.responsive(
          'Welcome to adaptive_kit',
          mobile: TypographyStyle.headlineSmall,
          tablet: TypographyStyle.headlineMedium,
          desktop: TypographyStyle.headlineLarge,
        ),
        const VGap.sm(),
        SmartText(
          'The Tailwind CSS of Flutter. A zero-config, declarative adaptive UI toolkit '
          'for building responsive, platform-aware Flutter applications.',
          style: TypographyStyle.bodyLarge,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.lg(),
        ResponsiveBuilder(
          builder: (context, info) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SmartSpacing.md,
                vertical: SmartSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: SmartRadius.md,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.aspect_ratio,
                    size: 18,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const HGap.sm(),
                  Text(
                    'Current: ${info.breakpoint.name.toUpperCase()} '
                    '(${info.screenWidth.toInt()} x ${info.screenHeight.toInt()})',
                    style: SmartTypography.labelMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      _FeatureItem(
        icon: Icons.screen_rotation,
        title: 'Breakpoints',
        description: 'Five-tier responsive system from watch to TV',
        color: Colors.blue,
      ),
      _FeatureItem(
        icon: Icons.view_quilt,
        title: 'SmartLayout',
        description: 'Declarative layout switching per breakpoint',
        color: Colors.green,
      ),
      _FeatureItem(
        icon: Icons.grid_view,
        title: 'Responsive Grid',
        description: 'Flexible 12-column grid with breakpoint spans',
        color: Colors.orange,
      ),
      _FeatureItem(
        icon: Icons.widgets,
        title: 'Adaptive Widgets',
        description: 'Platform-aware UI components',
        color: Colors.purple,
      ),
      _FeatureItem(
        icon: Icons.palette,
        title: 'Design Tokens',
        description: 'Typography, spacing, and radius scales',
        color: Colors.red,
      ),
      _FeatureItem(
        icon: Icons.visibility,
        title: 'Visibility',
        description: 'Show/hide widgets per breakpoint',
        color: Colors.teal,
      ),
      _FeatureItem(
        icon: Icons.extension,
        title: 'Extensions',
        description: 'Powerful context and widget extensions',
        color: Colors.indigo,
      ),
      _FeatureItem(
        icon: Icons.devices,
        title: 'Platform Detection',
        description: 'Smart platform-aware rendering',
        color: Colors.pink,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Features', style: TypographyStyle.titleLarge),
        const VGap.sm(),
        SmartText(
          'Explore the demos using the navigation',
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        SmartGrid(
          columns: 12,
          spacing: SmartSpacing.md,
          runSpacing: SmartSpacing.md,
          children: features.map((feature) {
            return SmartCol(
              mobile: 12,
              tablet: 6,
              desktop: 3,
              child: _FeatureCard(feature: feature),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText('Package Highlights',
            style: TypographyStyle.titleLarge),
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
              child: _StatCard(
                value: '24+',
                label: 'Widgets',
                icon: Icons.widgets,
                color: Colors.blue,
              ),
            ),
            SmartCol(
              mobile: 6,
              tablet: 3,
              desktop: 3,
              child: _StatCard(
                value: '5',
                label: 'Breakpoints',
                icon: Icons.screen_rotation,
                color: Colors.green,
              ),
            ),
            SmartCol(
              mobile: 6,
              tablet: 3,
              desktop: 3,
              child: _StatCard(
                value: '50+',
                label: 'Extensions',
                icon: Icons.extension,
                color: Colors.orange,
              ),
            ),
            SmartCol(
              mobile: 6,
              tablet: 3,
              desktop: 3,
              child: _StatCard(
                value: '0',
                label: 'Config',
                icon: Icons.settings,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final _FeatureItem feature;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(SmartSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(SmartSpacing.sm),
              decoration: BoxDecoration(
                color: feature.color.withOpacity(0.1),
                borderRadius: SmartRadius.sm,
              ),
              child: Icon(
                feature.icon,
                color: feature.color,
                size: 24,
              ),
            ),
            const VGap.md(),
            SmartText(
              feature.title,
              style: TypographyStyle.titleMedium,
            ),
            const VGap.xs(),
            SmartText(
              feature.description,
              style: TypographyStyle.bodySmall,
              textColor: Theme.of(context).colorScheme.onSurfaceVariant,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(SmartSpacing.md),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const VGap.sm(),
            SmartText(
              value,
              style: TypographyStyle.headlineMedium,
              textColor: color,
            ),
            SmartText(
              label,
              style: TypographyStyle.labelMedium,
              textColor: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
