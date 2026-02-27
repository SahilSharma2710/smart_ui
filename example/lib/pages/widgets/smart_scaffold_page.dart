import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/material.dart' as material show Badge;
import 'package:adaptive_kit/adaptive_kit.dart';

import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartScaffold widget
class SmartScaffoldPage extends StatefulWidget {
  const SmartScaffoldPage({super.key});

  @override
  State<SmartScaffoldPage> createState() => _SmartScaffoldPageState();
}

class _SmartScaffoldPageState extends State<SmartScaffoldPage> {
  // Demo state
  int _selectedIndex = 0;
  bool _extended = false;
  bool _showAppBar = true;
  bool _showFab = true;
  bool _showBadges = false;

  // Simulated breakpoint for preview
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
              'SmartScaffold',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'An adaptive scaffold that automatically switches navigation patterns based on screen size: bottom nav on mobile, rail on tablet, and drawer on desktop.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Navigation Patterns Section
            SectionHeader(
              title: 'Adaptive Navigation Patterns',
              subtitle: 'How navigation adapts across breakpoints',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _NavigationPatternsDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Configure scaffold properties and preview different breakpoints',
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
                        label: 'Show App Bar',
                        value: _showAppBar,
                        onChanged: (value) => setState(() => _showAppBar = value),
                      ),
                      SwitchControl(
                        label: 'Show FAB',
                        value: _showFab,
                        onChanged: (value) => setState(() => _showFab = value),
                      ),
                      SwitchControl(
                        label: 'Extended Rail/Drawer',
                        value: _extended,
                        description: 'Show labels on tablet',
                        onChanged: (value) => setState(() => _extended = value),
                      ),
                      SwitchControl(
                        label: 'Show Badges',
                        value: _showBadges,
                        description: 'Display notification badges',
                        onChanged: (value) => setState(() => _showBadges = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _ScaffoldPreview(
                    breakpoint: _previewBreakpoint,
                    selectedIndex: _selectedIndex,
                    onIndexChanged: (index) =>
                        setState(() => _selectedIndex = index),
                    showAppBar: _showAppBar,
                    showFab: _showFab,
                    extended: _extended,
                    showBadges: _showBadges,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getScaffoldCode(),
              title: 'smart_scaffold_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartDestination Section
            SectionHeader(
              title: 'SmartDestination',
              subtitle: 'Define navigation items with icons, labels, and badges',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _DestinationDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Customization Section
            SectionHeader(
              title: 'Customization Options',
              subtitle: 'Add headers, footers, and custom widgets',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _CustomizationDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartAppScaffold Section
            SectionHeader(
              title: 'SmartAppScaffold',
              subtitle: 'A simpler scaffold without navigation patterns',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _AppScaffoldDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference Section
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartScaffold parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getScaffoldCode() {
    String code = '''SmartScaffold(
  selectedIndex: $_selectedIndex,
  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
  destinations: [
    SmartDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',${_showBadges ? "\n      badge: Text('3')," : ''}
    ),
    SmartDestination(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search),
      label: 'Search',
    ),
    SmartDestination(
      icon: Icon(Icons.notifications_outlined),
      selectedIcon: Icon(Icons.notifications),
      label: 'Notifications',${_showBadges ? "\n      badge: Text('9+')," : ''}
    ),
    SmartDestination(
      icon: Icon(Icons.person_outlined),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ],
  body: _pages[_selectedIndex],''';

    if (_showAppBar) {
      code += '''
  appBar: AppBar(
    title: Text('My App'),
  ),''';
    }

    if (_showFab) {
      code += '''
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),''';
    }

    if (_extended) {
      code += '\n  extended: true,';
    }

    code += '\n)';
    return code;
  }
}

class _NavigationPatternsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 4,
          child: _PatternCard(
            title: 'Mobile',
            subtitle: 'Bottom Navigation',
            icon: Icons.phone_android,
            color: PlaygroundTheme.mobileColor,
            description: 'BottomNavigationBar with up to 5 destinations',
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 4,
          child: _PatternCard(
            title: 'Tablet',
            subtitle: 'Navigation Rail',
            icon: Icons.tablet_android,
            color: PlaygroundTheme.tabletColor,
            description: 'Compact rail on the left, can be extended to show labels',
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 4,
          child: _PatternCard(
            title: 'Desktop',
            subtitle: 'Navigation Drawer',
            icon: Icons.desktop_windows,
            color: PlaygroundTheme.desktopColor,
            description: 'Full drawer with header and footer support',
          ),
        ),
      ],
    );
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.description,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String description;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaffoldPreview extends StatelessWidget {
  const _ScaffoldPreview({
    required this.breakpoint,
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.showAppBar,
    required this.showFab,
    required this.extended,
    required this.showBadges,
  });

  final String breakpoint;
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;
  final bool showAppBar;
  final bool showFab;
  final bool extended;
  final bool showBadges;

  @override
  Widget build(BuildContext context) {
    final destinations = [
      _DestinationData('Home', Icons.home_outlined, Icons.home, showBadges ? '3' : null),
      _DestinationData('Search', Icons.search_outlined, Icons.search, null),
      _DestinationData('Notifications', Icons.notifications_outlined, Icons.notifications, showBadges ? '9+' : null),
      _DestinationData('Profile', Icons.person_outlined, Icons.person, null),
    ];

    return Container(
      height: 450,
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
            // Scaffold preview
            Expanded(
              child: _buildScaffoldPreview(context, destinations),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScaffoldPreview(BuildContext context, List<_DestinationData> destinations) {
    final body = Container(
      color: context.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              destinations[selectedIndex].selectedIcon,
              size: 48,
              color: PlaygroundTheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              destinations[selectedIndex].label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Page Content',
              style: TextStyle(
                fontSize: 14,
                color: context.textMutedColor,
              ),
            ),
          ],
        ),
      ),
    );

    final appBar = showAppBar
        ? AppBar(
            title: const Text('My App'),
            backgroundColor: context.surfaceColor,
            elevation: 0,
          )
        : null;

    final fab = showFab
        ? FloatingActionButton(
            onPressed: () {},
            mini: breakpoint == 'mobile',
            child: const Icon(Icons.add),
          )
        : null;

    switch (breakpoint) {
      case 'mobile':
        return Scaffold(
          appBar: appBar,
          body: body,
          floatingActionButton: fab,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onIndexChanged,
            height: 65,
            destinations: destinations.map((d) {
              final icon = d.badge != null
                  ? material.Badge(label: Text(d.badge!), child: Icon(d.icon))
                  : Icon(d.icon);
              return NavigationDestination(
                icon: icon,
                selectedIcon: d.badge != null
                    ? material.Badge(label: Text(d.badge!), child: Icon(d.selectedIcon))
                    : Icon(d.selectedIcon),
                label: d.label,
              );
            }).toList(),
          ),
        );
      case 'tablet':
        return Scaffold(
          appBar: appBar,
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: onIndexChanged,
                extended: extended,
                destinations: destinations.map((d) {
                  final icon = d.badge != null
                      ? material.Badge(label: Text(d.badge!), child: Icon(d.icon))
                      : Icon(d.icon);
                  return NavigationRailDestination(
                    icon: icon,
                    selectedIcon: d.badge != null
                        ? material.Badge(label: Text(d.badge!), child: Icon(d.selectedIcon))
                        : Icon(d.selectedIcon),
                    label: Text(d.label),
                  );
                }).toList(),
              ),
              VerticalDivider(thickness: 1, width: 1, color: context.borderColor),
              Expanded(child: body),
            ],
          ),
          floatingActionButton: fab,
        );
      default: // desktop
        return Scaffold(
          appBar: appBar,
          body: Row(
            children: [
              NavigationDrawer(
                selectedIndex: selectedIndex,
                onDestinationSelected: onIndexChanged,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                    child: Text(
                      'Navigation',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ...destinations.map((d) {
                    final icon = d.badge != null
                        ? material.Badge(label: Text(d.badge!), child: Icon(d.icon))
                        : Icon(d.icon);
                    return NavigationDrawerDestination(
                      icon: icon,
                      selectedIcon: d.badge != null
                          ? material.Badge(label: Text(d.badge!), child: Icon(d.selectedIcon))
                          : Icon(d.selectedIcon),
                      label: Text(d.label),
                    );
                  }),
                ],
              ),
              VerticalDivider(thickness: 1, width: 1, color: context.borderColor),
              Expanded(child: body),
            ],
          ),
          floatingActionButton: fab,
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

class _DestinationData {
  const _DestinationData(this.label, this.icon, this.selectedIcon, this.badge);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String? badge;
}

class _DestinationDemo extends StatelessWidget {
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
                'SmartDestination Properties',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              _DestinationProperty(
                name: 'icon',
                type: 'Widget',
                description: 'The default icon widget',
              ),
              _DestinationProperty(
                name: 'selectedIcon',
                type: 'Widget?',
                description: 'Icon shown when selected',
              ),
              _DestinationProperty(
                name: 'label',
                type: 'String',
                description: 'The text label for the destination',
              ),
              _DestinationProperty(
                name: 'badge',
                type: 'Widget?',
                description: 'Badge widget to show on the icon',
              ),
              _DestinationProperty(
                name: 'tooltip',
                type: 'String?',
                description: 'Tooltip text for accessibility',
                isLast: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Basic destination
SmartDestination(
  icon: Icon(Icons.home_outlined),
  label: 'Home',
)

// With selected icon
SmartDestination(
  icon: Icon(Icons.search_outlined),
  selectedIcon: Icon(Icons.search),
  label: 'Search',
)

// With badge
SmartDestination(
  icon: Icon(Icons.notifications_outlined),
  selectedIcon: Icon(Icons.notifications),
  label: 'Notifications',
  badge: Text('5'),
)''',
          title: 'smart_destination_examples.dart',
        ),
      ],
    );
  }
}

class _DestinationProperty extends StatelessWidget {
  const _DestinationProperty({
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
            width: 80,
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

class _CustomizationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CodePreview(
      code: '''SmartScaffold(
  selectedIndex: _currentIndex,
  onDestinationSelected: (index) => setState(() => _currentIndex = index),
  destinations: destinations,
  body: pages[_currentIndex],

  // App bar
  appBar: AppBar(
    title: Text('My App'),
    actions: [
      IconButton(icon: Icon(Icons.settings), onPressed: () {}),
    ],
  ),

  // Floating action button
  floatingActionButton: FloatingActionButton.extended(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Create'),
  ),

  // Drawer header (desktop only)
  drawerHeader: UserAccountsDrawerHeader(
    accountName: Text('John Doe'),
    accountEmail: Text('john@example.com'),
    currentAccountPicture: CircleAvatar(
      child: Text('JD'),
    ),
  ),

  // Drawer footer
  drawerFooter: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Version 1.0.0'),
  ),

  // Rail leading/trailing (tablet only)
  railLeading: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  railTrailing: IconButton(
    icon: Icon(Icons.logout),
    onPressed: () {},
  ),

  // Colors
  backgroundColor: Colors.grey[100],
  navigationBackgroundColor: Colors.white,

  // Extended labels on rail
  extended: true,
)''',
      title: 'smart_scaffold_customization.dart',
    );
  }
}

class _AppScaffoldDemo extends StatelessWidget {
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
                'SmartAppScaffold',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A simpler scaffold without navigation pattern switching. Use this when you only need basic scaffold functionality without adaptive navigation.',
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
          code: '''SmartAppScaffold(
  title: Text('Page Title'),
  body: MyPageContent(),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {},
    ),
  ],
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: [...],
  ),
)''',
          title: 'smart_app_scaffold_example.dart',
        ),
      ],
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
            param: 'destinations',
            type: 'List<SmartDestination>',
            description: 'The navigation destinations',
          ),
          _ApiRow(
            param: 'body',
            type: 'Widget',
            description: 'The main content body',
          ),
          _ApiRow(
            param: 'selectedIndex',
            type: 'int',
            description: 'Currently selected destination index',
          ),
          _ApiRow(
            param: 'onDestinationSelected',
            type: 'ValueChanged<int>?',
            description: 'Called when a destination is selected',
          ),
          _ApiRow(
            param: 'appBar',
            type: 'PreferredSizeWidget?',
            description: 'The app bar to display',
          ),
          _ApiRow(
            param: 'floatingActionButton',
            type: 'Widget?',
            description: 'A floating action button',
          ),
          _ApiRow(
            param: 'drawerHeader',
            type: 'Widget?',
            description: 'Header widget for the navigation drawer',
          ),
          _ApiRow(
            param: 'drawerFooter',
            type: 'Widget?',
            description: 'Footer widget for the navigation drawer',
          ),
          _ApiRow(
            param: 'railLeading',
            type: 'Widget?',
            description: 'Leading widget for the navigation rail',
          ),
          _ApiRow(
            param: 'railTrailing',
            type: 'Widget?',
            description: 'Trailing widget for the navigation rail',
          ),
          _ApiRow(
            param: 'extended',
            type: 'bool',
            description: 'Whether to show labels on rail/drawer',
          ),
          _ApiRow(
            param: 'backgroundColor',
            type: 'Color?',
            description: 'Background color of the scaffold',
          ),
          _ApiRow(
            param: 'navigationBackgroundColor',
            type: 'Color?',
            description: 'Background color of navigation',
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
            width: 180,
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
