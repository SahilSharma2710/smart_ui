import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

import 'pages/home_page.dart';
import 'pages/breakpoints_demo_page.dart';
import 'pages/layout_demo_page.dart';
import 'pages/grid_demo_page.dart';
import 'pages/widgets_demo_page.dart';
import 'pages/tokens_demo_page.dart';
import 'pages/visibility_demo_page.dart';
import 'pages/extensions_demo_page.dart';

void main() {
  runApp(const AdaptiveKitDemoApp());
}

class AdaptiveKitDemoApp extends StatefulWidget {
  const AdaptiveKitDemoApp({super.key});

  @override
  State<AdaptiveKitDemoApp> createState() => _AdaptiveKitDemoAppState();
}

class _AdaptiveKitDemoAppState extends State<AdaptiveKitDemoApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : _themeMode == ThemeMode.dark
              ? ThemeMode.system
              : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartUi(
      child: MaterialApp(
        title: 'adaptive_kit Playground',
        debugShowCheckedModeBanner: false,
        themeMode: _themeMode,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: MainNavigation(
          themeMode: _themeMode,
          onToggleTheme: _toggleTheme,
        ),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const BreakpointsDemoPage(),
      const LayoutDemoPage(),
      const GridDemoPage(),
      const WidgetsDemoPage(),
      const TokensDemoPage(),
      const VisibilityDemoPage(),
      const ExtensionsDemoPage(),
    ];

    return SmartScaffold(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      destinations: const [
        SmartDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        SmartDestination(
          icon: Icon(Icons.screen_rotation_outlined),
          selectedIcon: Icon(Icons.screen_rotation),
          label: 'Breakpoints',
        ),
        SmartDestination(
          icon: Icon(Icons.view_quilt_outlined),
          selectedIcon: Icon(Icons.view_quilt),
          label: 'Layout',
        ),
        SmartDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view),
          label: 'Grid',
        ),
        SmartDestination(
          icon: Icon(Icons.widgets_outlined),
          selectedIcon: Icon(Icons.widgets),
          label: 'Widgets',
        ),
        SmartDestination(
          icon: Icon(Icons.palette_outlined),
          selectedIcon: Icon(Icons.palette),
          label: 'Tokens',
        ),
        SmartDestination(
          icon: Icon(Icons.visibility_outlined),
          selectedIcon: Icon(Icons.visibility),
          label: 'Visibility',
        ),
        SmartDestination(
          icon: Icon(Icons.extension_outlined),
          selectedIcon: Icon(Icons.extension),
          label: 'Extensions',
        ),
      ],
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: SmartRadius.sm,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 18,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const HGap.sm(),
            const Text('adaptive_kit'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.light
                  ? Icons.light_mode
                  : widget.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.brightness_auto,
            ),
            tooltip: 'Toggle theme',
            onPressed: widget.onToggleTheme,
          ),
          const HGap.sm(),
        ],
      ),
      drawerHeader: Padding(
        padding: const EdgeInsets.all(SmartSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: SmartRadius.md,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const VGap.md(),
            const SmartText(
              'adaptive_kit',
              style: TypographyStyle.titleLarge,
            ),
            const SmartText(
              'Interactive Playground',
              style: TypographyStyle.bodySmall,
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
