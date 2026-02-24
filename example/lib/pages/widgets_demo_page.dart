import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

class WidgetsDemoPage extends StatefulWidget {
  const WidgetsDemoPage({super.key});

  @override
  State<WidgetsDemoPage> createState() => _WidgetsDemoPageState();
}

class _WidgetsDemoPageState extends State<WidgetsDemoPage> {
  bool _switchValue = false;
  bool _checkboxValue = false;
  String _radioValue = 'option1';
  double _progressValue = 0.6;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsive(
        mobile: SmartSpacing.md,
        tablet: SmartSpacing.lg,
        desktop: SmartSpacing.xl,
      )),
      child: SmartContainer(
        maxWidth: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const VGap.xl(),
            _buildButtonsSection(context),
            const VGap.xl(),
            _buildSwitchSection(context),
            const VGap.xl(),
            _buildCheckboxSection(context),
            const VGap.xl(),
            _buildRadioSection(context),
            const VGap.xl(),
            _buildProgressSection(context),
            const VGap.xl(),
            _buildDialogSection(context),
            const VGap.xl(),
            _buildScaffoldSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmartText(
          'Adaptive Widgets',
          style: TypographyStyle.headlineMedium,
        ),
        const VGap.sm(),
        SmartText(
          'Widgets that automatically adapt to the current platform. '
          'On iOS/macOS they use Cupertino styling, on Android/Windows/Linux they use Material.',
          style: TypographyStyle.bodyLarge,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SmartSpacing.md,
            vertical: SmartSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: SmartRadius.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                context.usesMaterial ? Icons.android : Icons.apple,
                size: 18,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const HGap.sm(),
              Text(
                'Platform: ${context.platform.name.toUpperCase()} '
                '(${context.usesMaterial ? "Material" : "Cupertino"})',
                style: SmartTypography.labelMedium.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsSection(BuildContext context) {
    return _Section(
      title: 'SmartButton',
      description: 'Adaptive buttons with multiple variants',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: SmartSpacing.md,
            runSpacing: SmartSpacing.sm,
            children: [
              SmartButton(
                onPressed: () => _showSnackBar(context, 'Default pressed'),
                child: const Text('Default'),
              ),
              SmartButton.filled(
                onPressed: () => _showSnackBar(context, 'Filled pressed'),
                child: const Text('Filled'),
              ),
              SmartButton.outlined(
                onPressed: () => _showSnackBar(context, 'Outlined pressed'),
                child: const Text('Outlined'),
              ),
              SmartButton.text(
                onPressed: () => _showSnackBar(context, 'Text pressed'),
                child: const Text('Text'),
              ),
            ],
          ),
          const VGap.md(),
          Wrap(
            spacing: SmartSpacing.md,
            runSpacing: SmartSpacing.sm,
            children: [
              SmartButton.filled(
                onPressed: null,
                child: const Text('Disabled'),
              ),
              SmartIconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () => _showSnackBar(context, 'Icon button pressed'),
                tooltip: 'Favorite',
              ),
              SmartIconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _showSnackBar(context, 'Share pressed'),
                tooltip: 'Share',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchSection(BuildContext context) {
    return _Section(
      title: 'SmartSwitch',
      description: 'Adaptive toggle switch',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(SmartSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SmartText('Enable feature',
                        style: TypographyStyle.titleSmall),
                    SmartText(
                      'Toggle this setting on or off',
                      style: TypographyStyle.bodySmall,
                      textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              SmartSwitch(
                value: _switchValue,
                onChanged: (value) => setState(() => _switchValue = value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxSection(BuildContext context) {
    return _Section(
      title: 'SmartCheckbox',
      description: 'Adaptive checkbox',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(SmartSpacing.md),
          child: Row(
            children: [
              SmartCheckbox(
                value: _checkboxValue,
                onChanged: (value) =>
                    setState(() => _checkboxValue = value ?? false),
              ),
              const HGap.md(),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _checkboxValue = !_checkboxValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SmartText('Accept terms',
                          style: TypographyStyle.titleSmall),
                      SmartText(
                        'I agree to the terms and conditions',
                        style: TypographyStyle.bodySmall,
                        textColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioSection(BuildContext context) {
    return _Section(
      title: 'SmartRadio',
      description: 'Adaptive radio buttons',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(SmartSpacing.md),
          child: Column(
            children: [
              _RadioOption(
                value: 'option1',
                groupValue: _radioValue,
                label: 'Option 1',
                description: 'First choice',
                onChanged: (value) => setState(() => _radioValue = value!),
              ),
              const Divider(height: SmartSpacing.md),
              _RadioOption(
                value: 'option2',
                groupValue: _radioValue,
                label: 'Option 2',
                description: 'Second choice',
                onChanged: (value) => setState(() => _radioValue = value!),
              ),
              const Divider(height: SmartSpacing.md),
              _RadioOption(
                value: 'option3',
                groupValue: _radioValue,
                label: 'Option 3',
                description: 'Third choice',
                onChanged: (value) => setState(() => _radioValue = value!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return _Section(
      title: 'SmartIndicator',
      description: 'Adaptive progress indicators',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(SmartSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SmartText('Circular Indicators',
                      style: TypographyStyle.titleSmall),
                  const VGap.md(),
                  Row(
                    children: [
                      Column(
                        children: [
                          const SmartIndicator(),
                          const VGap.sm(),
                          SmartText(
                            'Indeterminate',
                            style: TypographyStyle.labelSmall,
                            textColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                      const HGap.xl(),
                      Column(
                        children: [
                          SmartIndicator(value: _progressValue),
                          const VGap.sm(),
                          SmartText(
                            '${(_progressValue * 100).toInt()}%',
                            style: TypographyStyle.labelSmall,
                            textColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const VGap.md(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(SmartSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SmartText('Linear Progress',
                          style: TypographyStyle.titleSmall),
                      Text(
                        '${(_progressValue * 100).toInt()}%',
                        style: SmartTypography.labelMedium.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const VGap.md(),
                  SmartLinearIndicator(value: _progressValue),
                  const VGap.md(),
                  Slider(
                    value: _progressValue,
                    onChanged: (value) =>
                        setState(() => _progressValue = value),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSection(BuildContext context) {
    return _Section(
      title: 'SmartDialog',
      description: 'Adaptive dialogs and sheets',
      child: Wrap(
        spacing: SmartSpacing.md,
        runSpacing: SmartSpacing.sm,
        children: [
          SmartButton(
            onPressed: () => _showAlertDialog(context),
            child: const Text('Alert Dialog'),
          ),
          SmartButton(
            onPressed: () => _showConfirmDialog(context),
            child: const Text('Confirm Dialog'),
          ),
          SmartButton(
            onPressed: () => _showBottomSheet(context),
            child: const Text('Bottom Sheet'),
          ),
          SmartButton(
            onPressed: () => _showActionSheet(context),
            child: const Text('Action Sheet'),
          ),
        ],
      ),
    );
  }

  Widget _buildScaffoldSection(BuildContext context) {
    return _Section(
      title: 'SmartScaffold',
      description: 'Adaptive scaffold with navigation',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(SmartSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(
                'SmartScaffold automatically switches between:',
                style: TypographyStyle.bodyMedium,
                textColor: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const VGap.md(),
              _NavigationModeRow(
                icon: Icons.phone_android,
                label: 'Mobile',
                mode: 'Bottom Navigation Bar',
                color: Colors.blue,
              ),
              const VGap.sm(),
              _NavigationModeRow(
                icon: Icons.tablet_android,
                label: 'Tablet',
                mode: 'Navigation Rail',
                color: Colors.green,
              ),
              const VGap.sm(),
              _NavigationModeRow(
                icon: Icons.desktop_windows,
                label: 'Desktop',
                mode: 'Navigation Drawer',
                color: Colors.orange,
              ),
              const VGap.md(),
              Container(
                padding: const EdgeInsets.all(SmartSpacing.sm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: SmartRadius.sm,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const HGap.sm(),
                    Expanded(
                      child: SmartText(
                        'This app uses SmartScaffold - resize to see navigation change!',
                        style: TypographyStyle.bodySmall,
                        textColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        width: 300,
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showSmartDialog<void>(
      context: context,
      title: 'Alert',
      content: 'This is an adaptive alert dialog that adjusts to the platform.',
      actions: [
        SmartDialogAction(
          label: 'OK',
          isDefault: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showConfirmDialog(BuildContext context) async {
    final confirmed = await showSmartConfirmDialog(
      context: context,
      title: 'Confirm Action',
      content: 'Are you sure you want to proceed with this action?',
      confirmLabel: 'Confirm',
      cancelLabel: 'Cancel',
    );

    if (context.mounted) {
      _showSnackBar(context, confirmed ? 'Confirmed!' : 'Cancelled');
    }
  }

  void _showBottomSheet(BuildContext context) {
    showSmartBottomSheet<void>(
      context: context,
      title: 'Bottom Sheet',
      child: Padding(
        padding: const EdgeInsets.all(SmartSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SmartText(
              'This is an adaptive bottom sheet',
              style: TypographyStyle.bodyMedium,
            ),
            const VGap.lg(),
            SmartButton.filled(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            const VGap.md(),
          ],
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showSmartActionSheet<void>(
      context: context,
      title: 'Choose an action',
      message: 'Select one of the options below',
      actions: [
        SmartSheetAction(
          label: 'Share',
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Share selected');
          },
        ),
        SmartSheetAction(
          label: 'Edit',
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Edit selected');
          },
        ),
        SmartSheetAction(
          label: 'Delete',
          isDestructive: true,
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Delete selected');
          },
        ),
      ],
      cancelAction: SmartSheetAction(
        label: 'Cancel',
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(title, style: TypographyStyle.titleLarge),
        const VGap.xs(),
        SmartText(
          description,
          style: TypographyStyle.bodyMedium,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const VGap.md(),
        child,
      ],
    );
  }
}

class _RadioOption extends StatelessWidget {
  const _RadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.description,
    required this.onChanged,
  });

  final String value;
  final String groupValue;
  final String label;
  final String description;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmartRadio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        const HGap.md(),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(label, style: TypographyStyle.titleSmall),
                SmartText(
                  description,
                  style: TypographyStyle.bodySmall,
                  textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NavigationModeRow extends StatelessWidget {
  const _NavigationModeRow({
    required this.icon,
    required this.label,
    required this.mode,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String mode;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(SmartSpacing.xs),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: SmartRadius.xs,
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const HGap.sm(),
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: SmartTypography.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const HGap.sm(),
        const Icon(Icons.arrow_forward, size: 14),
        const HGap.sm(),
        Expanded(
          child: Text(
            mode,
            style: SmartTypography.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
