import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartTypography text styles.
class TypographyPage extends StatefulWidget {
  const TypographyPage({super.key});

  @override
  State<TypographyPage> createState() => _TypographyPageState();
}

class _TypographyPageState extends State<TypographyPage> {
  // Current selected typography style for the interactive demo
  TypographyStyle _selectedStyle = TypographyStyle.bodyMedium;
  String _sampleText = 'The quick brown fox jumps over the lazy dog';
  Color _textColor = PlaygroundTheme.primary;

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'Typography',
      subtitle:
          'Consistent text styles following Material Design 3 typography scale.',
      children: [
        // Typography Scale Overview
        SectionHeader(
          title: 'Typography Scale',
          subtitle: 'A complete typographic scale from Display to Label',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildTypographyScaleOverview(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Display Styles
        SectionHeader(
          title: 'Display Styles',
          subtitle: 'Large, impactful text for hero sections',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildDisplayStylesSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Headline Styles
        SectionHeader(
          title: 'Headline Styles',
          subtitle: 'Section headings and prominent content',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildHeadlineStylesSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Title Styles
        SectionHeader(
          title: 'Title Styles',
          subtitle: 'Component titles and labels',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildTitleStylesSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Body Styles
        SectionHeader(
          title: 'Body Styles',
          subtitle: 'Main content and paragraphs',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildBodyStylesSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Label Styles
        SectionHeader(
          title: 'Label Styles',
          subtitle: 'Captions, buttons, and small text',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildLabelStylesSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Demo
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Try different typography styles with custom text',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Typography
        SectionHeader(
          title: 'Responsive Typography',
          subtitle: 'Text styles that adapt to screen size',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveTypographySection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // SmartText Usage
        SectionHeader(
          title: 'SmartText Widget',
          subtitle: 'Convenience widgets for typography tokens',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSmartTextUsageSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildTypographyScaleOverview() {
    final categories = [
      _TypographyCategory(
        name: 'Display',
        color: PlaygroundTheme.watchColor,
        styles: [
          TypographyStyle.displayLarge,
          TypographyStyle.displayMedium,
          TypographyStyle.displaySmall,
        ],
      ),
      _TypographyCategory(
        name: 'Headline',
        color: PlaygroundTheme.mobileColor,
        styles: [
          TypographyStyle.headlineLarge,
          TypographyStyle.headlineMedium,
          TypographyStyle.headlineSmall,
        ],
      ),
      _TypographyCategory(
        name: 'Title',
        color: PlaygroundTheme.tabletColor,
        styles: [
          TypographyStyle.titleLarge,
          TypographyStyle.titleMedium,
          TypographyStyle.titleSmall,
        ],
      ),
      _TypographyCategory(
        name: 'Body',
        color: PlaygroundTheme.desktopColor,
        styles: [
          TypographyStyle.bodyLarge,
          TypographyStyle.bodyMedium,
          TypographyStyle.bodySmall,
        ],
      ),
      _TypographyCategory(
        name: 'Label',
        color: PlaygroundTheme.tvColor,
        styles: [
          TypographyStyle.labelLarge,
          TypographyStyle.labelMedium,
          TypographyStyle.labelSmall,
        ],
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children:
            categories.map((category) => _buildCategoryRow(category)).toList(),
      ),
    );
  }

  Widget _buildCategoryRow(_TypographyCategory category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PlaygroundTheme.spaceSm),
      child: Row(
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(
              horizontal: PlaygroundTheme.spaceSm,
              vertical: PlaygroundTheme.spaceXs,
            ),
            decoration: BoxDecoration(
              color: category.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              category.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: category.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(
            child: Wrap(
              spacing: PlaygroundTheme.spaceSm,
              runSpacing: PlaygroundTheme.spaceSm,
              children: category.styles.map((style) {
                final textStyle = SmartTypography.fromStyle(style);
                return GestureDetector(
                  onTap: () => setState(() => _selectedStyle = style),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: PlaygroundTheme.spaceSm,
                      vertical: PlaygroundTheme.spaceXs,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedStyle == style
                          ? PlaygroundTheme.primary.withValues(alpha: 0.15)
                          : context.surfaceElevatedColor,
                      borderRadius:
                          BorderRadius.circular(PlaygroundTheme.radiusSm),
                      border: Border.all(
                        color: _selectedStyle == style
                            ? PlaygroundTheme.primary
                            : context.borderColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          style.name,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: _selectedStyle == style
                                ? PlaygroundTheme.primary
                                : context.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${textStyle.fontSize?.toInt()}',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: context.textMutedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayStylesSection() {
    return _buildStyleShowcase([
      _StyleInfo(
        style: TypographyStyle.displayLarge,
        label: 'displayLarge',
        description: 'Hero text, large headlines',
        specs: '57px / 64px line height',
      ),
      _StyleInfo(
        style: TypographyStyle.displayMedium,
        label: 'displayMedium',
        description: 'Prominent display text',
        specs: '45px / 52px line height',
      ),
      _StyleInfo(
        style: TypographyStyle.displaySmall,
        label: 'displaySmall',
        description: 'Smaller display text',
        specs: '36px / 44px line height',
      ),
    ]);
  }

  Widget _buildHeadlineStylesSection() {
    return _buildStyleShowcase([
      _StyleInfo(
        style: TypographyStyle.headlineLarge,
        label: 'headlineLarge',
        description: 'Primary section headers',
        specs: '32px / 40px line height',
      ),
      _StyleInfo(
        style: TypographyStyle.headlineMedium,
        label: 'headlineMedium',
        description: 'Secondary section headers',
        specs: '28px / 36px line height',
      ),
      _StyleInfo(
        style: TypographyStyle.headlineSmall,
        label: 'headlineSmall',
        description: 'Tertiary section headers',
        specs: '24px / 32px line height',
      ),
    ]);
  }

  Widget _buildTitleStylesSection() {
    return _buildStyleShowcase([
      _StyleInfo(
        style: TypographyStyle.titleLarge,
        label: 'titleLarge',
        description: 'Card titles, dialog headers',
        specs: '22px / 28px line height / medium',
      ),
      _StyleInfo(
        style: TypographyStyle.titleMedium,
        label: 'titleMedium',
        description: 'List item titles',
        specs: '16px / 24px line height / medium',
      ),
      _StyleInfo(
        style: TypographyStyle.titleSmall,
        label: 'titleSmall',
        description: 'Tab labels, small titles',
        specs: '14px / 20px line height / medium',
      ),
    ]);
  }

  Widget _buildBodyStylesSection() {
    return _buildStyleShowcase([
      _StyleInfo(
        style: TypographyStyle.bodyLarge,
        label: 'bodyLarge',
        description: 'Main content text',
        specs: '16px / 24px line height',
      ),
      _StyleInfo(
        style: TypographyStyle.bodyMedium,
        label: 'bodyMedium',
        description: 'Default body text',
        specs: '14px / 20px line height',
      ),
      _StyleInfo(
        style: TypographyStyle.bodySmall,
        label: 'bodySmall',
        description: 'Supporting text',
        specs: '12px / 16px line height',
      ),
    ]);
  }

  Widget _buildLabelStylesSection() {
    return _buildStyleShowcase([
      _StyleInfo(
        style: TypographyStyle.labelLarge,
        label: 'labelLarge',
        description: 'Button text, prominent labels',
        specs: '14px / 20px line height / medium',
      ),
      _StyleInfo(
        style: TypographyStyle.labelMedium,
        label: 'labelMedium',
        description: 'Chip text, secondary labels',
        specs: '12px / 16px line height / medium',
      ),
      _StyleInfo(
        style: TypographyStyle.labelSmall,
        label: 'labelSmall',
        description: 'Captions, timestamps',
        specs: '11px / 16px line height / medium',
      ),
    ]);
  }

  Widget _buildStyleShowcase(List<_StyleInfo> styles) {
    return Column(
      children: styles
          .map((info) => Padding(
                padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
                child: _buildStyleCard(info),
              ))
          .toList(),
    );
  }

  Widget _buildStyleCard(_StyleInfo info) {
    final textStyle = SmartTypography.fromStyle(info.style);
    final isSelected = _selectedStyle == info.style;

    return GestureDetector(
      onTap: () => setState(() => _selectedStyle = info.style),
      child: AnimatedContainer(
        duration: PlaygroundTheme.durationFast,
        padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
        decoration: BoxDecoration(
          color: isSelected
              ? PlaygroundTheme.primary.withValues(alpha: 0.05)
              : context.surfaceColor,
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
          border: Border.all(
            color: isSelected
                ? PlaygroundTheme.primary.withValues(alpha: 0.5)
                : context.borderColor.withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PlaygroundTheme.spaceSm,
                    vertical: PlaygroundTheme.spaceXs,
                  ),
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(PlaygroundTheme.radiusSm),
                  ),
                  child: Text(
                    info.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                      color: PlaygroundTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: PlaygroundTheme.spaceSm),
                Text(
                  info.specs,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: context.textMutedColor,
                  ),
                ),
                const Spacer(),
                Text(
                  info.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            Text(
              'The quick brown fox jumps over the lazy dog',
              style: textStyle.copyWith(
                color: context.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return SmartLayout(
      mobile: Column(
        children: [
          _buildInteractiveControls(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildInteractivePreview(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: _buildInteractiveControls(),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(child: _buildInteractivePreview()),
        ],
      ),
    );
  }

  Widget _buildInteractiveControls() {
    return InteractiveControls(
      title: 'Typography Controls',
      children: [
        DropdownControl<TypographyStyle>(
          label: 'Typography Style',
          value: _selectedStyle,
          options: TypographyStyle.values,
          optionLabels: {
            for (final style in TypographyStyle.values) style: style.name
          },
          onChanged: (value) => setState(() => _selectedStyle = value),
        ),
        TextInputControl(
          label: 'Sample Text',
          value: _sampleText,
          onChanged: (value) => setState(() => _sampleText = value),
          maxLines: 2,
        ),
        ColorPickerControl(
          label: 'Text Color',
          value: _textColor,
          colors: [
            PlaygroundTheme.primary,
            PlaygroundTheme.accent,
            PlaygroundTheme.success,
            PlaygroundTheme.error,
            PlaygroundTheme.warning,
            context.textPrimaryColor,
            context.textSecondaryColor,
          ],
          onChanged: (value) => setState(() => _textColor = value),
        ),
      ],
    );
  }

  Widget _buildInteractivePreview() {
    final textStyle = SmartTypography.fromStyle(_selectedStyle);

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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Text(
              _sampleText.isEmpty ? 'Enter some text...' : _sampleText,
              style: textStyle.copyWith(color: _textColor),
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Style details
          Wrap(
            spacing: PlaygroundTheme.spaceSm,
            runSpacing: PlaygroundTheme.spaceSm,
            children: [
              _buildStyleDetail(
                  'Font Size', '${textStyle.fontSize?.toInt()}px'),
              _buildStyleDetail('Line Height',
                  '${((textStyle.height ?? 1.0) * (textStyle.fontSize ?? 14)).toInt()}px'),
              _buildStyleDetail(
                  'Weight', _fontWeightName(textStyle.fontWeight)),
              if (textStyle.letterSpacing != null)
                _buildStyleDetail(
                    'Letter Spacing', '${textStyle.letterSpacing}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStyleDetail(String label, String value) {
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
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _fontWeightName(FontWeight? weight) {
    return switch (weight) {
      FontWeight.w100 => 'Thin',
      FontWeight.w200 => 'Extra Light',
      FontWeight.w300 => 'Light',
      FontWeight.w400 => 'Regular',
      FontWeight.w500 => 'Medium',
      FontWeight.w600 => 'Semi Bold',
      FontWeight.w700 => 'Bold',
      FontWeight.w800 => 'Extra Bold',
      FontWeight.w900 => 'Black',
      _ => 'Regular',
    };
  }

  Widget _buildResponsiveTypographySection() {
    return Column(
      children: [
        // Toggle for responsive demo
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
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
                    'Responsive Typography in Action',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              SmartText.responsive(
                'This text adapts to your screen size',
                mobile: TypographyStyle.bodyMedium,
                tablet: TypographyStyle.titleMedium,
                desktop: TypographyStyle.headlineSmall,
                textColor: context.textPrimaryColor,
              ),
              const SizedBox(height: PlaygroundTheme.spaceSm),
              Text(
                'Resize your browser to see the text style change',
                style: TextStyle(
                  fontSize: 12,
                  color: context.textMutedColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Responsive typography with SmartText
SmartText.responsive(
  'This text adapts to your screen size',
  mobile: TypographyStyle.bodyMedium,
  tablet: TypographyStyle.titleMedium,
  desktop: TypographyStyle.headlineSmall,
)

// Current breakpoint: ${context.isDesktop ? 'desktop' : context.isTablet ? 'tablet' : 'mobile'}
// Current style: ${context.isDesktop ? 'headlineSmall (24px)' : context.isTablet ? 'titleMedium (16px)' : 'bodyMedium (14px)'}''',
          title: 'responsive_typography.dart',
        ),
      ],
    );
  }

  Widget _buildSmartTextUsageSection() {
    return CodePreviewSplit(
      code: '''// Using SmartText with TypographyStyle
SmartText(
  'Hello World',
  style: TypographyStyle.headlineLarge,
)

// Using convenience widgets
DisplayText('Large Display', size: DisplaySize.large)
HeadlineText('Section Title', size: HeadlineSize.medium)
BodyText('Body content here', size: BodySize.medium)
LabelText('Caption text', size: LabelSize.small)

// Using SmartTypography directly
Text(
  'Custom styled text',
  style: SmartTypography.titleLarge.copyWith(
    color: Colors.blue,
  ),
)

// Get style from enum
final style = TypographyStyle.bodyLarge.style;''',
      codeTitle: 'smart_text_usage.dart',
      preview: Container(
        padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DisplayText('Display', size: DisplaySize.small),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            HeadlineText('Headline', size: HeadlineSize.medium),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            SmartText(
              'SmartText with titleMedium',
              style: TypographyStyle.titleMedium,
              textColor: context.textPrimaryColor,
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            BodyText('Body text content'),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            LabelText('Label / Caption text', size: LabelSize.medium),
          ],
        ),
      ),
    );
  }
}

class _TypographyCategory {
  const _TypographyCategory({
    required this.name,
    required this.color,
    required this.styles,
  });

  final String name;
  final Color color;
  final List<TypographyStyle> styles;
}

class _StyleInfo {
  const _StyleInfo({
    required this.style,
    required this.label,
    required this.description,
    required this.specs,
  });

  final TypographyStyle style;
  final String label;
  final String description;
  final String specs;
}
