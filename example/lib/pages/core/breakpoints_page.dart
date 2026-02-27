import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for the 5 breakpoint system.
class BreakpointsPage extends StatefulWidget {
  const BreakpointsPage({super.key});

  @override
  State<BreakpointsPage> createState() => _BreakpointsPageState();
}

class _BreakpointsPageState extends State<BreakpointsPage> {
  // Simulated width for the resizable demo
  double _simulatedWidth = 800.0;

  // Custom breakpoint values for the interactive editor
  double _customMobile = 300;
  double _customTablet = 600;
  double _customDesktop = 900;
  double _customTv = 1200;

  String get _currentBreakpointName {
    if (_simulatedWidth < _customMobile) return 'watch';
    if (_simulatedWidth < _customTablet) return 'mobile';
    if (_simulatedWidth < _customDesktop) return 'tablet';
    if (_simulatedWidth < _customTv) return 'desktop';
    return 'tv';
  }

  Color get _currentBreakpointColor =>
      PlaygroundTheme.colorForBreakpoint(_currentBreakpointName);

  IconData get _currentBreakpointIcon =>
      PlaygroundTheme.iconForBreakpoint(_currentBreakpointName);

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'Breakpoints',
      subtitle:
          'A 5-breakpoint system for building truly responsive Flutter applications.',
      children: [
        // Live Current Breakpoint Display
        _buildCurrentBreakpointDisplay(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Breakpoint Overview
        SectionHeader(
          title: 'The 5 Breakpoint System',
          subtitle: 'From wearables to large screens',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildBreakpointOverview(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Resizer Demo
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Drag the slider to see breakpoint changes in real-time',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveResizer(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Using Breakpoints in Code
        SectionHeader(
          title: 'Using Breakpoints',
          subtitle: 'Context extensions for breakpoint detection',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildBreakpointUsageSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Custom Breakpoints
        SectionHeader(
          title: 'Custom Breakpoints',
          subtitle: 'Adjust thresholds to match your design requirements',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildCustomBreakpointsSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Value Example
        SectionHeader(
          title: 'Responsive Values',
          subtitle: 'Return different values based on breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveValueExample(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildCurrentBreakpointDisplay() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getBreakpointColorForContext().withValues(alpha: 0.15),
            _getBreakpointColorForContext().withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: _getBreakpointColorForContext().withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getBreakpointIconForContext(),
                size: 48,
                color: _getBreakpointColorForContext(),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Breakpoint',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  Text(
                    _getBreakpointNameForContext().toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: _getBreakpointColorForContext(),
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PlaygroundTheme.spaceMd,
              vertical: PlaygroundTheme.spaceSm,
            ),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.aspect_ratio,
                  size: 16,
                  color: context.textMutedColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Screen Width: ${context.screenWidth.toInt()}px',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'monospace',
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Text(
            'Resize your browser window to see the breakpoint change',
            style: TextStyle(
              fontSize: 12,
              color: context.textMutedColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getBreakpointNameForContext() {
    if (context.isWatch) return 'watch';
    if (context.isMobile) return 'mobile';
    if (context.isTablet) return 'tablet';
    if (context.isDesktop) return 'desktop';
    return 'tv';
  }

  Color _getBreakpointColorForContext() {
    return PlaygroundTheme.colorForBreakpoint(_getBreakpointNameForContext());
  }

  IconData _getBreakpointIconForContext() {
    return PlaygroundTheme.iconForBreakpoint(_getBreakpointNameForContext());
  }

  Widget _buildBreakpointOverview() {
    final breakpoints = [
      _BreakpointInfo(
        name: 'watch',
        minWidth: 0,
        maxWidth: 299,
        icon: Icons.watch_outlined,
        color: PlaygroundTheme.watchColor,
        description: 'Wearable devices like smartwatches',
        examples: 'Apple Watch, Wear OS',
      ),
      _BreakpointInfo(
        name: 'mobile',
        minWidth: 300,
        maxWidth: 599,
        icon: Icons.phone_android_outlined,
        color: PlaygroundTheme.mobileColor,
        description: 'Mobile phones in portrait mode',
        examples: 'iPhone, Android phones',
      ),
      _BreakpointInfo(
        name: 'tablet',
        minWidth: 600,
        maxWidth: 899,
        icon: Icons.tablet_android_outlined,
        color: PlaygroundTheme.tabletColor,
        description: 'Tablets and large phones in landscape',
        examples: 'iPad Mini, Android tablets',
      ),
      _BreakpointInfo(
        name: 'desktop',
        minWidth: 900,
        maxWidth: 1199,
        icon: Icons.desktop_windows_outlined,
        color: PlaygroundTheme.desktopColor,
        description: 'Desktop and laptop screens',
        examples: 'MacBook, Windows laptops',
      ),
      _BreakpointInfo(
        name: 'tv',
        minWidth: 1200,
        maxWidth: double.infinity,
        icon: Icons.tv_outlined,
        color: PlaygroundTheme.tvColor,
        description: 'Large screens and TVs',
        examples: 'Smart TVs, 4K monitors',
      ),
    ];

    return Column(
      children: [
        // Visual breakpoint bar
        _buildBreakpointBar(breakpoints),
        const SizedBox(height: PlaygroundTheme.spaceLg),
        // Breakpoint cards
        ...breakpoints.map((bp) => Padding(
              padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
              child: _buildBreakpointCard(bp),
            )),
      ],
    );
  }

  Widget _buildBreakpointBar(List<_BreakpointInfo> breakpoints) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        child: Row(
          children: breakpoints.asMap().entries.map((entry) {
            final index = entry.key;
            final bp = entry.value;
            final flex = index == breakpoints.length - 1
                ? 2
                : ((bp.maxWidth - bp.minWidth) / 100).round().clamp(1, 3);
            final isActive = _isBreakpointActive(bp.name);

            return Expanded(
              flex: flex,
              child: AnimatedContainer(
                duration: PlaygroundTheme.durationFast,
                decoration: BoxDecoration(
                  color: isActive
                      ? bp.color.withValues(alpha: 0.2)
                      : bp.color.withValues(alpha: 0.05),
                  border: Border(
                    right: index < breakpoints.length - 1
                        ? BorderSide(
                            color: context.borderColor.withValues(alpha: 0.3),
                          )
                        : BorderSide.none,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      bp.icon,
                      size: 18,
                      color: isActive ? bp.color : context.textMutedColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bp.minWidth.toInt().toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: isActive
                            ? bp.color
                            : context.textMutedColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  bool _isBreakpointActive(String name) {
    return _getBreakpointNameForContext() == name;
  }

  Widget _buildBreakpointCard(_BreakpointInfo bp) {
    final isActive = _isBreakpointActive(bp.name);

    return AnimatedContainer(
      duration: PlaygroundTheme.durationFast,
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: isActive
            ? bp.color.withValues(alpha: 0.1)
            : context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: isActive
              ? bp.color.withValues(alpha: 0.5)
              : context.borderColor.withValues(alpha: 0.5),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bp.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Icon(
              bp.icon,
              color: bp.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      bp.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: bp.color,
                        letterSpacing: 1,
                      ),
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: bp.color,
                          borderRadius:
                              BorderRadius.circular(PlaygroundTheme.radiusFull),
                        ),
                        child: Text(
                          'ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  bp.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Text(
              bp.maxWidth == double.infinity
                  ? '${bp.minWidth.toInt()}px+'
                  : '${bp.minWidth.toInt()} - ${bp.maxWidth.toInt()}px',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
                color: context.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveResizer() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          // Current simulated breakpoint display
          AnimatedContainer(
            duration: PlaygroundTheme.durationFast,
            padding: const EdgeInsets.symmetric(
              horizontal: PlaygroundTheme.spaceLg,
              vertical: PlaygroundTheme.spaceMd,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _currentBreakpointColor.withValues(alpha: 0.2),
                  _currentBreakpointColor.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
              border: Border.all(
                color: _currentBreakpointColor.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _currentBreakpointIcon,
                  size: 28,
                  color: _currentBreakpointColor,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentBreakpointName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _currentBreakpointColor,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '${_simulatedWidth.toInt()}px',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'monospace',
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          // Breakpoint indicator bar
          _buildInteractiveBreakpointBar(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Slider
          Row(
            children: [
              Text(
                '0px',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: context.textMutedColor,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: _currentBreakpointColor,
                    inactiveTrackColor:
                        context.borderColor.withValues(alpha: 0.3),
                    thumbColor: _currentBreakpointColor,
                    overlayColor: _currentBreakpointColor.withValues(alpha: 0.1),
                    trackHeight: 6,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 10),
                  ),
                  child: Slider(
                    value: _simulatedWidth,
                    min: 200,
                    max: 1600,
                    onChanged: (value) {
                      setState(() => _simulatedWidth = value);
                    },
                  ),
                ),
              ),
              Text(
                '1600px',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: context.textMutedColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Quick select buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _QuickWidthButton(
                label: 'Watch',
                width: 280,
                color: PlaygroundTheme.watchColor,
                onTap: () => setState(() => _simulatedWidth = 280),
              ),
              _QuickWidthButton(
                label: 'Mobile',
                width: 375,
                color: PlaygroundTheme.mobileColor,
                onTap: () => setState(() => _simulatedWidth = 375),
              ),
              _QuickWidthButton(
                label: 'Tablet',
                width: 768,
                color: PlaygroundTheme.tabletColor,
                onTap: () => setState(() => _simulatedWidth = 768),
              ),
              _QuickWidthButton(
                label: 'Desktop',
                width: 1024,
                color: PlaygroundTheme.desktopColor,
                onTap: () => setState(() => _simulatedWidth = 1024),
              ),
              _QuickWidthButton(
                label: 'TV',
                width: 1400,
                color: PlaygroundTheme.tvColor,
                onTap: () => setState(() => _simulatedWidth = 1400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveBreakpointBar() {
    final segments = [
      _BreakpointSegment('watch', 0, _customMobile, PlaygroundTheme.watchColor),
      _BreakpointSegment(
          'mobile', _customMobile, _customTablet, PlaygroundTheme.mobileColor),
      _BreakpointSegment(
          'tablet', _customTablet, _customDesktop, PlaygroundTheme.tabletColor),
      _BreakpointSegment(
          'desktop', _customDesktop, _customTv, PlaygroundTheme.desktopColor),
      _BreakpointSegment('tv', _customTv, 1600, PlaygroundTheme.tvColor),
    ];

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        child: Stack(
          children: [
            Row(
              children: segments.map((seg) {
                final width = (seg.end - seg.start) / 1600;
                final isActive = _simulatedWidth >= seg.start &&
                    (_simulatedWidth < seg.end || seg.name == 'tv');

                return Expanded(
                  flex: (width * 100).round().clamp(1, 100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isActive
                          ? seg.color.withValues(alpha: 0.3)
                          : seg.color.withValues(alpha: 0.1),
                    ),
                    child: Center(
                      child: Text(
                        seg.name,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.normal,
                          color: isActive ? seg.color : context.textMutedColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            // Position indicator
            Positioned(
              left: (_simulatedWidth / 1600) *
                      (MediaQuery.of(context).size.width - 100) -
                  1,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                color: context.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakpointUsageSection() {
    return SmartLayout(
      mobile: Column(
        children: [
          _buildUsageCodePreview(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildUsageCheckboxDemo(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildUsageCodePreview()),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(child: _buildUsageCheckboxDemo()),
        ],
      ),
    );
  }

  Widget _buildUsageCodePreview() {
    return CodePreview(
      code: '''// Direct breakpoint checks
if (context.isMobile) {
  return MobileLayout();
}

// Check current breakpoint
final bp = context.breakpoint;
if (bp >= SmartBreakpoint.tablet) {
  showSidebar();
}

// Convenient range checks
context.isWatch           // < 300px
context.isMobile          // 300-599px
context.isTablet          // 600-899px
context.isDesktop         // 900-1199px
context.isTv              // >= 1200px

// Combined checks
context.isMobileOrSmaller // watch or mobile
context.isTabletOrLarger  // tablet, desktop, or tv
context.isDesktopOrLarger // desktop or tv''',
      title: 'breakpoint_checks.dart',
    );
  }

  Widget _buildUsageCheckboxDemo() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Breakpoint Checks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _BreakpointCheckRow(label: 'context.isWatch', value: context.isWatch),
          _BreakpointCheckRow(
              label: 'context.isMobile', value: context.isMobile),
          _BreakpointCheckRow(
              label: 'context.isTablet', value: context.isTablet),
          _BreakpointCheckRow(
              label: 'context.isDesktop', value: context.isDesktop),
          _BreakpointCheckRow(label: 'context.isTv', value: context.isTv),
          const Divider(height: 24),
          _BreakpointCheckRow(
              label: 'context.isMobileOrSmaller',
              value: context.isMobileOrSmaller),
          _BreakpointCheckRow(
              label: 'context.isTabletOrLarger',
              value: context.isTabletOrLarger),
          _BreakpointCheckRow(
              label: 'context.isDesktopOrLarger',
              value: context.isDesktopOrLarger),
        ],
      ),
    );
  }

  Widget _buildCustomBreakpointsSection() {
    return SmartLayout(
      mobile: Column(
        children: [
          _buildCustomBreakpointsControls(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildCustomBreakpointsCode(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: _buildCustomBreakpointsControls(),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(child: _buildCustomBreakpointsCode()),
        ],
      ),
    );
  }

  Widget _buildCustomBreakpointsControls() {
    return InteractiveControls(
      title: 'Custom Thresholds',
      children: [
        SliderControl(
          label: 'Mobile',
          value: _customMobile,
          min: 200,
          max: 400,
          divisions: 20,
          valueLabel: '${_customMobile.toInt()}px',
          onChanged: (value) => setState(() => _customMobile = value),
        ),
        SliderControl(
          label: 'Tablet',
          value: _customTablet,
          min: 400,
          max: 800,
          divisions: 40,
          valueLabel: '${_customTablet.toInt()}px',
          onChanged: (value) => setState(() => _customTablet = value),
        ),
        SliderControl(
          label: 'Desktop',
          value: _customDesktop,
          min: 700,
          max: 1100,
          divisions: 40,
          valueLabel: '${_customDesktop.toInt()}px',
          onChanged: (value) => setState(() => _customDesktop = value),
        ),
        SliderControl(
          label: 'TV',
          value: _customTv,
          min: 1000,
          max: 1600,
          divisions: 60,
          valueLabel: '${_customTv.toInt()}px',
          onChanged: (value) => setState(() => _customTv = value),
        ),
      ],
    );
  }

  Widget _buildCustomBreakpointsCode() {
    return CodePreview(
      code: '''SmartApp(
  breakpoints: SmartBreakpoints.custom(
    watch: 0,           // Always 0
    mobile: ${_customMobile.toInt()},       // Your value
    tablet: ${_customTablet.toInt()},       // Your value
    desktop: ${_customDesktop.toInt()},      // Your value
    tv: ${_customTv.toInt()},          // Your value
  ),
  home: HomeScreen(),
)

// Default breakpoints for reference:
// watch: 0, mobile: 300, tablet: 600,
// desktop: 900, tv: 1200''',
      title: 'custom_breakpoints.dart',
    );
  }

  Widget _buildResponsiveValueExample() {
    final currentPadding = context.responsive<double>(
      mobile: 16,
      tablet: 24,
      desktop: 32,
    );

    final currentColumns = context.responsive<int>(
      mobile: 1,
      tablet: 2,
      desktop: 4,
    );

    return CodePreviewSplit(
      code: '''// Get different values per breakpoint
final padding = context.responsive<double>(
  mobile: 16,
  tablet: 24,
  desktop: 32,
);

final columns = context.responsive<int>(
  mobile: 1,
  tablet: 2,
  desktop: 4,
);

// Shorthand version
final gap = context.bp<double>(
  mobile: 8,
  desktop: 16,
);

// Mobile vs other helper
final showSidebar = context.mobileOr(
  mobile: false,
  other: true,
);''',
      codeTitle: 'responsive_values.dart',
      preview: Container(
        padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Live Values',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ResponsiveValueDisplay(
              label: 'padding',
              value: '${currentPadding.toInt()}px',
            ),
            _ResponsiveValueDisplay(
              label: 'columns',
              value: currentColumns.toString(),
            ),
            _ResponsiveValueDisplay(
              label: 'breakpoint',
              value: context.breakpoint.name,
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakpointInfo {
  const _BreakpointInfo({
    required this.name,
    required this.minWidth,
    required this.maxWidth,
    required this.icon,
    required this.color,
    required this.description,
    required this.examples,
  });

  final String name;
  final double minWidth;
  final double maxWidth;
  final IconData icon;
  final Color color;
  final String description;
  final String examples;
}

class _BreakpointSegment {
  const _BreakpointSegment(this.name, this.start, this.end, this.color);

  final String name;
  final double start;
  final double end;
  final Color color;
}

class _QuickWidthButton extends StatelessWidget {
  const _QuickWidthButton({
    required this.label,
    required this.width,
    required this.color,
    required this.onTap,
  });

  final String label;
  final double width;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            Text(
              '${width.toInt()}px',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: color.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakpointCheckRow extends StatelessWidget {
  const _BreakpointCheckRow({
    required this.label,
    required this.value,
  });

  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            value ? Icons.check_circle : Icons.cancel_outlined,
            size: 18,
            color: value ? PlaygroundTheme.success : context.textMutedColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
                color: value
                    ? context.textPrimaryColor
                    : context.textMutedColor,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: value
                  ? PlaygroundTheme.success.withValues(alpha: 0.1)
                  : context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              value ? 'true' : 'false',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
                color: value
                    ? PlaygroundTheme.success
                    : context.textMutedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveValueDisplay extends StatelessWidget {
  const _ResponsiveValueDisplay({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'monospace',
              color: context.textSecondaryColor,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: PlaygroundTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
