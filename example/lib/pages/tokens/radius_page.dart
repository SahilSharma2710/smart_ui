import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartRadius border radius tokens.
class RadiusPage extends StatefulWidget {
  const RadiusPage({super.key});

  @override
  State<RadiusPage> createState() => _RadiusPageState();
}

class _RadiusPageState extends State<RadiusPage> {
  // Interactive demo state
  RadiusSize _selectedRadius = RadiusSize.md;
  bool _showCornerVariants = false;
  double _customRadius = 8;

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'Border Radius',
      subtitle: 'Consistent border radius tokens for rounded corners.',
      children: [
        // Radius Scale Visual
        SectionHeader(
          title: 'Radius Scale',
          subtitle: 'Visual comparison of all radius token values',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildRadiusScaleVisual(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Cards Demo
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'See how different radii affect component appearance',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // All Radius Tokens Grid
        SectionHeader(
          title: 'All Radius Tokens',
          subtitle: 'Complete set of radius values with visual examples',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildRadiusTokensGrid(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Corner Variants
        SectionHeader(
          title: 'Corner Variants',
          subtitle: 'Apply radius to specific corners',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildCornerVariantsSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Real-World Examples
        SectionHeader(
          title: 'Real-World Examples',
          subtitle: 'Common UI patterns using radius tokens',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildRealWorldExamples(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Usage Code
        SectionHeader(
          title: 'Usage Examples',
          subtitle: 'How to use SmartRadius in your code',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildUsageCodeSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildRadiusScaleVisual() {
    final radii = [
      _RadiusInfo('none', RadiusSize.none, 0, context.textMutedColor),
      _RadiusInfo('xs', RadiusSize.xs, 2, PlaygroundTheme.watchColor),
      _RadiusInfo('sm', RadiusSize.sm, 4, PlaygroundTheme.mobileColor),
      _RadiusInfo('md', RadiusSize.md, 8, PlaygroundTheme.tabletColor),
      _RadiusInfo('lg', RadiusSize.lg, 12, PlaygroundTheme.desktopColor),
      _RadiusInfo('xl', RadiusSize.xl, 16, PlaygroundTheme.tvColor),
      _RadiusInfo('xxl', RadiusSize.xxl, 24, PlaygroundTheme.primary),
      _RadiusInfo('full', RadiusSize.full, 9999, PlaygroundTheme.accent),
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
        children: [
          // Visual scale of squares
          Wrap(
            spacing: PlaygroundTheme.spaceMd,
            runSpacing: PlaygroundTheme.spaceMd,
            alignment: WrapAlignment.center,
            children: radii.map((info) {
              final isSelected = _selectedRadius == info.size;
              return GestureDetector(
                onTap: () => setState(() => _selectedRadius = info.size),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: PlaygroundTheme.durationFast,
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            info.color,
                            info.color.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: info.size.borderRadius,
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: info.color.withValues(alpha: 0.5),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(height: PlaygroundTheme.spaceSm),
                    Text(
                      info.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? PlaygroundTheme.primary
                            : context.textSecondaryColor,
                      ),
                    ),
                    Text(
                      info.name == 'full' ? 'pill' : '${info.value}px',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          // Progress bar showing scale
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: radii.map((r) => r.color).toList(),
              ),
            ),
          ),
        ],
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
      title: 'Radius Controls',
      children: [
        DropdownControl<RadiusSize>(
          label: 'Radius Token',
          value: _selectedRadius,
          options: RadiusSize.values,
          optionLabels: {
            for (final size in RadiusSize.values)
              size:
                  '${size.name} (${size.name == "full" ? "pill" : "${size.value.toInt()}px"})'
          },
          onChanged: (value) => setState(() => _selectedRadius = value),
        ),
        SliderControl(
          label: 'Custom Radius',
          value: _customRadius,
          min: 0,
          max: 48,
          divisions: 48,
          valueLabel: '${_customRadius.toInt()}px',
          onChanged: (value) => setState(() => _customRadius = value),
        ),
        SwitchControl(
          label: 'Show Corner Variants',
          value: _showCornerVariants,
          onChanged: (value) => setState(() => _showCornerVariants = value),
          description: 'Toggle to see different corner combinations',
        ),
      ],
    );
  }

  Widget _buildInteractivePreview() {
    final radius = _selectedRadius.borderRadius;
    final radiusValue = _selectedRadius.value;

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
            'Preview - SmartRadius.${_selectedRadius.name}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Center(
            child: Column(
              children: [
                // Main preview shape
                AnimatedContainer(
                  duration: PlaygroundTheme.durationNormal,
                  curve: Curves.easeOutCubic,
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: PlaygroundTheme.primaryGradient,
                    borderRadius: radius,
                    boxShadow: [
                      BoxShadow(
                        color: PlaygroundTheme.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedRadius.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _selectedRadius == RadiusSize.full
                              ? 'pill shape'
                              : '${radiusValue.toInt()}px',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: PlaygroundTheme.spaceLg),
                // Custom radius preview
                AnimatedContainer(
                  duration: PlaygroundTheme.durationNormal,
                  curve: Curves.easeOutCubic,
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(_customRadius),
                    border: Border.all(
                      color: PlaygroundTheme.accent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Custom',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: PlaygroundTheme.accent,
                          ),
                        ),
                        Text(
                          '${_customRadius.toInt()}px',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_showCornerVariants) ...[
            const SizedBox(height: PlaygroundTheme.spaceLg),
            Divider(color: context.borderColor.withValues(alpha: 0.3)),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            Text(
              'Corner Variants',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            Wrap(
              spacing: PlaygroundTheme.spaceMd,
              runSpacing: PlaygroundTheme.spaceMd,
              children: [
                _buildCornerVariantBox('top', SmartRadius.top(radiusValue)),
                _buildCornerVariantBox(
                    'bottom', SmartRadius.bottom(radiusValue)),
                _buildCornerVariantBox('left', SmartRadius.left(radiusValue)),
                _buildCornerVariantBox('right', SmartRadius.right(radiusValue)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCornerVariantBox(String label, BorderRadius radius) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: PlaygroundTheme.primary.withValues(alpha: 0.15),
            borderRadius: radius,
            border: Border.all(
              color: PlaygroundTheme.primary.withValues(alpha: 0.5),
            ),
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: context.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRadiusTokensGrid() {
    final tokens = [
      _RadiusTokenInfo(
        name: 'none',
        size: RadiusSize.none,
        value: '0px',
        description: 'Sharp corners, no rounding',
        useCase: 'Tables, dividers',
      ),
      _RadiusTokenInfo(
        name: 'xs',
        size: RadiusSize.xs,
        value: '2px',
        description: 'Barely noticeable rounding',
        useCase: 'Progress bars, badges',
      ),
      _RadiusTokenInfo(
        name: 'sm',
        size: RadiusSize.sm,
        value: '4px',
        description: 'Subtle rounding',
        useCase: 'Inputs, small buttons',
      ),
      _RadiusTokenInfo(
        name: 'md',
        size: RadiusSize.md,
        value: '8px',
        description: 'Standard rounding',
        useCase: 'Cards, buttons, dialogs',
      ),
      _RadiusTokenInfo(
        name: 'lg',
        size: RadiusSize.lg,
        value: '12px',
        description: 'Prominent rounding',
        useCase: 'Large cards, panels',
      ),
      _RadiusTokenInfo(
        name: 'xl',
        size: RadiusSize.xl,
        value: '16px',
        description: 'Very rounded',
        useCase: 'Feature cards, modals',
      ),
      _RadiusTokenInfo(
        name: 'xxl',
        size: RadiusSize.xxl,
        value: '24px',
        description: 'Extra rounded',
        useCase: 'Hero sections, callouts',
      ),
      _RadiusTokenInfo(
        name: 'full',
        size: RadiusSize.full,
        value: 'pill',
        description: 'Fully rounded (pill shape)',
        useCase: 'Chips, pills, avatars',
      ),
    ];

    return SmartLayout(
      mobile: Column(
        children: tokens
            .map((token) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
                  child: _buildRadiusTokenCard(token),
                ))
            .toList(),
      ),
      tablet: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          crossAxisSpacing: PlaygroundTheme.spaceMd,
          mainAxisSpacing: PlaygroundTheme.spaceMd,
        ),
        itemCount: tokens.length,
        itemBuilder: (context, index) => _buildRadiusTokenCard(tokens[index]),
      ),
      desktop: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.3,
          crossAxisSpacing: PlaygroundTheme.spaceMd,
          mainAxisSpacing: PlaygroundTheme.spaceMd,
        ),
        itemCount: tokens.length,
        itemBuilder: (context, index) => _buildRadiusTokenCard(tokens[index]),
      ),
    );
  }

  Widget _buildRadiusTokenCard(_RadiusTokenInfo token) {
    final isSelected = _selectedRadius == token.size;

    return GestureDetector(
      onTap: () => setState(() => _selectedRadius = token.size),
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
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: PlaygroundTheme.primaryGradient,
                    borderRadius: token.size.borderRadius,
                  ),
                ),
                const SizedBox(width: PlaygroundTheme.spaceSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        token.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          color: PlaygroundTheme.primary,
                        ),
                      ),
                      Text(
                        token.value,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              token.description,
              style: TextStyle(
                fontSize: 12,
                color: context.textSecondaryColor,
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXs),
            Text(
              token.useCase,
              style: TextStyle(
                fontSize: 11,
                color: context.textMutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCornerVariantsSection() {
    return CodePreviewSplit(
      code: '''// Top corners only
SmartRadius.top(12)  // BorderRadius.vertical(top: Radius.circular(12))

// Bottom corners only
SmartRadius.bottom(12)

// Left corners only
SmartRadius.left(12)

// Right corners only
SmartRadius.right(12)

// Specific corners
SmartRadius.only(
  topLeft: 16,
  topRight: 8,
  bottomLeft: 0,
  bottomRight: 24,
)

// Custom radius value
SmartRadius.all(20)  // BorderRadius.all(Radius.circular(20))''',
      codeTitle: 'corner_variants.dart',
      preview: Container(
        padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
        child: Wrap(
          spacing: PlaygroundTheme.spaceMd,
          runSpacing: PlaygroundTheme.spaceMd,
          alignment: WrapAlignment.center,
          children: [
            _buildLabeledCornerBox('top(12)', SmartRadius.top(12)),
            _buildLabeledCornerBox('bottom(12)', SmartRadius.bottom(12)),
            _buildLabeledCornerBox('left(12)', SmartRadius.left(12)),
            _buildLabeledCornerBox('right(12)', SmartRadius.right(12)),
            _buildLabeledCornerBox(
              'only(...)',
              SmartRadius.only(
                topLeft: 16,
                topRight: 8,
                bottomLeft: 0,
                bottomRight: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledCornerBox(String label, BorderRadius radius) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            gradient: PlaygroundTheme.primaryGradient,
            borderRadius: radius,
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: context.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRealWorldExamples() {
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
          // Example 1: Card
          Text(
            'Card with SmartRadius.lg',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: SmartRadius.lg,
              border: Border.all(
                color: context.borderColor.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: PlaygroundTheme.primary.withValues(alpha: 0.15),
                    borderRadius: SmartRadius.md,
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    color: PlaygroundTheme.primary,
                  ),
                ),
                const SizedBox(width: PlaygroundTheme.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      Text(
                        'Using SmartRadius.lg for the card',
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),

          // Example 2: Buttons
          Text(
            'Buttons with various radii',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Wrap(
            spacing: PlaygroundTheme.spaceSm,
            runSpacing: PlaygroundTheme.spaceSm,
            children: [
              _buildExampleButton('sm', SmartRadius.sm),
              _buildExampleButton('md', SmartRadius.md),
              _buildExampleButton('lg', SmartRadius.lg),
              _buildExampleButton('full', SmartRadius.full),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),

          // Example 3: Avatar/Chip
          Text(
            'Avatars and Chips with SmartRadius.full',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: PlaygroundTheme.heroGradient,
                  borderRadius: SmartRadius.full,
                ),
                child: Center(
                  child: Text(
                    'JD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: PlaygroundTheme.spaceMd),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PlaygroundTheme.spaceMd,
                  vertical: PlaygroundTheme.spaceSm,
                ),
                decoration: BoxDecoration(
                  color: PlaygroundTheme.primary.withValues(alpha: 0.15),
                  borderRadius: SmartRadius.full,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: PlaygroundTheme.primary,
                    ),
                    const SizedBox(width: PlaygroundTheme.spaceXs),
                    Text(
                      'Verified',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: PlaygroundTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExampleButton(String label, BorderRadius radius) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PlaygroundTheme.spaceMd,
        vertical: PlaygroundTheme.spaceSm,
      ),
      decoration: BoxDecoration(
        color: PlaygroundTheme.primary,
        borderRadius: radius,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUsageCodeSection() {
    return CodePreview(
      code: '''// Using SmartRadius constants
Container(
  decoration: BoxDecoration(
    borderRadius: SmartRadius.md,  // 8px all corners
  ),
)

// Using RadiusSize enum
Container(
  decoration: BoxDecoration(
    borderRadius: RadiusSize.lg.borderRadius,  // 12px
  ),
)

// Get raw value from enum
final value = RadiusSize.xl.value;  // 16.0

// Using raw values
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(SmartRadius.lgValue),  // 12.0
  ),
)

// Using helper methods
SmartRadius.all(16)       // All corners
SmartRadius.top(12)       // Top corners only
SmartRadius.bottom(12)    // Bottom corners only
SmartRadius.left(12)      // Left corners only
SmartRadius.right(12)     // Right corners only
SmartRadius.only(         // Specific corners
  topLeft: 16,
  topRight: 8,
  bottomRight: 24,
)

// With SmartRadius.fromSize
final radius = SmartRadius.fromSize(RadiusSize.lg);''',
      title: 'smart_radius_usage.dart',
    );
  }
}

class _RadiusInfo {
  const _RadiusInfo(this.name, this.size, this.value, this.color);

  final String name;
  final RadiusSize size;
  final double value;
  final Color color;
}

class _RadiusTokenInfo {
  const _RadiusTokenInfo({
    required this.name,
    required this.size,
    required this.value,
    required this.description,
    required this.useCase,
  });

  final String name;
  final RadiusSize size;
  final String value;
  final String description;
  final String useCase;
}
