import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartDialog widgets
class SmartDialogPage extends StatefulWidget {
  const SmartDialogPage({super.key});

  @override
  State<SmartDialogPage> createState() => _SmartDialogPageState();
}

class _SmartDialogPageState extends State<SmartDialogPage> {
  // Controls
  String _platformStyle = 'adaptive';
  bool _barrierDismissible = true;
  bool _showDestructiveAction = false;

  // Dialog result
  String _lastResult = 'No dialog shown yet';

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
              'SmartDialog',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'Adaptive dialog utilities that automatically switch between Material AlertDialog and Cupertino AlertDialog based on the platform.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Configure and test different dialog types',
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
                      SwitchControl(
                        label: 'Barrier Dismissible',
                        value: _barrierDismissible,
                        description: 'Tap outside to dismiss',
                        onChanged: (value) =>
                            setState(() => _barrierDismissible = value),
                      ),
                      SwitchControl(
                        label: 'Show Destructive Action',
                        value: _showDestructiveAction,
                        description: 'Add a red delete button',
                        onChanged: (value) =>
                            setState(() => _showDestructiveAction = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _DialogPreview(
                    platformStyle: _platformStyle,
                    barrierDismissible: _barrierDismissible,
                    showDestructiveAction: _showDestructiveAction,
                    lastResult: _lastResult,
                    onResultChanged: (result) =>
                        setState(() => _lastResult = result),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getDialogCode(),
              title: 'show_smart_dialog_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Dialog Types Section
            SectionHeader(
              title: 'Dialog Types',
              subtitle: 'Different dialog utilities available',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _DialogTypesDemo(
              platformStyle: _platformStyle,
              onResultChanged: (result) => setState(() => _lastResult = result),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Bottom Sheet Section
            SectionHeader(
              title: 'SmartBottomSheet',
              subtitle: 'Adaptive modal bottom sheets',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _BottomSheetDemo(platformStyle: _platformStyle),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Action Sheet Section
            SectionHeader(
              title: 'SmartActionSheet',
              subtitle: 'Adaptive action sheets for multiple options',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ActionSheetDemo(
              platformStyle: _platformStyle,
              onResultChanged: (result) => setState(() => _lastResult = result),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Platform Comparison Section
            SectionHeader(
              title: 'Platform Comparison',
              subtitle: 'See how dialogs render on different platforms',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _PlatformComparisonDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference Section
            SectionHeader(
              title: 'API Reference',
              subtitle: 'showSmartDialog parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getDialogCode() {
    final forceMaterial = _platformStyle == 'material';
    final forceCupertino = _platformStyle == 'cupertino';

    String actions = '''actions: [
    SmartDialogAction(
      label: 'Cancel',
      onPressed: () => Navigator.of(context).pop(),
    ),''';

    if (_showDestructiveAction) {
      actions += '''
    SmartDialogAction(
      label: 'Delete',
      isDestructive: true,
      onPressed: () => Navigator.of(context).pop('deleted'),
    ),''';
    }

    actions += '''
    SmartDialogAction(
      label: 'OK',
      isDefault: true,
      onPressed: () => Navigator.of(context).pop('confirmed'),
    ),
  ],''';

    String code = '''await showSmartDialog(
  context: context,
  title: 'Dialog Title',
  content: 'This is the dialog content message.',
  barrierDismissible: $_barrierDismissible,''';

    if (forceMaterial) {
      code += '\n  forceMaterial: true,';
    }
    if (forceCupertino) {
      code += '\n  forceCupertino: true,';
    }

    code += '\n  $actions\n);';
    return code;
  }
}

class _DialogPreview extends StatelessWidget {
  const _DialogPreview({
    required this.platformStyle,
    required this.barrierDismissible,
    required this.showDestructiveAction,
    required this.lastResult,
    required this.onResultChanged,
  });

  final String platformStyle;
  final bool barrierDismissible;
  final bool showDestructiveAction;
  final String lastResult;
  final ValueChanged<String> onResultChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
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
                          : 'Adaptive',
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
          // Show dialog button
          SmartButton.filled(
            onPressed: () => _showDialog(context),
            child: const Text('Show Dialog'),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          // Last result
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Column(
              children: [
                Text(
                  'Last Result:',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textMutedColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lastResult,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    final actions = <SmartDialogAction>[
      SmartDialogAction(
        label: 'Cancel',
        onPressed: () => Navigator.of(context).pop('cancelled'),
      ),
      if (showDestructiveAction)
        SmartDialogAction(
          label: 'Delete',
          isDestructive: true,
          onPressed: () => Navigator.of(context).pop('deleted'),
        ),
      SmartDialogAction(
        label: 'OK',
        isDefault: true,
        onPressed: () => Navigator.of(context).pop('confirmed'),
      ),
    ];

    final result = await showSmartDialog<String>(
      context: context,
      title: 'Example Dialog',
      content: 'This is an adaptive dialog that changes style based on the platform.',
      barrierDismissible: barrierDismissible,
      forceMaterial: platformStyle == 'material',
      forceCupertino: platformStyle == 'cupertino',
      actions: actions,
    );

    onResultChanged(result ?? 'dismissed');
  }
}

class _DialogTypesDemo extends StatelessWidget {
  const _DialogTypesDemo({
    required this.platformStyle,
    required this.onResultChanged,
  });

  final String platformStyle;
  final ValueChanged<String> onResultChanged;

  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _DialogTypeCard(
            title: 'Alert Dialog',
            description: 'Basic alert with message and actions',
            icon: Icons.warning_amber_outlined,
            color: PlaygroundTheme.warning,
            onTap: () => _showAlertDialog(context),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _DialogTypeCard(
            title: 'Confirm Dialog',
            description: 'Confirmation with OK/Cancel buttons',
            icon: Icons.help_outline,
            color: PlaygroundTheme.info,
            onTap: () => _showConfirmDialog(context),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _DialogTypeCard(
            title: 'Custom Content',
            description: 'Dialog with custom widget content',
            icon: Icons.widgets_outlined,
            color: PlaygroundTheme.primary,
            onTap: () => _showCustomDialog(context),
          ),
        ),
      ],
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    await showSmartDialog(
      context: context,
      title: 'Alert',
      content: 'This is an important alert message!',
      forceMaterial: platformStyle == 'material',
      forceCupertino: platformStyle == 'cupertino',
      actions: [
        SmartDialogAction(
          label: 'OK',
          isDefault: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
    onResultChanged('Alert dismissed');
  }

  Future<void> _showConfirmDialog(BuildContext context) async {
    final result = await showSmartConfirmDialog(
      context: context,
      title: 'Confirm Action',
      content: 'Are you sure you want to proceed?',
      confirmLabel: 'Yes',
      cancelLabel: 'No',
      forceMaterial: platformStyle == 'material',
      forceCupertino: platformStyle == 'cupertino',
    );
    onResultChanged(result ? 'Confirmed' : 'Cancelled');
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    await showSmartDialog(
      context: context,
      title: 'Custom Content',
      forceMaterial: platformStyle == 'material',
      forceCupertino: platformStyle == 'cupertino',
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: PlaygroundTheme.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 32,
              color: PlaygroundTheme.success,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Custom widget content can be used!'),
        ],
      ),
      actions: [
        SmartDialogAction(
          label: 'Got it',
          isDefault: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
    onResultChanged('Custom dialog dismissed');
  }
}

class _DialogTypeCard extends StatelessWidget {
  const _DialogTypeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
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
          const SizedBox(height: 12),
          Text(
            'Tap to preview',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetDemo extends StatelessWidget {
  const _BottomSheetDemo({required this.platformStyle});

  final String platformStyle;

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
              SmartButton.filled(
                onPressed: () => _showBottomSheet(context),
                child: const Text('Show Bottom Sheet'),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              Text(
                'Bottom sheets adapt to Material or Cupertino styles',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textMutedColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''await showSmartBottomSheet(
  context: context,
  title: 'Options',
  child: Column(
    children: [
      ListTile(
        leading: Icon(Icons.share),
        title: Text('Share'),
        onTap: () => Navigator.pop(context),
      ),
      ListTile(
        leading: Icon(Icons.edit),
        title: Text('Edit'),
        onTap: () => Navigator.pop(context),
      ),
      ListTile(
        leading: Icon(Icons.delete),
        title: Text('Delete'),
        onTap: () => Navigator.pop(context),
      ),
    ],
  ),
);''',
          title: 'smart_bottom_sheet_example.dart',
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showSmartBottomSheet(
      context: context,
      title: 'Options',
      forceMaterial: platformStyle == 'material',
      forceCupertino: platformStyle == 'cupertino',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _ActionSheetDemo extends StatelessWidget {
  const _ActionSheetDemo({
    required this.platformStyle,
    required this.onResultChanged,
  });

  final String platformStyle;
  final ValueChanged<String> onResultChanged;

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
              SmartButton.filled(
                onPressed: () => _showActionSheet(context),
                child: const Text('Show Action Sheet'),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              Text(
                'Action sheets provide multiple choices with optional destructive actions',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textMutedColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''await showSmartActionSheet(
  context: context,
  title: 'Photo Options',
  message: 'Choose how to add a photo',
  actions: [
    SmartSheetAction(
      label: 'Take Photo',
      onPressed: () => print('Camera'),
    ),
    SmartSheetAction(
      label: 'Choose from Library',
      onPressed: () => print('Library'),
    ),
    SmartSheetAction(
      label: 'Delete Photo',
      isDestructive: true,
      onPressed: () => print('Delete'),
    ),
  ],
  cancelAction: SmartSheetAction(
    label: 'Cancel',
  ),
);''',
          title: 'smart_action_sheet_example.dart',
        ),
      ],
    );
  }

  void _showActionSheet(BuildContext context) {
    showSmartActionSheet(
      context: context,
      title: 'Photo Options',
      message: 'Choose how to add a photo',
      forceMaterial: platformStyle == 'material',
      forceCupertino: platformStyle == 'cupertino',
      actions: [
        SmartSheetAction(
          label: 'Take Photo',
          onPressed: () => onResultChanged('Take Photo selected'),
        ),
        SmartSheetAction(
          label: 'Choose from Library',
          onPressed: () => onResultChanged('Library selected'),
        ),
        SmartSheetAction(
          label: 'Delete Photo',
          isDestructive: true,
          onPressed: () => onResultChanged('Delete selected'),
        ),
      ],
      cancelAction: SmartSheetAction(
        label: 'Cancel',
        onPressed: () => onResultChanged('Cancelled'),
      ),
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
            features: const [
              'AlertDialog with rounded corners',
              'TextButton actions',
              'Barrier color overlay',
              'Title at top-left',
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _PlatformCard(
            title: 'Cupertino (iOS)',
            icon: Icons.apple,
            color: Colors.white,
            features: const [
              'CupertinoAlertDialog style',
              'Blurred background',
              'Stacked action buttons',
              'Centered title',
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
    required this.features,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<String> features;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          const SizedBox(height: PlaygroundTheme.spaceMd),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: PlaygroundTheme.success,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      feature,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              )),
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
            param: 'context',
            type: 'BuildContext',
            description: 'The build context for showing the dialog',
          ),
          _ApiRow(
            param: 'title',
            type: 'String?',
            description: 'The dialog title text',
          ),
          _ApiRow(
            param: 'content',
            type: 'String?',
            description: 'The dialog content message',
          ),
          _ApiRow(
            param: 'contentWidget',
            type: 'Widget?',
            description: 'Custom widget for dialog content',
          ),
          _ApiRow(
            param: 'actions',
            type: 'List<SmartDialogAction>?',
            description: 'List of action buttons',
          ),
          _ApiRow(
            param: 'barrierDismissible',
            type: 'bool',
            description: 'Whether tapping outside dismisses the dialog',
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
            width: 180,
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
