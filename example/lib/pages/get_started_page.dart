import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/playground_theme.dart';
import '../components/components.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

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
              'Get Started',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'Add responsive superpowers to your Flutter app in under 5 minutes.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Step 1: Installation
            _StepCard(
              number: 1,
              title: 'Installation',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add adaptive_kit to your pubspec.yaml:',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: PlaygroundTheme.spaceMd),
                  CodePreview(
                    code: '''dependencies:
  adaptive_kit: ^2.0.1''',
                    title: 'pubspec.yaml',
                  ),
                  const SizedBox(height: PlaygroundTheme.spaceMd),
                  Text(
                    'Or install via command line:',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: PlaygroundTheme.spaceMd),
                  CodePreview(
                    code: 'flutter pub add adaptive_kit',
                    title: 'Terminal',
                    showLineNumbers: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceLg),

            // Step 2: Wrap with SmartApp
            _StepCard(
              number: 2,
              title: 'Wrap with SmartApp',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Replace MaterialApp with SmartApp to enable responsive features:',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: PlaygroundTheme.spaceMd),
                  CodePreview(
                    code: '''import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SmartApp(
      title: 'My App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}''',
                    title: 'main.dart',
                  ),
                ],
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceLg),

            // Step 3: Use Responsive Widgets
            _StepCard(
              number: 3,
              title: 'Use Responsive Widgets',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start using responsive widgets throughout your app:',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: PlaygroundTheme.spaceMd),
                  CodePreview(
                    code: '''// Responsive layout switching
SmartLayout(
  mobile: MobileView(),
  tablet: TabletView(),
  desktop: DesktopView(),
)

// Responsive grid
SmartGrid(
  children: [
    SmartCol(mobile: 12, tablet: 6, desktop: 4,
      child: MyCard()),
  ],
)

// Responsive values
final padding = context.responsive(
  mobile: 16.0,
  tablet: 24.0,
  desktop: 32.0,
);

// Breakpoint checks
if (context.isTabletOrLarger) {
  // Show sidebar
}''',
                    title: 'usage_example.dart',
                  ),
                ],
              ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Quick Reference
            SectionHeader(
              title: 'Quick Reference',
              subtitle: 'Common patterns you\'ll use every day',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),

            SmartGrid(
              spacing: SmartSpacing.md,
              children: [
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  child: _QuickRefCard(
                    title: 'Breakpoint Checks',
                    code: '''context.isMobile
context.isTablet
context.isDesktop
context.isTabletOrLarger
context.isDesktopOrLarger''',
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  child: _QuickRefCard(
                    title: 'Platform Checks',
                    code: '''context.isAndroid
context.isIOS
context.isWeb
context.isMobilePlatform
context.isDesktopPlatform''',
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  child: _QuickRefCard(
                    title: 'Responsive Values',
                    code: '''context.responsive(
  mobile: value1,
  tablet: value2,
  desktop: value3,
)''',
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  child: _QuickRefCard(
                    title: 'Spacing Tokens',
                    code: '''SmartSpacing.xs  // 4px
SmartSpacing.sm  // 8px
SmartSpacing.md  // 16px
SmartSpacing.lg  // 24px
SmartSpacing.xl  // 32px''',
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Explore more
            SectionHeader(
              title: 'Explore More',
              subtitle: 'Dive deeper into adaptive_kit features',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),

            SmartGrid(
              spacing: SmartSpacing.md,
              children: [
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.devices,
                    title: 'Breakpoints',
                    description: 'Learn about the 5 breakpoint system',
                    color: PlaygroundTheme.primary,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.grid_view,
                    title: 'SmartGrid',
                    description: 'Master the 12-column grid system',
                    color: PlaygroundTheme.accent,
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  tablet: 6,
                  desktop: 4,
                  child: FeatureCard(
                    icon: Icons.extension,
                    title: 'Extensions',
                    description: 'Explore 50+ context extensions',
                    color: PlaygroundTheme.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.title,
    required this.child,
  });

  final int number;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: PlaygroundTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
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

class _QuickRefCard extends StatelessWidget {
  const _QuickRefCard({
    required this.title,
    required this.code,
  });

  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            decoration: BoxDecoration(
              color: context.codeBgColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: context.textPrimaryColor,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
