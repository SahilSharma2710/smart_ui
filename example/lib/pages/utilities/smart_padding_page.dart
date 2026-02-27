import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartPadding token-based padding widget.
class SmartPaddingPage extends StatefulWidget {
  const SmartPaddingPage({super.key});

  @override
  State<SmartPaddingPage> createState() => _SmartPaddingPageState();
}

class _SmartPaddingPageState extends State<SmartPaddingPage> {
  // Padding settings
  SpacingSize _paddingSize = SpacingSize.md;
  SpacingSize? _horizontalSize = SpacingSize.md;
  SpacingSize? _verticalSize = SpacingSize.sm;
  SpacingSize? _leftSize;
  SpacingSize? _topSize;
  SpacingSize? _rightSize;
  SpacingSize? _bottomSize;

  String _paddingMode = 'all'; // 'all', 'symmetric', 'only', 'responsive'

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'SmartPadding',
      subtitle:
          'A token-based padding widget for consistent spacing using design system tokens.',
      children: [
        // Spacing Tokens Overview
        SectionHeader(
          title: 'Spacing Tokens',
          subtitle: 'Available spacing values in the design system',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSpacingTokensSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Demo
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Experiment with different padding configurations',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Usage Examples
        SectionHeader(
          title: 'Usage Examples',
          subtitle: 'Common patterns for using SmartPadding',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildUsageExamples(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Padding
        SectionHeader(
          title: 'Responsive Padding',
          subtitle: 'Different padding values per breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Helper Widgets
        SectionHeader(
          title: 'Helper Widgets',
          subtitle: 'Convenience widgets for common padding patterns',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildHelperWidgets(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // API Reference
        SectionHeader(
          title: 'API Reference',
          subtitle: 'Available constructors and parameters',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildApiReference(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildSpacingTokensSection() {
    final tokens = [
      ('zero', SpacingSize.zero, 0.0),
      ('xs', SpacingSize.xs, SmartSpacing.xs),
      ('sm', SpacingSize.sm, SmartSpacing.sm),
      ('md', SpacingSize.md, SmartSpacing.md),
      ('lg', SpacingSize.lg, SmartSpacing.lg),
      ('xl', SpacingSize.xl, SmartSpacing.xl),
      ('xxl', SpacingSize.xxl, SmartSpacing.xxl),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border:
                Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: tokens.map((token) {
              return _SpacingTokenRow(
                name: token.$1,
                size: token.$2,
                value: token.$3,
                isSelected: _paddingSize == token.$2,
                onTap: () => setState(() => _paddingSize = token.$2),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Spacing token values
SmartSpacing.zero  // 0px
SmartSpacing.xs    // 4px
SmartSpacing.sm    // 8px
SmartSpacing.md    // 16px
SmartSpacing.lg    // 24px
SmartSpacing.xl    // 32px
SmartSpacing.xxl   // 48px

// Using SpacingSize enum
SpacingSize.xs.value  // 4.0''',
          title: 'spacing_tokens.dart',
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
          desktop: 5,
          child: InteractiveControls(
            title: 'Padding Configuration',
            children: [
              DropdownControl<String>(
                label: 'Padding Mode',
                value: _paddingMode,
                options: const ['all', 'symmetric', 'only'],
                optionLabels: const {
                  'all': 'All Sides',
                  'symmetric': 'Symmetric',
                  'only': 'Individual Sides',
                },
                onChanged: (value) => setState(() => _paddingMode = value),
              ),
              if (_paddingMode == 'all')
                DropdownControl<SpacingSize>(
                  label: 'Padding Size',
                  value: _paddingSize,
                  options: SpacingSize.values,
                  optionLabels: {
                    for (var size in SpacingSize.values)
                      size: '${size.name} (${size.value.toInt()}px)',
                  },
                  onChanged: (value) => setState(() => _paddingSize = value),
                ),
              if (_paddingMode == 'symmetric') ...[
                DropdownControl<SpacingSize?>(
                  label: 'Horizontal',
                  value: _horizontalSize,
                  options: [null, ...SpacingSize.values],
                  optionLabels: {
                    null: 'None',
                    for (var size in SpacingSize.values)
                      size: '${size.name} (${size.value.toInt()}px)',
                  },
                  onChanged: (value) =>
                      setState(() => _horizontalSize = value),
                ),
                DropdownControl<SpacingSize?>(
                  label: 'Vertical',
                  value: _verticalSize,
                  options: [null, ...SpacingSize.values],
                  optionLabels: {
                    null: 'None',
                    for (var size in SpacingSize.values)
                      size: '${size.name} (${size.value.toInt()}px)',
                  },
                  onChanged: (value) => setState(() => _verticalSize = value),
                ),
              ],
              if (_paddingMode == 'only') ...[
                _buildSideDropdown('Left', _leftSize,
                    (v) => setState(() => _leftSize = v)),
                _buildSideDropdown('Top', _topSize,
                    (v) => setState(() => _topSize = v)),
                _buildSideDropdown('Right', _rightSize,
                    (v) => setState(() => _rightSize = v)),
                _buildSideDropdown('Bottom', _bottomSize,
                    (v) => setState(() => _bottomSize = v)),
              ],
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius:
                      BorderRadius.circular(PlaygroundTheme.radiusLg),
                  border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.5)),
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                      border: Border.all(
                        color: PlaygroundTheme.primary.withValues(alpha: 0.3),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: _buildPaddingWidget(
                      Container(
                        width: 120,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: PlaygroundTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(
                              PlaygroundTheme.radiusMd),
                        ),
                        child: Center(
                          child: Text(
                            'Content',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              CodePreview(
                code: _getInteractiveCode(),
                title: 'smart_padding_example.dart',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSideDropdown(
      String label, SpacingSize? value, ValueChanged<SpacingSize?> onChanged) {
    return DropdownControl<SpacingSize?>(
      label: label,
      value: value,
      options: [null, ...SpacingSize.values],
      optionLabels: {
        null: 'None',
        for (var size in SpacingSize.values)
          size: '${size.name} (${size.value.toInt()}px)',
      },
      onChanged: onChanged,
    );
  }

  Widget _buildPaddingWidget(Widget child) {
    switch (_paddingMode) {
      case 'all':
        return SmartPadding.all(_paddingSize, child: child);
      case 'symmetric':
        return SmartPadding.symmetric(
          horizontal: _horizontalSize,
          vertical: _verticalSize,
          child: child,
        );
      case 'only':
        return SmartPadding.only(
          left: _leftSize,
          top: _topSize,
          right: _rightSize,
          bottom: _bottomSize,
          child: child,
        );
      default:
        return SmartPadding.all(_paddingSize, child: child);
    }
  }

  String _getInteractiveCode() {
    switch (_paddingMode) {
      case 'all':
        return '''SmartPadding.all(
  SpacingSize.${_paddingSize.name},
  child: YourContent(),
)''';
      case 'symmetric':
        final hParam = _horizontalSize != null
            ? 'horizontal: SpacingSize.${_horizontalSize!.name},'
            : '';
        final vParam = _verticalSize != null
            ? 'vertical: SpacingSize.${_verticalSize!.name},'
            : '';
        return '''SmartPadding.symmetric(
  $hParam
  $vParam
  child: YourContent(),
)''';
      case 'only':
        final params = <String>[];
        if (_leftSize != null) {
          params.add('left: SpacingSize.${_leftSize!.name},');
        }
        if (_topSize != null) {
          params.add('top: SpacingSize.${_topSize!.name},');
        }
        if (_rightSize != null) {
          params.add('right: SpacingSize.${_rightSize!.name},');
        }
        if (_bottomSize != null) {
          params.add('bottom: SpacingSize.${_bottomSize!.name},');
        }
        return '''SmartPadding.only(
  ${params.join('\n  ')}
  child: YourContent(),
)''';
      default:
        return '';
    }
  }

  Widget _buildUsageExamples() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ExampleCard(
            title: 'Token-based All',
            description: 'Equal padding on all sides using a token',
            code: '''SmartPadding.all(
  SpacingSize.md,
  child: Card(),
)''',
            preview: SmartPadding.all(
              SpacingSize.md,
              child: _PreviewContent(),
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ExampleCard(
            title: 'Symmetric Padding',
            description: 'Different horizontal and vertical padding',
            code: '''SmartPadding.symmetric(
  horizontal: SpacingSize.lg,
  vertical: SpacingSize.sm,
  child: Card(),
)''',
            preview: SmartPadding.symmetric(
              horizontal: SpacingSize.lg,
              vertical: SpacingSize.sm,
              child: _PreviewContent(),
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ExampleCard(
            title: 'Individual Sides',
            description: 'Specify padding for each side',
            code: '''SmartPadding.only(
  left: SpacingSize.xl,
  top: SpacingSize.sm,
  child: Card(),
)''',
            preview: SmartPadding.only(
              left: SpacingSize.xl,
              top: SpacingSize.sm,
              child: _PreviewContent(),
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ExampleCard(
            title: 'Direct EdgeInsets',
            description: 'Use EdgeInsets directly when needed',
            code: '''SmartPadding(
  padding: EdgeInsets.fromLTRB(
    SmartSpacing.sm,
    SmartSpacing.md,
    SmartSpacing.lg,
    SmartSpacing.xl,
  ),
  child: Card(),
)''',
            preview: SmartPadding(
              padding: EdgeInsets.fromLTRB(
                SmartSpacing.sm,
                SmartSpacing.md,
                SmartSpacing.lg,
                SmartSpacing.xl,
              ),
              child: _PreviewContent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodePreviewSplit(
          code: '''// Responsive padding that changes per breakpoint
SmartPadding.responsive(
  mobile: EdgeInsets.all(SmartSpacing.sm),
  tablet: EdgeInsets.all(SmartSpacing.md),
  desktop: EdgeInsets.all(SmartSpacing.lg),
  child: YourContent(),
)

// Values cascade up from smaller breakpoints
// Watch uses mobile value if not specified
SmartPadding.responsive(
  mobile: EdgeInsets.symmetric(horizontal: 16),
  desktop: EdgeInsets.symmetric(horizontal: 32),
  child: YourContent(),
)''',
          codeTitle: 'responsive_padding.dart',
          preview: Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Responsive Padding',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                Container(
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                    border: Border.all(
                      color: PlaygroundTheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: SmartPadding.responsive(
                    mobile: EdgeInsets.all(SmartSpacing.sm),
                    tablet: EdgeInsets.all(SmartSpacing.md),
                    desktop: EdgeInsets.all(SmartSpacing.lg),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: PlaygroundTheme.primaryGradient,
                        borderRadius:
                            BorderRadius.circular(PlaygroundTheme.radiusSm),
                      ),
                      child: Text(
                        context.responsive<String>(
                          mobile: 'Mobile: 8px',
                          tablet: 'Tablet: 16px',
                          desktop: 'Desktop: 24px',
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHelperWidgets() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _HelperWidgetCard(
            title: 'SmartHorizontalPadding',
            description: 'Applies horizontal padding only',
            code: '''SmartHorizontalPadding(
  SpacingSize.md,
  child: Text('Horizontal padding'),
)''',
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _HelperWidgetCard(
            title: 'SmartVerticalPadding',
            description: 'Applies vertical padding only',
            code: '''SmartVerticalPadding(
  SpacingSize.lg,
  child: Text('Vertical padding'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Text(
              'Constructors',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Divider(height: 1, color: context.borderColor.withValues(alpha: 0.3)),
          _ApiRow(
            param: 'SmartPadding()',
            type: 'EdgeInsets padding',
            description: 'Direct EdgeInsets padding',
          ),
          _ApiRow(
            param: 'SmartPadding.all()',
            type: 'SpacingSize size',
            description: 'Equal padding on all sides',
          ),
          _ApiRow(
            param: 'SmartPadding.symmetric()',
            type: 'SpacingSize? h, v',
            description: 'Symmetric horizontal and vertical padding',
          ),
          _ApiRow(
            param: 'SmartPadding.only()',
            type: 'SpacingSize? l, t, r, b',
            description: 'Individual side padding',
          ),
          _ApiRow(
            param: 'SmartPadding.responsive()',
            type: 'EdgeInsets? per bp',
            description: 'Breakpoint-specific padding',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _SpacingTokenRow extends StatelessWidget {
  const _SpacingTokenRow({
    required this.name,
    required this.size,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final SpacingSize size;
  final double value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: PlaygroundTheme.durationFast,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? PlaygroundTheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
          border: Border.all(
            color: isSelected
                ? PlaygroundTheme.primary
                : context.borderColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? PlaygroundTheme.primary
                      : context.textPrimaryColor,
                ),
              ),
            ),
            Container(
              width: 50,
              child: Text(
                '${value.toInt()}px',
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
                    width: value.clamp(2, 100),
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: PlaygroundTheme.primaryGradient,
                      borderRadius:
                          BorderRadius.circular(PlaygroundTheme.radiusFull),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 18,
                color: PlaygroundTheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}

class _PreviewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        gradient: PlaygroundTheme.primaryGradient,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
      ),
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.title,
    required this.description,
    required this.code,
    required this.preview,
  });

  final String title;
  final String description;
  final String code;
  final Widget preview;

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
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: context.textMutedColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
              border: Border.all(
                color: context.borderColor.withValues(alpha: 0.3),
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                  border: Border.all(
                    color: PlaygroundTheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: preview,
              ),
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
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
                fontSize: 10,
                color: context.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelperWidgetCard extends StatelessWidget {
  const _HelperWidgetCard({
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
            width: 180,
            child: Text(
              param,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
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
