import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartVisible, showOnly, hideOn visibility utilities.
class VisibilityPage extends StatefulWidget {
  const VisibilityPage({super.key});

  @override
  State<VisibilityPage> createState() => _VisibilityPageState();
}

class _VisibilityPageState extends State<VisibilityPage> {
  // Visibility controls
  Set<SmartBreakpoint> _visibleBreakpoints = {
    SmartBreakpoint.tablet,
    SmartBreakpoint.desktop,
    SmartBreakpoint.tv,
  };

  SmartTransition _transition = SmartTransition.fade;
  int _transitionDuration = 200;
  bool _maintainState = false;
  bool _maintainSize = false;

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'Visibility',
      subtitle:
          'Conditionally show or hide content based on breakpoints with SmartVisible, showOnly, and hideOn.',
      children: [
        // Current Visibility Status
        _buildVisibilityStatus(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // SmartVisible Section
        SectionHeader(
          title: 'SmartVisible Widget',
          subtitle: 'A widget for breakpoint-based conditional rendering',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSmartVisibleDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Demo
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Toggle breakpoints to see visibility changes',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Convenience Widgets
        SectionHeader(
          title: 'Convenience Widgets',
          subtitle: 'Pre-configured visibility widgets for common patterns',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildConvenienceWidgets(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Context Extensions
        SectionHeader(
          title: 'Context Extensions',
          subtitle: 'Use showOnly and hideOn methods directly on BuildContext',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildContextExtensions(),
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

  Widget _buildVisibilityStatus() {
    final currentBreakpoint = context.breakpoint;
    final isVisible = _visibleBreakpoints.contains(currentBreakpoint);
    final color = isVisible ? PlaygroundTheme.success : PlaygroundTheme.error;

    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                size: 48,
                color: color,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Content is',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  Text(
                    isVisible ? 'VISIBLE' : 'HIDDEN',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PlaygroundTheme.spaceMd,
              vertical: PlaygroundTheme.spaceSm,
            ),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
            ),
            child: Text(
              'Current breakpoint: ${currentBreakpoint.name.toUpperCase()}',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'monospace',
                color: context.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartVisibleDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExamplePreview(
          height: 150,
          child: Center(
            child: SmartVisible(
              visibleOn: _visibleBreakpoints.toList(),
              transition: _transition,
              transitionDuration: Duration(milliseconds: _transitionDuration),
              maintainState: _maintainState,
              maintainSize: _maintainSize,
              replacement: Container(
                padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
                decoration: BoxDecoration(
                  color: PlaygroundTheme.error.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(PlaygroundTheme.radiusMd),
                  border: Border.all(
                    color: PlaygroundTheme.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.visibility_off,
                      size: 32,
                      color: PlaygroundTheme.error,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hidden on this breakpoint',
                      style: TextStyle(
                        color: PlaygroundTheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
                decoration: BoxDecoration(
                  gradient: PlaygroundTheme.primaryGradient,
                  borderRadius:
                      BorderRadius.circular(PlaygroundTheme.radiusMd),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 32,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Visible content!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: _getSmartVisibleCode(),
          title: 'smart_visible_example.dart',
        ),
      ],
    );
  }

  String _getSmartVisibleCode() {
    final breakpointsList = _visibleBreakpoints
        .map((b) => 'SmartBreakpoint.${b.name}')
        .join(', ');
    return '''SmartVisible(
  visibleOn: [$breakpointsList],
  transition: SmartTransition.${_transition.name},
  transitionDuration: Duration(milliseconds: $_transitionDuration),
  maintainState: $_maintainState,
  maintainSize: $_maintainSize,
  replacement: HiddenPlaceholder(),
  child: VisibleContent(),
)''';
  }

  Widget _buildInteractiveDemo() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 5,
          child: InteractiveControls(
            title: 'Visibility Settings',
            children: [
              _buildBreakpointCheckboxes(),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              DropdownControl<SmartTransition>(
                label: 'Transition',
                value: _transition,
                options: SmartTransition.values,
                optionLabels: {
                  SmartTransition.none: 'None',
                  SmartTransition.fade: 'Fade',
                  SmartTransition.fadeSlide: 'Fade Slide',
                  SmartTransition.crossFade: 'Cross Fade',
                  SmartTransition.scale: 'Scale',
                },
                onChanged: (value) => setState(() => _transition = value),
              ),
              SliderControl(
                label: 'Duration (ms)',
                value: _transitionDuration.toDouble(),
                min: 100,
                max: 1000,
                divisions: 9,
                valueLabel: '${_transitionDuration}ms',
                onChanged: (value) =>
                    setState(() => _transitionDuration = value.toInt()),
              ),
              SwitchControl(
                label: 'Maintain State',
                value: _maintainState,
                description: 'Keep widget state when hidden',
                onChanged: (value) => setState(() => _maintainState = value),
              ),
              SwitchControl(
                label: 'Maintain Size',
                value: _maintainSize,
                description: 'Reserve space when hidden',
                onChanged: (value) => setState(() => _maintainSize = value),
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 7,
          child: _buildBreakpointVisualization(),
        ),
      ],
    );
  }

  Widget _buildBreakpointCheckboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visible on breakpoints',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: context.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: SmartBreakpoint.values.map((bp) {
            final isSelected = _visibleBreakpoints.contains(bp);
            final color = PlaygroundTheme.colorForBreakpoint(bp.name);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _visibleBreakpoints.remove(bp);
                  } else {
                    _visibleBreakpoints.add(bp);
                  }
                });
              },
              child: AnimatedContainer(
                duration: PlaygroundTheme.durationFast,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(PlaygroundTheme.radiusFull),
                  border: Border.all(
                    color: isSelected
                        ? color
                        : context.borderColor.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 16,
                      color: isSelected ? color : context.textMutedColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      bp.name,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected ? color : context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBreakpointVisualization() {
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
          Text(
            'Visibility by Breakpoint',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          ...SmartBreakpoint.values.map((bp) {
            final isVisible = _visibleBreakpoints.contains(bp);
            final isCurrent = context.breakpoint == bp;
            final color = PlaygroundTheme.colorForBreakpoint(bp.name);

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCurrent
                    ? color.withValues(alpha: 0.1)
                    : context.surfaceElevatedColor,
                borderRadius:
                    BorderRadius.circular(PlaygroundTheme.radiusMd),
                border: Border.all(
                  color: isCurrent
                      ? color.withValues(alpha: 0.5)
                      : context.borderColor.withValues(alpha: 0.3),
                  width: isCurrent ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    PlaygroundTheme.iconForBreakpoint(bp.name),
                    size: 20,
                    color: color,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    bp.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color,
                      letterSpacing: 1,
                    ),
                  ),
                  if (isCurrent) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            BorderRadius.circular(PlaygroundTheme.radiusFull),
                      ),
                      child: Text(
                        'CURRENT',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    size: 18,
                    color: isVisible
                        ? PlaygroundTheme.success
                        : context.textMutedColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isVisible ? 'Visible' : 'Hidden',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isVisible
                          ? PlaygroundTheme.success
                          : context.textMutedColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildConvenienceWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartGrid(
          spacing: SmartSpacing.md,
          children: [
            SmartCol(
              mobile: 12,
              tablet: 6,
              child: _ConvenienceWidgetCard(
                title: 'MobileOnly',
                description: 'Shows content only on watch and mobile',
                code: '''MobileOnly(
  child: MobileNavigation(),
  replacement: DesktopNavigation(),
)''',
              ),
            ),
            SmartCol(
              mobile: 12,
              tablet: 6,
              child: _ConvenienceWidgetCard(
                title: 'TabletOnly',
                description: 'Shows content only on tablet',
                code: '''TabletOnly(
  child: TabletSidebar(),
)''',
              ),
            ),
            SmartCol(
              mobile: 12,
              tablet: 6,
              child: _ConvenienceWidgetCard(
                title: 'DesktopOnly',
                description: 'Shows content only on desktop and TV',
                code: '''DesktopOnly(
  child: AdvancedSettings(),
)''',
              ),
            ),
            SmartCol(
              mobile: 12,
              tablet: 6,
              child: _ConvenienceWidgetCard(
                title: 'HideOnMobile',
                description: 'Hides content on watch and mobile',
                code: '''HideOnMobile(
  child: ExtendedInfo(),
)''',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContextExtensions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodePreviewSplit(
          code: '''// Show only on specific breakpoints
context.showOnly(
  breakpoints: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
  child: DesktopSidebar(),
  replacement: MobileSidebar(),
)

// Hide on specific breakpoints
context.hideOn(
  breakpoints: [SmartBreakpoint.watch, SmartBreakpoint.mobile],
  child: AdvancedOptions(),
)

// Using SmartVisible.on shorthand
SmartVisible.on(
  breakpoints: [SmartBreakpoint.tablet, SmartBreakpoint.desktop],
  child: TabletContent(),
)

// Using SmartVisible.except shorthand
SmartVisible.except(
  breakpoints: [SmartBreakpoint.watch],
  child: MainContent(),
)''',
          codeTitle: 'context_visibility.dart',
          preview: Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Live Demo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                context.showOnly(
                  breakpoints: const [SmartBreakpoint.desktop, SmartBreakpoint.tv],
                  child: _StatusBadge(
                    label: 'Desktop content visible',
                    isVisible: true,
                  ),
                  replacement: _StatusBadge(
                    label: 'Desktop content hidden',
                    isVisible: false,
                  ),
                ),
                const SizedBox(height: 8),
                context.hideOn(
                  breakpoints: const [SmartBreakpoint.watch, SmartBreakpoint.mobile],
                  child: _StatusBadge(
                    label: 'Non-mobile content visible',
                    isVisible: true,
                  ),
                  replacement: _StatusBadge(
                    label: 'Hidden on mobile',
                    isVisible: false,
                  ),
                ),
              ],
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
            param: 'visibleOn',
            type: 'List<SmartBreakpoint>?',
            description: 'Breakpoints on which to show the child',
          ),
          _ApiRow(
            param: 'hiddenOn',
            type: 'List<SmartBreakpoint>?',
            description: 'Breakpoints on which to hide the child',
          ),
          _ApiRow(
            param: 'replacement',
            type: 'Widget?',
            description: 'Widget to show when hidden (default: SizedBox.shrink)',
          ),
          _ApiRow(
            param: 'maintainState',
            type: 'bool',
            description: 'Whether to maintain state when hidden',
          ),
          _ApiRow(
            param: 'maintainSize',
            type: 'bool',
            description: 'Whether to reserve space when hidden',
          ),
          _ApiRow(
            param: 'transition',
            type: 'SmartTransition',
            description: 'Animation type (none, fade, fadeSlide, crossFade, scale)',
          ),
          _ApiRow(
            param: 'transitionDuration',
            type: 'Duration',
            description: 'Duration of the transition animation',
          ),
          _ApiRow(
            param: 'transitionCurve',
            type: 'Curve',
            description: 'Animation curve for the transition',
            isLast: true,
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

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.isVisible,
  });

  final String label;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final color = isVisible ? PlaygroundTheme.success : PlaygroundTheme.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVisible ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w500,
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
