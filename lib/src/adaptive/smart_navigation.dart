/// Adaptive navigation widgets.
///
/// This module provides navigation widgets that automatically adapt
/// based on screen size and platform.
library;

import 'package:flutter/material.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// An adaptive navigation component that switches between patterns.
///
/// Automatically shows the appropriate navigation pattern:
/// - [BottomNavigationBar] on mobile
/// - [NavigationRail] on tablet
/// - [NavigationDrawer] on desktop
///
/// Example:
/// ```dart
/// SmartNavigation(
///   selectedIndex: _currentIndex,
///   onDestinationSelected: (index) => setState(() => _currentIndex = index),
///   items: [
///     SmartNavItem(icon: Icons.home, label: 'Home'),
///     SmartNavItem(icon: Icons.search, label: 'Search'),
///     SmartNavItem(icon: Icons.settings, label: 'Settings'),
///   ],
/// )
/// ```
class SmartNavigation extends StatelessWidget {
  /// Creates an adaptive navigation component.
  const SmartNavigation({
    required this.items,
    super.key,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.backgroundColor,
    this.extended = false,
    this.leading,
    this.trailing,
    this.header,
    this.footer,
  });

  /// The navigation items.
  final List<SmartNavItem> items;

  /// The currently selected item index.
  final int selectedIndex;

  /// Called when a destination is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// The background color of the navigation.
  final Color? backgroundColor;

  /// Whether the rail/drawer should be extended to show labels.
  final bool extended;

  /// Widget to show at the top of the rail.
  final Widget? leading;

  /// Widget to show at the bottom of the rail.
  final Widget? trailing;

  /// Header widget for the drawer.
  final Widget? header;

  /// Footer widget for the drawer.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    return switch (breakpoint) {
      SmartBreakpoint.watch ||
      SmartBreakpoint.mobile =>
        _buildBottomNav(context),
      SmartBreakpoint.tablet => _buildNavigationRail(context),
      SmartBreakpoint.desktop ||
      SmartBreakpoint.tv =>
        _buildNavigationDrawer(context),
    };
  }

  Widget _buildBottomNav(BuildContext context) => NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: backgroundColor,
        destinations: items.map((item) {
          return NavigationDestination(
            icon: item.badge != null
                ? Badge(label: Text(item.badge!), child: Icon(item.icon))
                : Icon(item.icon),
            selectedIcon: item.selectedIcon != null
                ? (item.badge != null
                    ? Badge(
                        label: Text(item.badge!),
                        child: Icon(item.selectedIcon),
                      )
                    : Icon(item.selectedIcon))
                : null,
            label: item.label,
          );
        }).toList(),
      );

  Widget _buildNavigationRail(BuildContext context) => NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: backgroundColor,
        extended: extended,
        leading: leading,
        trailing: trailing != null
            ? Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: trailing,
                ),
              )
            : null,
        destinations: items.map((item) {
          return NavigationRailDestination(
            icon: item.badge != null
                ? Badge(label: Text(item.badge!), child: Icon(item.icon))
                : Icon(item.icon),
            selectedIcon: item.selectedIcon != null
                ? (item.badge != null
                    ? Badge(
                        label: Text(item.badge!),
                        child: Icon(item.selectedIcon),
                      )
                    : Icon(item.selectedIcon))
                : null,
            label: Text(item.label),
          );
        }).toList(),
      );

  Widget _buildNavigationDrawer(BuildContext context) => NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: backgroundColor,
        children: [
          if (header != null) header!,
          ...items.map((item) {
            return NavigationDrawerDestination(
              icon: item.badge != null
                  ? Badge(label: Text(item.badge!), child: Icon(item.icon))
                  : Icon(item.icon),
              selectedIcon: item.selectedIcon != null
                  ? (item.badge != null
                      ? Badge(
                          label: Text(item.badge!),
                          child: Icon(item.selectedIcon),
                        )
                      : Icon(item.selectedIcon))
                  : null,
              label: Text(item.label),
            );
          }),
          if (footer != null) ...[
            const Spacer(),
            footer!,
          ],
        ],
      );
}

/// A navigation item for [SmartNavigation].
class SmartNavItem {
  /// Creates a navigation item.
  const SmartNavItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
  });

  /// The icon data for this item.
  final IconData icon;

  /// The label for this item.
  final String label;

  /// The icon data when this item is selected.
  final IconData? selectedIcon;

  /// Optional badge text to display on the icon.
  final String? badge;
}

/// A tab bar that adapts its appearance based on screen size.
///
/// On smaller screens, tabs may scroll. On larger screens,
/// tabs may be centered or fill the available space.
class SmartTabBar extends StatelessWidget {
  /// Creates an adaptive tab bar.
  const SmartTabBar({
    required this.tabs,
    super.key,
    this.controller,
    this.onTap,
    this.isScrollable,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorWeight = 2.0,
    this.padding,
  });

  /// The tab widgets.
  final List<Widget> tabs;

  /// An optional controller for the tab bar.
  final TabController? controller;

  /// Called when a tab is tapped.
  final ValueChanged<int>? onTap;

  /// Whether the tab bar should be scrollable.
  ///
  /// If null, automatically determined based on screen size.
  final bool? isScrollable;

  /// The color of the selected tab indicator.
  final Color? indicatorColor;

  /// The color of selected tab labels.
  final Color? labelColor;

  /// The color of unselected tab labels.
  final Color? unselectedLabelColor;

  /// The thickness of the indicator.
  final double indicatorWeight;

  /// Padding around the tab bar.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    // Auto-determine scrollable based on breakpoint and tab count
    final effectiveScrollable = isScrollable ??
        (breakpoint <= SmartBreakpoint.mobile || tabs.length > 4);

    return TabBar(
      tabs: tabs,
      controller: controller,
      onTap: onTap,
      isScrollable: effectiveScrollable,
      indicatorColor: indicatorColor,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicatorWeight: indicatorWeight,
      padding: padding,
    );
  }
}

/// A breadcrumb navigation widget.
///
/// Shows the navigation path as a series of clickable links.
class SmartBreadcrumbs extends StatelessWidget {
  /// Creates a breadcrumb navigation.
  const SmartBreadcrumbs({
    required this.items,
    super.key,
    this.separator,
    this.style,
    this.activeStyle,
  });

  /// The breadcrumb items.
  final List<BreadcrumbItem> items;

  /// The separator widget between items.
  ///
  /// Defaults to a right chevron icon.
  final Widget? separator;

  /// The text style for inactive breadcrumbs.
  final TextStyle? style;

  /// The text style for the active (last) breadcrumb.
  final TextStyle? activeStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = style ?? theme.textTheme.bodyMedium;
    final defaultActiveStyle =
        activeStyle ?? defaultStyle?.copyWith(fontWeight: FontWeight.bold);

    final separatorWidget = separator ??
        Icon(
          Icons.chevron_right,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: separatorWidget,
            ),
          _BreadcrumbItemWidget(
            item: items[i],
            isActive: i == items.length - 1,
            style: defaultStyle,
            activeStyle: defaultActiveStyle,
          ),
        ],
      ],
    );
  }
}

class _BreadcrumbItemWidget extends StatelessWidget {
  const _BreadcrumbItemWidget({
    required this.item,
    required this.isActive,
    this.style,
    this.activeStyle,
  });

  final BreadcrumbItem item;
  final bool isActive;
  final TextStyle? style;
  final TextStyle? activeStyle;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = isActive ? activeStyle : style;

    if (isActive || item.onTap == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            Icon(item.icon, size: 16),
            const SizedBox(width: 4),
          ],
          Text(item.label, style: effectiveStyle),
        ],
      );
    }

    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              Icon(item.icon, size: 16),
              const SizedBox(width: 4),
            ],
            Text(
              item.label,
              style: effectiveStyle?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A breadcrumb item.
class BreadcrumbItem {
  /// Creates a breadcrumb item.
  const BreadcrumbItem({
    required this.label,
    this.icon,
    this.onTap,
  });

  /// The label for this breadcrumb.
  final String label;

  /// Optional icon for this breadcrumb.
  final IconData? icon;

  /// Called when this breadcrumb is tapped.
  final VoidCallback? onTap;
}
