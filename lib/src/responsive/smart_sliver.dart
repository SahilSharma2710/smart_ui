/// Responsive sliver widgets.
///
/// This module provides sliver widgets that adapt to breakpoints,
/// including SmartSliverGrid, SliverSmartPadding, and SliverSmartVisible.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/spacing.dart';

/// A responsive sliver grid that adjusts column count based on breakpoints.
///
/// Use [SmartSliverGrid] in a [CustomScrollView] for responsive grid layouts.
///
/// Example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SmartSliverGrid(
///       mobileColumns: 2,
///       tabletColumns: 3,
///       desktopColumns: 4,
///       children: items.map((item) => ItemCard(item)).toList(),
///     ),
///   ],
/// )
/// ```
///
/// With a builder:
/// ```dart
/// SmartSliverGrid.builder(
///   itemCount: items.length,
///   mobileColumns: 2,
///   desktopColumns: 4,
///   itemBuilder: (context, index) => ItemCard(items[index]),
/// )
/// ```
class SmartSliverGrid extends StatelessWidget {
  /// Creates a [SmartSliverGrid] with a list of children.
  const SmartSliverGrid({
    required this.children,
    super.key,
    this.watchColumns = 1,
    this.mobileColumns = 2,
    this.tabletColumns = 3,
    this.desktopColumns = 4,
    this.tvColumns = 5,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
  })  : itemCount = null,
        itemBuilder = null;

  /// Creates a [SmartSliverGrid] with an item builder.
  const SmartSliverGrid.builder({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.watchColumns = 1,
    this.mobileColumns = 2,
    this.tabletColumns = 3,
    this.desktopColumns = 4,
    this.tvColumns = 5,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
  }) : children = null;

  /// The children to display in the grid.
  final List<Widget>? children;

  /// The number of items in the grid (for builder).
  final int? itemCount;

  /// The builder for grid items.
  final IndexedWidgetBuilder? itemBuilder;

  /// Number of columns on watch-sized screens.
  final int watchColumns;

  /// Number of columns on mobile-sized screens.
  final int mobileColumns;

  /// Number of columns on tablet-sized screens.
  final int tabletColumns;

  /// Number of columns on desktop-sized screens.
  final int desktopColumns;

  /// Number of columns on TV-sized screens.
  final int tvColumns;

  /// The spacing along the main axis.
  final double mainAxisSpacing;

  /// The spacing along the cross axis.
  final double crossAxisSpacing;

  /// The ratio of the cross-axis to the main-axis extent.
  final double childAspectRatio;

  /// The extent of each child in the main axis.
  final double? mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final columns = _resolveColumns(breakpoint);

    final delegate = mainAxisExtent != null
        ? SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisExtent: mainAxisExtent,
          )
        : SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          );

    if (children != null) {
      return SliverGrid(
        delegate: SliverChildListDelegate(children!),
        gridDelegate: delegate,
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        itemBuilder!,
        childCount: itemCount,
      ),
      gridDelegate: delegate,
    );
  }

  int _resolveColumns(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.tv => tvColumns,
      SmartBreakpoint.desktop => desktopColumns,
      SmartBreakpoint.tablet => tabletColumns,
      SmartBreakpoint.mobile => mobileColumns,
      SmartBreakpoint.watch => watchColumns,
    };
  }
}

/// A responsive sliver grid with adaptive extent.
///
/// Use [SmartSliverGridExtent] when you want items to have a maximum
/// cross-axis extent that adjusts based on breakpoint.
///
/// Example:
/// ```dart
/// SmartSliverGridExtent(
///   mobileMaxExtent: 150,
///   tabletMaxExtent: 200,
///   desktopMaxExtent: 250,
///   children: items.map((item) => ItemCard(item)).toList(),
/// )
/// ```
class SmartSliverGridExtent extends StatelessWidget {
  /// Creates a [SmartSliverGridExtent] with a list of children.
  const SmartSliverGridExtent({
    required this.children,
    super.key,
    this.watchMaxExtent = 100,
    this.mobileMaxExtent = 150,
    this.tabletMaxExtent = 200,
    this.desktopMaxExtent = 250,
    this.tvMaxExtent = 300,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
  })  : itemCount = null,
        itemBuilder = null;

  /// Creates a [SmartSliverGridExtent] with an item builder.
  const SmartSliverGridExtent.builder({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.watchMaxExtent = 100,
    this.mobileMaxExtent = 150,
    this.tabletMaxExtent = 200,
    this.desktopMaxExtent = 250,
    this.tvMaxExtent = 300,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
  }) : children = null;

  /// The children to display in the grid.
  final List<Widget>? children;

  /// The number of items in the grid (for builder).
  final int? itemCount;

  /// The builder for grid items.
  final IndexedWidgetBuilder? itemBuilder;

  /// Maximum extent on watch-sized screens.
  final double watchMaxExtent;

  /// Maximum extent on mobile-sized screens.
  final double mobileMaxExtent;

  /// Maximum extent on tablet-sized screens.
  final double tabletMaxExtent;

  /// Maximum extent on desktop-sized screens.
  final double desktopMaxExtent;

  /// Maximum extent on TV-sized screens.
  final double tvMaxExtent;

  /// The spacing along the main axis.
  final double mainAxisSpacing;

  /// The spacing along the cross axis.
  final double crossAxisSpacing;

  /// The ratio of the cross-axis to the main-axis extent.
  final double childAspectRatio;

  /// The extent of each child in the main axis.
  final double? mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final maxExtent = _resolveMaxExtent(breakpoint);

    final delegate = mainAxisExtent != null
        ? SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxExtent,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisExtent: mainAxisExtent,
          )
        : SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxExtent,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          );

    if (children != null) {
      return SliverGrid(
        delegate: SliverChildListDelegate(children!),
        gridDelegate: delegate,
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        itemBuilder!,
        childCount: itemCount,
      ),
      gridDelegate: delegate,
    );
  }

  double _resolveMaxExtent(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.tv => tvMaxExtent,
      SmartBreakpoint.desktop => desktopMaxExtent,
      SmartBreakpoint.tablet => tabletMaxExtent,
      SmartBreakpoint.mobile => mobileMaxExtent,
      SmartBreakpoint.watch => watchMaxExtent,
    };
  }
}

/// A sliver that applies responsive padding.
///
/// Use [SliverSmartPadding] to add breakpoint-aware padding to slivers.
///
/// Example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverSmartPadding(
///       mobile: EdgeInsets.all(8),
///       tablet: EdgeInsets.all(16),
///       desktop: EdgeInsets.all(24),
///       sliver: SliverList(...),
///     ),
///   ],
/// )
/// ```
class SliverSmartPadding extends StatelessWidget {
  /// Creates a [SliverSmartPadding] with responsive padding.
  const SliverSmartPadding({
    required this.sliver,
    super.key,
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
  })  : _tokenSize = null,
        _watchToken = null,
        _mobileToken = null,
        _tabletToken = null,
        _desktopToken = null,
        _tvToken = null,
        assert(
          watch != null ||
              mobile != null ||
              tablet != null ||
              desktop != null ||
              tv != null,
          'At least one breakpoint padding must be provided',
        );

  /// Creates a [SliverSmartPadding] with token-based padding.
  const SliverSmartPadding.all(
    SpacingSize size, {
    required this.sliver,
    super.key,
  })  : watch = null,
        mobile = null,
        tablet = null,
        desktop = null,
        tv = null,
        _tokenSize = size,
        _watchToken = null,
        _mobileToken = null,
        _tabletToken = null,
        _desktopToken = null,
        _tvToken = null;

  /// Creates a [SliverSmartPadding] with responsive token sizes.
  const SliverSmartPadding.responsive({
    required this.sliver,
    super.key,
    SpacingSize? watchToken,
    SpacingSize? mobileToken,
    SpacingSize? tabletToken,
    SpacingSize? desktopToken,
    SpacingSize? tvToken,
  })  : watch = null,
        mobile = null,
        tablet = null,
        desktop = null,
        tv = null,
        _watchToken = watchToken,
        _mobileToken = mobileToken,
        _tabletToken = tabletToken,
        _desktopToken = desktopToken,
        _tvToken = tvToken,
        _tokenSize = null,
        assert(
          watchToken != null ||
              mobileToken != null ||
              tabletToken != null ||
              desktopToken != null ||
              tvToken != null,
          'At least one breakpoint token must be provided',
        );

  /// The sliver to pad.
  final Widget sliver;

  /// Padding for watch-sized screens.
  final EdgeInsets? watch;

  /// Padding for mobile-sized screens.
  final EdgeInsets? mobile;

  /// Padding for tablet-sized screens.
  final EdgeInsets? tablet;

  /// Padding for desktop-sized screens.
  final EdgeInsets? desktop;

  /// Padding for TV-sized screens.
  final EdgeInsets? tv;

  // Token-based padding
  final SpacingSize? _tokenSize;
  final SpacingSize? _watchToken;
  final SpacingSize? _mobileToken;
  final SpacingSize? _tabletToken;
  final SpacingSize? _desktopToken;
  final SpacingSize? _tvToken;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final padding = _resolvePadding(context, breakpoint);

    return SliverPadding(
      padding: padding,
      sliver: sliver,
    );
  }

  EdgeInsets _resolvePadding(BuildContext context, SmartBreakpoint breakpoint) {
    // Token-based uniform padding
    final tokenSize = _tokenSize;
    if (tokenSize != null) {
      final config = SmartUi.of(context);
      return EdgeInsets.all(config.spacingTokens.fromSize(tokenSize));
    }

    // Token-based responsive padding
    if (_watchToken != null ||
        _mobileToken != null ||
        _tabletToken != null ||
        _desktopToken != null ||
        _tvToken != null) {
      final config = SmartUi.of(context);
      final token = switch (breakpoint) {
        SmartBreakpoint.tv =>
          _tvToken ?? _desktopToken ?? _tabletToken ?? _mobileToken ?? _watchToken,
        SmartBreakpoint.desktop =>
          _desktopToken ?? _tabletToken ?? _mobileToken ?? _watchToken,
        SmartBreakpoint.tablet => _tabletToken ?? _mobileToken ?? _watchToken,
        SmartBreakpoint.mobile => _mobileToken ?? _watchToken,
        SmartBreakpoint.watch =>
          _watchToken ?? _mobileToken ?? _tabletToken ?? _desktopToken ?? _tvToken,
      };
      return EdgeInsets.all(config.spacingTokens.fromSize(token!));
    }

    // EdgeInsets-based responsive padding
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch ?? mobile ?? tablet ?? desktop ?? tv,
    };

    return resolved ?? EdgeInsets.zero;
  }
}

/// A sliver that conditionally shows its child based on breakpoints.
///
/// Use [SliverSmartVisible] to show or hide slivers on specific breakpoints.
///
/// Example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverSmartVisible(
///       visibleOn: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
///       sliver: SliverToBoxAdapter(child: DesktopBanner()),
///     ),
///     SliverSmartVisible.except(
///       breakpoints: [SmartBreakpoint.watch, SmartBreakpoint.mobile],
///       sliver: SliverGrid(...),
///     ),
///   ],
/// )
/// ```
class SliverSmartVisible extends StatelessWidget {
  /// Creates a [SliverSmartVisible] widget.
  ///
  /// Either [visibleOn] or [hiddenOn] must be provided, but not both.
  const SliverSmartVisible({
    required this.sliver,
    super.key,
    this.visibleOn,
    this.hiddenOn,
    this.replacement,
  }) : assert(
          (visibleOn != null) != (hiddenOn != null),
          'Either visibleOn or hiddenOn must be provided, but not both',
        );

  /// Creates a [SliverSmartVisible] that shows on specific breakpoints.
  const SliverSmartVisible.on({
    required this.sliver,
    required List<SmartBreakpoint> breakpoints,
    super.key,
    this.replacement,
  })  : visibleOn = breakpoints,
        hiddenOn = null;

  /// Creates a [SliverSmartVisible] that hides on specific breakpoints.
  const SliverSmartVisible.except({
    required this.sliver,
    required List<SmartBreakpoint> breakpoints,
    super.key,
    this.replacement,
  })  : hiddenOn = breakpoints,
        visibleOn = null;

  /// The sliver to conditionally show.
  final Widget sliver;

  /// The breakpoints on which to show the sliver.
  final List<SmartBreakpoint>? visibleOn;

  /// The breakpoints on which to hide the sliver.
  final List<SmartBreakpoint>? hiddenOn;

  /// The sliver to show when hidden.
  ///
  /// Defaults to an empty [SliverToBoxAdapter].
  final Widget? replacement;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final isVisible = _isVisibleAt(breakpoint);

    if (isVisible) {
      return sliver;
    }

    return replacement ?? const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  bool _isVisibleAt(SmartBreakpoint breakpoint) {
    if (visibleOn != null) {
      return visibleOn!.contains(breakpoint);
    }
    if (hiddenOn != null) {
      return !hiddenOn!.contains(breakpoint);
    }
    return true;
  }
}

/// A sliver list that builds different items based on breakpoints.
///
/// Use [SliverSmartList] when you need different list layouts per breakpoint.
///
/// Example:
/// ```dart
/// SliverSmartList(
///   itemCount: items.length,
///   mobile: (context, index) => MobileItemTile(items[index]),
///   desktop: (context, index) => DesktopItemCard(items[index]),
/// )
/// ```
class SliverSmartList extends StatelessWidget {
  /// Creates a [SliverSmartList] widget.
  const SliverSmartList({
    required this.itemCount,
    super.key,
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  }) : assert(
          watch != null ||
              mobile != null ||
              tablet != null ||
              desktop != null ||
              tv != null,
          'At least one breakpoint builder must be provided',
        );

  /// The number of items in the list.
  final int itemCount;

  /// Builder for watch-sized screens.
  final IndexedWidgetBuilder? watch;

  /// Builder for mobile-sized screens.
  final IndexedWidgetBuilder? mobile;

  /// Builder for tablet-sized screens.
  final IndexedWidgetBuilder? tablet;

  /// Builder for desktop-sized screens.
  final IndexedWidgetBuilder? desktop;

  /// Builder for TV-sized screens.
  final IndexedWidgetBuilder? tv;

  /// Whether to wrap each child in an [AutomaticKeepAlive].
  final bool addAutomaticKeepAlives;

  /// Whether to wrap each child in a [RepaintBoundary].
  final bool addRepaintBoundaries;

  /// Whether to wrap each child in an [IndexedSemantics].
  final bool addSemanticIndexes;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final builder = _resolveBuilder(breakpoint);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        builder,
        childCount: itemCount,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      ),
    );
  }

  IndexedWidgetBuilder _resolveBuilder(SmartBreakpoint breakpoint) {
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch ?? mobile ?? tablet ?? desktop ?? tv,
    };

    return resolved!;
  }
}
