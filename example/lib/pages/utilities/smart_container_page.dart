import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartContainer responsive max-width container.
class SmartContainerPage extends StatefulWidget {
  const SmartContainerPage({super.key});

  @override
  State<SmartContainerPage> createState() => _SmartContainerPageState();
}

class _SmartContainerPageState extends State<SmartContainerPage> {
  // Container settings
  String _selectedSize = 'lg';
  double _customMaxWidth = 1024;
  bool _showPadding = true;
  Alignment _alignment = Alignment.topCenter;

  final Map<String, double> _sizeValues = {
    'sm': 640,
    'md': 768,
    'lg': 1024,
    'xl': 1280,
    'xxl': 1536,
    'fluid': double.infinity,
  };

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'SmartContainer',
      subtitle:
          'A responsive container widget with max-width constraints for consistent layouts.',
      children: [
        // Size Presets Section
        SectionHeader(
          title: 'Container Sizes',
          subtitle: 'Pre-configured size presets for common layouts',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSizePresetsSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Demo Section
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Adjust container settings and see changes in real-time',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Container Section
        SectionHeader(
          title: 'Responsive Max-Width',
          subtitle: 'Different max-widths per breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Additional Containers Section
        SectionHeader(
          title: 'Related Widgets',
          subtitle: 'Additional container variations',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildRelatedWidgets(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // API Reference
        SectionHeader(
          title: 'API Reference',
          subtitle: 'Available parameters and their types',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildApiReference(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildSizePresetsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Size cards
        SmartGrid(
          spacing: SmartSpacing.sm,
          children: _sizeValues.entries.map((entry) {
            final isSelected = _selectedSize == entry.key;
            final maxWidth = entry.value;
            final label = entry.key.toUpperCase();
            final widthText = maxWidth == double.infinity
                ? 'Full width'
                : '${maxWidth.toInt()}px';

            return SmartCol(
              mobile: 6,
              tablet: 4,
              desktop: 2,
              child: GestureDetector(
                onTap: () => setState(() => _selectedSize = entry.key),
                child: AnimatedContainer(
                  duration: PlaygroundTheme.durationFast,
                  padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? PlaygroundTheme.primary.withValues(alpha: 0.1)
                        : context.surfaceColor,
                    borderRadius:
                        BorderRadius.circular(PlaygroundTheme.radiusMd),
                    border: Border.all(
                      color: isSelected
                          ? PlaygroundTheme.primary
                          : context.borderColor.withValues(alpha: 0.5),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? PlaygroundTheme.primary
                              : context.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widthText,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: isSelected
                              ? PlaygroundTheme.primary
                              : context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: PlaygroundTheme.spaceLg),
        // Preview
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: context.surfaceElevatedColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border:
                Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Stack(
            children: [
              // Background grid
              Positioned.fill(
                child: CustomPaint(
                  painter: _GridPainter(
                    color: context.borderColor.withValues(alpha: 0.2),
                  ),
                ),
              ),
              // Container visualization
              Center(
                child: AnimatedContainer(
                  duration: PlaygroundTheme.durationNormal,
                  curve: PlaygroundTheme.curveSnappy,
                  constraints: BoxConstraints(
                    maxWidth: _sizeValues[_selectedSize] == double.infinity
                        ? context.screenWidth - 48
                        : (_sizeValues[_selectedSize]! * 0.5)
                            .clamp(100, context.screenWidth - 48),
                  ),
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: PlaygroundTheme.primaryGradient,
                    borderRadius:
                        BorderRadius.circular(PlaygroundTheme.radiusMd),
                    boxShadow: PlaygroundTheme.glowShadow,
                  ),
                  child: Center(
                    child: Text(
                      'SmartContainer.${_selectedSize}()',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: _getPresetCode(),
          title: 'container_presets.dart',
        ),
      ],
    );
  }

  String _getPresetCode() {
    if (_selectedSize == 'fluid') {
      return '''// Full-width container (no max-width constraint)
SmartContainer.fluid(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: YourContent(),
)''';
    }
    return '''// Max-width: ${_sizeValues[_selectedSize]!.toInt()}px
SmartContainer.${_selectedSize}(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: YourContent(),
)''';
  }

  Widget _buildInteractiveDemo() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 4,
          child: InteractiveControls(
            title: 'Container Settings',
            children: [
              DropdownControl<String>(
                label: 'Size Preset',
                value: _selectedSize,
                options: _sizeValues.keys.toList(),
                optionLabels: {
                  'sm': 'Small (640px)',
                  'md': 'Medium (768px)',
                  'lg': 'Large (1024px)',
                  'xl': 'Extra Large (1280px)',
                  'xxl': 'XXL (1536px)',
                  'fluid': 'Fluid (Full Width)',
                },
                onChanged: (value) => setState(() => _selectedSize = value),
              ),
              SliderControl(
                label: 'Custom Max Width',
                value: _customMaxWidth,
                min: 320,
                max: 1920,
                divisions: 32,
                valueLabel: '${_customMaxWidth.toInt()}px',
                onChanged: (value) =>
                    setState(() => _customMaxWidth = value),
              ),
              SwitchControl(
                label: 'Show Padding',
                value: _showPadding,
                description: 'Add horizontal padding',
                onChanged: (value) => setState(() => _showPadding = value),
              ),
              DropdownControl<Alignment>(
                label: 'Alignment',
                value: _alignment,
                options: const [
                  Alignment.topLeft,
                  Alignment.topCenter,
                  Alignment.topRight,
                  Alignment.centerLeft,
                  Alignment.center,
                  Alignment.centerRight,
                ],
                optionLabels: {
                  Alignment.topLeft: 'Top Left',
                  Alignment.topCenter: 'Top Center',
                  Alignment.topRight: 'Top Right',
                  Alignment.centerLeft: 'Center Left',
                  Alignment.center: 'Center',
                  Alignment.centerRight: 'Center Right',
                },
                onChanged: (value) => setState(() => _alignment = value),
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
                  border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.5)),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GridPainter(
                          color: context.borderColor.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    SmartContainer(
                      maxWidth: _customMaxWidth,
                      alignment: _alignment,
                      padding: _showPadding
                          ? const EdgeInsets.symmetric(
                              horizontal: SmartSpacing.md,
                            )
                          : null,
                      child: Container(
                        height: 160,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: PlaygroundTheme.primaryGradient,
                          borderRadius:
                              BorderRadius.circular(PlaygroundTheme.radiusMd),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SmartContainer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'maxWidth: ${_customMaxWidth.toInt()}px',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              CodePreview(
                code: _getCustomCode(),
                title: 'custom_container.dart',
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getCustomCode() {
    return '''SmartContainer(
  maxWidth: ${_customMaxWidth.toInt()},
  alignment: Alignment.${_alignmentToString(_alignment)},${_showPadding ? '''
  padding: EdgeInsets.symmetric(horizontal: SmartSpacing.md),''' : ''}
  child: YourContent(),
)''';
  }

  String _alignmentToString(Alignment alignment) {
    if (alignment == Alignment.topLeft) return 'topLeft';
    if (alignment == Alignment.topCenter) return 'topCenter';
    if (alignment == Alignment.topRight) return 'topRight';
    if (alignment == Alignment.centerLeft) return 'centerLeft';
    if (alignment == Alignment.center) return 'center';
    if (alignment == Alignment.centerRight) return 'centerRight';
    return 'topCenter';
  }

  Widget _buildResponsiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodePreviewSplit(
          code: '''// Different max-widths per breakpoint
SmartContainer.responsive(
  mobile: double.infinity,  // Full width on mobile
  tablet: 720,              // 720px on tablet
  desktop: 960,             // 960px on desktop
  tv: 1200,                 // 1200px on TV
  padding: EdgeInsets.symmetric(horizontal: SmartSpacing.md),
  child: YourContent(),
)

// Values cascade up from smaller breakpoints
// If tablet is not specified, it uses mobile value
SmartContainer.responsive(
  mobile: double.infinity,
  desktop: 1024,
  child: YourContent(),
)''',
          codeTitle: 'responsive_container.dart',
          preview: Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Breakpoint Values',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                _ResponsiveValueRow(
                  breakpoint: 'mobile',
                  value: 'infinity (full width)',
                  isActive: context.isMobileOrSmaller,
                ),
                _ResponsiveValueRow(
                  breakpoint: 'tablet',
                  value: '720px',
                  isActive: context.isTablet,
                ),
                _ResponsiveValueRow(
                  breakpoint: 'desktop',
                  value: '960px',
                  isActive: context.isDesktop,
                ),
                _ResponsiveValueRow(
                  breakpoint: 'tv',
                  value: '1200px',
                  isActive: context.isTv,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedWidgets() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _RelatedWidgetCard(
            title: 'ResponsivePaddedContainer',
            description: 'Auto-applies responsive padding based on breakpoint',
            code: '''ResponsivePaddedContainer(
  maxWidth: 1200,
  mobilePadding: EdgeInsets.all(16),
  tabletPadding: EdgeInsets.all(24),
  desktopPadding: EdgeInsets.all(32),
  child: Content(),
)''',
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _RelatedWidgetCard(
            title: 'CenteredContent',
            description: 'Simple centered container with max-width',
            code: '''CenteredContent(
  maxWidth: 800,
  horizontalPadding: SmartSpacing.md,
  verticalPadding: SmartSpacing.lg,
  child: Content(),
)''',
          ),
        ),
      ],
    );
  }

  Widget _buildApiReference() {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          _ApiRow(
            param: 'maxWidth',
            type: 'double',
            description: 'Maximum width of the container (default: 1200)',
          ),
          _ApiRow(
            param: 'padding',
            type: 'EdgeInsets?',
            description: 'Padding inside the container',
          ),
          _ApiRow(
            param: 'alignment',
            type: 'Alignment',
            description: 'How to align the child (default: topCenter)',
          ),
          _ApiRow(
            param: 'color',
            type: 'Color?',
            description: 'Background color of the container',
          ),
          _ApiRow(
            param: 'decoration',
            type: 'BoxDecoration?',
            description: 'Decoration for the container',
          ),
          _ApiRow(
            param: 'child',
            type: 'Widget',
            description: 'The child widget',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const spacing = 20.0;

    for (var x = 0.0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (var y = 0.0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ResponsiveValueRow extends StatelessWidget {
  const _ResponsiveValueRow({
    required this.breakpoint,
    required this.value,
    required this.isActive,
  });

  final String breakpoint;
  final String value;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = PlaygroundTheme.colorForBreakpoint(breakpoint);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? color.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(
          color: isActive
              ? color.withValues(alpha: 0.5)
              : context.borderColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            PlaygroundTheme.iconForBreakpoint(breakpoint),
            size: 18,
            color: isActive ? color : context.textMutedColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              breakpoint,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? color : context.textMutedColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: isActive ? color : context.textMutedColor,
            ),
          ),
          if (isActive) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
              ),
              child: Text(
                'ACTIVE',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RelatedWidgetCard extends StatelessWidget {
  const _RelatedWidgetCard({
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
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PlaygroundTheme.primary,
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
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceSm),
            decoration: BoxDecoration(
              color: context.codeBgColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: context.textPrimaryColor,
              ),
            ),
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
            width: 120,
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
            width: 140,
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
