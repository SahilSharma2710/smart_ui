/// SmartApp - MaterialApp.builder wrapper with auto SmartUi configuration.
///
/// This module provides a convenient wrapper for MaterialApp that
/// automatically configures SmartUi and breakpoints.
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tokens/spacing.dart';
import 'breakpoints.dart';
import 'smart_ui_config.dart';

/// A wrapper widget that auto-configures [SmartUi] with your [MaterialApp].
///
/// Use [SmartApp] instead of manually wrapping your app with [SmartUi].
/// It automatically injects the [SmartUi] configuration via MaterialApp's builder.
///
/// Example:
/// ```dart
/// SmartApp(
///   title: 'My App',
///   home: HomeScreen(),
/// )
/// ```
///
/// With custom breakpoints:
/// ```dart
/// SmartApp(
///   breakpoints: SmartBreakpoints.custom(
///     mobile: 320,
///     tablet: 768,
///     desktop: 1024,
///   ),
///   title: 'My App',
///   home: HomeScreen(),
/// )
/// ```
class SmartApp extends StatelessWidget {
  /// Creates a [SmartApp] widget.
  const SmartApp({
    super.key,
    this.breakpoints = SmartBreakpoints.defaults,
    this.spacingTokens = SmartSpacingTokens.defaults,
    this.designSize,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.themeAnimationStyle,
  })  : routerDelegate = null,
        routeInformationProvider = null,
        routeInformationParser = null,
        routerConfig = null,
        backButtonDispatcher = null;

  /// Creates a [SmartApp] that uses the [Router] instead of a [Navigator].
  const SmartApp.router({
    super.key,
    this.breakpoints = SmartBreakpoints.defaults,
    this.spacingTokens = SmartSpacingTokens.defaults,
    this.designSize,
    this.scaffoldMessengerKey,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.onNavigationNotification,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.themeAnimationStyle,
  })  : navigatorObservers = const <NavigatorObserver>[],
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = const <String, WidgetBuilder>{},
        initialRoute = null;

  // SmartUi configuration

  /// The breakpoint configuration for responsive layouts.
  ///
  /// Defaults to [SmartBreakpoints.defaults].
  final SmartBreakpoints breakpoints;

  /// The spacing token configuration.
  ///
  /// Defaults to [SmartSpacingTokens.defaults].
  final SmartSpacingTokens spacingTokens;

  /// The reference design size for scaling calculations.
  final Size? designSize;

  // MaterialApp properties

  /// A key to use when building the [Navigator].
  final GlobalKey<NavigatorState>? navigatorKey;

  /// A key to use when building the [ScaffoldMessenger].
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// The widget for the default route of the app.
  final Widget? home;

  /// The application's top-level routing table.
  final Map<String, WidgetBuilder> routes;

  /// The name of the first route to show.
  final String? initialRoute;

  /// Called to generate a route for a given [RouteSettings].
  final RouteFactory? onGenerateRoute;

  /// Called to generate initial routes.
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// Called when [onGenerateRoute] fails to generate a route.
  final RouteFactory? onUnknownRoute;

  /// Called when a navigation notification is received.
  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;

  /// The list of observers for the [Navigator].
  final List<NavigatorObserver> navigatorObservers;

  /// A builder for inserting widgets above the [Navigator].
  final TransitionBuilder? builder;

  /// A one-line description used by the device to identify the app.
  final String title;

  /// Called to generate the title string for the app.
  final GenerateAppTitle? onGenerateTitle;

  /// The primary color to use for the application.
  final Color? color;

  /// The default visual properties for this app.
  final ThemeData? theme;

  /// The dark theme to use when [themeMode] is [ThemeMode.dark].
  final ThemeData? darkTheme;

  /// The high contrast theme to use.
  final ThemeData? highContrastTheme;

  /// The high contrast dark theme to use.
  final ThemeData? highContrastDarkTheme;

  /// Determines which theme will be used by the application.
  final ThemeMode themeMode;

  /// The duration of animated theme changes.
  final Duration themeAnimationDuration;

  /// The curve to apply when animating theme changes.
  final Curve themeAnimationCurve;

  /// The initial locale for this app's [Localizations].
  final Locale? locale;

  /// The delegates for this app's [Localizations].
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// This callback is responsible for choosing the locale.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// This callback is responsible for choosing the locale.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// The list of locales that this app has been localized for.
  final Iterable<Locale> supportedLocales;

  /// Turns on a [GridPaper] overlay.
  final bool debugShowMaterialGrid;

  /// Turns on a performance overlay.
  final bool showPerformanceOverlay;

  /// Turns on checkerboarding of raster cache images.
  final bool checkerboardRasterCacheImages;

  /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
  final bool checkerboardOffscreenLayers;

  /// Turns on an overlay that shows the accessibility information.
  final bool showSemanticsDebugger;

  /// Turns on a "DEBUG" banner.
  final bool debugShowCheckedModeBanner;

  /// The keyboard shortcuts that are used throughout the application.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The actions that are used throughout the application.
  final Map<Type, Action<Intent>>? actions;

  /// The identifier to use for state restoration.
  final String? restorationScopeId;

  /// The default scroll behavior for the application.
  final ScrollBehavior? scrollBehavior;

  /// The animation style to use for theme changes.
  final AnimationStyle? themeAnimationStyle;

  // Router properties

  /// A delegate for route information changes.
  final RouteInformationProvider? routeInformationProvider;

  /// A delegate for parsing route information.
  final RouteInformationParser<Object>? routeInformationParser;

  /// A delegate for routing.
  final RouterDelegate<Object>? routerDelegate;

  /// A configuration for the underlying [Router].
  final RouterConfig<Object>? routerConfig;

  /// A delegate for handling back button presses.
  final BackButtonDispatcher? backButtonDispatcher;

  @override
  Widget build(BuildContext context) {
    Widget smartUiBuilder(BuildContext context, Widget? child) {
      Widget result = SmartUi(
        breakpoints: breakpoints,
        spacingTokens: spacingTokens,
        designSize: designSize,
        child: child ?? const SizedBox.shrink(),
      );

      if (builder != null) {
        result = builder!(context, result);
      }

      return result;
    }

    if (routerConfig != null || routerDelegate != null) {
      return MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        routeInformationProvider: routeInformationProvider,
        routeInformationParser: routeInformationParser,
        routerDelegate: routerDelegate,
        routerConfig: routerConfig,
        backButtonDispatcher: backButtonDispatcher,
        builder: smartUiBuilder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        onNavigationNotification: onNavigationNotification,
        color: color,
        theme: theme,
        darkTheme: darkTheme,
        highContrastTheme: highContrastTheme,
        highContrastDarkTheme: highContrastDarkTheme,
        themeMode: themeMode,
        themeAnimationDuration: themeAnimationDuration,
        themeAnimationCurve: themeAnimationCurve,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        debugShowMaterialGrid: debugShowMaterialGrid,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        scrollBehavior: scrollBehavior,
        themeAnimationStyle: themeAnimationStyle,
      );
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: home,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      onNavigationNotification: onNavigationNotification,
      navigatorObservers: navigatorObservers,
      builder: smartUiBuilder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: theme,
      darkTheme: darkTheme,
      highContrastTheme: highContrastTheme,
      highContrastDarkTheme: highContrastDarkTheme,
      themeMode: themeMode,
      themeAnimationDuration: themeAnimationDuration,
      themeAnimationCurve: themeAnimationCurve,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowMaterialGrid: debugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
      themeAnimationStyle: themeAnimationStyle,
    );
  }
}

/// A wrapper widget that auto-configures [SmartUi] with your [CupertinoApp].
///
/// Use [SmartCupertinoApp] for Cupertino-style apps with SmartUi configuration.
///
/// Example:
/// ```dart
/// SmartCupertinoApp(
///   home: HomeScreen(),
/// )
/// ```
class SmartCupertinoApp extends StatelessWidget {
  /// Creates a [SmartCupertinoApp] widget.
  const SmartCupertinoApp({
    super.key,
    this.breakpoints = SmartBreakpoints.defaults,
    this.spacingTokens = SmartSpacingTokens.defaults,
    this.designSize,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
  })  : routerDelegate = null,
        routeInformationProvider = null,
        routeInformationParser = null,
        routerConfig = null,
        backButtonDispatcher = null;

  /// Creates a [SmartCupertinoApp] that uses the [Router] instead of a [Navigator].
  const SmartCupertinoApp.router({
    super.key,
    this.breakpoints = SmartBreakpoints.defaults,
    this.spacingTokens = SmartSpacingTokens.defaults,
    this.designSize,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.onNavigationNotification,
    this.color,
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
  })  : navigatorObservers = const <NavigatorObserver>[],
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = const <String, WidgetBuilder>{},
        initialRoute = null;

  // SmartUi configuration

  /// The breakpoint configuration.
  final SmartBreakpoints breakpoints;

  /// The spacing token configuration.
  final SmartSpacingTokens spacingTokens;

  /// The reference design size.
  final Size? designSize;

  // CupertinoApp properties

  /// A key to use when building the [Navigator].
  final GlobalKey<NavigatorState>? navigatorKey;

  /// The widget for the default route of the app.
  final Widget? home;

  /// The application's top-level routing table.
  final Map<String, WidgetBuilder> routes;

  /// The name of the first route to show.
  final String? initialRoute;

  /// Called to generate a route for a given [RouteSettings].
  final RouteFactory? onGenerateRoute;

  /// Called to generate initial routes.
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// Called when [onGenerateRoute] fails to generate a route.
  final RouteFactory? onUnknownRoute;

  /// Called when a navigation notification is received.
  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;

  /// The list of observers for the [Navigator].
  final List<NavigatorObserver> navigatorObservers;

  /// A builder for inserting widgets above the [Navigator].
  final TransitionBuilder? builder;

  /// A one-line description used by the device to identify the app.
  final String title;

  /// Called to generate the title string for the app.
  final GenerateAppTitle? onGenerateTitle;

  /// The primary color to use for the application.
  final Color? color;

  /// The default visual properties for this app.
  final CupertinoThemeData? theme;

  /// The initial locale for this app's [Localizations].
  final Locale? locale;

  /// The delegates for this app's [Localizations].
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// This callback is responsible for choosing the locale.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// This callback is responsible for choosing the locale.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// The list of locales that this app has been localized for.
  final Iterable<Locale> supportedLocales;

  /// Turns on a performance overlay.
  final bool showPerformanceOverlay;

  /// Turns on checkerboarding of raster cache images.
  final bool checkerboardRasterCacheImages;

  /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
  final bool checkerboardOffscreenLayers;

  /// Turns on an overlay that shows the accessibility information.
  final bool showSemanticsDebugger;

  /// Turns on a "DEBUG" banner.
  final bool debugShowCheckedModeBanner;

  /// The keyboard shortcuts that are used throughout the application.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The actions that are used throughout the application.
  final Map<Type, Action<Intent>>? actions;

  /// The identifier to use for state restoration.
  final String? restorationScopeId;

  /// The default scroll behavior for the application.
  final ScrollBehavior? scrollBehavior;

  // Router properties

  /// A delegate for route information changes.
  final RouteInformationProvider? routeInformationProvider;

  /// A delegate for parsing route information.
  final RouteInformationParser<Object>? routeInformationParser;

  /// A delegate for routing.
  final RouterDelegate<Object>? routerDelegate;

  /// A configuration for the underlying [Router].
  final RouterConfig<Object>? routerConfig;

  /// A delegate for handling back button presses.
  final BackButtonDispatcher? backButtonDispatcher;

  @override
  Widget build(BuildContext context) {
    Widget smartUiBuilder(BuildContext context, Widget? child) {
      Widget result = SmartUi(
        breakpoints: breakpoints,
        spacingTokens: spacingTokens,
        designSize: designSize,
        child: child ?? const SizedBox.shrink(),
      );

      if (builder != null) {
        result = builder!(context, result);
      }

      return result;
    }

    if (routerConfig != null || routerDelegate != null) {
      return CupertinoApp.router(
        routeInformationProvider: routeInformationProvider,
        routeInformationParser: routeInformationParser,
        routerDelegate: routerDelegate,
        routerConfig: routerConfig,
        backButtonDispatcher: backButtonDispatcher,
        builder: smartUiBuilder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        onNavigationNotification: onNavigationNotification,
        color: color,
        theme: theme,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        scrollBehavior: scrollBehavior,
      );
    }

    return CupertinoApp(
      navigatorKey: navigatorKey,
      home: home,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      onNavigationNotification: onNavigationNotification,
      navigatorObservers: navigatorObservers,
      builder: smartUiBuilder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: theme,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
    );
  }
}
