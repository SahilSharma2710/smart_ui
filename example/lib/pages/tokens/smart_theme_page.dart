import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartTheme breakpoint-aware theming.
class SmartThemePage extends StatefulWidget {
  const SmartThemePage({super.key});

  @override
  State<SmartThemePage> createState() => _SmartThemePageState();
}

class _SmartThemePageState extends State<SmartThemePage> {
  // Simulated breakpoint for demo
  SmartBreakpoint _simulatedBreakpoint = SmartBreakpoint.desktop;

  // Custom theme values for interactive demo
  double _mobileBaseFontSize = 14;
  double _tabletBaseFontSize = 15;
  double _desktopBaseFontSize = 16;

  double _mobileBaseSpacing = 12;
  double _tabletBaseSpacing = 14;
  double _desktopBaseSpacing = 16;

  double _mobileBaseRadius = 8;
  double _tabletBaseRadius = 10;
  double _desktopBaseRadius = 12;

  int _mobileGridColumns = 4;
  int _tabletGridColumns = 8;
  int _desktopGridColumns = 12;

  // Custom tokens demo
  String _customTokenKey = 'cardElevation';
  String _customTokenValue = '4.0';

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'SmartTheme',
      subtitle: 'Breakpoint-aware theme configuration with design tokens.',
      children: [
        // Current Theme Display
        SectionHeader(
          title: 'Current Theme',
          subtitle: 'Live theme values based on your current breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildCurrentThemeDisplay(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // How SmartTheme Works
        SectionHeader(
          title: 'How SmartTheme Works',
          subtitle: 'Define different theme values for each breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildHowItWorksSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Theme Builder
        SectionHeader(
          title: 'Interactive Theme Builder',
          subtitle: 'Configure theme values per breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveThemeBuilder(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Preset Themes
        SectionHeader(
          title: 'Preset Themes',
          subtitle: 'Ready-to-use SmartThemeData presets',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildPresetThemesSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Custom Tokens
        SectionHeader(
          title: 'Custom Tokens',
          subtitle: 'Add your own design tokens to SmartThemeData',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildCustomTokensSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Theme Properties
        SectionHeader(
          title: 'Theme Properties',
          subtitle: 'All available properties in SmartThemeData',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildThemePropertiesTable(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Usage Examples
        SectionHeader(
          title: 'Usage Examples',
          subtitle: 'Accessing and using SmartTheme in your app',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildUsageExamples(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildCurrentThemeDisplay() {
    return SmartTheme(
      mobile: SmartThemeData.mobile,
      tablet: SmartThemeData.tablet,
      desktop: SmartThemeData.desktop,
      child: Builder(
        builder: (context) {
          final theme = SmartTheme.of(context);
          final breakpointName = context.isDesktop
              ? 'desktop'
              : context.isTablet
                  ? 'tablet'
                  : 'mobile';
          final breakpointColor =
              PlaygroundTheme.colorForBreakpoint(breakpointName);

          return Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  breakpointColor.withValues(alpha: 0.15),
                  breakpointColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
              border: Border.all(
                color: breakpointColor.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      PlaygroundTheme.iconForBreakpoint(breakpointName),
                      size: 32,
                      color: breakpointColor,
                    ),
                    const SizedBox(width: PlaygroundTheme.spaceMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Breakpoint',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textMutedColor,
                          ),
                        ),
                        Text(
                          breakpointName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: breakpointColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: PlaygroundTheme.spaceLg),
                // Theme values grid
                Wrap(
                  spacing: PlaygroundTheme.spaceMd,
                  runSpacing: PlaygroundTheme.spaceMd,
                  children: [
                    _buildThemeValueChip(
                        'baseFontSize', '${theme.baseFontSize}px'),
                    _buildThemeValueChip(
                        'baseSpacing', '${theme.baseSpacing}px'),
                    _buildThemeValueChip('baseRadius', '${theme.baseRadius}px'),
                    _buildThemeValueChip('gridColumns', '${theme.gridColumns}'),
                    _buildThemeValueChip('iconSize', '${theme.iconSize}px'),
                    _buildThemeValueChip(
                        'buttonHeight', '${theme.buttonHeight}px'),
                  ],
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                Text(
                  'Resize your browser to see values change automatically',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textMutedColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildThemeValueChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PlaygroundTheme.spaceSm,
        vertical: PlaygroundTheme.spaceXs,
      ),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: context.textMutedColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: PlaygroundTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return Column(
      children: [
        Container(
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
              _buildStepRow(
                1,
                'Wrap with SmartTheme',
                'Define theme values for each breakpoint',
                Icons.layers_outlined,
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _buildStepRow(
                2,
                'Access with SmartTheme.of(context)',
                'Get the current theme based on screen size',
                Icons.visibility_outlined,
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _buildStepRow(
                3,
                'Use theme values',
                'Apply baseFontSize, baseSpacing, etc.',
                Icons.brush_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartTheme(
  mobile: SmartThemeData(
    baseFontSize: 14,
    baseSpacing: 12,
    baseRadius: 8,
    gridColumns: 4,
  ),
  tablet: SmartThemeData(
    baseFontSize: 15,
    baseSpacing: 14,
    baseRadius: 10,
    gridColumns: 8,
  ),
  desktop: SmartThemeData(
    baseFontSize: 16,
    baseSpacing: 16,
    baseRadius: 12,
    gridColumns: 12,
  ),
  child: MyApp(),
)

// Access the theme
final theme = SmartTheme.of(context);
Text('Hello', style: TextStyle(fontSize: theme.baseFontSize));
Padding(padding: EdgeInsets.all(theme.baseSpacing));''',
          title: 'smart_theme_setup.dart',
        ),
      ],
    );
  }

  Widget _buildStepRow(
      int step, String title, String description, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: PlaygroundTheme.primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: PlaygroundTheme.spaceMd),
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
                  fontSize: 13,
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        Icon(
          icon,
          size: 24,
          color: context.textMutedColor,
        ),
      ],
    );
  }

  Widget _buildInteractiveThemeBuilder() {
    return SmartLayout(
      mobile: Column(
        children: [
          _buildBreakpointSelector(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildThemeControls(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildThemePreview(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildGeneratedCode(),
        ],
      ),
      desktop: Column(
        children: [
          _buildBreakpointSelector(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 320,
                child: _buildThemeControls(),
              ),
              const SizedBox(width: PlaygroundTheme.spaceMd),
              Expanded(
                child: Column(
                  children: [
                    _buildThemePreview(),
                    const SizedBox(height: PlaygroundTheme.spaceMd),
                    _buildGeneratedCode(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakpointSelector() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Editing:',
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          ...SmartBreakpoint.values
              .where((bp) =>
                  bp != SmartBreakpoint.watch && bp != SmartBreakpoint.tv)
              .map((bp) {
            final isSelected = _simulatedBreakpoint == bp;
            final color = PlaygroundTheme.colorForBreakpoint(bp.name);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => setState(() => _simulatedBreakpoint = bp),
                child: AnimatedContainer(
                  duration: PlaygroundTheme.durationFast,
                  padding: const EdgeInsets.symmetric(
                    horizontal: PlaygroundTheme.spaceMd,
                    vertical: PlaygroundTheme.spaceSm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius:
                        BorderRadius.circular(PlaygroundTheme.radiusMd),
                    border: Border.all(
                      color: isSelected
                          ? color
                          : context.borderColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PlaygroundTheme.iconForBreakpoint(bp.name),
                        size: 18,
                        color: isSelected ? color : context.textMutedColor,
                      ),
                      const SizedBox(width: PlaygroundTheme.spaceXs),
                      Text(
                        bp.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? color : context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildThemeControls() {
    // Get current breakpoint values
    double baseFontSize;
    double baseSpacing;
    double baseRadius;
    int gridColumns;

    switch (_simulatedBreakpoint) {
      case SmartBreakpoint.mobile:
      case SmartBreakpoint.watch:
        baseFontSize = _mobileBaseFontSize;
        baseSpacing = _mobileBaseSpacing;
        baseRadius = _mobileBaseRadius;
        gridColumns = _mobileGridColumns;
        break;
      case SmartBreakpoint.tablet:
        baseFontSize = _tabletBaseFontSize;
        baseSpacing = _tabletBaseSpacing;
        baseRadius = _tabletBaseRadius;
        gridColumns = _tabletGridColumns;
        break;
      case SmartBreakpoint.desktop:
      case SmartBreakpoint.tv:
        baseFontSize = _desktopBaseFontSize;
        baseSpacing = _desktopBaseSpacing;
        baseRadius = _desktopBaseRadius;
        gridColumns = _desktopGridColumns;
        break;
    }

    return InteractiveControls(
      title: '${_simulatedBreakpoint.name} Theme',
      children: [
        SliderControl(
          label: 'baseFontSize',
          value: baseFontSize,
          min: 10,
          max: 24,
          divisions: 14,
          valueLabel: '${baseFontSize.toInt()}px',
          onChanged: (value) {
            setState(() {
              switch (_simulatedBreakpoint) {
                case SmartBreakpoint.mobile:
                case SmartBreakpoint.watch:
                  _mobileBaseFontSize = value;
                  break;
                case SmartBreakpoint.tablet:
                  _tabletBaseFontSize = value;
                  break;
                case SmartBreakpoint.desktop:
                case SmartBreakpoint.tv:
                  _desktopBaseFontSize = value;
                  break;
              }
            });
          },
        ),
        SliderControl(
          label: 'baseSpacing',
          value: baseSpacing,
          min: 4,
          max: 32,
          divisions: 28,
          valueLabel: '${baseSpacing.toInt()}px',
          onChanged: (value) {
            setState(() {
              switch (_simulatedBreakpoint) {
                case SmartBreakpoint.mobile:
                case SmartBreakpoint.watch:
                  _mobileBaseSpacing = value;
                  break;
                case SmartBreakpoint.tablet:
                  _tabletBaseSpacing = value;
                  break;
                case SmartBreakpoint.desktop:
                case SmartBreakpoint.tv:
                  _desktopBaseSpacing = value;
                  break;
              }
            });
          },
        ),
        SliderControl(
          label: 'baseRadius',
          value: baseRadius,
          min: 0,
          max: 24,
          divisions: 24,
          valueLabel: '${baseRadius.toInt()}px',
          onChanged: (value) {
            setState(() {
              switch (_simulatedBreakpoint) {
                case SmartBreakpoint.mobile:
                case SmartBreakpoint.watch:
                  _mobileBaseRadius = value;
                  break;
                case SmartBreakpoint.tablet:
                  _tabletBaseRadius = value;
                  break;
                case SmartBreakpoint.desktop:
                case SmartBreakpoint.tv:
                  _desktopBaseRadius = value;
                  break;
              }
            });
          },
        ),
        SliderControl(
          label: 'gridColumns',
          value: gridColumns.toDouble(),
          min: 2,
          max: 16,
          divisions: 14,
          valueLabel: '$gridColumns',
          onChanged: (value) {
            setState(() {
              switch (_simulatedBreakpoint) {
                case SmartBreakpoint.mobile:
                case SmartBreakpoint.watch:
                  _mobileGridColumns = value.toInt();
                  break;
                case SmartBreakpoint.tablet:
                  _tabletGridColumns = value.toInt();
                  break;
                case SmartBreakpoint.desktop:
                case SmartBreakpoint.tv:
                  _desktopGridColumns = value.toInt();
                  break;
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildThemePreview() {
    // Get current breakpoint values
    double baseFontSize;
    double baseSpacing;
    double baseRadius;

    switch (_simulatedBreakpoint) {
      case SmartBreakpoint.mobile:
      case SmartBreakpoint.watch:
        baseFontSize = _mobileBaseFontSize;
        baseSpacing = _mobileBaseSpacing;
        baseRadius = _mobileBaseRadius;
        break;
      case SmartBreakpoint.tablet:
        baseFontSize = _tabletBaseFontSize;
        baseSpacing = _tabletBaseSpacing;
        baseRadius = _tabletBaseRadius;
        break;
      case SmartBreakpoint.desktop:
      case SmartBreakpoint.tv:
        baseFontSize = _desktopBaseFontSize;
        baseSpacing = _desktopBaseSpacing;
        baseRadius = _desktopBaseRadius;
        break;
    }

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
            'Preview',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Simulated card
          Container(
            padding: EdgeInsets.all(baseSpacing),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(baseRadius),
              border: Border.all(
                color: context.borderColor.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Title',
                  style: TextStyle(
                    fontSize: baseFontSize * 1.25,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                SizedBox(height: baseSpacing / 2),
                Text(
                  'This is body text using the current theme values. The font size, spacing, and border radius all adjust based on the breakpoint.',
                  style: TextStyle(
                    fontSize: baseFontSize,
                    color: context.textSecondaryColor,
                  ),
                ),
                SizedBox(height: baseSpacing),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: baseSpacing,
                        vertical: baseSpacing / 2,
                      ),
                      decoration: BoxDecoration(
                        color: PlaygroundTheme.primary,
                        borderRadius: BorderRadius.circular(baseRadius / 2),
                      ),
                      child: Text(
                        'Button',
                        style: TextStyle(
                          fontSize: baseFontSize * 0.875,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedCode() {
    return CodePreview(
      code: '''SmartTheme(
  mobile: SmartThemeData(
    baseFontSize: ${_mobileBaseFontSize.toInt()},
    baseSpacing: ${_mobileBaseSpacing.toInt()},
    baseRadius: ${_mobileBaseRadius.toInt()},
    gridColumns: $_mobileGridColumns,
  ),
  tablet: SmartThemeData(
    baseFontSize: ${_tabletBaseFontSize.toInt()},
    baseSpacing: ${_tabletBaseSpacing.toInt()},
    baseRadius: ${_tabletBaseRadius.toInt()},
    gridColumns: $_tabletGridColumns,
  ),
  desktop: SmartThemeData(
    baseFontSize: ${_desktopBaseFontSize.toInt()},
    baseSpacing: ${_desktopBaseSpacing.toInt()},
    baseRadius: ${_desktopBaseRadius.toInt()},
    gridColumns: $_desktopGridColumns,
  ),
  child: MyApp(),
)''',
      title: 'generated_theme.dart',
    );
  }

  Widget _buildPresetThemesSection() {
    return Column(
      children: [
        SmartLayout(
          mobile: Column(
            children: [
              _buildPresetCard(
                  'Mobile', SmartThemeData.mobile, PlaygroundTheme.mobileColor),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _buildPresetCard(
                  'Tablet', SmartThemeData.tablet, PlaygroundTheme.tabletColor),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _buildPresetCard('Desktop', SmartThemeData.desktop,
                  PlaygroundTheme.desktopColor),
            ],
          ),
          desktop: Row(
            children: [
              Expanded(
                child: _buildPresetCard('Mobile', SmartThemeData.mobile,
                    PlaygroundTheme.mobileColor),
              ),
              const SizedBox(width: PlaygroundTheme.spaceMd),
              Expanded(
                child: _buildPresetCard('Tablet', SmartThemeData.tablet,
                    PlaygroundTheme.tabletColor),
              ),
              const SizedBox(width: PlaygroundTheme.spaceMd),
              Expanded(
                child: _buildPresetCard('Desktop', SmartThemeData.desktop,
                    PlaygroundTheme.desktopColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Using preset themes
SmartTheme(
  mobile: SmartThemeData.mobile,
  tablet: SmartThemeData.tablet,
  desktop: SmartThemeData.desktop,
  child: MyApp(),
)

// Or use the default
SmartTheme(
  mobile: SmartThemeData.defaults,
  child: MyApp(),
)''',
          title: 'preset_themes.dart',
        ),
      ],
    );
  }

  Widget _buildPresetCard(String name, SmartThemeData theme, Color color) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PlaygroundTheme.iconForBreakpoint(name.toLowerCase()),
                size: 20,
                color: color,
              ),
              const SizedBox(width: PlaygroundTheme.spaceSm),
              Text(
                'SmartThemeData.$name',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildPresetRow('baseFontSize', '${theme.baseFontSize}'),
          _buildPresetRow('baseSpacing', '${theme.baseSpacing}'),
          _buildPresetRow('baseRadius', '${theme.baseRadius}'),
          _buildPresetRow('gridColumns', '${theme.gridColumns}'),
          _buildPresetRow('iconSize', '${theme.iconSize}'),
          _buildPresetRow('buttonHeight', '${theme.buttonHeight}'),
        ],
      ),
    );
  }

  Widget _buildPresetRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: context.textSecondaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTokensSection() {
    return CodePreviewSplit(
      code: '''// Define custom tokens
SmartThemeData(
  baseFontSize: 16,
  baseSpacing: 16,
  customTokens: {
    'cardElevation': 4.0,
    'headerHeight': 64.0,
    'sidebarWidth': 280.0,
    'animationDuration': 300,
    'primaryGradient': ['#6366F1', '#8B5CF6'],
  },
)

// Access custom tokens
final theme = SmartTheme.of(context);
final elevation = theme.token<double>('cardElevation') ?? 4.0;
final headerHeight = theme.token<double>('headerHeight') ?? 56.0;

// Type-safe access
final duration = theme.token<int>('animationDuration') ?? 200;
final colors = theme.token<List<String>>('primaryGradient');''',
      codeTitle: 'custom_tokens.dart',
      preview: Container(
        padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Tokens Demo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            TextInputControl(
              label: 'Token Key',
              value: _customTokenKey,
              onChanged: (value) => setState(() => _customTokenKey = value),
            ),
            TextInputControl(
              label: 'Token Value',
              value: _customTokenValue,
              onChanged: (value) => setState(() => _customTokenValue = value),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            Container(
              padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
              decoration: BoxDecoration(
                color: context.surfaceElevatedColor,
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Generated:',
                    style: TextStyle(
                      fontSize: 11,
                      color: context.textMutedColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "customTokens: {'$_customTokenKey': $_customTokenValue}",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: PlaygroundTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePropertiesTable() {
    final properties = [
      _PropertyInfo(
          'baseFontSize', 'double', '16', 'Base font size for body text'),
      _PropertyInfo('smallFontSize', 'double', '14', 'Small text size'),
      _PropertyInfo('largeFontSize', 'double', '18', 'Large text size'),
      _PropertyInfo('headingFontSize', 'double', '24', 'Heading text size'),
      _PropertyInfo('baseSpacing', 'double', '16', 'Base spacing value'),
      _PropertyInfo('smallSpacing', 'double', '8', 'Small spacing'),
      _PropertyInfo('largeSpacing', 'double', '24', 'Large spacing'),
      _PropertyInfo(
          'basePadding', 'EdgeInsets', 'all(16)', 'Base container padding'),
      _PropertyInfo('smallPadding', 'EdgeInsets', 'all(8)', 'Tight padding'),
      _PropertyInfo(
          'largePadding', 'EdgeInsets', 'all(24)', 'Spacious padding'),
      _PropertyInfo('baseRadius', 'double', '8', 'Base border radius'),
      _PropertyInfo('smallRadius', 'double', '4', 'Small radius'),
      _PropertyInfo('largeRadius', 'double', '16', 'Large radius'),
      _PropertyInfo(
          'containerMaxWidth', 'double?', 'null', 'Max container width'),
      _PropertyInfo('iconSize', 'double', '24', 'Default icon size'),
      _PropertyInfo('buttonHeight', 'double', '48', 'Button height'),
      _PropertyInfo('inputHeight', 'double', '48', 'Input field height'),
      _PropertyInfo('gridColumns', 'int', '12', 'Grid column count'),
      _PropertyInfo('customTokens', 'Map', '{}', 'Custom token map'),
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
                    'Property',
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
                    'Type',
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
                    'Default',
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
                    'Description',
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
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final prop = properties[index];
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
                        child: Text(
                          prop.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: PlaygroundTheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          prop.type,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          prop.defaultValue,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: context.textMutedColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          prop.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageExamples() {
    return CodePreview(
      code: '''// Setup SmartTheme in your app
SmartTheme(
  mobile: SmartThemeData.mobile,
  tablet: SmartThemeData.tablet,
  desktop: SmartThemeData.desktop,
  child: MaterialApp(home: MyHomePage()),
)

// Access theme values anywhere
Widget build(BuildContext context) {
  final theme = SmartTheme.of(context);

  return Container(
    padding: EdgeInsets.all(theme.baseSpacing),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(theme.baseRadius),
    ),
    child: Column(
      children: [
        Text(
          'Title',
          style: TextStyle(fontSize: theme.headingFontSize),
        ),
        SizedBox(height: theme.smallSpacing),
        Text(
          'Body text',
          style: TextStyle(fontSize: theme.baseFontSize),
        ),
      ],
    ),
  );
}

// Using context extension
Widget build(BuildContext context) {
  final theme = context.smartTheme;
  return Padding(
    padding: theme.basePadding,
    child: Text('Hello'),
  );
}

// Using custom tokens
final cardElevation = theme.token<double>('cardElevation') ?? 4.0;
final showAnimations = theme.token<bool>('enableAnimations') ?? true;

// Creating a copy with modifications
final customTheme = theme.copyWith(
  baseFontSize: 18,
  baseSpacing: 20,
);''',
      title: 'smart_theme_usage.dart',
    );
  }
}

class _PropertyInfo {
  const _PropertyInfo(
      this.name, this.type, this.defaultValue, this.description);

  final String name;
  final String type;
  final String defaultValue;
  final String description;
}
