import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartIndicator widget
class SmartIndicatorPage extends StatefulWidget {
  const SmartIndicatorPage({super.key});

  @override
  State<SmartIndicatorPage> createState() => _SmartIndicatorPageState();
}

class _SmartIndicatorPageState extends State<SmartIndicatorPage> {
  // Controls
  String _platformStyle = 'adaptive';
  double _progressValue = 0.65;
  bool _isDeterminate = true;
  Color _indicatorColor = PlaygroundTheme.primary;

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
              'SmartIndicator',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'Adaptive progress indicators that switch between Material CircularProgressIndicator and Cupertino ActivityIndicator based on the platform.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Customize indicator properties and see live changes',
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
                        label: 'Determinate',
                        value: _isDeterminate,
                        description: 'Show specific progress value',
                        onChanged: (value) =>
                            setState(() => _isDeterminate = value),
                      ),
                      if (_isDeterminate)
                        SliderControl(
                          label: 'Progress',
                          value: _progressValue,
                          min: 0,
                          max: 1,
                          divisions: 100,
                          valueLabel: '${(_progressValue * 100).toInt()}%',
                          onChanged: (value) =>
                              setState(() => _progressValue = value),
                        ),
                      ColorPickerControl(
                        label: 'Color',
                        value: _indicatorColor,
                        colors: [
                          PlaygroundTheme.primary,
                          PlaygroundTheme.success,
                          PlaygroundTheme.error,
                          PlaygroundTheme.warning,
                          PlaygroundTheme.info,
                          PlaygroundTheme.accent,
                        ],
                        onChanged: (value) =>
                            setState(() => _indicatorColor = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _IndicatorPreview(
                    platformStyle: _platformStyle,
                    isDeterminate: _isDeterminate,
                    progressValue: _progressValue,
                    color: _indicatorColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getIndicatorCode(),
              title: 'smart_indicator_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Platform Comparison Section
            SectionHeader(
              title: 'Platform Comparison',
              subtitle: 'See how indicators render on different platforms',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _PlatformComparisonDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Linear Indicator Section
            SectionHeader(
              title: 'SmartLinearIndicator',
              subtitle: 'Adaptive linear progress bars',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _LinearIndicatorDemo(
              platformStyle: _platformStyle,
              color: _indicatorColor,
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Loading Overlay Section
            SectionHeader(
              title: 'SmartLoadingOverlay',
              subtitle: 'Full-screen loading indicator with optional message',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _LoadingOverlayDemo(platformStyle: _platformStyle),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Refresh Indicator Section
            SectionHeader(
              title: 'SmartRefreshIndicator',
              subtitle: 'Pull-to-refresh with platform-specific styling',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _RefreshIndicatorDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Use Cases Section
            SectionHeader(
              title: 'Common Use Cases',
              subtitle: 'Real-world examples of progress indicators',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _UseCasesDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference Section
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartIndicator parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getIndicatorCode() {
    final forceMaterial = _platformStyle == 'material';
    final forceCupertino = _platformStyle == 'cupertino';

    String code = '''SmartIndicator(''';

    if (_isDeterminate) {
      code += '\n  value: ${_progressValue.toStringAsFixed(2)},';
    }

    if (_indicatorColor != PlaygroundTheme.primary) {
      final colorHex = _indicatorColor.r.toInt().toRadixString(16).padLeft(2, '0') +
          _indicatorColor.g.toInt().toRadixString(16).padLeft(2, '0') +
          _indicatorColor.b.toInt().toRadixString(16).padLeft(2, '0');
      code += '\n  color: Color(0xFF${colorHex.toUpperCase()}),';
    }

    if (forceMaterial) {
      code += '\n  forceMaterial: true,';
    }
    if (forceCupertino) {
      code += '\n  forceCupertino: true,';
    }

    code += '\n)';
    return code;
  }
}

class _IndicatorPreview extends StatelessWidget {
  const _IndicatorPreview({
    required this.platformStyle,
    required this.isDeterminate,
    required this.progressValue,
    required this.color,
  });

  final String platformStyle;
  final bool isDeterminate;
  final double progressValue;
  final Color color;

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
          // Indicator preview
          SizedBox(
            width: 80,
            height: 80,
            child: SmartIndicator(
              value: isDeterminate ? progressValue : null,
              color: color,
              forceMaterial: platformStyle == 'material',
              forceCupertino: platformStyle == 'cupertino',
              strokeWidth: 5,
              radius: 20,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          // Progress label
          if (isDeterminate)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
              ),
              child: Text(
                '${(progressValue * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            )
          else
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14,
                color: context.textMutedColor,
              ),
            ),
        ],
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const SmartIndicator(
                        forceMaterial: true,
                        strokeWidth: 4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Indeterminate',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SmartIndicator(
                        value: 0.7,
                        forceMaterial: true,
                        strokeWidth: 4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Determinate',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const SmartIndicator(
                        forceCupertino: true,
                        radius: 14,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Activity Indicator',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Note: CupertinoActivityIndicator\ndoesn\'t support determinate mode',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: context.textMutedColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
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

class _LinearIndicatorDemo extends StatefulWidget {
  const _LinearIndicatorDemo({
    required this.platformStyle,
    required this.color,
  });

  final String platformStyle;
  final Color color;

  @override
  State<_LinearIndicatorDemo> createState() => _LinearIndicatorDemoState();
}

class _LinearIndicatorDemoState extends State<_LinearIndicatorDemo> {
  double _linearProgress = 0.4;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Indeterminate',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 12),
              SmartLinearIndicator(
                color: widget.color,
                forceMaterial: widget.platformStyle == 'material',
                forceCupertino: widget.platformStyle == 'cupertino',
              ),
              const SizedBox(height: PlaygroundTheme.spaceLg),
              Text(
                'Determinate',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 12),
              SmartLinearIndicator(
                value: _linearProgress,
                color: widget.color,
                forceMaterial: widget.platformStyle == 'material',
                forceCupertino: widget.platformStyle == 'cupertino',
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Uploading...',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textMutedColor,
                    ),
                  ),
                  Text(
                    '${(_linearProgress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: widget.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmartButton.outlined(
                    onPressed: () {
                      setState(() {
                        _linearProgress = (_linearProgress - 0.1).clamp(0.0, 1.0);
                      });
                    },
                    child: const Icon(Icons.remove, size: 18),
                  ),
                  const SizedBox(width: 16),
                  SmartButton.outlined(
                    onPressed: () {
                      setState(() {
                        _linearProgress = (_linearProgress + 0.1).clamp(0.0, 1.0);
                      });
                    },
                    child: const Icon(Icons.add, size: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Indeterminate
SmartLinearIndicator(
  color: Colors.blue,
)

// Determinate with progress
SmartLinearIndicator(
  value: 0.65, // 0.0 to 1.0
  color: Colors.blue,
  backgroundColor: Colors.grey[200],
  minHeight: 6,
  borderRadius: BorderRadius.circular(3),
)''',
          title: 'smart_linear_indicator_example.dart',
        ),
      ],
    );
  }
}

class _LoadingOverlayDemo extends StatefulWidget {
  const _LoadingOverlayDemo({required this.platformStyle});

  final String platformStyle;

  @override
  State<_LoadingOverlayDemo> createState() => _LoadingOverlayDemoState();
}

class _LoadingOverlayDemoState extends State<_LoadingOverlayDemo> {
  bool _showOverlay = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
                border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmartButton.filled(
                      onPressed: () {
                        setState(() => _showOverlay = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            setState(() => _showOverlay = false);
                          }
                        });
                      },
                      child: const Text('Show Loading Overlay'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Overlay will auto-dismiss after 2 seconds',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_showOverlay)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
                  child: SmartLoadingOverlay(
                    message: 'Loading...',
                    forceMaterial: widget.platformStyle == 'material',
                    forceCupertino: widget.platformStyle == 'cupertino',
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// As a Stack overlay
Stack(
  children: [
    MyPageContent(),
    if (isLoading)
      SmartLoadingOverlay(
        message: 'Loading...',
        color: Colors.white,
        backgroundColor: Colors.black54,
      ),
  ],
)

// Full screen overlay
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => SmartLoadingOverlay(
    message: 'Please wait...',
  ),
);''',
          title: 'smart_loading_overlay_example.dart',
        ),
      ],
    );
  }
}

class _RefreshIndicatorDemo extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SmartRefreshIndicator',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Wraps scrollable content with platform-appropriate pull-to-refresh functionality. Uses RefreshIndicator on Material and CupertinoSliverRefreshControl on iOS.',
                style: TextStyle(
                  fontSize: 14,
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartRefreshIndicator(
  onRefresh: () async {
    // Fetch new data
    await fetchData();
  },
  color: Colors.blue,
  backgroundColor: Colors.white,
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(items[index]),
      );
    },
  ),
)''',
          title: 'smart_refresh_indicator_example.dart',
        ),
      ],
    );
  }
}

class _UseCasesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _UseCaseCard(
            title: 'Button Loading State',
            icon: Icons.touch_app,
            child: _LoadingButton(),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _UseCaseCard(
            title: 'File Upload Progress',
            icon: Icons.cloud_upload,
            child: _UploadProgress(),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _UseCaseCard(
            title: 'Step Progress',
            icon: Icons.checklist,
            child: _StepProgress(),
          ),
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: PlaygroundTheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          child,
        ],
      ),
    );
  }
}

class _LoadingButton extends StatefulWidget {
  @override
  State<_LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<_LoadingButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SmartButton.filled(
      onPressed: _isLoading
          ? null
          : () {
              setState(() => _isLoading = true);
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  setState(() => _isLoading = false);
                }
              });
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLoading) ...[
            const SizedBox(
              width: 16,
              height: 16,
              child: SmartIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(_isLoading ? 'Processing...' : 'Submit'),
        ],
      ),
    );
  }
}

class _UploadProgress extends StatefulWidget {
  @override
  State<_UploadProgress> createState() => _UploadProgressState();
}

class _UploadProgressState extends State<_UploadProgress> {
  double _progress = 0.0;
  bool _isUploading = false;

  void _startUpload() {
    setState(() {
      _isUploading = true;
      _progress = 0;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted && _progress < 1.0) {
        setState(() => _progress += 0.05);
        return true;
      }
      if (mounted) {
        setState(() => _isUploading = false);
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmartLinearIndicator(
          value: _isUploading ? _progress : null,
          color: PlaygroundTheme.primary,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _isUploading
                  ? 'Uploading...'
                  : _progress >= 1.0
                      ? 'Complete!'
                      : 'Ready',
              style: TextStyle(
                fontSize: 12,
                color: context.textMutedColor,
              ),
            ),
            if (_isUploading)
              Text(
                '${(_progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: PlaygroundTheme.primary,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SmartButton.outlined(
          onPressed: _isUploading ? null : _startUpload,
          child: const Text('Start Upload'),
        ),
      ],
    );
  }
}

class _StepProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StepItem(step: 1, label: 'Account', isComplete: true),
        _StepItem(step: 2, label: 'Details', isComplete: true),
        _StepItem(step: 3, label: 'Payment', isComplete: false, isActive: true),
        _StepItem(step: 4, label: 'Confirm', isComplete: false),
      ],
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.step,
    required this.label,
    required this.isComplete,
    this.isActive = false,
  });

  final int step;
  final String label;
  final bool isComplete;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isComplete
                  ? PlaygroundTheme.success
                  : isActive
                      ? PlaygroundTheme.primary
                      : context.borderColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isComplete
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : Text(
                      '$step',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : context.textMutedColor,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isComplete || isActive
                  ? context.textPrimaryColor
                  : context.textMutedColor,
            ),
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
            type: 'double?',
            description: 'Progress value (0.0 to 1.0), null for indeterminate',
          ),
          _ApiRow(
            param: 'color',
            type: 'Color?',
            description: 'The color of the progress indicator',
          ),
          _ApiRow(
            param: 'backgroundColor',
            type: 'Color?',
            description: 'Background color of the progress track',
          ),
          _ApiRow(
            param: 'strokeWidth',
            type: 'double?',
            description: 'Width of the progress stroke (Material only)',
          ),
          _ApiRow(
            param: 'radius',
            type: 'double?',
            description: 'Radius of the indicator (Cupertino only)',
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
            width: 130,
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
            width: 100,
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
