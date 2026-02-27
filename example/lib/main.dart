import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/playground_theme.dart';
import 'components/components.dart';
import 'pages/home_page.dart';
import 'pages/get_started_page.dart';
import 'pages/core/smart_app_page.dart';
import 'pages/core/breakpoints_page.dart';
import 'pages/core/platform_page.dart';
import 'pages/layout/smart_layout_page.dart';
import 'pages/layout/smart_grid_page.dart';
import 'pages/layout/smart_form_page.dart';
import 'pages/layout/smart_wrap_page.dart';
import 'pages/layout/smart_sliver_page.dart';
import 'pages/widgets/smart_button_page.dart';
import 'pages/widgets/smart_switch_page.dart';
import 'pages/widgets/smart_dialog_page.dart';
import 'pages/widgets/smart_scaffold_page.dart';
import 'pages/widgets/smart_navigation_page.dart';
import 'pages/widgets/smart_indicator_page.dart';
import 'pages/widgets/smart_image_page.dart';
import 'pages/widgets/smart_safe_area_page.dart';
import 'pages/tokens/typography_page.dart';
import 'pages/tokens/spacing_page.dart';
import 'pages/tokens/radius_page.dart';
import 'pages/tokens/smart_theme_page.dart';
import 'pages/utilities/visibility_page.dart';
import 'pages/utilities/extensions_page.dart';
import 'pages/utilities/smart_container_page.dart';
import 'pages/utilities/smart_padding_page.dart';
import 'pages/utilities/smart_gap_page.dart';
import 'pages/utilities/smart_text_page.dart';

void main() {
  runApp(const PlaygroundApp());
}

class PlaygroundApp extends StatefulWidget {
  const PlaygroundApp({super.key});

  @override
  State<PlaygroundApp> createState() => _PlaygroundAppState();
}

class _PlaygroundAppState extends State<PlaygroundApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartApp(
      title: 'adaptive_kit Playground',
      debugShowCheckedModeBanner: false,
      theme: PlaygroundTheme.lightTheme(),
      darkTheme: PlaygroundTheme.darkTheme(),
      themeMode: _themeMode,
      home: PlaygroundShell(
        onThemeToggle: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

/// Navigation item model
class NavItem {
  const NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
    required this.route,
    this.category,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;
  final String route;
  final String? category;
}

/// Main app shell with navigation
class PlaygroundShell extends StatefulWidget {
  const PlaygroundShell({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  @override
  State<PlaygroundShell> createState() => _PlaygroundShellState();
}

class _PlaygroundShellState extends State<PlaygroundShell> {
  int _selectedIndex = 0;
  bool _sidebarExpanded = true;

  static final List<NavItem> _navItems = [
    // Home
    NavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: const HomePage(),
      route: '/',
    ),
    NavItem(
      label: 'Get Started',
      icon: Icons.rocket_launch_outlined,
      selectedIcon: Icons.rocket_launch,
      page: const GetStartedPage(),
      route: '/get-started',
    ),

    // Core
    NavItem(
      label: 'SmartApp',
      icon: Icons.apps_outlined,
      selectedIcon: Icons.apps,
      page: const SmartAppPage(),
      route: '/smart-app',
      category: 'Core',
    ),
    NavItem(
      label: 'Breakpoints',
      icon: Icons.devices_outlined,
      selectedIcon: Icons.devices,
      page: const BreakpointsPage(),
      route: '/breakpoints',
      category: 'Core',
    ),
    NavItem(
      label: 'Platform',
      icon: Icons.phone_android_outlined,
      selectedIcon: Icons.phone_android,
      page: const PlatformPage(),
      route: '/platform',
      category: 'Core',
    ),

    // Layout
    NavItem(
      label: 'SmartLayout',
      icon: Icons.view_quilt_outlined,
      selectedIcon: Icons.view_quilt,
      page: const SmartLayoutPage(),
      route: '/smart-layout',
      category: 'Layout',
    ),
    NavItem(
      label: 'SmartGrid',
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view,
      page: const SmartGridPage(),
      route: '/smart-grid',
      category: 'Layout',
    ),
    NavItem(
      label: 'SmartForm',
      icon: Icons.dynamic_form_outlined,
      selectedIcon: Icons.dynamic_form,
      page: const SmartFormPage(),
      route: '/smart-form',
      category: 'Layout',
    ),
    NavItem(
      label: 'SmartWrap',
      icon: Icons.wrap_text_outlined,
      selectedIcon: Icons.wrap_text,
      page: const SmartWrapPage(),
      route: '/smart-wrap',
      category: 'Layout',
    ),
    NavItem(
      label: 'SmartSliver',
      icon: Icons.view_list_outlined,
      selectedIcon: Icons.view_list,
      page: const SmartSliverPage(),
      route: '/smart-sliver',
      category: 'Layout',
    ),

    // Widgets
    NavItem(
      label: 'SmartButton',
      icon: Icons.smart_button_outlined,
      selectedIcon: Icons.smart_button,
      page: const SmartButtonPage(),
      route: '/smart-button',
      category: 'Widgets',
    ),
    NavItem(
      label: 'SmartSwitch',
      icon: Icons.toggle_on_outlined,
      selectedIcon: Icons.toggle_on,
      page: const SmartSwitchPage(),
      route: '/smart-switch',
      category: 'Widgets',
    ),
    NavItem(
      label: 'SmartDialog',
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
      page: const SmartDialogPage(),
      route: '/smart-dialog',
      category: 'Widgets',
    ),
    NavItem(
      label: 'SmartScaffold',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      page: const SmartScaffoldPage(),
      route: '/smart-scaffold',
      category: 'Widgets',
    ),
    NavItem(
      label: 'SmartNavigation',
      icon: Icons.navigation_outlined,
      selectedIcon: Icons.navigation,
      page: const SmartNavigationPage(),
      route: '/smart-navigation',
      category: 'Widgets',
    ),
    NavItem(
      label: 'SmartIndicator',
      icon: Icons.hourglass_empty_outlined,
      selectedIcon: Icons.hourglass_full,
      page: const SmartIndicatorPage(),
      route: '/smart-indicator',
      category: 'Widgets',
    ),
    NavItem(
      label: 'SmartImage',
      icon: Icons.image_outlined,
      selectedIcon: Icons.image,
      page: const SmartImagePage(),
      route: '/smart-image',
      category: 'Widgets',
    ),
    NavItem(
      label: 'SmartSafeArea',
      icon: Icons.crop_free_outlined,
      selectedIcon: Icons.crop_free,
      page: const SmartSafeAreaPage(),
      route: '/smart-safe-area',
      category: 'Widgets',
    ),

    // Tokens
    NavItem(
      label: 'Typography',
      icon: Icons.text_fields_outlined,
      selectedIcon: Icons.text_fields,
      page: const TypographyPage(),
      route: '/typography',
      category: 'Tokens',
    ),
    NavItem(
      label: 'Spacing',
      icon: Icons.space_bar_outlined,
      selectedIcon: Icons.space_bar,
      page: const SpacingPage(),
      route: '/spacing',
      category: 'Tokens',
    ),
    NavItem(
      label: 'Radius',
      icon: Icons.rounded_corner_outlined,
      selectedIcon: Icons.rounded_corner,
      page: const RadiusPage(),
      route: '/radius',
      category: 'Tokens',
    ),
    NavItem(
      label: 'SmartTheme',
      icon: Icons.palette_outlined,
      selectedIcon: Icons.palette,
      page: const SmartThemePage(),
      route: '/smart-theme',
      category: 'Tokens',
    ),

    // Utilities
    NavItem(
      label: 'Visibility',
      icon: Icons.visibility_outlined,
      selectedIcon: Icons.visibility,
      page: const VisibilityPage(),
      route: '/visibility',
      category: 'Utilities',
    ),
    NavItem(
      label: 'Extensions',
      icon: Icons.extension_outlined,
      selectedIcon: Icons.extension,
      page: const ExtensionsPage(),
      route: '/extensions',
      category: 'Utilities',
    ),
    NavItem(
      label: 'SmartContainer',
      icon: Icons.check_box_outline_blank,
      selectedIcon: Icons.check_box_outline_blank,
      page: const SmartContainerPage(),
      route: '/smart-container',
      category: 'Utilities',
    ),
    NavItem(
      label: 'SmartPadding',
      icon: Icons.padding_outlined,
      selectedIcon: Icons.padding,
      page: const SmartPaddingPage(),
      route: '/smart-padding',
      category: 'Utilities',
    ),
    NavItem(
      label: 'SmartGap',
      icon: Icons.height_outlined,
      selectedIcon: Icons.height,
      page: const SmartGapPage(),
      route: '/smart-gap',
      category: 'Utilities',
    ),
    NavItem(
      label: 'SmartText',
      icon: Icons.short_text_outlined,
      selectedIcon: Icons.short_text,
      page: const SmartTextPage(),
      route: '/smart-text',
      category: 'Utilities',
    ),
  ];

  List<SearchItem> get _searchItems => _navItems.map((item) {
        return SearchItem(
          title: item.label,
          route: item.route,
          category: item.category,
          icon: item.icon,
          description: _getDescription(item.label),
        );
      }).toList();

  String _getDescription(String label) {
    switch (label) {
      case 'Home':
        return 'Interactive breakpoint visualizer and overview';
      case 'Get Started':
        return 'Installation and quick setup guide';
      case 'SmartApp':
        return 'App wrapper with responsive configuration';
      case 'Breakpoints':
        return 'Responsive breakpoint system (watch, mobile, tablet, desktop, tv)';
      case 'Platform':
        return 'Platform detection (iOS, Android, Web, etc.)';
      case 'SmartLayout':
        return 'Breakpoint-based widget switching with transitions';
      case 'SmartGrid':
        return '12-column responsive grid system';
      case 'SmartForm':
        return 'Responsive form layouts';
      case 'SmartWrap':
        return 'Responsive wrap layout';
      case 'SmartSliver':
        return 'Responsive sliver support';
      case 'SmartButton':
        return 'Adaptive Material/Cupertino button';
      case 'SmartSwitch':
        return 'Adaptive switch toggle';
      case 'SmartDialog':
        return 'Adaptive dialog';
      case 'SmartScaffold':
        return 'Adaptive navigation scaffold';
      case 'SmartNavigation':
        return 'Adaptive navigation utilities';
      case 'SmartIndicator':
        return 'Adaptive progress indicator';
      case 'SmartImage':
        return 'Responsive image widget';
      case 'SmartSafeArea':
        return 'Safe area handling';
      case 'Typography':
        return 'Typography scale and text styles';
      case 'Spacing':
        return 'Spacing tokens (xs, sm, md, lg, xl, xxl)';
      case 'Radius':
        return 'Border radius tokens';
      case 'SmartTheme':
        return 'Breakpoint-aware theme configuration';
      case 'Visibility':
        return 'Show/hide widgets based on breakpoints';
      case 'Extensions':
        return 'BuildContext extensions for responsive design';
      case 'SmartContainer':
        return 'Responsive max-width container';
      case 'SmartPadding':
        return 'Token-based padding widget';
      case 'SmartGap':
        return 'Spacer widget with token support';
      case 'SmartText':
        return 'Typography token-based text widget';
      default:
        return '';
    }
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openSearch() {
    SearchDialog.show(
      context,
      items: _searchItems,
      onItemSelected: (item) {
        final index = _navItems.indexWhere((n) => n.route == item.route);
        if (index != -1) {
          _onItemSelected(index);
        }
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SearchShortcutListener(
      onSearchRequested: _openSearch,
      child: SmartLayout(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _navItems[_selectedIndex].page,
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildCompactSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _navItems[_selectedIndex].page),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildExpandedSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _navItems[_selectedIndex].page),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              gradient: PlaygroundTheme.primaryGradient,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.widgets,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          const Text('adaptive_kit'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _openSearch,
          tooltip: 'Search (⌘K)',
        ),
        IconButton(
          icon: Icon(
            widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: widget.onThemeToggle,
          tooltip: 'Toggle theme',
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: PlaygroundTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.widgets,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'adaptive_kit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      Text(
                        'Playground',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: context.borderColor.withValues(alpha: 0.3)),
            // Navigation items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: PlaygroundTheme.spaceSm,
                ),
                children: _buildNavItems(expanded: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactSidebar() {
    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          right: BorderSide(
            color: context.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: PlaygroundTheme.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.widgets,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Divider(
            color: context.borderColor.withValues(alpha: 0.3),
            indent: 12,
            endIndent: 12,
          ),
          // Navigation items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: PlaygroundTheme.spaceSm,
              ),
              children: _buildNavItems(expanded: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedSidebar() {
    return AnimatedContainer(
      duration: PlaygroundTheme.durationNormal,
      width: _sidebarExpanded ? 260 : 72,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          right: BorderSide(
            color: context.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _sidebarExpanded ? PlaygroundTheme.spaceMd : 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: PlaygroundTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.widgets,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                if (_sidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'adaptive_kit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        Text(
                          'v2.0.1',
                          style: TextStyle(
                            fontSize: 11,
                            color: context.textMutedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _sidebarExpanded
                          ? Icons.chevron_left
                          : Icons.chevron_right,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _sidebarExpanded = !_sidebarExpanded;
                      });
                    },
                    tooltip: _sidebarExpanded ? 'Collapse' : 'Expand',
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Divider(
            color: context.borderColor.withValues(alpha: 0.3),
            indent: _sidebarExpanded ? PlaygroundTheme.spaceMd : 12,
            endIndent: _sidebarExpanded ? PlaygroundTheme.spaceMd : 12,
          ),
          // Navigation items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: PlaygroundTheme.spaceSm,
              ),
              children: _buildNavItems(expanded: _sidebarExpanded),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems({required bool expanded}) {
    final items = <Widget>[];
    String? currentCategory;

    for (var i = 0; i < _navItems.length; i++) {
      final item = _navItems[i];

      // Add category header
      if (item.category != null && item.category != currentCategory) {
        currentCategory = item.category;
        items.add(
          _NavCategoryHeader(
            label: currentCategory!,
            expanded: expanded,
          ),
        );
      }

      items.add(
        _NavItem(
          icon: item.icon,
          selectedIcon: item.selectedIcon,
          label: item.label,
          isSelected: _selectedIndex == i,
          expanded: expanded,
          onTap: () {
            _onItemSelected(i);
            if (context.isMobile) {
              Navigator.of(context).pop();
            }
          },
        ),
      );
    }

    return items;
  }

  Widget _buildTopBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          bottom: BorderSide(
            color: context.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          // Breadcrumb
          Text(
            _navItems[_selectedIndex].category ?? '',
            style: TextStyle(
              fontSize: 13,
              color: context.textMutedColor,
            ),
          ),
          if (_navItems[_selectedIndex].category != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.chevron_right,
                size: 16,
                color: context.textMutedColor,
              ),
            ),
          ],
          Text(
            _navItems[_selectedIndex].label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const Spacer(),
          // Search button
          _SearchButton(onTap: _openSearch),
          const SizedBox(width: 8),
          // Theme toggle
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              size: 20,
            ),
            onPressed: widget.onThemeToggle,
            tooltip: 'Toggle theme',
          ),
          const SizedBox(width: 8),
          // GitHub link
          _GitHubButton(onTap: () => _launchUrl('https://github.com/SahilSharma2710/smart_ui')),
        ],
      ),
    );
  }
}

class _NavCategoryHeader extends StatelessWidget {
  const _NavCategoryHeader({
    required this.label,
    required this.expanded,
  });

  final String label;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    if (!expanded) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: PlaygroundTheme.spaceSm,
        ),
        child: Divider(
          color: context.borderColor.withValues(alpha: 0.3),
          indent: 12,
          endIndent: 12,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: PlaygroundTheme.spaceMd,
        right: PlaygroundTheme.spaceMd,
        top: PlaygroundTheme.spaceMd,
        bottom: PlaygroundTheme.spaceSm,
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: context.textMutedColor,
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.expanded,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final bool expanded;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.expanded ? PlaygroundTheme.spaceSm : 12,
        vertical: 2,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: PlaygroundTheme.durationFast,
            padding: EdgeInsets.symmetric(
              horizontal: widget.expanded ? 12 : 0,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? PlaygroundTheme.primary.withValues(alpha: 0.1)
                  : _isHovered
                      ? context.surfaceElevatedColor
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
              border: Border.all(
                color: widget.isSelected
                    ? PlaygroundTheme.primary.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
            ),
            child: widget.expanded
                ? Row(
                    children: [
                      Icon(
                        widget.isSelected ? widget.selectedIcon : widget.icon,
                        size: 20,
                        color: widget.isSelected
                            ? PlaygroundTheme.primary
                            : _isHovered
                                ? context.textPrimaryColor
                                : context.textSecondaryColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: widget.isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: widget.isSelected
                                ? PlaygroundTheme.primary
                                : _isHovered
                                    ? context.textPrimaryColor
                                    : context.textSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : Tooltip(
                    message: widget.label,
                    child: Center(
                      child: Icon(
                        widget.isSelected ? widget.selectedIcon : widget.icon,
                        size: 22,
                        color: widget.isSelected
                            ? PlaygroundTheme.primary
                            : _isHovered
                                ? context.textPrimaryColor
                                : context.textSecondaryColor,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _SearchButton extends StatefulWidget {
  const _SearchButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<_SearchButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PlaygroundTheme.durationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? context.surfaceElevatedColor
                : context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            border: Border.all(
              color: context.borderColor.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                size: 16,
                color: context.textMutedColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Search...',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textMutedColor,
                ),
              ),
              const SizedBox(width: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: context.surfaceElevatedColor,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                  border: Border.all(
                    color: context.borderColor.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  '⌘K',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: context.textMutedColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GitHubButton extends StatefulWidget {
  const _GitHubButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_GitHubButton> createState() => _GitHubButtonState();
}

class _GitHubButtonState extends State<_GitHubButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PlaygroundTheme.durationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? context.surfaceElevatedColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code,
                size: 18,
                color: context.textSecondaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                'GitHub',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
