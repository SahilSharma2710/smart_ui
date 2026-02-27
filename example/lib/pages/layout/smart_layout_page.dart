import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartLayout widget
class SmartLayoutPage extends StatefulWidget {
  const SmartLayoutPage({super.key});

  @override
  State<SmartLayoutPage> createState() => _SmartLayoutPageState();
}

class _SmartLayoutPageState extends State<SmartLayoutPage> {
  SmartTransition _transition = SmartTransition.fade;
  int _transitionDuration = 300;
  bool _showTransitionDemo = true;

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
              'SmartLayout',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'Display different widget trees based on the current breakpoint with optional animated transitions.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Basic Example Section
            SectionHeader(
              title: 'Basic Usage',
              subtitle: 'Provide different widgets for mobile, tablet, and desktop',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _BasicExample(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Transition Animations',
              subtitle: 'SmartLayout supports animated transitions between breakpoints',
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
                      DropdownControl<SmartTransition>(
                        label: 'Transition Type',
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
                        label: 'Show Demo',
                        value: _showTransitionDemo,
                        onChanged: (value) =>
                            setState(() => _showTransitionDemo = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _TransitionDemo(
                    transition: _transition,
                    duration: _transitionDuration,
                    showDemo: _showTransitionDemo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getTransitionCode(),
              title: 'transition_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Cascade Behavior Section
            SectionHeader(
              title: 'Cascade Behavior',
              subtitle: 'Values cascade up from smaller breakpoints',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _CascadeExample(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Builder Pattern Section
            SectionHeader(
              title: 'Builder Pattern',
              subtitle: 'Use the builder parameter for custom wrapping logic',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: '''SmartLayout(
  mobile: MobileView(),
  desktop: DesktopView(),
  builder: (context, breakpoint, child) {
    // Custom wrapper with breakpoint info
    return Column(
      children: [
        Text('Current: \${breakpoint.name}'),
        Expanded(child: child),
      ],
    );
  },
)''',
              title: 'builder_example.dart',
            ),
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

  String _getTransitionCode() {
    return '''SmartLayout(
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
  transition: SmartTransition.${_transition.name},
  transitionDuration: Duration(milliseconds: $_transitionDuration),
  transitionCurve: Curves.easeInOut,
)''';
  }
}

class _BasicExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExamplePreview(
          height: 200,
          child: SmartLayout(
            mobile: _LayoutPreview(
              label: 'Mobile Layout',
              color: PlaygroundTheme.mobileColor,
              icon: Icons.phone_android,
            ),
            tablet: _LayoutPreview(
              label: 'Tablet Layout',
              color: PlaygroundTheme.tabletColor,
              icon: Icons.tablet_android,
            ),
            desktop: _LayoutPreview(
              label: 'Desktop Layout',
              color: PlaygroundTheme.desktopColor,
              icon: Icons.desktop_windows,
            ),
            transition: SmartTransition.fade,
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartLayout(
  mobile: MobileHomeScreen(),
  tablet: TabletHomeScreen(),
  desktop: DesktopHomeScreen(),
)''',
          title: 'basic_example.dart',
        ),
      ],
    );
  }
}

class _LayoutPreview extends StatelessWidget {
  const _LayoutPreview({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
              ),
              child: Text(
                'Resize browser to see transitions',
                style: TextStyle(fontSize: 12, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransitionDemo extends StatelessWidget {
  const _TransitionDemo({
    required this.transition,
    required this.duration,
    required this.showDemo,
  });

  final SmartTransition transition;
  final int duration;
  final bool showDemo;

  @override
  Widget build(BuildContext context) {
    if (!showDemo) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
          border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
        ),
        child: Center(
          child: Text(
            'Enable demo to see transitions',
            style: TextStyle(color: context.textMutedColor),
          ),
        ),
      );
    }

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        child: SmartLayout(
          mobile: _TransitionCard(
            title: 'Mobile',
            color: PlaygroundTheme.mobileColor,
            icon: Icons.phone_android,
          ),
          tablet: _TransitionCard(
            title: 'Tablet',
            color: PlaygroundTheme.tabletColor,
            icon: Icons.tablet_android,
          ),
          desktop: _TransitionCard(
            title: 'Desktop',
            color: PlaygroundTheme.desktopColor,
            icon: Icons.desktop_windows,
          ),
          transition: transition,
          transitionDuration: Duration(milliseconds: duration),
        ),
      ),
    );
  }
}

class _TransitionCard extends StatelessWidget {
  const _TransitionCard({
    required this.title,
    required this.color,
    required this.icon,
  });

  final String title;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
              ),
              child: Icon(icon, size: 40, color: color),
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            Text(
              '$title View',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CascadeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
                'Cascade Logic',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _CascadeRow(
                breakpoint: 'TV',
                logic: 'tv ?? desktop ?? tablet ?? mobile ?? watch',
              ),
              _CascadeRow(
                breakpoint: 'Desktop',
                logic: 'desktop ?? tablet ?? mobile ?? watch',
              ),
              _CascadeRow(
                breakpoint: 'Tablet',
                logic: 'tablet ?? mobile ?? watch',
              ),
              _CascadeRow(
                breakpoint: 'Mobile',
                logic: 'mobile ?? watch',
              ),
              _CascadeRow(
                breakpoint: 'Watch',
                logic: 'watch ?? mobile ?? tablet ?? desktop ?? tv',
                isLast: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Only define mobile and desktop
// Tablet will use mobile, TV will use desktop
SmartLayout(
  mobile: CompactView(),   // Used by watch, mobile, tablet
  desktop: ExpandedView(), // Used by desktop, TV
)''',
          title: 'cascade_example.dart',
        ),
      ],
    );
  }
}

class _CascadeRow extends StatelessWidget {
  const _CascadeRow({
    required this.breakpoint,
    required this.logic,
    this.isLast = false,
  });

  final String breakpoint;
  final String logic;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: PlaygroundTheme.colorForBreakpoint(breakpoint)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              breakpoint,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.colorForBreakpoint(breakpoint),
              ),
            ),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(
            child: Text(
              logic,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: context.textSecondaryColor,
              ),
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
            param: 'watch',
            type: 'Widget?',
            description: 'Widget for watch-sized screens',
          ),
          _ApiRow(
            param: 'mobile',
            type: 'Widget?',
            description: 'Widget for mobile-sized screens',
          ),
          _ApiRow(
            param: 'tablet',
            type: 'Widget?',
            description: 'Widget for tablet-sized screens',
          ),
          _ApiRow(
            param: 'desktop',
            type: 'Widget?',
            description: 'Widget for desktop-sized screens',
          ),
          _ApiRow(
            param: 'tv',
            type: 'Widget?',
            description: 'Widget for TV-sized screens',
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
          ),
          _ApiRow(
            param: 'builder',
            type: 'Function?',
            description: 'Custom builder for wrapping the selected widget',
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
            width: 120,
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
