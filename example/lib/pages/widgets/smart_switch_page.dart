import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartSwitch widget
class SmartSwitchPage extends StatefulWidget {
  const SmartSwitchPage({super.key});

  @override
  State<SmartSwitchPage> createState() => _SmartSwitchPageState();
}

class _SmartSwitchPageState extends State<SmartSwitchPage> {
  // Demo state
  bool _switchValue = true;
  bool _checkboxValue = true;
  String _radioValue = 'option1';

  // Controls
  String _platformStyle = 'adaptive';
  Color _activeColor = PlaygroundTheme.primary;
  bool _isEnabled = true;

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
              'SmartSwitch',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'Adaptive toggle controls that switch between Material and Cupertino styles based on the platform.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Customize switch properties and see live changes',
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
                      ColorPickerControl(
                        label: 'Active Color',
                        value: _activeColor,
                        colors: [
                          PlaygroundTheme.primary,
                          PlaygroundTheme.success,
                          PlaygroundTheme.error,
                          PlaygroundTheme.warning,
                          PlaygroundTheme.info,
                          PlaygroundTheme.accent,
                        ],
                        onChanged: (value) =>
                            setState(() => _activeColor = value),
                      ),
                      SwitchControl(
                        label: 'Enabled',
                        value: _isEnabled,
                        description: 'Toggle enabled state',
                        onChanged: (value) => setState(() => _isEnabled = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _SwitchPreview(
                    value: _switchValue,
                    onChanged: _isEnabled
                        ? (value) => setState(() => _switchValue = value)
                        : null,
                    platformStyle: _platformStyle,
                    activeColor: _activeColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getSwitchCode(),
              title: 'smart_switch_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Platform Comparison Section
            SectionHeader(
              title: 'Platform Comparison',
              subtitle: 'See how switches render on different platforms',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _PlatformComparisonDemo(
              value: _switchValue,
              onChanged: (value) => setState(() => _switchValue = value),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartCheckbox Section
            SectionHeader(
              title: 'SmartCheckbox',
              subtitle: 'Adaptive checkbox for both platforms',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _CheckboxDemo(
              value: _checkboxValue,
              onChanged: (value) => setState(() => _checkboxValue = value ?? false),
              platformStyle: _platformStyle,
              activeColor: _activeColor,
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartRadio Section
            SectionHeader(
              title: 'SmartRadio',
              subtitle: 'Adaptive radio buttons for both platforms',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _RadioDemo(
              value: _radioValue,
              onChanged: (value) => setState(() => _radioValue = value ?? 'option1'),
              platformStyle: _platformStyle,
              activeColor: _activeColor,
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Use Cases Section
            SectionHeader(
              title: 'Common Use Cases',
              subtitle: 'Real-world examples of toggle controls',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _UseCasesDemo(),
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

  String _getSwitchCode() {
    final forceMaterial = _platformStyle == 'material';
    final forceCupertino = _platformStyle == 'cupertino';

    String code = '''SmartSwitch(
  value: $_switchValue,
  onChanged: ${_isEnabled ? '(value) => setState(() => _value = value)' : 'null'},''';

    if (forceMaterial) {
      code += '\n  forceMaterial: true,';
    }
    if (forceCupertino) {
      code += '\n  forceCupertino: true,';
    }
    if (_activeColor != PlaygroundTheme.primary) {
      final colorHex = _activeColor.r.toInt().toRadixString(16).padLeft(2, '0') +
          _activeColor.g.toInt().toRadixString(16).padLeft(2, '0') +
          _activeColor.b.toInt().toRadixString(16).padLeft(2, '0');
      code += '\n  activeColor: Color(0xFF${colorHex.toUpperCase()}),';
    }

    code += '\n)';
    return code;
  }
}

class _SwitchPreview extends StatelessWidget {
  const _SwitchPreview({
    required this.value,
    required this.onChanged,
    required this.platformStyle,
    required this.activeColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String platformStyle;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
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
          // Switch preview
          Transform.scale(
            scale: 1.5,
            child: SmartSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              forceMaterial: platformStyle == 'material',
              forceCupertino: platformStyle == 'cupertino',
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          // State label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: (value ? PlaygroundTheme.success : PlaygroundTheme.error)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              value ? 'ON' : 'OFF',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: value ? PlaygroundTheme.success : PlaygroundTheme.error,
              ),
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Text(
            onChanged != null ? 'Tap to toggle' : 'Disabled',
            style: TextStyle(
              fontSize: 12,
              color: context.textMutedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformComparisonDemo extends StatelessWidget {
  const _PlatformComparisonDemo({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmartSwitch(
                      value: value,
                      onChanged: onChanged,
                      forceMaterial: true,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      value ? 'Enabled' : 'Disabled',
                      style: TextStyle(color: context.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SmartSwitch(
                      value: true,
                      onChanged: null,
                      forceMaterial: true,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Disabled state',
                      style: TextStyle(color: context.textMutedColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _PlatformCard(
            title: 'Cupertino (iOS)',
            icon: Icons.apple,
            color: context.textPrimaryColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmartSwitch(
                      value: value,
                      onChanged: onChanged,
                      forceCupertino: true,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      value ? 'Enabled' : 'Disabled',
                      style: TextStyle(color: context.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SmartSwitch(
                      value: true,
                      onChanged: null,
                      forceCupertino: true,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Disabled state',
                      style: TextStyle(color: context.textMutedColor),
                    ),
                  ],
                ),
              ],
            ),
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
    required this.child,
  });

  final String title;
  final IconData icon;
  final Color color;
  final Widget child;

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
          child,
        ],
      ),
    );
  }
}

class _CheckboxDemo extends StatelessWidget {
  const _CheckboxDemo({
    required this.value,
    required this.onChanged,
    required this.platformStyle,
    required this.activeColor,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final String platformStyle;
  final Color activeColor;

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CheckboxItem(
                    label: 'Unchecked',
                    child: SmartCheckbox(
                      value: false,
                      onChanged: (_) {},
                      forceMaterial: platformStyle == 'material',
                      forceCupertino: platformStyle == 'cupertino',
                      activeColor: activeColor,
                    ),
                  ),
                  _CheckboxItem(
                    label: 'Checked',
                    child: SmartCheckbox(
                      value: true,
                      onChanged: (_) {},
                      forceMaterial: platformStyle == 'material',
                      forceCupertino: platformStyle == 'cupertino',
                      activeColor: activeColor,
                    ),
                  ),
                  _CheckboxItem(
                    label: 'Tristate',
                    child: SmartCheckbox(
                      value: null,
                      onChanged: (_) {},
                      tristate: true,
                      forceMaterial: platformStyle == 'material',
                      forceCupertino: platformStyle == 'cupertino',
                      activeColor: activeColor,
                    ),
                  ),
                  _CheckboxItem(
                    label: 'Interactive',
                    child: SmartCheckbox(
                      value: value,
                      onChanged: onChanged,
                      forceMaterial: platformStyle == 'material',
                      forceCupertino: platformStyle == 'cupertino',
                      activeColor: activeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
  activeColor: Colors.blue,
)

// With tristate support
SmartCheckbox(
  value: isChecked, // Can be true, false, or null
  onChanged: (value) => setState(() => isChecked = value),
  tristate: true,
)''',
          title: 'smart_checkbox_example.dart',
        ),
      ],
    );
  }
}

class _CheckboxItem extends StatelessWidget {
  const _CheckboxItem({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: context.textMutedColor,
          ),
        ),
      ],
    );
  }
}

class _RadioDemo extends StatelessWidget {
  const _RadioDemo({
    required this.value,
    required this.onChanged,
    required this.platformStyle,
    required this.activeColor,
  });

  final String value;
  final ValueChanged<String?> onChanged;
  final String platformStyle;
  final Color activeColor;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _RadioItem(
                label: 'Option 1',
                value: 'option1',
                groupValue: value,
                onChanged: onChanged,
                platformStyle: platformStyle,
                activeColor: activeColor,
              ),
              _RadioItem(
                label: 'Option 2',
                value: 'option2',
                groupValue: value,
                onChanged: onChanged,
                platformStyle: platformStyle,
                activeColor: activeColor,
              ),
              _RadioItem(
                label: 'Option 3',
                value: 'option3',
                groupValue: value,
                onChanged: onChanged,
                platformStyle: platformStyle,
                activeColor: activeColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartRadio<String>(
  value: 'option1',
  groupValue: selectedOption,
  onChanged: (value) => setState(() => selectedOption = value),
  activeColor: Colors.blue,
)''',
          title: 'smart_radio_example.dart',
        ),
      ],
    );
  }
}

class _RadioItem extends StatelessWidget {
  const _RadioItem({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.platformStyle,
    required this.activeColor,
  });

  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final String platformStyle;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmartRadio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          forceMaterial: platformStyle == 'material',
          forceCupertino: platformStyle == 'cupertino',
          activeColor: activeColor,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: context.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class _UseCasesDemo extends StatefulWidget {
  @override
  State<_UseCasesDemo> createState() => _UseCasesDemoState();
}

class _UseCasesDemoState extends State<_UseCasesDemo> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _analytics = false;

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
          _SettingsRow(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Use dark theme throughout the app',
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),
          Divider(height: 1, color: context.borderColor.withValues(alpha: 0.3)),
          _SettingsRow(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            subtitle: 'Receive alerts and updates',
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
          Divider(height: 1, color: context.borderColor.withValues(alpha: 0.3)),
          _SettingsRow(
            icon: Icons.analytics_outlined,
            title: 'Analytics',
            subtitle: 'Help improve our app with usage data',
            value: _analytics,
            onChanged: (value) => setState(() => _analytics = value),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: PlaygroundTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Icon(
              icon,
              size: 20,
              color: PlaygroundTheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textMutedColor,
                  ),
                ),
              ],
            ),
          ),
          SmartSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
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
            param: 'value',
            type: 'bool',
            description: 'Whether the switch is on or off',
          ),
          _ApiRow(
            param: 'onChanged',
            type: 'ValueChanged<bool>?',
            description: 'Called when the user toggles the switch',
          ),
          _ApiRow(
            param: 'activeColor',
            type: 'Color?',
            description: 'The color when the switch is on',
          ),
          _ApiRow(
            param: 'inactiveTrackColor',
            type: 'Color?',
            description: 'The color of the inactive track',
          ),
          _ApiRow(
            param: 'thumbColor',
            type: 'Color?',
            description: 'The color of the thumb',
          ),
          _ApiRow(
            param: 'forceMaterial',
            type: 'bool',
            description: 'Force Material style regardless of platform',
          ),
          _ApiRow(
            param: 'forceCupertino',
            type: 'bool',
            description: 'Force Cupertino style regardless of platform',
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
