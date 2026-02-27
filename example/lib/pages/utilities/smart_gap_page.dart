import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartGap, HGap, VGap spacer widgets.
class SmartGapPage extends StatefulWidget {
  const SmartGapPage({super.key});

  @override
  State<SmartGapPage> createState() => _SmartGapPageState();
}

class _SmartGapPageState extends State<SmartGapPage> {
  // Gap settings
  SpacingSize _gapSize = SpacingSize.md;
  double _customGapValue = 16;
  bool _useColumn = true;

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'SmartGap & Spacers',
      subtitle:
          'Token-based gap widgets for consistent spacing between elements.',
      children: [
        // Overview Section
        SectionHeader(
          title: 'Smart Spacer Widgets',
          subtitle: 'Three widgets for different spacing needs',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildOverviewSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Demo
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Experiment with different gap sizes',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // SmartGap Auto-Detection
        SectionHeader(
          title: 'SmartGap Auto-Detection',
          subtitle:
              'SmartGap automatically detects parent direction (Row/Column)',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildAutoDetectionSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Size Presets
        SectionHeader(
          title: 'Size Presets',
          subtitle: 'Convenient constructors for common sizes',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSizePresetsSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Gaps
        SectionHeader(
          title: 'Responsive Gaps',
          subtitle: 'Different gap sizes per breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // API Reference
        SectionHeader(
          title: 'API Reference',
          subtitle: 'Available constructors and their usage',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildApiReference(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildOverviewSection() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 4,
          child: _GapWidgetCard(
            title: 'SmartGap',
            icon: Icons.swap_vert,
            description:
                'Auto-detects parent direction. Use in Row or Column.',
            code: '''Column(
  children: [
    Text('Hello'),
    SmartGap.md(), // Auto: vertical
    Text('World'),
  ],
)''',
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 4,
          child: _GapWidgetCard(
            title: 'HGap',
            icon: Icons.swap_horiz,
            description: 'Explicit horizontal gap. Use when direction is known.',
            code: '''Row(
  children: [
    Icon(Icons.star),
    HGap.sm(), // Horizontal gap
    Text('Rating'),
  ],
)''',
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 4,
          child: _GapWidgetCard(
            title: 'VGap',
            icon: Icons.height,
            description: 'Explicit vertical gap. Use when direction is known.',
            code: '''Column(
  children: [
    Header(),
    VGap.lg(), // Vertical gap
    Content(),
  ],
)''',
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveDemo() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 4,
          child: InteractiveControls(
            title: 'Gap Settings',
            children: [
              SwitchControl(
                label: 'Use Column',
                value: _useColumn,
                description: _useColumn ? 'Vertical layout' : 'Horizontal layout',
                onChanged: (value) => setState(() => _useColumn = value),
              ),
              DropdownControl<SpacingSize>(
                label: 'Gap Size (Token)',
                value: _gapSize,
                options: SpacingSize.values,
                optionLabels: {
                  for (var size in SpacingSize.values)
                    size: '${size.name} (${size.value.toInt()}px)',
                },
                onChanged: (value) => setState(() => _gapSize = value),
              ),
              SliderControl(
                label: 'Custom Value',
                value: _customGapValue,
                min: 0,
                max: 64,
                divisions: 16,
                valueLabel: '${_customGapValue.toInt()}px',
                onChanged: (value) => setState(() => _customGapValue = value),
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
                padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
                  border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.5)),
                ),
                child: _useColumn
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _DemoBox(label: 'Item 1'),
                          SmartGap(_gapSize),
                          _DemoBox(label: 'Item 2'),
                          SmartGap(_gapSize),
                          _DemoBox(label: 'Item 3'),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _DemoBox(label: 'Item 1'),
                          SmartGap(_gapSize),
                          _DemoBox(label: 'Item 2'),
                          SmartGap(_gapSize),
                          _DemoBox(label: 'Item 3'),
                        ],
                      ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              CodePreview(
                code: _getInteractiveCode(),
                title: 'gap_example.dart',
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getInteractiveCode() {
    final container = _useColumn ? 'Column' : 'Row';
    return '''$container(
  children: [
    Item1(),
    SmartGap.${_gapSize.name}(),  // ${_gapSize.value.toInt()}px
    Item2(),
    SmartGap.${_gapSize.name}(),
    Item3(),
  ],
)

// Or with custom value:
SmartGap.value(${_customGapValue.toInt()})''';
  }

  Widget _buildAutoDetectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartGrid(
          spacing: SmartSpacing.md,
          children: [
            SmartCol(
              mobile: 12,
              tablet: 6,
              child: Container(
                padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
                  border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.swap_vert,
                          size: 18,
                          color: PlaygroundTheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'In a Column (Vertical)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PlaygroundTheme.spaceMd),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.surfaceElevatedColor,
                        borderRadius:
                            BorderRadius.circular(PlaygroundTheme.radiusMd),
                      ),
                      child: Column(
                        children: [
                          _SmallDemoBox(),
                          SmartGap.md(),
                          _SmallDemoBox(),
                          SmartGap.md(),
                          _SmallDemoBox(),
                        ],
                      ),
                    ),
                    const SizedBox(height: PlaygroundTheme.spaceSm),
                    Text(
                      'SmartGap creates SizedBox(height: 16)',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SmartCol(
              mobile: 12,
              tablet: 6,
              child: Container(
                padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
                  border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.swap_horiz,
                          size: 18,
                          color: PlaygroundTheme.accent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'In a Row (Horizontal)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PlaygroundTheme.spaceMd),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.surfaceElevatedColor,
                        borderRadius:
                            BorderRadius.circular(PlaygroundTheme.radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SmallDemoBox(),
                          SmartGap.md(),
                          _SmallDemoBox(),
                          SmartGap.md(),
                          _SmallDemoBox(),
                        ],
                      ),
                    ),
                    const SizedBox(height: PlaygroundTheme.spaceSm),
                    Text(
                      'SmartGap creates SizedBox(width: 16)',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: PlaygroundTheme.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            border:
                Border.all(color: PlaygroundTheme.info.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18,
                color: PlaygroundTheme.info,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'SmartGap looks for the nearest Row, Column, or Flex ancestor to determine direction. '
                  'If none is found, it defaults to vertical.',
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSizePresetsSection() {
    final presets = [
      ('SmartGap.zero()', SpacingSize.zero),
      ('SmartGap.xs()', SpacingSize.xs),
      ('SmartGap.sm()', SpacingSize.sm),
      ('SmartGap.md()', SpacingSize.md),
      ('SmartGap.lg()', SpacingSize.lg),
      ('SmartGap.xl()', SpacingSize.xl),
      ('SmartGap.xxl()', SpacingSize.xxl),
    ];

    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: presets.asMap().entries.map((entry) {
          final isLast = entry.key == presets.length - 1;
          final preset = entry.value;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
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
                SizedBox(
                  width: 150,
                  child: Text(
                    preset.$1,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: PlaygroundTheme.primary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    '${preset.$2.value.toInt()}px',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: context.textMutedColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: preset.$2.value.clamp(2, 150),
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: PlaygroundTheme.primaryGradient,
                          borderRadius:
                              BorderRadius.circular(PlaygroundTheme.radiusFull),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildResponsiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodePreviewSplit(
          code: '''// Responsive gap with different sizes per breakpoint
SmartGap.responsive(
  mobile: 8,
  tablet: 16,
  desktop: 24,
)

// Values cascade up from smaller breakpoints
// Watch uses mobile value if not specified
SmartGap.responsive(
  mobile: 12,
  desktop: 32,
)

// Use in a Column
Column(
  children: [
    Header(),
    SmartGap.responsive(
      mobile: 16,
      desktop: 32,
    ),
    Content(),
  ],
)''',
          codeTitle: 'responsive_gap.dart',
          preview: Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Responsive Gap',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor,
                    borderRadius:
                        BorderRadius.circular(PlaygroundTheme.radiusMd),
                  ),
                  child: Column(
                    children: [
                      _SmallDemoBox(label: 'Top'),
                      SmartGap.responsive(
                        mobile: 8,
                        tablet: 16,
                        desktop: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(PlaygroundTheme.radiusFull),
                        ),
                        child: Text(
                          context.responsive<String>(
                            mobile: 'Gap: 8px',
                            tablet: 'Gap: 16px',
                            desktop: 'Gap: 24px',
                          ),
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: PlaygroundTheme.primary,
                          ),
                        ),
                      ),
                      SmartGap.responsive(
                        mobile: 8,
                        tablet: 16,
                        desktop: 24,
                      ),
                      _SmallDemoBox(label: 'Bottom'),
                    ],
                  ),
                ),
              ],
            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SmartGap
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Text(
              'SmartGap (Auto-detects direction)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Divider(height: 1, color: context.borderColor.withValues(alpha: 0.3)),
          _ApiRow(
            constructor: 'SmartGap(SpacingSize)',
            description: 'Gap with spacing token size',
          ),
          _ApiRow(
            constructor: 'SmartGap.value(double)',
            description: 'Gap with custom pixel value',
          ),
          _ApiRow(
            constructor: 'SmartGap.zero/xs/sm/md/lg/xl/xxl()',
            description: 'Size preset constructors',
          ),
          _ApiRow(
            constructor: 'SmartGap.responsive(...)',
            description: 'Breakpoint-specific gap sizes',
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // HGap
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Text(
              'HGap (Horizontal)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Divider(height: 1, color: context.borderColor.withValues(alpha: 0.3)),
          _ApiRow(
            constructor: 'HGap(SpacingSize)',
            description: 'Horizontal gap with spacing token',
          ),
          _ApiRow(
            constructor: 'HGap.value(double)',
            description: 'Horizontal gap with custom value',
          ),
          _ApiRow(
            constructor: 'HGap.zero/xs/sm/md/lg/xl/xxl()',
            description: 'Size preset constructors',
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // VGap
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Text(
              'VGap (Vertical)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Divider(height: 1, color: context.borderColor.withValues(alpha: 0.3)),
          _ApiRow(
            constructor: 'VGap(SpacingSize)',
            description: 'Vertical gap with spacing token',
          ),
          _ApiRow(
            constructor: 'VGap.value(double)',
            description: 'Vertical gap with custom value',
          ),
          _ApiRow(
            constructor: 'VGap.zero/xs/sm/md/lg/xl/xxl()',
            description: 'Size preset constructors',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _GapWidgetCard extends StatelessWidget {
  const _GapWidgetCard({
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
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: PlaygroundTheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
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

class _DemoBox extends StatelessWidget {
  const _DemoBox({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: PlaygroundTheme.primaryGradient,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SmallDemoBox extends StatelessWidget {
  const _SmallDemoBox({this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: label != null ? null : 60,
      height: 30,
      padding:
          label != null ? const EdgeInsets.symmetric(horizontal: 12) : null,
      decoration: BoxDecoration(
        gradient: PlaygroundTheme.primaryGradient,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
      ),
      child: label != null
          ? Center(
              child: Text(
                label!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({
    required this.constructor,
    required this.description,
    this.isLast = false,
  });

  final String constructor;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PlaygroundTheme.spaceMd,
        vertical: PlaygroundTheme.spaceSm,
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              constructor,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
