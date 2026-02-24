import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/premium_theme.dart';
import '../widgets/premium_widgets.dart';

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
            StaggeredFadeIn(index: 0, child: _buildHeroSection(context)),
            const VGap.xl(),
            const VGap.lg(),
            StaggeredFadeIn(index: 1, child: _buildStatsSection(context)),
            const VGap.xl(),
            const VGap.lg(),
            StaggeredFadeIn(index: 2, child: _buildFeaturesSection(context)),
            const VGap.xl(),
            const VGap.lg(),
            StaggeredFadeIn(index: 3, child: _buildQuickStartSection(context)),
            const VGap.xl(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SmartSpacing.md,
                vertical: SmartSpacing.xs,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PremiumColors.gold.withAlpha(51),
                    PremiumColors.amber.withAlpha(26),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: PremiumColors.gold.withAlpha(77)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded,
                      size: 14, color: PremiumColors.gold),
                  const HGap.xs(),
                  Text(
                    'The Tailwind CSS of Flutter',
                    style: PremiumTypography.labelSmall.copyWith(
                      color: PremiumColors.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const VGap.lg(),
        ShaderMask(
          shaderCallback: (bounds) =>
              PremiumGradients.primary.createShader(bounds),
          child: Text(
            'adaptive_kit',
            style: PremiumTypography.displayLarge.copyWith(
              color: Colors.white,
              fontSize: context.responsive(
                mobile: 48.0,
                tablet: 64.0,
                desktop: 80.0,
              ),
              height: 1.0,
            ),
          ),
        ),
        const VGap.md(),
        SizedBox(
          width: context.responsive(
            mobile: double.infinity,
            tablet: 600.0,
            desktop: 700.0,
          ),
          child: Text(
            'A zero-config, declarative adaptive UI toolkit for building responsive, platform-aware Flutter applications with elegance.',
            style: PremiumTypography.bodyLarge.copyWith(
              color: PremiumColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
        const VGap.xl(),
        Wrap(
          spacing: SmartSpacing.md,
          runSpacing: SmartSpacing.md,
          children: [
            _HeroButton(
              label: 'Get Started',
              icon: Icons.rocket_launch_rounded,
              isPrimary: true,
              onTap: () {},
            ),
            _HeroButton(
              label: 'View on pub.dev',
              icon: Icons.open_in_new_rounded,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return SmartGrid(
      columns: 12,
      spacing: SmartSpacing.md,
      runSpacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 6,
          tablet: 3,
          desktop: 3,
          child: PremiumStatCard(
            icon: Icons.widgets_rounded,
            value: 24,
            label: 'Widgets',
            suffix: '+',
            color: PremiumColors.info,
          ),
        ),
        SmartCol(
          mobile: 6,
          tablet: 3,
          desktop: 3,
          child: PremiumStatCard(
            icon: Icons.devices_rounded,
            value: 5,
            label: 'Breakpoints',
            suffix: '',
            color: PremiumColors.success,
          ),
        ),
        SmartCol(
          mobile: 6,
          tablet: 3,
          desktop: 3,
          child: PremiumStatCard(
            icon: Icons.extension_rounded,
            value: 50,
            label: 'Extensions',
            suffix: '+',
            color: PremiumColors.warning,
          ),
        ),
        SmartCol(
          mobile: 6,
          tablet: 3,
          desktop: 3,
          child: PremiumStatCard(
            icon: Icons.settings_rounded,
            value: 0,
            label: 'Config Required',
            suffix: '',
            color: PremiumColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final features = [
      _Feature(
        icon: Icons.devices_rounded,
        title: 'Responsive Breakpoints',
        description:
            'Five-tier system from watch to TV with automatic detection',
        gradient: [PremiumColors.info, PremiumColors.info.withAlpha(179)],
      ),
      _Feature(
        icon: Icons.view_quilt_rounded,
        title: 'Smart Layouts',
        description: 'Declarative layout switching per breakpoint',
        gradient: [PremiumColors.success, PremiumColors.success.withAlpha(179)],
      ),
      _Feature(
        icon: Icons.grid_view_rounded,
        title: 'Responsive Grid',
        description: 'Flexible 12-column grid with breakpoint-aware spans',
        gradient: [PremiumColors.warning, PremiumColors.warning.withAlpha(179)],
      ),
      _Feature(
        icon: Icons.auto_awesome_rounded,
        title: 'Adaptive Widgets',
        description: 'Platform-aware components that feel native everywhere',
        gradient: [PremiumColors.primary, PremiumColors.gradientEnd],
      ),
      _Feature(
        icon: Icons.palette_rounded,
        title: 'Design Tokens',
        description: 'Typography, spacing, and radius scales built-in',
        gradient: [PremiumColors.error, PremiumColors.error.withAlpha(179)],
      ),
      _Feature(
        icon: Icons.visibility_rounded,
        title: 'Visibility Control',
        description: 'Show or hide widgets based on breakpoints',
        gradient: [
          PremiumColors.gradientStart,
          PremiumColors.gradientStart.withAlpha(179)
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PremiumSectionHeader(
          title: 'Core Features',
          subtitle: 'Everything you need for responsive Flutter apps',
        ),
        const VGap.lg(),
        SmartGrid(
          columns: 12,
          spacing: SmartSpacing.md,
          runSpacing: SmartSpacing.md,
          children: features.asMap().entries.map((entry) {
            return SmartCol(
              mobile: 12,
              tablet: 6,
              desktop: 4,
              child: _FeatureCard(feature: entry.value, index: entry.key),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickStartSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PremiumSectionHeader(
          title: 'Quick Start',
          subtitle: 'Get up and running in seconds',
        ),
        const VGap.lg(),
        SmartGrid(
          columns: 12,
          spacing: SmartSpacing.md,
          runSpacing: SmartSpacing.md,
          children: [
            SmartCol(
              mobile: 12,
              desktop: 6,
              child: PremiumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: PremiumColors.info.withAlpha(26),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.download_rounded,
                              color: PremiumColors.info, size: 20),
                        ),
                        const HGap.md(),
                        Text('1. Install', style: PremiumTypography.titleMedium),
                      ],
                    ),
                    const VGap.md(),
                    const PremiumCodeBlock(
                      code: 'flutter pub add adaptive_kit',
                    ),
                  ],
                ),
              ),
            ),
            SmartCol(
              mobile: 12,
              desktop: 6,
              child: PremiumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: PremiumColors.success.withAlpha(26),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.code_rounded,
                              color: PremiumColors.success, size: 20),
                        ),
                        const HGap.md(),
                        Text('2. Wrap App', style: PremiumTypography.titleMedium),
                      ],
                    ),
                    const VGap.md(),
                    const PremiumCodeBlock(
                      code:
                          'SmartUi(\n  child: MaterialApp(...),\n)',
                    ),
                  ],
                ),
              ),
            ),
            SmartCol(
              mobile: 12,
              child: PremiumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: PremiumColors.primary.withAlpha(26),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.auto_awesome_rounded,
                              color: PremiumColors.primary, size: 20),
                        ),
                        const HGap.md(),
                        Text('3. Build Responsive UI',
                            style: PremiumTypography.titleMedium),
                      ],
                    ),
                    const VGap.md(),
                    const PremiumCodeBlock(
                      code: '''SmartGrid(
  columns: 12,
  children: [
    SmartCol(
      mobile: 12,
      tablet: 6,
      desktop: 4,
      child: MyWidget(),
    ),
  ],
)''',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Feature {
  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;
}

class _FeatureCard extends StatefulWidget {
  const _FeatureCard({required this.feature, required this.index});

  final _Feature feature;
  final int index;

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
        child: PremiumCard(
          padding: const EdgeInsets.all(SmartSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: widget.feature.gradient),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: widget.feature.gradient.first.withAlpha(77),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    Icon(widget.feature.icon, color: Colors.white, size: 24),
              ),
              const VGap.lg(),
              Text(widget.feature.title, style: PremiumTypography.titleMedium),
              const VGap.sm(),
              Text(
                widget.feature.description,
                style: PremiumTypography.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroButton extends StatefulWidget {
  const _HeroButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: SmartSpacing.lg,
            vertical: SmartSpacing.md,
          ),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? PremiumGradients.primary : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: widget.isPrimary
                ? null
                : Border.all(color: PremiumColors.cardBorder),
            boxShadow: widget.isPrimary && _isHovered
                ? [
                    BoxShadow(
                      color: PremiumColors.gradientStart.withAlpha(102),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.isPrimary
                    ? Colors.white
                    : PremiumColors.textSecondary,
              ),
              const HGap.sm(),
              Text(
                widget.label,
                style: PremiumTypography.labelLarge.copyWith(
                  color: widget.isPrimary
                      ? Colors.white
                      : PremiumColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
