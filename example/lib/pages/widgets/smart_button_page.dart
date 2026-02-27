import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartButton widget
class SmartButtonPage extends StatefulWidget {
  const SmartButtonPage({super.key});

  @override
  State<SmartButtonPage> createState() => _SmartButtonPageState();
}

class _SmartButtonPageState extends State<SmartButtonPage> {
  // Controls
  String _variant = 'filled';
  String _platformStyle = 'adaptive';
  bool _isEnabled = true;
  Color _buttonColor = PlaygroundTheme.primary;
  String _buttonText = 'Click Me';

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
              'SmartButton',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'An adaptive button that automatically switches between Material and Cupertino styles based on the platform.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Customize the button properties and see live changes',
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
                        label: 'Variant',
                        value: _variant,
                        options: const ['default', 'filled', 'text', 'outlined'],
                        optionLabels: const {
                          'default': 'Default (Elevated)',
                          'filled': 'Filled',
                          'text': 'Text',
                          'outlined': 'Outlined',
                        },
                        onChanged: (value) => setState(() => _variant = value),
                      ),
                      DropdownControl<String>(
                        label: 'Platform Style',
                        value: _platformStyle,
                        options: const ['adaptive', 'material', 'cupertino'],
                        optionLabels: const {
                          'adaptive': 'Adaptive (Auto)',
                          'material': 'Force Material',
                          'cupertino': 'Force Cupertino',
                        },
                        onChanged: (value) =>
                            setState(() => _platformStyle = value),
                      ),
                      SwitchControl(
                        label: 'Enabled',
                        value: _isEnabled,
                        description: 'Toggle button enabled state',
                        onChanged: (value) => setState(() => _isEnabled = value),
                      ),
                      ColorPickerControl(
                        label: 'Button Color',
                        value: _buttonColor,
                        colors: [
                          PlaygroundTheme.primary,
                          PlaygroundTheme.success,
                          PlaygroundTheme.error,
                          PlaygroundTheme.warning,
                          PlaygroundTheme.info,
                          PlaygroundTheme.accent,
                        ],
                        onChanged: (value) =>
                            setState(() => _buttonColor = value),
                      ),
                      TextInputControl(
                        label: 'Button Text',
                        value: _buttonText,
                        onChanged: (value) =>
                            setState(() => _buttonText = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _ButtonPreview(
                    variant: _variant,
                    platformStyle: _platformStyle,
                    isEnabled: _isEnabled,
                    color: _buttonColor,
                    text: _buttonText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getInteractiveCode(),
              title: 'smart_button_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // All Variants Section
            SectionHeader(
              title: 'Button Variants',
              subtitle: 'All available button styles in one view',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _AllVariantsDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Platform Comparison Section
            SectionHeader(
              title: 'Platform Comparison',
              subtitle:
                  'See how buttons render on Material vs Cupertino platforms',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _PlatformComparisonDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartIconButton Section
            SectionHeader(
              title: 'SmartIconButton',
              subtitle: 'Adaptive icon button for both platforms',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _IconButtonDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference Section
            SectionHeader(
              title: 'API Reference',
              subtitle: 'Available parameters and their types',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getInteractiveCode() {
    final constructorName = _variant == 'default' ? '' : '.$_variant';
    final forceMaterial = _platformStyle == 'material';
    final forceCupertino = _platformStyle == 'cupertino';

    String code = '''SmartButton$constructorName(
  onPressed: ${_isEnabled ? '() => print("Pressed!")' : 'null'},
  child: Text('$_buttonText'),''';

    if (forceMaterial) {
      code += '\n  forceMaterial: true,';
    }
    if (forceCupertino) {
      code += '\n  forceCupertino: true,';
    }
    if (_buttonColor != PlaygroundTheme.primary) {
      final colorHex = _buttonColor.r.toInt().toRadixString(16).padLeft(2, '0') +
          _buttonColor.g.toInt().toRadixString(16).padLeft(2, '0') +
          _buttonColor.b.toInt().toRadixString(16).padLeft(2, '0');
      code += '\n  color: Color(0xFF${colorHex.toUpperCase()}),';
    }

    code += '\n)';
    return code;
  }
}

class _ButtonPreview extends StatelessWidget {
  const _ButtonPreview({
    required this.variant,
    required this.platformStyle,
    required this.isEnabled,
    required this.color,
    required this.text,
  });

  final String variant;
  final String platformStyle;
  final bool isEnabled;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Platform indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PlaygroundTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  platformStyle == 'cupertino'
                      ? Icons.apple
                      : platformStyle == 'material'
                          ? Icons.android
                          : Icons.devices,
                  size: 16,
                  color: PlaygroundTheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  platformStyle == 'cupertino'
                      ? 'Cupertino Style'
                      : platformStyle == 'material'
                          ? 'Material Style'
                          : 'Adaptive (Platform Default)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: PlaygroundTheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          // Button preview
          _buildButton(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Variant label
          Text(
            'Variant: ${variant.toUpperCase()}',
            style: TextStyle(
              fontSize: 12,
              color: context.textMutedColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    final VoidCallback? onPressed = isEnabled ? () {} : null;
    final forceMaterial = platformStyle == 'material';
    final forceCupertino = platformStyle == 'cupertino';
    final child = Text(text);

    switch (variant) {
      case 'filled':
        return SmartButton.filled(
          onPressed: onPressed,
          forceMaterial: forceMaterial,
          forceCupertino: forceCupertino,
          color: color,
          child: child,
        );
      case 'text':
        return SmartButton.text(
          onPressed: onPressed,
          forceMaterial: forceMaterial,
          forceCupertino: forceCupertino,
          color: color,
          child: child,
        );
      case 'outlined':
        return SmartButton.outlined(
          onPressed: onPressed,
          forceMaterial: forceMaterial,
          forceCupertino: forceCupertino,
          color: color,
          child: child,
        );
      default:
        return SmartButton(
          onPressed: onPressed,
          forceMaterial: forceMaterial,
          forceCupertino: forceCupertino,
          color: color,
          child: child,
        );
    }
  }
}

class _AllVariantsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          _VariantRow(
            label: 'Default (Elevated)',
            enabled: SmartButton(
              onPressed: () {},
              child: const Text('Enabled'),
            ),
            disabled: const SmartButton(
              onPressed: null,
              child: Text('Disabled'),
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _VariantRow(
            label: 'Filled',
            enabled: SmartButton.filled(
              onPressed: () {},
              child: const Text('Enabled'),
            ),
            disabled: const SmartButton.filled(
              onPressed: null,
              child: Text('Disabled'),
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _VariantRow(
            label: 'Text',
            enabled: SmartButton.text(
              onPressed: () {},
              child: const Text('Enabled'),
            ),
            disabled: const SmartButton.text(
              onPressed: null,
              child: Text('Disabled'),
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _VariantRow(
            label: 'Outlined',
            enabled: SmartButton.outlined(
              onPressed: () {},
              child: const Text('Enabled'),
            ),
            disabled: const SmartButton.outlined(
              onPressed: null,
              child: Text('Disabled'),
            ),
          ),
        ],
      ),
    );
  }
}

class _VariantRow extends StatelessWidget {
  const _VariantRow({
    required this.label,
    required this.enabled,
    required this.disabled,
  });

  final String label;
  final Widget enabled;
  final Widget disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: PlaygroundTheme.spaceMd,
            runSpacing: PlaygroundTheme.spaceSm,
            children: [enabled, disabled],
          ),
        ),
      ],
    );
  }
}

class _PlatformComparisonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _PlatformCard(
            title: 'Material Design',
            icon: Icons.android,
            color: PlaygroundTheme.success,
            children: [
              SmartButton.filled(
                onPressed: () {},
                forceMaterial: true,
                child: const Text('Filled'),
              ),
              const SizedBox(height: PlaygroundTheme.spaceSm),
              SmartButton.outlined(
                onPressed: () {},
                forceMaterial: true,
                child: const Text('Outlined'),
              ),
              const SizedBox(height: PlaygroundTheme.spaceSm),
              SmartButton.text(
                onPressed: () {},
                forceMaterial: true,
                child: const Text('Text'),
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _PlatformCard(
            title: 'Cupertino (iOS)',
            icon: Icons.apple,
            color: context.textPrimaryColor,
            children: [
              SmartButton.filled(
                onPressed: () {},
                forceCupertino: true,
                child: const Text('Filled'),
              ),
              const SizedBox(height: PlaygroundTheme.spaceSm),
              SmartButton.outlined(
                onPressed: () {},
                forceCupertino: true,
                child: const Text('Outlined'),
              ),
              const SizedBox(height: PlaygroundTheme.spaceSm),
              SmartButton.text(
                onPressed: () {},
                forceCupertino: true,
                child: const Text('Text'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlatformCard extends StatelessWidget {
  const _PlatformCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.children,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          ...children,
        ],
      ),
    );
  }
}

class _IconButtonDemo extends StatelessWidget {
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
          child: Wrap(
            spacing: PlaygroundTheme.spaceMd,
            runSpacing: PlaygroundTheme.spaceMd,
            alignment: WrapAlignment.center,
            children: [
              SmartIconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {},
                tooltip: 'Favorite',
                color: PlaygroundTheme.error,
              ),
              SmartIconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
                tooltip: 'Share',
              ),
              SmartIconButton(
                icon: const Icon(Icons.bookmark),
                onPressed: () {},
                tooltip: 'Bookmark',
                color: PlaygroundTheme.warning,
              ),
              SmartIconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
                tooltip: 'More options',
              ),
              const SmartIconButton(
                icon: Icon(Icons.delete),
                onPressed: null,
                tooltip: 'Delete (Disabled)',
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartIconButton(
  icon: Icon(Icons.favorite),
  onPressed: () => print('Favorited!'),
  tooltip: 'Favorite',
  color: Colors.red,
)

// Force Material style
SmartIconButton(
  icon: Icon(Icons.share),
  onPressed: () {},
  forceMaterial: true,
)

// Force Cupertino style
SmartIconButton(
  icon: Icon(Icons.bookmark),
  onPressed: () {},
  forceCupertino: true,
)''',
          title: 'smart_icon_button_example.dart',
        ),
      ],
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
            description: 'The button content, typically a Text widget',
          ),
          _ApiRow(
            param: 'onPressed',
            type: 'VoidCallback?',
            description: 'Callback when button is pressed (null = disabled)',
          ),
          _ApiRow(
            param: 'forceMaterial',
            type: 'bool',
            description: 'Force Material Design style regardless of platform',
          ),
          _ApiRow(
            param: 'forceCupertino',
            type: 'bool',
            description: 'Force Cupertino style regardless of platform',
          ),
          _ApiRow(
            param: 'padding',
            type: 'EdgeInsetsGeometry?',
            description: 'Custom padding around the button content',
          ),
          _ApiRow(
            param: 'color',
            type: 'Color?',
            description: 'Background color for the button',
          ),
          _ApiRow(
            param: 'disabledColor',
            type: 'Color?',
            description: 'Background color when button is disabled',
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
            width: 140,
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
            width: 160,
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
