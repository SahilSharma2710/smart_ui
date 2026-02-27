import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/playground_theme.dart';
import '../components/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero section with breakpoint visualizer
          _HeroSection(),
          // Stats banner
          _StatsBanner(),
          // Features grid
          _FeaturesSection(),
          // Comparison section
          _ComparisonSection(),
          // Quick links
          _QuickLinksSection(),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive(
          mobile: PlaygroundTheme.spaceMd,
          tablet: PlaygroundTheme.spaceLg,
          desktop: PlaygroundTheme.spaceXl,
        ),
        vertical: PlaygroundTheme.spaceXl,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PlaygroundTheme.primary.withValues(alpha: 0.1),
            Colors.transparent,
            PlaygroundTheme.accent.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: SmartContainer.xl(
        child: Column(
          children: [
            // Title
            StaggeredFadeIn(
              index: 0,
              child: Column(
                children: [
                  PlaygroundBadge(
                    label: 'v2.0.1 — Now with 10 new features!',
                    color: PlaygroundTheme.accent,
                    icon: Icons.new_releases_outlined,
                  ),
                  const SizedBox(height: PlaygroundTheme.spaceMd),
                  GradientText(
                    text: 'Build Responsive Flutter Apps',
                    gradient: PlaygroundTheme.heroGradient,
                    style: TextStyle(
                      fontSize: context.responsive(
                        mobile: 32.0,
                        tablet: 42.0,
                        desktop: 52.0,
                      ),
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: PlaygroundTheme.spaceSm),
                  Text(
                    'In Minutes, Not Days',
                    style: TextStyle(
                      fontSize: context.responsive(
                        mobile: 28.0,
                        tablet: 36.0,
                        desktop: 44.0,
                      ),
                      fontWeight: FontWeight.w800,
                      color: context.textPrimaryColor,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            StaggeredFadeIn(
              index: 1,
              child: Text(
                'Zero-config, declarative adaptive UI toolkit with responsive breakpoints,\nplatform-aware widgets, and design tokens.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsive(
                    mobile: 14.0,
                    tablet: 16.0,
                    desktop: 18.0,
                  ),
                  color: context.textSecondaryColor,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),
            // Interactive breakpoint visualizer
            StaggeredFadeIn(
              index: 2,
              child: SizedBox(
                height: context.responsive(
                  mobile: 500.0,
                  tablet: 550.0,
                  desktop: 600.0,
                ),
                child: BreakpointVisualizer(
                  child: _VisualizerContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisualizerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: SmartLayout(
        mobile: _MobileLayout(),
        tablet: _TabletLayout(),
        desktop: _DesktopLayout(),
        transition: SmartTransition.fade,
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: PlaygroundTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Icon(Icons.menu, color: PlaygroundTheme.primary, size: 20),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.mobileColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'MOBILE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: PlaygroundTheme.mobileColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Column(
              children: List.generate(3, (i) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: i < 2 ? 8 : 0),
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor,
                    borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                    border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Card ${i + 1}',
                      style: TextStyle(
                        color: context.textMutedColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      child: Row(
        children: [
          // Sidebar
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: PlaygroundTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.widgets, color: Colors.white, size: 18),
                ),
                const SizedBox(height: 16),
                ...List.generate(4, (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: i == 0
                          ? PlaygroundTheme.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      [Icons.home, Icons.grid_view, Icons.settings, Icons.person][i],
                      color: i == 0 ? PlaygroundTheme.primary : context.textMutedColor,
                      size: 18,
                    ),
                  ),
                )),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.tabletColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'TAB',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: PlaygroundTheme.tabletColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: List.generate(2, (i) => Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: i == 0 ? 8 : 0),
                        decoration: BoxDecoration(
                          color: context.surfaceElevatedColor,
                          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                          border: Border.all(
                            color: context.borderColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Card ${i + 1}',
                            style: TextStyle(
                              color: context.textMutedColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.surfaceElevatedColor,
                      borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                      border: Border.all(
                        color: context.borderColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Card 3',
                        style: TextStyle(
                          color: context.textMutedColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      child: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: PlaygroundTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.widgets, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'adaptive_kit',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...['Home', 'Layout', 'Widgets', 'Settings'].asMap().entries.map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: e.key == 0
                        ? PlaygroundTheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        [Icons.home, Icons.grid_view, Icons.widgets, Icons.settings][e.key],
                        size: 16,
                        color: e.key == 0 ? PlaygroundTheme.primary : context.textMutedColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        e.value,
                        style: TextStyle(
                          fontSize: 12,
                          color: e.key == 0 ? PlaygroundTheme.primary : context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                )),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.desktopColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'DESKTOP',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: PlaygroundTheme.desktopColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: SmartGrid(
              spacing: SmartSpacing.sm,
              children: List.generate(3, (i) => SmartCol(
                mobile: 12,
                tablet: 6,
                desktop: 4,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor,
                    borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                    border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Card ${i + 1}',
                      style: TextStyle(
                        color: context.textMutedColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive(
          mobile: PlaygroundTheme.spaceMd,
          desktop: PlaygroundTheme.spaceXl,
        ),
        vertical: PlaygroundTheme.spaceLg,
      ),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(color: context.borderColor.withValues(alpha: 0.3)),
          bottom: BorderSide(color: context.borderColor.withValues(alpha: 0.3)),
        ),
      ),
      child: SmartContainer.xl(
        child: SmartGrid(
          spacing: SmartSpacing.md,
          children: [
            SmartCol(
              mobile: 6,
              tablet: 3,
              child: _StatItem(
                value: 34,
                label: 'Widgets',
                icon: Icons.widgets_outlined,
                color: PlaygroundTheme.primary,
              ),
            ),
            SmartCol(
              mobile: 6,
              tablet: 3,
              child: _StatItem(
                value: 6,
                label: 'Platforms',
                icon: Icons.devices_outlined,
                color: PlaygroundTheme.accent,
              ),
            ),
            SmartCol(
              mobile: 6,
              tablet: 3,
              child: _StatItem(
                value: 0,
                label: 'Dependencies',
                icon: Icons.link_off_outlined,
                color: PlaygroundTheme.success,
              ),
            ),
            SmartCol(
              mobile: 6,
              tablet: 3,
              child: _StatItem(
                value: 207,
                label: 'Tests',
                icon: Icons.check_circle_outline,
                color: PlaygroundTheme.warning,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final int value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCounter(
              value: value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
              suffix: value == 0 ? '' : '+',
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: context.textMutedColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive(
          mobile: PlaygroundTheme.spaceMd,
          desktop: PlaygroundTheme.spaceXl,
        ),
        vertical: PlaygroundTheme.spaceXl,
      ),
      child: SmartContainer.xl(
        child: Column(
          children: [
            SectionHeader(
              title: 'Why adaptive_kit?',
              subtitle: 'Everything you need to build responsive Flutter apps',
            ),
            const SizedBox(height: PlaygroundTheme.spaceLg),
            SmartGrid(
              spacing: SmartSpacing.md,
              children: [
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.devices,
                    title: '5 Breakpoints',
                    description: 'Watch, mobile, tablet, desktop, and TV — cover every screen size with declarative widgets.',
                    color: PlaygroundTheme.primary,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.auto_awesome,
                    title: 'Zero Config',
                    description: 'Works out of the box. No setup needed. Just wrap with SmartApp and start building.',
                    color: PlaygroundTheme.accent,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.palette,
                    title: 'Design Tokens',
                    description: 'Consistent spacing, typography, and radius across your app with built-in token system.',
                    color: PlaygroundTheme.success,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.phone_android,
                    title: 'Platform Aware',
                    description: 'Automatically adapts to Material on Android and Cupertino on iOS/macOS.',
                    color: PlaygroundTheme.warning,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.grid_view,
                    title: '12-Column Grid',
                    description: 'Familiar Bootstrap-style grid system with responsive column spans.',
                    color: PlaygroundTheme.error,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.extension,
                    title: '50+ Extensions',
                    description: 'Convenient BuildContext extensions for breakpoints, platform, safe area, and more.',
                    color: PlaygroundTheme.info,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparisonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive(
          mobile: PlaygroundTheme.spaceMd,
          desktop: PlaygroundTheme.spaceXl,
        ),
        vertical: PlaygroundTheme.spaceXl,
      ),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(color: context.borderColor.withValues(alpha: 0.3)),
          bottom: BorderSide(color: context.borderColor.withValues(alpha: 0.3)),
        ),
      ),
      child: SmartContainer.lg(
        child: Column(
          children: [
            SectionHeader(
              title: 'Less Code, More Power',
              subtitle: 'See how adaptive_kit simplifies responsive development',
            ),
            const SizedBox(height: PlaygroundTheme.spaceLg),
            CodeComparison(
              beforeCode: '''LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return Column(
        children: [Card1(), Card2(), Card3()],
      );
    } else if (constraints.maxWidth < 900) {
      return Row(
        children: [
          Expanded(child: Card1()),
          Expanded(child: Card2()),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(child: Card1()),
          Expanded(child: Card2()),
          Expanded(child: Card3()),
        ],
      );
    }
  },
)''',
              afterCode: '''SmartGrid(
  children: [
    SmartCol(mobile: 12, tablet: 6, desktop: 4,
      child: Card1()),
    SmartCol(mobile: 12, tablet: 6, desktop: 4,
      child: Card2()),
    SmartCol(mobile: 12, tablet: 6, desktop: 4,
      child: Card3()),
  ],
)''',
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickLinksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive(
          mobile: PlaygroundTheme.spaceMd,
          desktop: PlaygroundTheme.spaceXl,
        ),
        vertical: PlaygroundTheme.spaceXl,
      ),
      child: SmartContainer.xl(
        child: Column(
          children: [
            SectionHeader(
              title: 'Quick Links',
              subtitle: 'Get started quickly with these resources',
            ),
            const SizedBox(height: PlaygroundTheme.spaceLg),
            SmartGrid(
              spacing: SmartSpacing.md,
              children: [
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 3,
                  child: _QuickLinkCard(
                    icon: Icons.rocket_launch,
                    title: 'Get Started',
                    description: 'Installation & setup',
                    color: PlaygroundTheme.primary,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 3,
                  child: _QuickLinkCard(
                    icon: Icons.menu_book,
                    title: 'pub.dev',
                    description: 'Package documentation',
                    color: PlaygroundTheme.accent,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 3,
                  child: _QuickLinkCard(
                    icon: Icons.code,
                    title: 'GitHub',
                    description: 'Source code & issues',
                    color: PlaygroundTheme.success,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 3,
                  child: _QuickLinkCard(
                    icon: Icons.lightbulb,
                    title: 'Examples',
                    description: 'Browse all examples',
                    color: PlaygroundTheme.warning,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),
            // Footer
            Text(
              'Made with Flutter',
              style: TextStyle(
                fontSize: 12,
                color: context.textMutedColor,
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
          ],
        ),
      ),
    );
  }
}

class _QuickLinkCard extends StatelessWidget {
  const _QuickLinkCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      onTap: () {
        // TODO: Navigate to appropriate page
      },
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textMutedColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward,
            size: 16,
            color: context.textMutedColor,
          ),
        ],
      ),
    );
  }
}
