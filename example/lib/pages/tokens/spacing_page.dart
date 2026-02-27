import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartSpacing tokens.
class SpacingPage extends StatefulWidget {
  const SpacingPage({super.key});

  @override
  State<SpacingPage> createState() => _SpacingPageState();
}

class _SpacingPageState extends State<SpacingPage> {
  // Interactive demo state
  SpacingSize _selectedGapSize = SpacingSize.md;
  SpacingSize _selectedPaddingSize = SpacingSize.md;
  bool _showHorizontalGap = false;

  // Custom spacing tokens for demo
  double _customXs = 4;
  double _customSm = 8;
  double _customMd = 16;
  double _customLg = 24;
  double _customXl = 32;
  double _customXxl = 48;

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'Spacing',
      subtitle: 'Consistent spacing tokens for margins, padding, and gaps.',
      children: [
        // Spacing Scale Visual Ruler
        SectionHeader(
          title: 'Spacing Scale',
          subtitle: 'Visual ruler showing all spacing token values',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSpacingRuler(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Spacing Tokens Table
        SectionHeader(
          title: 'Spacing Tokens',
          subtitle: 'All available spacing values at a glance',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSpacingTokensTable(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // SmartGap Demo
        SectionHeader(
          title: 'SmartGap Widget',
          subtitle: 'Direction-aware gap widget for consistent spacing',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSmartGapDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // SmartPadding Demo
        SectionHeader(
          title: 'SmartPadding Widget',
          subtitle: 'Token-based padding for containers',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSmartPaddingDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Spacing
        SectionHeader(
          title: 'Responsive Spacing',
          subtitle: 'Spacing that adapts to screen size',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveSpacingDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Custom Spacing Tokens
        SectionHeader(
          title: 'Custom Spacing Tokens',
          subtitle: 'Configure your own spacing scale',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildCustomSpacingDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Usage Examples
        SectionHeader(
          title: 'Usage Examples',
          subtitle: 'Common patterns with SmartSpacing',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildUsageExamples(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildSpacingRuler() {
    final spacings = [
      _SpacingInfo('xs', SmartSpacing.xs, PlaygroundTheme.watchColor),
      _SpacingInfo('sm', SmartSpacing.sm, PlaygroundTheme.mobileColor),
      _SpacingInfo('md', SmartSpacing.md, PlaygroundTheme.tabletColor),
      _SpacingInfo('lg', SmartSpacing.lg, PlaygroundTheme.desktopColor),
      _SpacingInfo('xl', SmartSpacing.xl, PlaygroundTheme.tvColor),
      _SpacingInfo('xxl', SmartSpacing.xxl, PlaygroundTheme.primary),
    ];

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
          // Visual ruler
          ...spacings.map((info) => _buildRulerRow(info)),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          // Scale bar
          _buildScaleBar(spacings),
        ],
      ),
    );
  }

  Widget _buildRulerRow(_SpacingInfo info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PlaygroundTheme.spaceSm),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              info.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
                color: info.color,
              ),
            ),
          ),
          const SizedBox(width: PlaygroundTheme.spaceSm),
          AnimatedContainer(
            duration: PlaygroundTheme.durationNormal,
            width: info.value * 3, // Scale up for visibility
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  info.color,
                  info.color.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
              boxShadow: [
                BoxShadow(
                  color: info.color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PlaygroundTheme.spaceSm,
              vertical: PlaygroundTheme.spaceXs,
            ),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              '${info.value.toInt()}px',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScaleBar(List<_SpacingInfo> spacings) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: spacings.asMap().entries.map((entry) {
          final info = entry.value;
          final flex = info.value.toInt();
          return Expanded(
            flex: flex,
            child: Container(
              decoration: BoxDecoration(
                color: info.color.withValues(alpha: 0.2),
                border: Border(
                  right: entry.key < spacings.length - 1
                      ? BorderSide(
                          color: context.borderColor.withValues(alpha: 0.3),
                        )
                      : BorderSide.none,
                ),
              ),
              child: Center(
                child: Text(
                  info.name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: info.color,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpacingTokensTable() {
    final tokens = [
      _TokenInfo('zero', '0', 'No spacing'),
      _TokenInfo('xs', '4px', 'Extra small - tight spacing'),
      _TokenInfo('sm', '8px', 'Small - compact elements'),
      _TokenInfo('md', '16px', 'Medium - default spacing'),
      _TokenInfo('lg', '24px', 'Large - section spacing'),
      _TokenInfo('xl', '32px', 'Extra large - major sections'),
      _TokenInfo('xxl', '48px', 'Extra extra large - page sections'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(PlaygroundTheme.radiusLg),
                topRight: Radius.circular(PlaygroundTheme.radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Token',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textMutedColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Value',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textMutedColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textMutedColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Visual',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textMutedColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Rows
          ...tokens.asMap().entries.map((entry) {
            final index = entry.key;
            final token = entry.value;
            final value = _getTokenValue(token.name);
            return Container(
              padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.borderColor.withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          'SmartSpacing.${token.name}',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'monospace',
                            color: PlaygroundTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      token.value,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      token.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          width: value,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getColorForIndex(index),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  double _getTokenValue(String name) {
    return switch (name) {
      'zero' => 0,
      'xs' => 4,
      'sm' => 8,
      'md' => 16,
      'lg' => 24,
      'xl' => 32,
      'xxl' => 48,
      _ => 0,
    };
  }

  Color _getColorForIndex(int index) {
    final colors = [
      context.textMutedColor,
      PlaygroundTheme.watchColor,
      PlaygroundTheme.mobileColor,
      PlaygroundTheme.tabletColor,
      PlaygroundTheme.desktopColor,
      PlaygroundTheme.tvColor,
      PlaygroundTheme.primary,
    ];
    return colors[index % colors.length];
  }

  Widget _buildSmartGapDemo() {
    return SmartLayout(
      mobile: Column(
        children: [
          _buildSmartGapControls(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildSmartGapPreview(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: _buildSmartGapControls(),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(child: _buildSmartGapPreview()),
        ],
      ),
    );
  }

  Widget _buildSmartGapControls() {
    return InteractiveControls(
      title: 'SmartGap Controls',
      children: [
        DropdownControl<SpacingSize>(
          label: 'Gap Size',
          value: _selectedGapSize,
          options:
              SpacingSize.values.where((s) => s != SpacingSize.zero).toList(),
          optionLabels: {
            for (final size in SpacingSize.values)
              size: '${size.name} (${size.value.toInt()}px)'
          },
          onChanged: (value) => setState(() => _selectedGapSize = value),
        ),
        SwitchControl(
          label: 'Horizontal Direction',
          value: _showHorizontalGap,
          onChanged: (value) => setState(() => _showHorizontalGap = value),
          description: 'Toggle between Column and Row',
        ),
      ],
    );
  }

  Widget _buildSmartGapPreview() {
    final gapValue = _selectedGapSize.value;

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
            'Preview - ${_showHorizontalGap ? 'Row' : 'Column'} with SmartGap.${_selectedGapSize.name}()',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: _showHorizontalGap
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDemoBox('A'),
                      SmartGap(_selectedGapSize),
                      _buildDemoBox('B'),
                      SmartGap(_selectedGapSize),
                      _buildDemoBox('C'),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDemoBox('Item 1'),
                      SmartGap(_selectedGapSize),
                      _buildDemoBox('Item 2'),
                      SmartGap(_selectedGapSize),
                      _buildDemoBox('Item 3'),
                    ],
                  ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Row(
            children: [
              Icon(
                Icons.straighten,
                size: 16,
                color: PlaygroundTheme.primary,
              ),
              const SizedBox(width: PlaygroundTheme.spaceSm),
              Text(
                'Gap: ${gapValue.toInt()}px',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDemoBox(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PlaygroundTheme.spaceMd,
        vertical: PlaygroundTheme.spaceSm,
      ),
      decoration: BoxDecoration(
        color: PlaygroundTheme.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
        border: Border.all(
          color: PlaygroundTheme.primary.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: PlaygroundTheme.primary,
        ),
      ),
    );
  }

  Widget _buildSmartPaddingDemo() {
    return CodePreviewSplit(
      code: '''// SmartPadding with token sizes
SmartPadding.all(
  SpacingSize.${_selectedPaddingSize.name},
  child: Container(...),
)

// Symmetric padding
SmartPadding.symmetric(
  horizontal: SpacingSize.lg,
  vertical: SpacingSize.md,
  child: Container(...),
)

// Specific sides
SmartPadding.only(
  left: SpacingSize.md,
  top: SpacingSize.sm,
  child: Container(...),
)

// Current padding: ${_selectedPaddingSize.value.toInt()}px''',
      codeTitle: 'smart_padding.dart',
      preview: Container(
        padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SmartPadding Demo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            // Padding size selector
            Wrap(
              spacing: PlaygroundTheme.spaceSm,
              runSpacing: PlaygroundTheme.spaceSm,
              children: SpacingSize.values
                  .where((s) => s != SpacingSize.zero)
                  .map((size) {
                final isSelected = _selectedPaddingSize == size;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPaddingSize = size),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: PlaygroundTheme.spaceSm,
                      vertical: PlaygroundTheme.spaceXs,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? PlaygroundTheme.primary.withValues(alpha: 0.15)
                          : context.surfaceElevatedColor,
                      borderRadius:
                          BorderRadius.circular(PlaygroundTheme.radiusSm),
                      border: Border.all(
                        color: isSelected
                            ? PlaygroundTheme.primary
                            : context.borderColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      size.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? PlaygroundTheme.primary
                            : context.textSecondaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            // Visual preview
            Container(
              decoration: BoxDecoration(
                color: PlaygroundTheme.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                border: Border.all(
                  color: PlaygroundTheme.accent.withValues(alpha: 0.3),
                  style: BorderStyle.solid,
                ),
              ),
              child: SmartPadding.all(
                _selectedPaddingSize,
                child: Container(
                  padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.primary.withValues(alpha: 0.15),
                    borderRadius:
                        BorderRadius.circular(PlaygroundTheme.radiusSm),
                  ),
                  child: Text(
                    'Content with ${_selectedPaddingSize.value.toInt()}px padding',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveSpacingDemo() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                PlaygroundTheme.primary.withValues(alpha: 0.1),
                PlaygroundTheme.accent.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(
              color: PlaygroundTheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.devices_outlined,
                    size: 20,
                    color: PlaygroundTheme.primary,
                  ),
                  const SizedBox(width: PlaygroundTheme.spaceSm),
                  Text(
                    'Responsive Gap Demo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDemoBox('A'),
                  SmartGap.responsive(
                    mobile: 8,
                    tablet: 16,
                    desktop: 32,
                  ),
                  _buildDemoBox('B'),
                ],
              ),
              const SizedBox(height: PlaygroundTheme.spaceSm),
              Text(
                'Current gap: ${context.isDesktop ? '32px' : context.isTablet ? '16px' : '8px'} (${context.isDesktop ? 'desktop' : context.isTablet ? 'tablet' : 'mobile'})',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: context.textMutedColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Responsive gap
SmartGap.responsive(
  mobile: 8,
  tablet: 16,
  desktop: 32,
)

// Responsive padding
SmartPadding.responsive(
  mobile: EdgeInsets.all(SmartSpacing.sm),
  tablet: EdgeInsets.all(SmartSpacing.md),
  desktop: EdgeInsets.all(SmartSpacing.lg),
  child: MyContent(),
)''',
          title: 'responsive_spacing.dart',
        ),
      ],
    );
  }

  Widget _buildCustomSpacingDemo() {
    return SmartLayout(
      mobile: Column(
        children: [
          _buildCustomSpacingControls(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildCustomSpacingCode(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: _buildCustomSpacingControls(),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(child: _buildCustomSpacingCode()),
        ],
      ),
    );
  }

  Widget _buildCustomSpacingControls() {
    return InteractiveControls(
      title: 'Custom Tokens',
      children: [
        SliderControl(
          label: 'xs',
          value: _customXs,
          min: 0,
          max: 16,
          divisions: 16,
          valueLabel: '${_customXs.toInt()}px',
          onChanged: (value) => setState(() => _customXs = value),
        ),
        SliderControl(
          label: 'sm',
          value: _customSm,
          min: 0,
          max: 24,
          divisions: 24,
          valueLabel: '${_customSm.toInt()}px',
          onChanged: (value) => setState(() => _customSm = value),
        ),
        SliderControl(
          label: 'md',
          value: _customMd,
          min: 8,
          max: 32,
          divisions: 24,
          valueLabel: '${_customMd.toInt()}px',
          onChanged: (value) => setState(() => _customMd = value),
        ),
        SliderControl(
          label: 'lg',
          value: _customLg,
          min: 16,
          max: 48,
          divisions: 32,
          valueLabel: '${_customLg.toInt()}px',
          onChanged: (value) => setState(() => _customLg = value),
        ),
        SliderControl(
          label: 'xl',
          value: _customXl,
          min: 24,
          max: 64,
          divisions: 40,
          valueLabel: '${_customXl.toInt()}px',
          onChanged: (value) => setState(() => _customXl = value),
        ),
        SliderControl(
          label: 'xxl',
          value: _customXxl,
          min: 32,
          max: 96,
          divisions: 64,
          valueLabel: '${_customXxl.toInt()}px',
          onChanged: (value) => setState(() => _customXxl = value),
        ),
      ],
    );
  }

  Widget _buildCustomSpacingCode() {
    return CodePreview(
      code: '''SmartApp(
  spacingTokens: SmartSpacingTokens.custom(
    xs: ${_customXs.toInt()},
    sm: ${_customSm.toInt()},
    md: ${_customMd.toInt()},
    lg: ${_customLg.toInt()},
    xl: ${_customXl.toInt()},
    xxl: ${_customXxl.toInt()},
  ),
  home: MyApp(),
)

// Default values for reference:
// xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48''',
      title: 'custom_spacing_tokens.dart',
    );
  }

  Widget _buildUsageExamples() {
    return CodePreview(
      code: '''// SmartSpacing constants
Padding(
  padding: EdgeInsets.all(SmartSpacing.md),  // 16px
  child: Text('Hello'),
)

// SmartGap in Column (vertical)
Column(
  children: [
    Text('Line 1'),
    SmartGap.md(),  // 16px vertical gap
    Text('Line 2'),
  ],
)

// SmartGap in Row (horizontal)
Row(
  children: [
    Icon(Icons.star),
    SmartGap.sm(),  // 8px horizontal gap
    Text('Rating'),
  ],
)

// HGap and VGap for explicit direction
Row(children: [Text('A'), HGap.md(), Text('B')])
Column(children: [Text('1'), VGap.lg(), Text('2')])

// SmartPadding with tokens
SmartPadding.all(SpacingSize.lg, child: MyContent())
SmartPadding.symmetric(
  horizontal: SpacingSize.md,
  vertical: SpacingSize.sm,
  child: MyContent(),
)

// Helper EdgeInsets methods
SmartSpacing.all(16)        // EdgeInsets.all(16)
SmartSpacing.horizontal(8)  // EdgeInsets.symmetric(horizontal: 8)
SmartSpacing.vertical(12)   // EdgeInsets.symmetric(vertical: 12)
SmartSpacing.only(left: 8, top: 4)''',
      title: 'spacing_usage.dart',
    );
  }
}

class _SpacingInfo {
  const _SpacingInfo(this.name, this.value, this.color);

  final String name;
  final double value;
  final Color color;
}

class _TokenInfo {
  const _TokenInfo(this.name, this.value, this.description);

  final String name;
  final String value;
  final String description;
}
