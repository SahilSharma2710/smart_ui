import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/material.dart' as material show Badge;
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartNavigation widget
class SmartNavigationPage extends StatefulWidget {
  const SmartNavigationPage({super.key});

  @override
  State<SmartNavigationPage> createState() => _SmartNavigationPageState();
}

class _SmartNavigationPageState extends State<SmartNavigationPage> {
  // Demo state
  int _selectedIndex = 0;
  bool _extended = false;
  bool _showBadges = true;

  // Simulated breakpoint
  String _previewBreakpoint = 'desktop';

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
              'SmartNavigation',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'A standalone adaptive navigation component that switches between BottomNavigationBar, NavigationRail, and NavigationDrawer based on screen size.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Configure navigation properties and preview different breakpoints',
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
                        label: 'Preview Breakpoint',
                        value: _previewBreakpoint,
                        options: const ['mobile', 'tablet', 'desktop'],
                        optionLabels: const {
                          'mobile': 'Mobile (Bottom Nav)',
                          'tablet': 'Tablet (Navigation Rail)',
                          'desktop': 'Desktop (Drawer)',
                        },
                        onChanged: (value) =>
                            setState(() => _previewBreakpoint = value),
                      ),
                      SwitchControl(
                        label: 'Extended Mode',
                        value: _extended,
                        description: 'Show labels on rail',
                        onChanged: (value) => setState(() => _extended = value),
                      ),
                      SwitchControl(
                        label: 'Show Badges',
                        value: _showBadges,
                        description: 'Display notification badges',
                        onChanged: (value) =>
                            setState(() => _showBadges = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _NavigationPreview(
                    breakpoint: _previewBreakpoint,
                    selectedIndex: _selectedIndex,
                    onIndexChanged: (index) =>
                        setState(() => _selectedIndex = index),
                    extended: _extended,
                    showBadges: _showBadges,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getNavigationCode(),
              title: 'smart_navigation_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartNavItem Section
            SectionHeader(
              title: 'SmartNavItem',
              subtitle: 'Define navigation items with icons, labels, and badges',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _NavItemDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartTabBar Section
            SectionHeader(
              title: 'SmartTabBar',
              subtitle: 'Adaptive tab bar that adjusts scrollability based on screen size',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _TabBarDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartBreadcrumbs Section
            SectionHeader(
              title: 'SmartBreadcrumbs',
              subtitle: 'Breadcrumb navigation for showing path hierarchy',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _BreadcrumbsDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Comparison Section
            SectionHeader(
              title: 'SmartNavigation vs SmartScaffold',
              subtitle: 'When to use each navigation approach',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ComparisonDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference Section
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartNavigation parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getNavigationCode() {
    String items = '''items: [
    SmartNavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',${_showBadges ? "\n      badge: '3'," : ''}
    ),
    SmartNavItem(
      icon: Icons.search_outlined,
      selectedIcon: Icons.search,
      label: 'Search',
    ),
    SmartNavItem(
      icon: Icons.inbox_outlined,
      selectedIcon: Icons.inbox,
      label: 'Inbox',${_showBadges ? "\n      badge: '12'," : ''}
    ),
    SmartNavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
    ),
  ],''';

    String code = '''SmartNavigation(
  selectedIndex: $_selectedIndex,
  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
  $items''';

    if (_extended) {
      code += '\n  extended: true,';
    }

    code += '\n)';
    return code;
  }
}

class _NavigationPreview extends StatelessWidget {
  const _NavigationPreview({
    required this.breakpoint,
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.extended,
    required this.showBadges,
  });

  final String breakpoint;
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;
  final bool extended;
  final bool showBadges;

  List<SmartNavItem> get _items => [
        SmartNavItem(
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
          label: 'Home',
          badge: showBadges ? '3' : null,
        ),
        const SmartNavItem(
          icon: Icons.search_outlined,
          selectedIcon: Icons.search,
          label: 'Search',
        ),
        SmartNavItem(
          icon: Icons.inbox_outlined,
          selectedIcon: Icons.inbox,
          label: 'Inbox',
          badge: showBadges ? '12' : null,
        ),
        const SmartNavItem(
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings,
          label: 'Settings',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        child: Column(
          children: [
            // Breakpoint indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: _getBreakpointColor().withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_getBreakpointIcon(), size: 16, color: _getBreakpointColor()),
                  const SizedBox(width: 8),
                  Text(
                    'Preview: ${breakpoint.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getBreakpointColor(),
                    ),
                  ),
                ],
              ),
            ),
            // Navigation preview
            Expanded(
              child: _buildNavigationPreview(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationPreview(BuildContext context) {
    final content = Container(
      color: context.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _items[selectedIndex].selectedIcon ?? _items[selectedIndex].icon,
              size: 48,
              color: PlaygroundTheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              _items[selectedIndex].label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );

    switch (breakpoint) {
      case 'mobile':
        return Column(
          children: [
            Expanded(child: content),
            NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onIndexChanged,
              height: 65,
              destinations: _items.map((item) {
                final icon = item.badge != null
                    ? material.Badge(label: Text(item.badge!), child: Icon(item.icon))
                    : Icon(item.icon);
                return NavigationDestination(
                  icon: icon,
                  selectedIcon: item.selectedIcon != null
                      ? (item.badge != null
                          ? material.Badge(label: Text(item.badge!), child: Icon(item.selectedIcon!))
                          : Icon(item.selectedIcon!))
                      : null,
                  label: item.label,
                );
              }).toList(),
            ),
          ],
        );
      case 'tablet':
        return Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onIndexChanged,
              extended: extended,
              destinations: _items.map((item) {
                final icon = item.badge != null
                    ? material.Badge(label: Text(item.badge!), child: Icon(item.icon))
                    : Icon(item.icon);
                return NavigationRailDestination(
                  icon: icon,
                  selectedIcon: item.selectedIcon != null
                      ? (item.badge != null
                          ? material.Badge(label: Text(item.badge!), child: Icon(item.selectedIcon!))
                          : Icon(item.selectedIcon!))
                      : null,
                  label: Text(item.label),
                );
              }).toList(),
            ),
            VerticalDivider(thickness: 1, width: 1, color: context.borderColor),
            Expanded(child: content),
          ],
        );
      default: // desktop
        return Row(
          children: [
            SizedBox(
              width: 200,
              child: NavigationDrawer(
                selectedIndex: selectedIndex,
                onDestinationSelected: onIndexChanged,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ..._items.map((item) {
                    final icon = item.badge != null
                        ? material.Badge(label: Text(item.badge!), child: Icon(item.icon))
                        : Icon(item.icon);
                    return NavigationDrawerDestination(
                      icon: icon,
                      selectedIcon: item.selectedIcon != null
                          ? (item.badge != null
                              ? material.Badge(label: Text(item.badge!), child: Icon(item.selectedIcon!))
                              : Icon(item.selectedIcon!))
                          : null,
                      label: Text(item.label),
                    );
                  }),
                ],
              ),
            ),
            VerticalDivider(thickness: 1, width: 1, color: context.borderColor),
            Expanded(child: content),
          ],
        );
    }
  }

  Color _getBreakpointColor() {
    switch (breakpoint) {
      case 'mobile':
        return PlaygroundTheme.mobileColor;
      case 'tablet':
        return PlaygroundTheme.tabletColor;
      default:
        return PlaygroundTheme.desktopColor;
    }
  }

  IconData _getBreakpointIcon() {
    switch (breakpoint) {
      case 'mobile':
        return Icons.phone_android;
      case 'tablet':
        return Icons.tablet_android;
      default:
        return Icons.desktop_windows;
    }
  }
}

class _NavItemDemo extends StatelessWidget {
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
                'SmartNavItem Properties',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _PropertyRow(
                name: 'icon',
                type: 'IconData',
                description: 'The default icon',
              ),
              _PropertyRow(
                name: 'label',
                type: 'String',
                description: 'The text label',
              ),
              _PropertyRow(
                name: 'selectedIcon',
                type: 'IconData?',
                description: 'Icon shown when selected',
              ),
              _PropertyRow(
                name: 'badge',
                type: 'String?',
                description: 'Badge text to display',
                isLast: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Basic item
SmartNavItem(
  icon: Icons.home_outlined,
  label: 'Home',
)

// With selected icon variation
SmartNavItem(
  icon: Icons.search_outlined,
  selectedIcon: Icons.search,
  label: 'Search',
)

// With badge
SmartNavItem(
  icon: Icons.notifications_outlined,
  selectedIcon: Icons.notifications,
  label: 'Notifications',
  badge: '5',
)''',
          title: 'smart_nav_item_examples.dart',
        ),
      ],
    );
  }
}

class _PropertyRow extends StatelessWidget {
  const _PropertyRow({
    required this.name,
    required this.type,
    required this.description,
    this.isLast = false,
  });

  final String name;
  final String type;
  final String description;
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
                  color: context.borderColor.withValues(alpha: 0.2),
                ),
              ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
          SizedBox(
            width: 90,
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

class _TabBarDemo extends StatefulWidget {
  @override
  State<_TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<_TabBarDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: [
              SmartTabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Features'),
                  Tab(text: 'Pricing'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Support'),
                ],
              ),
              SizedBox(
                height: 150,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _TabContent(title: 'Overview', icon: Icons.info_outline),
                    _TabContent(title: 'Features', icon: Icons.stars_outlined),
                    _TabContent(title: 'Pricing', icon: Icons.attach_money),
                    _TabContent(title: 'Reviews', icon: Icons.rate_review_outlined),
                    _TabContent(title: 'Support', icon: Icons.support_agent_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartTabBar(
  controller: _tabController,
  tabs: [
    Tab(text: 'Overview'),
    Tab(text: 'Features'),
    Tab(text: 'Pricing'),
    Tab(text: 'Reviews'),
    Tab(text: 'Support'),
  ],
  // Auto-scrollable on mobile or when many tabs
  isScrollable: null, // Auto-determined
  indicatorColor: Colors.blue,
  labelColor: Colors.blue,
  unselectedLabelColor: Colors.grey,
)''',
          title: 'smart_tab_bar_example.dart',
        ),
      ],
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: PlaygroundTheme.primary),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _BreadcrumbsDemo extends StatelessWidget {
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
                'Basic Breadcrumbs',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 12),
              SmartBreadcrumbs(
                items: [
                  BreadcrumbItem(
                    label: 'Home',
                    icon: Icons.home,
                    onTap: () {},
                  ),
                  BreadcrumbItem(
                    label: 'Products',
                    onTap: () {},
                  ),
                  BreadcrumbItem(
                    label: 'Electronics',
                    onTap: () {},
                  ),
                  const BreadcrumbItem(
                    label: 'Smartphones',
                  ),
                ],
              ),
              const SizedBox(height: PlaygroundTheme.spaceLg),
              Text(
                'With Custom Separator',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 12),
              SmartBreadcrumbs(
                separator: const Text(' / '),
                items: const [
                  BreadcrumbItem(label: 'Dashboard'),
                  BreadcrumbItem(label: 'Settings'),
                  BreadcrumbItem(label: 'Profile'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartBreadcrumbs(
  items: [
    BreadcrumbItem(
      label: 'Home',
      icon: Icons.home,
      onTap: () => Navigator.pushNamed(context, '/'),
    ),
    BreadcrumbItem(
      label: 'Products',
      onTap: () => Navigator.pushNamed(context, '/products'),
    ),
    BreadcrumbItem(
      label: 'Electronics',
      onTap: () => Navigator.pushNamed(context, '/products/electronics'),
    ),
    // Last item (active) - no onTap
    BreadcrumbItem(
      label: 'Smartphones',
    ),
  ],
  separator: Icon(Icons.chevron_right, size: 16),
  style: TextStyle(color: Colors.grey),
  activeStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
)''',
          title: 'smart_breadcrumbs_example.dart',
        ),
      ],
    );
  }
}

class _ComparisonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ComparisonCard(
            title: 'SmartNavigation',
            icon: Icons.menu,
            color: PlaygroundTheme.primary,
            useCase: 'When you need standalone navigation',
            features: const [
              'Just the navigation component',
              'You handle the scaffold yourself',
              'More flexible layout control',
              'Can be placed anywhere',
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _ComparisonCard(
            title: 'SmartScaffold',
            icon: Icons.dashboard,
            color: PlaygroundTheme.accent,
            useCase: 'When you want a complete page setup',
            features: const [
              'Full scaffold with navigation',
              'Handles layout automatically',
              'Includes app bar and FAB support',
              'One widget for everything',
            ],
          ),
        ),
      ],
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.useCase,
    required this.features,
  });

  final String title;
  final IconData icon;
  final Color color;
  final String useCase;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                ),
                child: Icon(icon, size: 22, color: color),
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
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              useCase,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: PlaygroundTheme.success,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textSecondaryColor,
                        ),
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
            param: 'items',
            type: 'List<SmartNavItem>',
            description: 'The navigation items',
          ),
          _ApiRow(
            param: 'selectedIndex',
            type: 'int',
            description: 'Currently selected item index',
          ),
          _ApiRow(
            param: 'onDestinationSelected',
            type: 'ValueChanged<int>?',
            description: 'Called when an item is selected',
          ),
          _ApiRow(
            param: 'backgroundColor',
            type: 'Color?',
            description: 'Background color of the navigation',
          ),
          _ApiRow(
            param: 'extended',
            type: 'bool',
            description: 'Whether to show labels on rail',
          ),
          _ApiRow(
            param: 'leading',
            type: 'Widget?',
            description: 'Widget at the top of the rail',
          ),
          _ApiRow(
            param: 'trailing',
            type: 'Widget?',
            description: 'Widget at the bottom of the rail',
          ),
          _ApiRow(
            param: 'header',
            type: 'Widget?',
            description: 'Header widget for the drawer',
          ),
          _ApiRow(
            param: 'footer',
            type: 'Widget?',
            description: 'Footer widget for the drawer',
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
            width: 160,
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
