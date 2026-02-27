import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartImage widget
class SmartImagePage extends StatefulWidget {
  const SmartImagePage({super.key});

  @override
  State<SmartImagePage> createState() => _SmartImagePageState();
}

class _SmartImagePageState extends State<SmartImagePage> {
  // Controls
  BoxFit _fit = BoxFit.cover;
  AlignmentGeometry _alignment = Alignment.center;
  String _currentBreakpoint = 'desktop';

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
              'SmartImage',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'A responsive image widget that displays different images based on the current breakpoint. Serve optimized images for mobile, tablet, and desktop.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Key Features Section
            SectionHeader(
              title: 'Key Features',
              subtitle: 'Why use SmartImage for responsive images',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _FeaturesDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'See how images change across breakpoints',
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
                      DropdownControl<String>(
                        label: 'Simulate Breakpoint',
                        value: _currentBreakpoint,
                        options: const ['watch', 'mobile', 'tablet', 'desktop', 'tv'],
                        optionLabels: const {
                          'watch': 'Watch',
                          'mobile': 'Mobile',
                          'tablet': 'Tablet',
                          'desktop': 'Desktop',
                          'tv': 'TV',
                        },
                        onChanged: (value) =>
                            setState(() => _currentBreakpoint = value),
                      ),
                      DropdownControl<BoxFit>(
                        label: 'BoxFit',
                        value: _fit,
                        options: BoxFit.values,
                        optionLabels: {
                          for (var fit in BoxFit.values)
                            fit: fit.name,
                        },
                        onChanged: (value) => setState(() => _fit = value),
                      ),
                      DropdownControl<String>(
                        label: 'Alignment',
                        value: _alignment == Alignment.topCenter
                            ? 'top'
                            : _alignment == Alignment.bottomCenter
                                ? 'bottom'
                                : 'center',
                        options: const ['top', 'center', 'bottom'],
                        optionLabels: const {
                          'top': 'Top',
                          'center': 'Center',
                          'bottom': 'Bottom',
                        },
                        onChanged: (value) => setState(() {
                          _alignment = value == 'top'
                              ? Alignment.topCenter
                              : value == 'bottom'
                                  ? Alignment.bottomCenter
                                  : Alignment.center;
                        }),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _ImagePreview(
                    breakpoint: _currentBreakpoint,
                    fit: _fit,
                    alignment: _alignment,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getImageCode(),
              title: 'smart_image_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Constructor Variants Section
            SectionHeader(
              title: 'Constructor Variants',
              subtitle: 'Different ways to create SmartImage',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ConstructorVariantsDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartDecorationImage Section
            SectionHeader(
              title: 'SmartDecorationImage',
              subtitle: 'Responsive background images for containers',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _DecorationImageDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Cascade Behavior Section
            SectionHeader(
              title: 'Cascade Behavior',
              subtitle: 'How images resolve across breakpoints',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _CascadeBehaviorDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Best Practices Section
            SectionHeader(
              title: 'Best Practices',
              subtitle: 'Tips for optimal image performance',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _BestPracticesDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference Section
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartImage parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getImageCode() {
    return '''SmartImage(
  // Different images for different screen sizes
  mobile: AssetImage('assets/images/hero_mobile.png'),
  tablet: AssetImage('assets/images/hero_tablet.png'),
  desktop: AssetImage('assets/images/hero_desktop.png'),

  // Image display options
  fit: BoxFit.${_fit.name},
  alignment: Alignment.${_alignment.toString().split('.').last},

  // Optional: dimensions, color filters, etc.
  width: double.infinity,
  height: 300,
)''';
  }
}

class _FeaturesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 3,
          child: _FeatureCard(
            icon: Icons.image,
            title: 'Responsive',
            description: 'Different images for different screen sizes',
            color: PlaygroundTheme.primary,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 3,
          child: _FeatureCard(
            icon: Icons.speed,
            title: 'Optimized',
            description: 'Load smaller images on mobile devices',
            color: PlaygroundTheme.success,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 3,
          child: _FeatureCard(
            icon: Icons.swap_horiz,
            title: 'Cascade',
            description: 'Automatic fallback to smaller breakpoints',
            color: PlaygroundTheme.info,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 3,
          child: _FeatureCard(
            icon: Icons.extension,
            title: 'Flexible',
            description: 'Works with assets, network, and any ImageProvider',
            color: PlaygroundTheme.warning,
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
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
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({
    required this.breakpoint,
    required this.fit,
    required this.alignment,
  });

  final String breakpoint;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    // Simulated different images per breakpoint
    final imageColors = {
      'watch': PlaygroundTheme.watchColor,
      'mobile': PlaygroundTheme.mobileColor,
      'tablet': PlaygroundTheme.tabletColor,
      'desktop': PlaygroundTheme.desktopColor,
      'tv': PlaygroundTheme.tvColor,
    };

    final imageLabels = {
      'watch': 'hero_watch.png\n(200x200)',
      'mobile': 'hero_mobile.png\n(400x300)',
      'tablet': 'hero_tablet.png\n(800x400)',
      'desktop': 'hero_desktop.png\n(1200x500)',
      'tv': 'hero_tv.png\n(1920x600)',
    };

    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          // Breakpoint indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: (imageColors[breakpoint] ?? PlaygroundTheme.primary)
                .withValues(alpha: 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PlaygroundTheme.iconForBreakpoint(breakpoint),
                  size: 16,
                  color: imageColors[breakpoint],
                ),
                const SizedBox(width: 8),
                Text(
                  'Current: ${breakpoint.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: imageColors[breakpoint],
                  ),
                ),
              ],
            ),
          ),
          // Image preview
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(PlaygroundTheme.spaceMd),
              decoration: BoxDecoration(
                color: (imageColors[breakpoint] ?? PlaygroundTheme.primary)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                border: Border.all(
                  color: (imageColors[breakpoint] ?? PlaygroundTheme.primary)
                      .withValues(alpha: 0.3),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 48,
                      color: imageColors[breakpoint],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      imageLabels[breakpoint] ?? 'Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: imageColors[breakpoint],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (imageColors[breakpoint] ?? PlaygroundTheme.primary)
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                      ),
                      child: Text(
                        'fit: ${fit.name}',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: imageColors[breakpoint],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConstructorVariantsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ConstructorCard(
          title: 'SmartImage (ImageProvider)',
          description: 'Use any ImageProvider for maximum flexibility',
          code: '''SmartImage(
  mobile: AssetImage('assets/hero_mobile.png'),
  tablet: AssetImage('assets/hero_tablet.png'),
  desktop: NetworkImage('https://example.com/hero.png'),
  fit: BoxFit.cover,
)''',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _ConstructorCard(
          title: 'SmartImage.asset',
          description: 'Convenience constructor for asset images',
          code: '''SmartImage.asset(
  mobile: 'assets/images/hero_mobile.png',
  tablet: 'assets/images/hero_tablet.png',
  desktop: 'assets/images/hero_desktop.png',
  package: 'my_package', // Optional
  fit: BoxFit.cover,
)''',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _ConstructorCard(
          title: 'SmartImage.network',
          description: 'Convenience constructor for network images',
          code: '''SmartImage.network(
  mobile: 'https://example.com/image_small.jpg',
  tablet: 'https://example.com/image_medium.jpg',
  desktop: 'https://example.com/image_large.jpg',
  scale: 1.0,
  headers: {'Authorization': 'Bearer token'},
  fit: BoxFit.cover,
)''',
        ),
      ],
    );
  }
}

class _ConstructorCard extends StatelessWidget {
  const _ConstructorCard({
    required this.title,
    required this.description,
    required this.code,
  });

  final String title;
  final String description;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          CodePreview(code: code),
        ],
      ),
    );
  }
}

class _DecorationImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SmartDecorationImage',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Use SmartDecorationImage.resolve() to get a responsive DecorationImage for use in Container or DecoratedBox backgrounds.',
                style: TextStyle(
                  fontSize: 14,
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// In a Container
Container(
  decoration: BoxDecoration(
    image: SmartDecorationImage.resolve(
      context,
      mobile: AssetImage('assets/bg_mobile.png'),
      desktop: AssetImage('assets/bg_desktop.png'),
      fit: BoxFit.cover,
    ),
  ),
  child: MyContent(),
)

// From asset paths
Container(
  decoration: BoxDecoration(
    image: SmartDecorationImage.resolveAsset(
      context,
      mobile: 'assets/bg_mobile.png',
      desktop: 'assets/bg_desktop.png',
      fit: BoxFit.cover,
      opacity: 0.8,
    ),
  ),
)''',
          title: 'smart_decoration_image_example.dart',
        ),
      ],
    );
  }
}

class _CascadeBehaviorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Image Resolution Logic',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _CascadeRow(
            breakpoint: 'TV',
            logic: 'tv ?? desktop ?? tablet ?? mobile ?? watch',
            color: PlaygroundTheme.tvColor,
          ),
          _CascadeRow(
            breakpoint: 'Desktop',
            logic: 'desktop ?? tablet ?? mobile ?? watch',
            color: PlaygroundTheme.desktopColor,
          ),
          _CascadeRow(
            breakpoint: 'Tablet',
            logic: 'tablet ?? mobile ?? watch',
            color: PlaygroundTheme.tabletColor,
          ),
          _CascadeRow(
            breakpoint: 'Mobile',
            logic: 'mobile ?? watch',
            color: PlaygroundTheme.mobileColor,
          ),
          _CascadeRow(
            breakpoint: 'Watch',
            logic: 'watch ?? mobile ?? tablet ?? desktop ?? tv',
            color: PlaygroundTheme.watchColor,
            isLast: true,
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PlaygroundTheme.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 18,
                  color: PlaygroundTheme.info,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You only need to provide images for the breakpoints you care about. Smaller breakpoints cascade up automatically.',
                    style: TextStyle(
                      fontSize: 13,
                      color: PlaygroundTheme.info,
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

class _CascadeRow extends StatelessWidget {
  const _CascadeRow({
    required this.breakpoint,
    required this.logic,
    required this.color,
    this.isLast = false,
  });

  final String breakpoint;
  final String logic;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: context.borderColor.withValues(alpha: 0.2),
                ),
              ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              breakpoint,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(
            child: Text(
              logic,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BestPracticesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _PracticeCard(
            icon: Icons.check_circle,
            title: 'Do',
            color: PlaygroundTheme.success,
            practices: const [
              'Provide appropriately sized images for each breakpoint',
              'Use WebP or AVIF for better compression',
              'Add loading and error builders for network images',
              'Use gaplessPlayback for smooth image transitions',
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _PracticeCard(
            icon: Icons.cancel,
            title: "Don't",
            color: PlaygroundTheme.error,
            practices: const [
              'Load large desktop images on mobile devices',
              'Forget to handle loading states for network images',
              'Use the same image for all breakpoints',
              'Ignore image caching strategies',
            ],
          ),
        ),
      ],
    );
  }
}

class _PracticeCard extends StatelessWidget {
  const _PracticeCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.practices,
  });

  final IconData icon;
  final String title;
  final Color color;
  final List<String> practices;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          ...practices.map((practice) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\u2022',
                      style: TextStyle(color: color),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        practice,
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
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
            param: 'watch',
            type: 'ImageProvider?',
            description: 'Image for watch-sized screens',
          ),
          _ApiRow(
            param: 'mobile',
            type: 'ImageProvider?',
            description: 'Image for mobile-sized screens',
          ),
          _ApiRow(
            param: 'tablet',
            type: 'ImageProvider?',
            description: 'Image for tablet-sized screens',
          ),
          _ApiRow(
            param: 'desktop',
            type: 'ImageProvider?',
            description: 'Image for desktop-sized screens',
          ),
          _ApiRow(
            param: 'tv',
            type: 'ImageProvider?',
            description: 'Image for TV-sized screens',
          ),
          _ApiRow(
            param: 'fit',
            type: 'BoxFit?',
            description: 'How the image should be inscribed',
          ),
          _ApiRow(
            param: 'alignment',
            type: 'AlignmentGeometry',
            description: 'How to align the image within bounds',
          ),
          _ApiRow(
            param: 'width/height',
            type: 'double?',
            description: 'Target dimensions for the image',
          ),
          _ApiRow(
            param: 'loadingBuilder',
            type: 'ImageLoadingBuilder?',
            description: 'Builder for loading states',
          ),
          _ApiRow(
            param: 'errorBuilder',
            type: 'ImageErrorWidgetBuilder?',
            description: 'Builder for error states',
          ),
          _ApiRow(
            param: 'gaplessPlayback',
            type: 'bool',
            description: 'Keep old image during provider change',
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
            width: 130,
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
            width: 160,
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
