import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartSafeArea widget
class SmartSafeAreaPage extends StatefulWidget {
  const SmartSafeAreaPage({super.key});

  @override
  State<SmartSafeAreaPage> createState() => _SmartSafeAreaPageState();
}

class _SmartSafeAreaPageState extends State<SmartSafeAreaPage> {
  // Controls
  bool _left = true;
  bool _top = true;
  bool _right = true;
  bool _bottom = true;

  // Responsive overrides
  bool _mobileTop = true;
  bool _mobileBottom = true;
  bool _desktopTop = false;
  bool _desktopBottom = false;

  // Preview breakpoint
  String _previewBreakpoint = 'mobile';

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
              'SmartSafeArea',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'A responsive safe area wrapper that can apply different safe area insets based on the current breakpoint. Perfect for apps that need safe areas on mobile but not on desktop.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Key Features Section
            SectionHeader(
              title: 'Why SmartSafeArea?',
              subtitle: 'Benefits of responsive safe area handling',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _FeaturesDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Configure safe area properties per breakpoint',
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
                        label: 'Preview Breakpoint',
                        value: _previewBreakpoint,
                        options: const ['mobile', 'tablet', 'desktop'],
                        onChanged: (value) =>
                            setState(() => _previewBreakpoint = value),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Default Edges',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: context.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _EdgeToggleRow(
                        left: _left,
                        top: _top,
                        right: _right,
                        bottom: _bottom,
                        onLeftChanged: (v) => setState(() => _left = v),
                        onTopChanged: (v) => setState(() => _top = v),
                        onRightChanged: (v) => setState(() => _right = v),
                        onBottomChanged: (v) => setState(() => _bottom = v),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Mobile Override',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: PlaygroundTheme.mobileColor,
                        ),
                      ),
                      SwitchControl(
                        label: 'Top (Mobile)',
                        value: _mobileTop,
                        onChanged: (v) => setState(() => _mobileTop = v),
                      ),
                      SwitchControl(
                        label: 'Bottom (Mobile)',
                        value: _mobileBottom,
                        onChanged: (v) => setState(() => _mobileBottom = v),
                      ),
                      Text(
                        'Desktop Override',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: PlaygroundTheme.desktopColor,
                        ),
                      ),
                      SwitchControl(
                        label: 'Top (Desktop)',
                        value: _desktopTop,
                        onChanged: (v) => setState(() => _desktopTop = v),
                      ),
                      SwitchControl(
                        label: 'Bottom (Desktop)',
                        value: _desktopBottom,
                        onChanged: (v) => setState(() => _desktopBottom = v),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _SafeAreaPreview(
                    breakpoint: _previewBreakpoint,
                    left: _left,
                    top: _top,
                    right: _right,
                    bottom: _bottom,
                    mobileTop: _mobileTop,
                    mobileBottom: _mobileBottom,
                    desktopTop: _desktopTop,
                    desktopBottom: _desktopBottom,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getSafeAreaCode(),
              title: 'smart_safe_area_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Convenience Constructors Section
            SectionHeader(
              title: 'Convenience Constructors',
              subtitle: 'Quick presets for common use cases',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ConvenienceConstructorsDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Sliver Version Section
            SectionHeader(
              title: 'SliverSmartSafeArea',
              subtitle: 'For use in CustomScrollView',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _SliverSafeAreaDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Context Extensions Section
            SectionHeader(
              title: 'Context Extensions',
              subtitle: 'Access safe area values directly',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ContextExtensionsDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Use Cases Section
            SectionHeader(
              title: 'Common Use Cases',
              subtitle: 'Real-world examples',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _UseCasesDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference Section
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartSafeArea parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getSafeAreaCode() {
    String code = '''SmartSafeArea(
  // Default values for all breakpoints
  left: $_left,
  top: $_top,
  right: $_right,
  bottom: $_bottom,

  // Mobile-specific overrides
  mobileTop: $_mobileTop,
  mobileBottom: $_mobileBottom,

  // Desktop-specific overrides
  desktopTop: $_desktopTop,
  desktopBottom: $_desktopBottom,

  child: MyContent(),
)''';
    return code;
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
            icon: Icons.devices,
            title: 'Responsive',
            description: 'Different safe area settings per breakpoint',
            color: PlaygroundTheme.primary,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 3,
          child: _FeatureCard(
            icon: Icons.phone_iphone,
            title: 'Mobile-first',
            description: 'Apply safe areas on phones with notches',
            color: PlaygroundTheme.mobileColor,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 3,
          child: _FeatureCard(
            icon: Icons.desktop_windows,
            title: 'Desktop-aware',
            description: 'Skip unnecessary padding on desktop',
            color: PlaygroundTheme.desktopColor,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 3,
          child: _FeatureCard(
            icon: Icons.space_bar,
            title: 'Minimum Padding',
            description: 'Set minimum padding regardless of safe area',
            color: PlaygroundTheme.accent,
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

class _EdgeToggleRow extends StatelessWidget {
  const _EdgeToggleRow({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.onLeftChanged,
    required this.onTopChanged,
    required this.onRightChanged,
    required this.onBottomChanged,
  });

  final bool left, top, right, bottom;
  final ValueChanged<bool> onLeftChanged, onTopChanged, onRightChanged, onBottomChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _EdgeChip(label: 'Left', value: left, onChanged: onLeftChanged),
        _EdgeChip(label: 'Top', value: top, onChanged: onTopChanged),
        _EdgeChip(label: 'Right', value: right, onChanged: onRightChanged),
        _EdgeChip(label: 'Bottom', value: bottom, onChanged: onBottomChanged),
      ],
    );
  }
}

class _EdgeChip extends StatelessWidget {
  const _EdgeChip({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: value
              ? PlaygroundTheme.primary.withValues(alpha: 0.15)
              : context.surfaceElevatedColor,
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
          border: Border.all(
            color: value
                ? PlaygroundTheme.primary
                : context.borderColor.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: value ? PlaygroundTheme.primary : context.textSecondaryColor,
          ),
        ),
      ),
    );
  }
}

class _SafeAreaPreview extends StatelessWidget {
  const _SafeAreaPreview({
    required this.breakpoint,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.mobileTop,
    required this.mobileBottom,
    required this.desktopTop,
    required this.desktopBottom,
  });

  final String breakpoint;
  final bool left, top, right, bottom;
  final bool mobileTop, mobileBottom, desktopTop, desktopBottom;

  @override
  Widget build(BuildContext context) {
    // Calculate effective safe areas for the current breakpoint
    bool effectiveTop, effectiveBottom;
    if (breakpoint == 'mobile') {
      effectiveTop = mobileTop;
      effectiveBottom = mobileBottom;
    } else if (breakpoint == 'desktop') {
      effectiveTop = desktopTop;
      effectiveBottom = desktopBottom;
    } else {
      effectiveTop = top;
      effectiveBottom = bottom;
    }

    final breakpointColor = PlaygroundTheme.colorForBreakpoint(breakpoint);

    return Container(
      height: 400,
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
            color: breakpointColor.withValues(alpha: 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PlaygroundTheme.iconForBreakpoint(breakpoint),
                  size: 16,
                  color: breakpointColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Preview: ${breakpoint.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: breakpointColor,
                  ),
                ),
              ],
            ),
          ),
          // Device preview
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
              child: _DeviceFrame(
                breakpoint: breakpoint,
                topSafeArea: effectiveTop,
                bottomSafeArea: effectiveBottom,
                leftSafeArea: left,
                rightSafeArea: right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceFrame extends StatelessWidget {
  const _DeviceFrame({
    required this.breakpoint,
    required this.topSafeArea,
    required this.bottomSafeArea,
    required this.leftSafeArea,
    required this.rightSafeArea,
  });

  final String breakpoint;
  final bool topSafeArea;
  final bool bottomSafeArea;
  final bool leftSafeArea;
  final bool rightSafeArea;

  @override
  Widget build(BuildContext context) {
    final isMobile = breakpoint == 'mobile';
    final safeAreaHeight = isMobile ? 44.0 : 0.0;
    final homeIndicatorHeight = isMobile ? 34.0 : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(isMobile ? 40 : 12),
        border: Border.all(
          color: context.borderColor,
          width: isMobile ? 8 : 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 32 : 10),
        child: Stack(
          children: [
            // Content area
            Positioned.fill(
              child: Column(
                children: [
                  // Top safe area indicator
                  if (isMobile)
                    _SafeAreaIndicator(
                      height: safeAreaHeight,
                      label: 'Top Safe Area',
                      isActive: topSafeArea,
                      hasNotch: true,
                    ),
                  // Main content
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: leftSafeArea || rightSafeArea ? 8 : 0,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.article_outlined,
                              size: 32,
                              color: context.textMutedColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Your Content',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: context.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bottom safe area indicator
                  if (isMobile)
                    _SafeAreaIndicator(
                      height: homeIndicatorHeight,
                      label: 'Bottom Safe Area',
                      isActive: bottomSafeArea,
                      hasHomeIndicator: true,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafeAreaIndicator extends StatelessWidget {
  const _SafeAreaIndicator({
    required this.height,
    required this.label,
    required this.isActive,
    this.hasNotch = false,
    this.hasHomeIndicator = false,
  });

  final double height;
  final String label;
  final bool isActive;
  final bool hasNotch;
  final bool hasHomeIndicator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: isActive
          ? PlaygroundTheme.success.withValues(alpha: 0.2)
          : PlaygroundTheme.error.withValues(alpha: 0.1),
      child: Stack(
        children: [
          // Notch or home indicator
          if (hasNotch)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 100,
                  height: 28,
                  decoration: BoxDecoration(
                    color: context.borderColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          if (hasHomeIndicator)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: context.borderColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          // Label
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive ? Icons.check_circle : Icons.cancel,
                  size: 12,
                  color: isActive ? PlaygroundTheme.success : PlaygroundTheme.error,
                ),
                const SizedBox(width: 4),
                Text(
                  isActive ? 'Active' : 'Disabled',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isActive ? PlaygroundTheme.success : PlaygroundTheme.error,
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

class _ConvenienceConstructorsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ConstructorCard(
          title: 'SmartSafeArea.mobileOnly',
          description: 'Apply safe areas only on mobile/watch, disabled on tablet/desktop',
          code: '''SmartSafeArea.mobileOnly(
  child: Scaffold(
    body: MyContent(),
  ),
)

// Equivalent to:
SmartSafeArea(
  watchLeft: true, watchTop: true, watchRight: true, watchBottom: true,
  mobileLeft: true, mobileTop: true, mobileRight: true, mobileBottom: true,
  tabletLeft: false, tabletTop: false, tabletRight: false, tabletBottom: false,
  desktopLeft: false, desktopTop: false, desktopRight: false, desktopBottom: false,
  child: MyContent(),
)''',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _ConstructorCard(
          title: 'SmartSafeArea.topOnlyMobile',
          description: 'Only apply top safe area on mobile (for status bar/notch)',
          code: '''SmartSafeArea.topOnlyMobile(
  child: Scaffold(
    appBar: AppBar(title: Text('My App')),
    body: MyContent(),
  ),
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

class _SliverSafeAreaDemo extends StatelessWidget {
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
                'SliverSmartSafeArea',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Use SliverSmartSafeArea in CustomScrollView to apply safe area padding to slivers.',
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
          code: '''CustomScrollView(
  slivers: [
    SliverSmartSafeArea(
      top: true,
      bottom: true,
      minimum: EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(
            title: Text('Item \$index'),
          ),
          childCount: 20,
        ),
      ),
    ),
  ],
)''',
          title: 'sliver_smart_safe_area_example.dart',
        ),
      ],
    );
  }
}

class _ContextExtensionsDemo extends StatelessWidget {
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
                'Available Extensions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _ExtensionRow(name: 'context.safeAreaPadding', description: 'Full EdgeInsets'),
              _ExtensionRow(name: 'context.safeAreaTop', description: 'Top padding value'),
              _ExtensionRow(name: 'context.safeAreaBottom', description: 'Bottom padding value'),
              _ExtensionRow(name: 'context.safeAreaLeft', description: 'Left padding value'),
              _ExtensionRow(name: 'context.safeAreaRight', description: 'Right padding value'),
              _ExtensionRow(name: 'context.safeAreaHorizontal', description: 'Left + Right combined'),
              _ExtensionRow(name: 'context.safeAreaVertical', description: 'Top + Bottom combined'),
              _ExtensionRow(name: 'context.hasSafeAreaPadding', description: 'Has any safe area?'),
              _ExtensionRow(name: 'context.hasTopSafeArea', description: 'Has top safe area?'),
              _ExtensionRow(name: 'context.hasBottomSafeArea', description: 'Has bottom safe area?', isLast: true),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Access safe area values directly
final topPadding = context.safeAreaTop;
final bottomPadding = context.safeAreaBottom;

// Check if safe area exists
if (context.hasBottomSafeArea) {
  // Add extra padding for home indicator
}

// Use in widget
Padding(
  padding: EdgeInsets.only(
    top: context.safeAreaTop + 16,
    bottom: context.safeAreaBottom + 16,
  ),
  child: MyContent(),
)''',
          title: 'safe_area_extensions_example.dart',
        ),
      ],
    );
  }
}

class _ExtensionRow extends StatelessWidget {
  const _ExtensionRow({
    required this.name,
    required this.description,
    this.isLast = false,
  });

  final String name;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: PlaygroundTheme.primary,
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

class _UseCasesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _UseCaseCard(
            title: 'Full-screen content',
            icon: Icons.fullscreen,
            description: 'Images or videos that need to extend behind safe areas',
            code: '''SmartSafeArea(
  // Only apply safe area to UI elements
  minimum: EdgeInsets.all(16),
  child: Stack(
    children: [
      Positioned.fill(
        child: Image(...),
      ),
      // UI floats above
      Positioned(
        bottom: 0,
        child: PlayerControls(),
      ),
    ],
  ),
)''',
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _UseCaseCard(
            title: 'Floating action buttons',
            icon: Icons.add_circle,
            description: 'Position FABs above the home indicator',
            code: '''Scaffold(
  floatingActionButton: Padding(
    padding: EdgeInsets.only(
      bottom: context.hasBottomSafeArea
        ? context.safeAreaBottom
        : 0,
    ),
    child: FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    ),
  ),
)''',
          ),
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.code,
  });

  final String title;
  final IconData icon;
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
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                  ),
                  child: Icon(icon, size: 18, color: PlaygroundTheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
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
                      const SizedBox(height: 2),
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
              ],
            ),
          ),
          CodePreview(code: code, maxHeight: 200),
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
            param: 'child',
            type: 'Widget',
            description: 'The widget to wrap with safe area',
          ),
          _ApiRow(
            param: 'left/top/right/bottom',
            type: 'bool',
            description: 'Default values for all breakpoints',
          ),
          _ApiRow(
            param: 'watchLeft/Top/Right/Bottom',
            type: 'bool?',
            description: 'Override for watch breakpoint',
          ),
          _ApiRow(
            param: 'mobileLeft/Top/Right/Bottom',
            type: 'bool?',
            description: 'Override for mobile breakpoint',
          ),
          _ApiRow(
            param: 'tabletLeft/Top/Right/Bottom',
            type: 'bool?',
            description: 'Override for tablet breakpoint',
          ),
          _ApiRow(
            param: 'desktopLeft/Top/Right/Bottom',
            type: 'bool?',
            description: 'Override for desktop breakpoint',
          ),
          _ApiRow(
            param: 'tvLeft/Top/Right/Bottom',
            type: 'bool?',
            description: 'Override for TV breakpoint',
          ),
          _ApiRow(
            param: 'minimum',
            type: 'EdgeInsets',
            description: 'Minimum padding to apply',
          ),
          _ApiRow(
            param: 'maintainBottomViewPadding',
            type: 'bool',
            description: 'Maintain bottom view padding',
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
            width: 200,
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
            width: 100,
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
