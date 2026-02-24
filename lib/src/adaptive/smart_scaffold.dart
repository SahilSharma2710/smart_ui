/// Adaptive scaffold widget.
///
/// This module provides a scaffold widget that automatically adapts
/// navigation patterns based on screen size.
library;

import 'package:flutter/material.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// A destination for the adaptive scaffold navigation.
///
/// Represents a navigation item with an icon, label, and optional badge.
class SmartDestination {
  /// Creates a navigation destination.
  const SmartDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
    this.tooltip,
  });

  /// The icon to display for this destination.
  final Widget icon;

  /// The label for this destination.
  final String label;

  /// The icon to display when this destination is selected.
  final Widget? selectedIcon;

  /// Optional badge to display on the icon.
  final Widget? badge;

  /// Optional tooltip for this destination.
  final String? tooltip;
}

/// An adaptive scaffold that switches navigation patterns by screen size.
///
/// On mobile, displays a [BottomNavigationBar].
/// On tablet, displays a [NavigationRail].
/// On desktop, displays a full [NavigationDrawer].
///
/// Example:
/// ```dart
/// SmartScaffold(
///   selectedIndex: _currentIndex,
///   onDestinationSelected: (index) => setState(() => _currentIndex = index),
///   destinations: [
///     SmartDestination(icon: Icon(Icons.home), label: 'Home'),
///     SmartDestination(icon: Icon(Icons.search), label: 'Search'),
///     SmartDestination(icon: Icon(Icons.settings), label: 'Settings'),
///   ],
///   body: _pages[_currentIndex],
/// )
/// ```
class SmartScaffold extends StatelessWidget {
  /// Creates an adaptive scaffold.
  const SmartScaffold({
    required this.destinations,
    required this.body,
    super.key,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawerHeader,
    this.drawerFooter,
    this.railLeading,
    this.railTrailing,
    this.extended = false,
    this.backgroundColor,
    this.navigationBackgroundColor,
    this.mobileBreakpoint = SmartBreakpoint.mobile,
    this.tabletBreakpoint = SmartBreakpoint.tablet,
  });

  /// The navigation destinations.
  final List<SmartDestination> destinations;

  /// The main content body.
  final Widget body;

  /// The currently selected destination index.
  final int selectedIndex;

  /// Called when a destination is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// The app bar to display.
  final PreferredSizeWidget? appBar;

  /// A floating action button.
  final Widget? floatingActionButton;

  /// The location of the floating action button.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Header widget for the navigation drawer.
  final Widget? drawerHeader;

  /// Footer widget for the navigation drawer.
  final Widget? drawerFooter;

  /// Leading widget for the navigation rail.
  final Widget? railLeading;

  /// Trailing widget for the navigation rail.
  final Widget? railTrailing;

  /// Whether the navigation rail/drawer should be extended.
  final bool extended;

  /// The background color of the scaffold.
  final Color? backgroundColor;

  /// The background color of the navigation.
  final Color? navigationBackgroundColor;

  /// The breakpoint at which to show bottom navigation.
  final SmartBreakpoint mobileBreakpoint;

  /// The breakpoint at which to switch from rail to drawer.
  final SmartBreakpoint tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    return switch (breakpoint) {
      SmartBreakpoint.watch ||
      SmartBreakpoint.mobile =>
        _buildMobileLayout(context),
      SmartBreakpoint.tablet => _buildTabletLayout(context),
      SmartBreakpoint.desktop ||
      SmartBreakpoint.tv =>
        _buildDesktopLayout(context),
    };
  }

  Widget _buildMobileLayout(BuildContext context) => Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        backgroundColor: backgroundColor,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          backgroundColor: navigationBackgroundColor,
          destinations: destinations.map((d) {
            return NavigationDestination(
              icon: d.badge != null
                  ? Badge(label: d.badge, child: d.icon)
                  : d.icon,
              selectedIcon: d.selectedIcon != null
                  ? (d.badge != null
                      ? Badge(label: d.badge, child: d.selectedIcon!)
                      : d.selectedIcon)
                  : null,
              label: d.label,
              tooltip: d.tooltip,
            );
          }).toList(),
        ),
      );

  Widget _buildTabletLayout(BuildContext context) => Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              backgroundColor: navigationBackgroundColor,
              extended: extended,
              leading: railLeading,
              trailing: railTrailing,
              destinations: destinations.map((d) {
                return NavigationRailDestination(
                  icon: d.badge != null
                      ? Badge(label: d.badge, child: d.icon)
                      : d.icon,
                  selectedIcon: d.selectedIcon != null
                      ? (d.badge != null
                          ? Badge(label: d.badge, child: d.selectedIcon!)
                          : d.selectedIcon)
                      : null,
                  label: Text(d.label),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: body),
          ],
        ),
      );

  Widget _buildDesktopLayout(BuildContext context) => Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: Row(
          children: [
            NavigationDrawer(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              backgroundColor: navigationBackgroundColor,
              children: [
                if (drawerHeader != null) drawerHeader!,
                const Padding(
                  padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                ),
                ...destinations.map((d) {
                  return NavigationDrawerDestination(
                    icon: d.badge != null
                        ? Badge(label: d.badge, child: d.icon)
                        : d.icon,
                    selectedIcon: d.selectedIcon != null
                        ? (d.badge != null
                            ? Badge(label: d.badge, child: d.selectedIcon!)
                            : d.selectedIcon)
                        : null,
                    label: Text(d.label),
                  );
                }),
                if (drawerFooter != null) ...[
                  const Spacer(),
                  drawerFooter!,
                ],
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: body),
          ],
        ),
      );
}

/// A simpler adaptive scaffold without navigation.
///
/// Use this when you only need the adaptive app bar behavior
/// without the navigation pattern switching.
class SmartAppScaffold extends StatelessWidget {
  /// Creates a simple adaptive scaffold.
  const SmartAppScaffold({
    required this.body,
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.centerTitle,
  });

  /// The main content body.
  final Widget body;

  /// The title widget or text for the app bar.
  final Widget? title;

  /// Action widgets for the app bar.
  final List<Widget>? actions;

  /// Leading widget for the app bar.
  final Widget? leading;

  /// A floating action button.
  final Widget? floatingActionButton;

  /// The location of the floating action button.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// A bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// The background color of the scaffold.
  final Color? backgroundColor;

  /// Whether to center the title.
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: title != null || actions != null || leading != null
            ? AppBar(
                title: title,
                actions: actions,
                leading: leading,
                centerTitle: centerTitle,
              )
            : null,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: backgroundColor,
      );
}
