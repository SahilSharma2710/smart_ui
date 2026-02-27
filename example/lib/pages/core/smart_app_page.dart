import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for the SmartApp wrapper widget.
class SmartAppPage extends StatefulWidget {
  const SmartAppPage({super.key});

  @override
  State<SmartAppPage> createState() => _SmartAppPageState();
}

class _SmartAppPageState extends State<SmartAppPage> {
  // Interactive controls state
  bool _useDarkTheme = true;
  bool _useRouter = false;
  bool _showDebugBanner = false;
  bool _useCustomBreakpoints = false;
  String _selectedThemeMode = 'system';

  String get _generatedCode {
    final buffer = StringBuffer();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'package:adaptive_kit/adaptive_kit.dart';");
    buffer.writeln();
    buffer.writeln('void main() {');
    buffer.writeln('  runApp(const MyApp());');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('class MyApp extends StatelessWidget {');
    buffer.writeln('  const MyApp({super.key});');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context) {');

    if (_useRouter) {
      buffer.writeln('    return SmartApp.router(');
    } else {
      buffer.writeln('    return SmartApp(');
    }

    buffer.writeln("      title: 'My App',");

    if (_useCustomBreakpoints) {
      buffer.writeln('      breakpoints: SmartBreakpoints.custom(');
      buffer.writeln('        mobile: 320,');
      buffer.writeln('        tablet: 768,');
      buffer.writeln('        desktop: 1024,');
      buffer.writeln('        tv: 1440,');
      buffer.writeln('      ),');
    }

    if (_useDarkTheme) {
      buffer.writeln('      theme: ThemeData.light(),');
      buffer.writeln('      darkTheme: ThemeData.dark(),');
    } else {
      buffer.writeln('      theme: ThemeData.light(),');
    }

    if (_selectedThemeMode != 'system') {
      buffer.writeln('      themeMode: ThemeMode.$_selectedThemeMode,');
    }

    if (!_showDebugBanner) {
      buffer.writeln('      debugShowCheckedModeBanner: false,');
    }

    if (_useRouter) {
      buffer.writeln('      routerConfig: router,');
    } else {
      buffer.writeln('      home: const HomeScreen(),');
    }

    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'SmartApp',
      subtitle:
          'A convenient wrapper for MaterialApp that auto-configures SmartUi and responsive breakpoints.',
      children: [
        // Overview Section
        _buildOverviewSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Interactive Demo Section
        SectionHeader(
          title: 'Interactive Demo',
          subtitle: 'Configure SmartApp options and see the generated code',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildInteractiveDemo(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Features Section
        SectionHeader(
          title: 'Key Features',
          subtitle: 'What SmartApp provides out of the box',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildFeaturesGrid(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // SmartCupertinoApp Section
        SectionHeader(
          title: 'SmartCupertinoApp',
          subtitle: 'For Cupertino-style iOS apps',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildCupertinoSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // API Reference
        SectionHeader(
          title: 'API Reference',
          subtitle: 'Key properties and their descriptions',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildApiReference(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildOverviewSection() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            PlaygroundTheme.primary.withValues(alpha: 0.1),
            PlaygroundTheme.accent.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: PlaygroundTheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PlaygroundTheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                ),
                child: Icon(
                  Icons.apps_rounded,
                  color: PlaygroundTheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drop-in Replacement for MaterialApp',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SmartApp wraps MaterialApp and automatically injects SmartUi configuration, '
                      'giving you instant access to responsive breakpoints and utilities.',
                      style: TextStyle(
                        fontSize: 14,
                        color: context.textSecondaryColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          CodePreview(
            code: '''// Before (manual setup)
MaterialApp(
  builder: (context, child) {
    return SmartUi(
      breakpoints: SmartBreakpoints.defaults,
      child: child!,
    );
  },
  home: HomeScreen(),
)

// After (with SmartApp)
SmartApp(
  home: HomeScreen(),
)''',
            title: 'Simplified Setup',
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return SmartLayout(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildControlsPanel(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildCodeOutput(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: _buildControlsPanel(),
          ),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(child: _buildCodeOutput()),
        ],
      ),
    );
  }

  Widget _buildControlsPanel() {
    return InteractiveControls(
      title: 'Configuration',
      children: [
        SwitchControl(
          label: 'Use Router API',
          description: 'Use SmartApp.router() constructor',
          value: _useRouter,
          onChanged: (value) => setState(() => _useRouter = value),
        ),
        SwitchControl(
          label: 'Dark Theme Support',
          description: 'Add darkTheme property',
          value: _useDarkTheme,
          onChanged: (value) => setState(() => _useDarkTheme = value),
        ),
        SwitchControl(
          label: 'Custom Breakpoints',
          description: 'Override default breakpoint values',
          value: _useCustomBreakpoints,
          onChanged: (value) => setState(() => _useCustomBreakpoints = value),
        ),
        SwitchControl(
          label: 'Debug Banner',
          description: 'Show debug banner in corner',
          value: _showDebugBanner,
          onChanged: (value) => setState(() => _showDebugBanner = value),
        ),
        DropdownControl<String>(
          label: 'Theme Mode',
          value: _selectedThemeMode,
          options: const ['system', 'light', 'dark'],
          optionLabels: const {
            'system': 'System (default)',
            'light': 'Light',
            'dark': 'Dark',
          },
          onChanged: (value) => setState(() => _selectedThemeMode = value),
        ),
      ],
    );
  }

  Widget _buildCodeOutput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodePreview(
          code: _generatedCode,
          title: 'main.dart',
          maxHeight: 500,
        ),
      ],
    );
  }

  Widget _buildFeaturesGrid() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _FeatureItem(
            icon: Icons.auto_awesome,
            title: 'Auto Configuration',
            description:
                'SmartUi is automatically injected via MaterialApp.builder',
            color: PlaygroundTheme.primary,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _FeatureItem(
            icon: Icons.devices,
            title: 'Breakpoints Ready',
            description:
                'All responsive breakpoints are available immediately',
            color: PlaygroundTheme.tabletColor,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _FeatureItem(
            icon: Icons.swap_horiz,
            title: 'API Compatible',
            description:
                'Same API as MaterialApp - easy migration',
            color: PlaygroundTheme.success,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _FeatureItem(
            icon: Icons.route,
            title: 'Router Support',
            description:
                'Works with Navigator and Router (go_router, etc.)',
            color: PlaygroundTheme.accent,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _FeatureItem(
            icon: Icons.tune,
            title: 'Customizable',
            description:
                'Override breakpoints and spacing tokens as needed',
            color: PlaygroundTheme.warning,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _FeatureItem(
            icon: Icons.apple,
            title: 'Cupertino Variant',
            description:
                'SmartCupertinoApp for iOS-style apps',
            color: PlaygroundTheme.mobileColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCupertinoSection() {
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
              Icon(
                Icons.apple,
                color: context.textPrimaryColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'For Cupertino Apps',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Text(
            'Use SmartCupertinoApp for iOS-style apps with Cupertino widgets:',
            style: TextStyle(
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          CodePreview(
            code: '''SmartCupertinoApp(
  theme: CupertinoThemeData(
    primaryColor: CupertinoColors.activeBlue,
  ),
  home: const HomeScreen(),
)

// With router
SmartCupertinoApp.router(
  routerConfig: router,
)''',
            title: 'cupertino_example.dart',
          ),
        ],
      ),
    );
  }

  Widget _buildApiReference() {
    final properties = [
      _ApiProperty(
        name: 'breakpoints',
        type: 'SmartBreakpoints',
        defaultValue: 'SmartBreakpoints.defaults',
        description: 'Custom breakpoint thresholds for responsive layouts',
      ),
      _ApiProperty(
        name: 'spacingTokens',
        type: 'SmartSpacingTokens',
        defaultValue: 'SmartSpacingTokens.defaults',
        description: 'Custom spacing token values',
      ),
      _ApiProperty(
        name: 'designSize',
        type: 'Size?',
        defaultValue: 'null',
        description: 'Reference design size for scaling calculations',
      ),
      _ApiProperty(
        name: 'theme',
        type: 'ThemeData?',
        defaultValue: 'null',
        description: 'The default visual properties for this app',
      ),
      _ApiProperty(
        name: 'darkTheme',
        type: 'ThemeData?',
        defaultValue: 'null',
        description: 'The dark theme to use when themeMode is dark',
      ),
      _ApiProperty(
        name: 'themeMode',
        type: 'ThemeMode',
        defaultValue: 'ThemeMode.system',
        description: 'Determines which theme will be used',
      ),
      _ApiProperty(
        name: 'home',
        type: 'Widget?',
        defaultValue: 'null',
        description: 'The widget for the default route of the app',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(PlaygroundTheme.radiusLg),
                topRight: Radius.circular(PlaygroundTheme.radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Property',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...properties.map((prop) => _buildApiRow(prop)),
        ],
      ),
    );
  }

  Widget _buildApiRow(_ApiProperty prop) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              prop.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: 'monospace',
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              prop.type,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
                color: PlaygroundTheme.codeClass,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              prop.description,
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

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
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
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiProperty {
  const _ApiProperty({
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.description,
  });

  final String name;
  final String type;
  final String defaultValue;
  final String description;
}
