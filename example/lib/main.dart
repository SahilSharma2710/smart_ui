import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/premium_theme.dart';
import 'widgets/premium_widgets.dart';
import 'pages/home_page.dart';
import 'pages/breakpoints_demo_page.dart';
import 'pages/layout_demo_page.dart';
import 'pages/grid_demo_page.dart';
import 'pages/widgets_demo_page.dart';
import 'pages/tokens_demo_page.dart';
import 'pages/visibility_demo_page.dart';
import 'pages/extensions_demo_page.dart';

/// Global ValueNotifier for navigation index
final selectedNavIndex = ValueNotifier<int>(0);

void main() {
  runApp(const AdaptiveKitDemoApp());
}

class AdaptiveKitDemoApp extends StatelessWidget {
  const AdaptiveKitDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SmartUi(
      child: MaterialApp(
        title: 'adaptive_kit',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: createPremiumLightTheme(),
        darkTheme: createPremiumTheme(),
        home: const MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedNavIndex.addListener(_onGlobalNavChange);
  }

  @override
  void dispose() {
    selectedNavIndex.removeListener(_onGlobalNavChange);
    super.dispose();
  }

  void _onGlobalNavChange() {
    if (selectedNavIndex.value != _selectedIndex) {
      setState(() => _selectedIndex = selectedNavIndex.value);
    }
  }

  static const _navItems = [
    _NavItem(Icons.home_rounded, Icons.home_outlined, 'Home'),
    _NavItem(Icons.devices_rounded, Icons.devices_outlined, 'Breakpoints'),
    _NavItem(Icons.view_quilt_rounded, Icons.view_quilt_outlined, 'Layout'),
    _NavItem(Icons.grid_view_rounded, Icons.grid_view_outlined, 'Grid'),
    _NavItem(Icons.widgets_rounded, Icons.widgets_outlined, 'Widgets'),
    _NavItem(Icons.palette_rounded, Icons.palette_outlined, 'Tokens'),
    _NavItem(Icons.visibility_rounded, Icons.visibility_outlined, 'Visibility'),
    _NavItem(Icons.extension_rounded, Icons.extension_outlined, 'Extensions'),
  ];

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
      destinations: _navItems
          .map((item) => SmartDestination(
                icon: GradientIcon(
                  item.outlinedIcon,
                  size: 24,
                ),
                selectedIcon: GradientIcon(
                  item.filledIcon,
                  size: 24,
                ),
                label: item.label,
              ))
          .toList(),
      appBar: AppBar(
        backgroundColor: PremiumColors.surface,
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: PremiumGradients.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: PremiumColors.gradientStart.withAlpha(77),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
            const HGap.md(),
            const GradientText(
              'adaptive_kit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          PremiumChip(
            label: 'v1.1.3',
            color: PremiumColors.gold,
            icon: Icons.verified_rounded,
          ),
          const HGap.sm(),
          const BreakpointIndicator(),
          const HGap.sm(),
          const PlatformBadge(),
          const HGap.md(),
        ],
      ),
      drawerHeader: _buildDrawerHeader(context),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_selectedIndex],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SmartSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PremiumColors.gradientStart.withAlpha(51),
            PremiumColors.gradientMiddle.withAlpha(26),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: PremiumGradients.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: PremiumColors.gradientStart.withAlpha(102),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 32,
              color: Colors.white,
            ),
          ),
          const VGap.lg(),
          const GradientText(
            'adaptive_kit',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const VGap.xs(),
          Text(
            'Build responsive Flutter apps',
            style: PremiumTypography.bodySmall,
          ),
          const VGap.lg(),
          Row(
            children: [
              _DrawerLink(
                icon: Icons.public_rounded,
                label: 'pub.dev',
                onTap: () => _launchUrl('https://pub.dev/packages/adaptive_kit'),
              ),
              const HGap.md(),
              _DrawerLink(
                icon: Icons.code_rounded,
                label: 'GitHub',
                onTap: () => _launchUrl('https://github.com/SahilSharma2710/smart_ui'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _NavItem {
  const _NavItem(this.filledIcon, this.outlinedIcon, this.label);
  final IconData filledIcon;
  final IconData outlinedIcon;
  final String label;
}

class _DrawerLink extends StatelessWidget {
  const _DrawerLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SmartSpacing.sm,
          vertical: SmartSpacing.xs,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: PremiumColors.cardBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: PremiumColors.textSecondary),
            const HGap.xs(),
            Text(
              label,
              style: PremiumTypography.labelSmall.copyWith(
                color: PremiumColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
