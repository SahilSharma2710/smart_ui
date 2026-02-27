import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartText typography token-based text widget.
class SmartTextPage extends StatefulWidget {
  const SmartTextPage({super.key});

  @override
  State<SmartTextPage> createState() => _SmartTextPageState();
}

class _SmartTextPageState extends State<SmartTextPage> {
  // Text settings
  TypographyStyle _selectedStyle = TypographyStyle.bodyLarge;
  String _sampleText = 'The quick brown fox jumps over the lazy dog';
  TextAlign _textAlign = TextAlign.left;
  int? _maxLines;
  Color? _textColor;

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'SmartText',
      subtitle:
          'Typography token-based text widget for consistent styling across your app.',
      children: [
        // Typography Scale Overview
        SectionHeader(
          title: 'Typography Scale',
          subtitle: 'Material Design 3 typography styles',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildTypographyScaleSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Demo
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Experiment with different typography styles',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Text
        SectionHeader(
          title: 'Responsive Typography',
          subtitle: 'Different styles per breakpoint',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Convenience Widgets
        SectionHeader(
          title: 'Convenience Widgets',
          subtitle: 'Pre-configured text widgets for common use cases',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildConvenienceWidgets(),
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

  Widget _buildTypographyScaleSection() {
    final categories = [
      (
        'Display',
        [
          TypographyStyle.displayLarge,
          TypographyStyle.displayMedium,
          TypographyStyle.displaySmall,
        ]
      ),
      (
        'Headline',
        [
          TypographyStyle.headlineLarge,
          TypographyStyle.headlineMedium,
          TypographyStyle.headlineSmall,
        ]
      ),
      (
        'Title',
        [
          TypographyStyle.titleLarge,
          TypographyStyle.titleMedium,
          TypographyStyle.titleSmall,
        ]
      ),
      (
        'Body',
        [
          TypographyStyle.bodyLarge,
          TypographyStyle.bodyMedium,
          TypographyStyle.bodySmall,
        ]
      ),
      (
        'Label',
        [
          TypographyStyle.labelLarge,
          TypographyStyle.labelMedium,
          TypographyStyle.labelSmall,
        ]
      ),
    ];

    return SmartGrid(
      spacing: SmartSpacing.md,
      children: categories.map((category) {
        return SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _TypographyCategory(
            title: category.$1,
            styles: category.$2,
            selectedStyle: _selectedStyle,
            onStyleSelected: (style) => setState(() => _selectedStyle = style),
          ),
        );
      }).toList(),
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
            title: 'Text Settings',
            children: [
              DropdownControl<TypographyStyle>(
                label: 'Typography Style',
                value: _selectedStyle,
                options: TypographyStyle.values,
                optionLabels: {
                  for (var style in TypographyStyle.values)
                    style: _formatStyleName(style),
                },
                onChanged: (value) => setState(() => _selectedStyle = value),
              ),
              TextInputControl(
                label: 'Sample Text',
                value: _sampleText,
                onChanged: (value) => setState(() => _sampleText = value),
              ),
              DropdownControl<TextAlign>(
                label: 'Text Align',
                value: _textAlign,
                options: TextAlign.values,
                optionLabels: {
                  TextAlign.left: 'Left',
                  TextAlign.center: 'Center',
                  TextAlign.right: 'Right',
                  TextAlign.justify: 'Justify',
                  TextAlign.start: 'Start',
                  TextAlign.end: 'End',
                },
                onChanged: (value) => setState(() => _textAlign = value),
              ),
              DropdownControl<int?>(
                label: 'Max Lines',
                value: _maxLines,
                options: const [null, 1, 2, 3, 5],
                optionLabels: {
                  null: 'Unlimited',
                  1: '1 line',
                  2: '2 lines',
                  3: '3 lines',
                  5: '5 lines',
                },
                onChanged: (value) => setState(() => _maxLines = value),
              ),
              ColorPickerControl(
                label: 'Text Color',
                value: _textColor ?? PlaygroundTheme.textPrimaryDark,
                colors: [
                  PlaygroundTheme.textPrimaryDark,
                  PlaygroundTheme.primary,
                  PlaygroundTheme.accent,
                  PlaygroundTheme.success,
                  PlaygroundTheme.error,
                  PlaygroundTheme.warning,
                ],
                onChanged: (value) => setState(() => _textColor = value),
              ),
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
                height: 200,
                padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius:
                      BorderRadius.circular(PlaygroundTheme.radiusLg),
                  border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.5)),
                ),
                child: Center(
                  child: SmartText(
                    _sampleText,
                    style: _selectedStyle,
                    textAlign: _textAlign,
                    maxLines: _maxLines,
                    overflow:
                        _maxLines != null ? TextOverflow.ellipsis : null,
                    textColor: _textColor,
                  ),
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _buildStyleInfo(),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              CodePreview(
                code: _getInteractiveCode(),
                title: 'smart_text_example.dart',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStyleInfo() {
    final textStyle = SmartTypography.fromStyle(_selectedStyle);
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
      ),
      child: Row(
        children: [
          _StyleInfoItem(
            label: 'Size',
            value: '${textStyle.fontSize?.toInt() ?? 0}px',
          ),
          _StyleInfoItem(
            label: 'Weight',
            value: _fontWeightName(textStyle.fontWeight),
          ),
          _StyleInfoItem(
            label: 'Height',
            value: textStyle.height?.toStringAsFixed(2) ?? 'auto',
          ),
          _StyleInfoItem(
            label: 'Spacing',
            value: '${textStyle.letterSpacing ?? 0}',
          ),
        ],
      ),
    );
  }

  String _fontWeightName(FontWeight? weight) {
    if (weight == null) return 'normal';
    switch (weight) {
      case FontWeight.w100:
        return '100';
      case FontWeight.w200:
        return '200';
      case FontWeight.w300:
        return '300';
      case FontWeight.w400:
        return '400 (normal)';
      case FontWeight.w500:
        return '500 (medium)';
      case FontWeight.w600:
        return '600 (semi)';
      case FontWeight.w700:
        return '700 (bold)';
      case FontWeight.w800:
        return '800';
      case FontWeight.w900:
        return '900';
      default:
        return 'normal';
    }
  }

  String _formatStyleName(TypographyStyle style) {
    final name = style.name;
    // Convert camelCase to Title Case with spaces
    final formatted = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  String _getInteractiveCode() {
    final params = <String>[];
    params.add("'$_sampleText'");
    params.add('style: TypographyStyle.${_selectedStyle.name},');
    if (_textAlign != TextAlign.left) {
      params.add('textAlign: TextAlign.${_textAlign.name},');
    }
    if (_maxLines != null) {
      params.add('maxLines: $_maxLines,');
      params.add('overflow: TextOverflow.ellipsis,');
    }
    if (_textColor != null) {
      params.add('textColor: yourColor,');
    }

    return '''SmartText(
  ${params.join('\n  ')}
)''';
  }

  Widget _buildResponsiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodePreviewSplit(
          code: '''// Typography that changes per breakpoint
SmartText.responsive(
  'Responsive Heading',
  mobile: TypographyStyle.headlineSmall,
  tablet: TypographyStyle.headlineMedium,
  desktop: TypographyStyle.headlineLarge,
)

// Values cascade up from smaller breakpoints
SmartText.responsive(
  'Responsive Body',
  mobile: TypographyStyle.bodySmall,
  desktop: TypographyStyle.bodyLarge,
)''',
          codeTitle: 'responsive_text.dart',
          preview: Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Responsive Text',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                SmartText.responsive(
                  'Responsive Heading',
                  mobile: TypographyStyle.headlineSmall,
                  tablet: TypographyStyle.headlineMedium,
                  desktop: TypographyStyle.headlineLarge,
                  textColor: context.textPrimaryColor,
                ),
                const SizedBox(height: PlaygroundTheme.spaceSm),
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
                      mobile: 'headlineSmall (24px)',
                      tablet: 'headlineMedium (28px)',
                      desktop: 'headlineLarge (32px)',
                    ),
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: PlaygroundTheme.primary,
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

  Widget _buildConvenienceWidgets() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ConvenienceWidgetCard(
            title: 'DisplayText',
            description: 'For large display headlines',
            sizes: ['large', 'medium', 'small'],
            code: '''DisplayText(
  'Big Title',
  size: DisplaySize.large,
  textColor: Colors.blue,
)''',
            preview: DisplayText(
              'Display',
              size: DisplaySize.small,
              textColor: context.textPrimaryColor,
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ConvenienceWidgetCard(
            title: 'HeadlineText',
            description: 'For section headings',
            sizes: ['large', 'medium', 'small'],
            code: '''HeadlineText(
  'Section Title',
  size: HeadlineSize.medium,
)''',
            preview: HeadlineText(
              'Headline',
              size: HeadlineSize.small,
              textColor: context.textPrimaryColor,
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ConvenienceWidgetCard(
            title: 'BodyText',
            description: 'For body content',
            sizes: ['large', 'medium', 'small'],
            code: '''BodyText(
  'Lorem ipsum dolor sit amet...',
  size: BodySize.medium,
)''',
            preview: BodyText(
              'Body text content',
              size: BodySize.medium,
              textColor: context.textPrimaryColor,
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ConvenienceWidgetCard(
            title: 'LabelText',
            description: 'For labels and captions',
            sizes: ['large', 'medium', 'small'],
            code: '''LabelText(
  'FORM LABEL',
  size: LabelSize.medium,
)''',
            preview: LabelText(
              'Label text',
              size: LabelSize.medium,
              textColor: context.textPrimaryColor,
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
        children: [
          _ApiRow(
            param: 'text',
            type: 'String',
            description: 'The text to display',
          ),
          _ApiRow(
            param: 'style',
            type: 'TypographyStyle',
            description: 'The typography style token to use',
          ),
          _ApiRow(
            param: 'textAlign',
            type: 'TextAlign?',
            description: 'How to align the text horizontally',
          ),
          _ApiRow(
            param: 'textDirection',
            type: 'TextDirection?',
            description: 'The direction of the text',
          ),
          _ApiRow(
            param: 'overflow',
            type: 'TextOverflow?',
            description: 'How visual overflow should be handled',
          ),
          _ApiRow(
            param: 'maxLines',
            type: 'int?',
            description: 'Maximum number of lines',
          ),
          _ApiRow(
            param: 'softWrap',
            type: 'bool?',
            description: 'Whether to break at soft line breaks',
          ),
          _ApiRow(
            param: 'textColor',
            type: 'Color?',
            description: 'Override color for the text',
          ),
          _ApiRow(
            param: 'customStyle',
            type: 'TextStyle?',
            description: 'Custom TextStyle to merge with token style',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TypographyCategory extends StatelessWidget {
  const _TypographyCategory({
    required this.title,
    required this.styles,
    required this.selectedStyle,
    required this.onStyleSelected,
  });

  final String title;
  final List<TypographyStyle> styles;
  final TypographyStyle selectedStyle;
  final ValueChanged<TypographyStyle> onStyleSelected;

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
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: context.borderColor.withValues(alpha: 0.3),
          ),
          ...styles.map((style) {
            final isSelected = style == selectedStyle;
            final textStyle = SmartTypography.fromStyle(style);
            final name = style.name;
            final size = name.contains('Large')
                ? 'Large'
                : name.contains('Medium')
                    ? 'Medium'
                    : 'Small';

            return GestureDetector(
              onTap: () => onStyleSelected(style),
              child: AnimatedContainer(
                duration: PlaygroundTheme.durationFast,
                padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                decoration: BoxDecoration(
                  color: isSelected
                      ? PlaygroundTheme.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            size,
                            style: textStyle.copyWith(
                              color: isSelected
                                  ? PlaygroundTheme.primary
                                  : context.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${textStyle.fontSize?.toInt()}px',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: context.textMutedColor,
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
          }),
        ],
      ),
    );
  }
}

class _StyleInfoItem extends StatelessWidget {
  const _StyleInfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: context.textMutedColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConvenienceWidgetCard extends StatelessWidget {
  const _ConvenienceWidgetCard({
    required this.title,
    required this.description,
    required this.sizes,
    required this.code,
    required this.preview,
  });

  final String title;
  final String description;
  final List<String> sizes;
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
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: PlaygroundTheme.primary,
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 4,
                children: sizes
                    .map((size) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: context.surfaceElevatedColor,
                            borderRadius: BorderRadius.circular(
                                PlaygroundTheme.radiusFull),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 10,
                              color: context.textMutedColor,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
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
            width: double.infinity,
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: preview,
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
            width: 130,
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
