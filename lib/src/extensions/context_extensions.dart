/// BuildContext extensions for responsive and adaptive UI.
///
/// This module provides convenient extensions on [BuildContext]
/// for accessing screen information and breakpoints.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/platform_info.dart';
import '../core/smart_ui_config.dart';

/// Extension on [BuildContext] for responsive UI utilities.
///
/// Provides convenient access to screen dimensions, breakpoints,
/// orientation, and platform information.
///
/// Example:
/// ```dart
/// // Breakpoint checks
/// if (context.isMobile) {
///   return MobileLayout();
/// }
///
/// // Screen dimensions
/// final width = context.screenWidth;
/// final height = context.screenHeight;
///
/// // Orientation
/// if (context.isPortrait) {
///   return PortraitLayout();
/// }
/// ```
extension SmartContextExtension on BuildContext {
  // ============ Screen Dimensions ============

  /// The current screen width in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// The current screen height in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// The current screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// The device pixel ratio.
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// The current text scale factor.
  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1);

  /// The text scaler for the current context.
  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  // ============ Orientation ============

  /// Returns `true` if the screen is in portrait orientation.
  bool get isPortrait => screenHeight > screenWidth;

  /// Returns `true` if the screen is in landscape orientation.
  bool get isLandscape => screenWidth > screenHeight;

  /// The current screen orientation.
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// The aspect ratio of the screen (width / height).
  double get aspectRatio => screenWidth / screenHeight;

  // ============ Breakpoints ============

  /// The current breakpoint based on screen width.
  SmartBreakpoint get breakpoint {
    final config = SmartUi.of(this);
    return config.breakpoints.breakpointForWidth(screenWidth);
  }

  /// Returns `true` if the current breakpoint is watch.
  bool get isWatch => breakpoint == SmartBreakpoint.watch;

  /// Returns `true` if the current breakpoint is mobile.
  bool get isMobile => breakpoint == SmartBreakpoint.mobile;

  /// Returns `true` if the current breakpoint is tablet.
  bool get isTablet => breakpoint == SmartBreakpoint.tablet;

  /// Returns `true` if the current breakpoint is desktop.
  bool get isDesktop => breakpoint == SmartBreakpoint.desktop;

  /// Returns `true` if the current breakpoint is TV.
  bool get isTv => breakpoint == SmartBreakpoint.tv;

  /// Returns `true` if the current breakpoint is mobile or smaller.
  bool get isMobileOrSmaller =>
      breakpoint == SmartBreakpoint.watch ||
      breakpoint == SmartBreakpoint.mobile;

  /// Returns `true` if the current breakpoint is tablet or larger.
  bool get isTabletOrLarger =>
      breakpoint == SmartBreakpoint.tablet ||
      breakpoint == SmartBreakpoint.desktop ||
      breakpoint == SmartBreakpoint.tv;

  /// Returns `true` if the current breakpoint is desktop or larger.
  bool get isDesktopOrLarger =>
      breakpoint == SmartBreakpoint.desktop || breakpoint == SmartBreakpoint.tv;

  // ============ Platform ============

  /// The current platform.
  SmartPlatform get platform => SmartPlatformInfo.current;

  /// Returns `true` if running on Android.
  bool get isAndroid => SmartPlatformInfo.isAndroid;

  /// Returns `true` if running on iOS.
  bool get isIOS => SmartPlatformInfo.isIOS;

  /// Returns `true` if running on macOS.
  bool get isMacOS => SmartPlatformInfo.isMacOS;

  /// Returns `true` if running on Windows.
  bool get isWindows => SmartPlatformInfo.isWindows;

  /// Returns `true` if running on Linux.
  bool get isLinux => SmartPlatformInfo.isLinux;

  /// Returns `true` if running on the web.
  bool get isWeb => SmartPlatformInfo.isWeb;

  /// Returns `true` if running on a mobile platform (Android or iOS).
  bool get isMobilePlatform => SmartPlatformInfo.isMobile;

  /// Returns `true` if running on a desktop platform.
  bool get isDesktopPlatform => SmartPlatformInfo.isDesktop;

  /// Returns `true` if running on an Apple platform (iOS or macOS).
  bool get isApplePlatform => SmartPlatformInfo.isApple;

  /// Returns `true` if the platform uses Material design.
  bool get usesMaterial => SmartPlatformInfo.usesMaterial;

  /// Returns `true` if the platform uses Cupertino design.
  bool get usesCupertino => SmartPlatformInfo.usesCupertino;

  // ============ Safe Areas ============

  /// The safe area padding (notches, system UI).
  EdgeInsets get safeAreaPadding => MediaQuery.paddingOf(this);

  /// The safe area view padding.
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// The view insets (keyboard, etc.).
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Returns `true` if the keyboard is visible.
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  /// Returns the top safe area padding.
  double get safeAreaTop => MediaQuery.paddingOf(this).top;

  /// Returns the bottom safe area padding.
  double get safeAreaBottom => MediaQuery.paddingOf(this).bottom;

  /// Returns the left safe area padding.
  double get safeAreaLeft => MediaQuery.paddingOf(this).left;

  /// Returns the right safe area padding.
  double get safeAreaRight => MediaQuery.paddingOf(this).right;

  /// Returns the horizontal safe area padding (left + right).
  double get safeAreaHorizontal =>
      MediaQuery.paddingOf(this).left + MediaQuery.paddingOf(this).right;

  /// Returns the vertical safe area padding (top + bottom).
  double get safeAreaVertical =>
      MediaQuery.paddingOf(this).top + MediaQuery.paddingOf(this).bottom;

  /// Returns whether there is any safe area padding.
  bool get hasSafeAreaPadding => MediaQuery.paddingOf(this) != EdgeInsets.zero;

  /// Returns whether there is top safe area padding (notch, status bar).
  bool get hasTopSafeArea => MediaQuery.paddingOf(this).top > 0;

  /// Returns whether there is bottom safe area padding (home indicator).
  bool get hasBottomSafeArea => MediaQuery.paddingOf(this).bottom > 0;

  // ============ Configuration ============

  /// The smartui configuration.
  SmartUiData get smartUiConfig => SmartUi.of(this);

  /// The breakpoints configuration.
  SmartBreakpoints get breakpoints => SmartUi.of(this).breakpoints;

  // ============ Adaptive Helpers ============

  /// Returns a value based on the platform (Material or Cupertino).
  ///
  /// Use this to select between Material and Cupertino design variants.
  ///
  /// Example:
  /// ```dart
  /// final borderRadius = context.adaptive<double>(
  ///   material: 4.0,
  ///   cupertino: 8.0,
  /// );
  /// ```
  T adaptive<T>({
    required T material,
    required T cupertino,
  }) {
    return SmartPlatformInfo.usesCupertino ? cupertino : material;
  }

  /// Returns a widget based on the platform (Material or Cupertino).
  ///
  /// Example:
  /// ```dart
  /// context.adaptiveWidget(
  ///   material: ElevatedButton(...),
  ///   cupertino: CupertinoButton(...),
  /// )
  /// ```
  Widget adaptiveWidget({
    required Widget material,
    required Widget cupertino,
  }) {
    return SmartPlatformInfo.usesCupertino ? cupertino : material;
  }

  /// Shows a widget only on specified breakpoints.
  ///
  /// Returns the child if the current breakpoint is in [breakpoints],
  /// otherwise returns [SizedBox.shrink] or [replacement].
  ///
  /// Example:
  /// ```dart
  /// context.showOnly(
  ///   breakpoints: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
  ///   child: DesktopSidebar(),
  /// )
  /// ```
  Widget showOnly({
    required List<SmartBreakpoint> breakpoints,
    required Widget child,
    Widget replacement = const SizedBox.shrink(),
  }) {
    final config = SmartUi.of(this);
    final width = MediaQuery.sizeOf(this).width;
    final currentBreakpoint = config.breakpoints.breakpointForWidth(width);

    return breakpoints.contains(currentBreakpoint) ? child : replacement;
  }

  /// Hides a widget on specified breakpoints.
  ///
  /// Returns the child if the current breakpoint is NOT in [breakpoints],
  /// otherwise returns [SizedBox.shrink] or [replacement].
  ///
  /// Example:
  /// ```dart
  /// context.hideOn(
  ///   breakpoints: [SmartBreakpoint.watch, SmartBreakpoint.mobile],
  ///   child: AdvancedOptions(),
  /// )
  /// ```
  Widget hideOn({
    required List<SmartBreakpoint> breakpoints,
    required Widget child,
    Widget replacement = const SizedBox.shrink(),
  }) {
    final config = SmartUi.of(this);
    final width = MediaQuery.sizeOf(this).width;
    final currentBreakpoint = config.breakpoints.breakpointForWidth(width);

    return breakpoints.contains(currentBreakpoint) ? replacement : child;
  }

  /// Returns a responsive value based on the current breakpoint.
  ///
  /// This is the same as the responsive<T> method but with a shorter name.
  ///
  /// Example:
  /// ```dart
  /// final columns = context.bp<int>(
  ///   mobile: 1,
  ///   tablet: 2,
  ///   desktop: 4,
  /// );
  /// ```
  T bp<T>({
    T? watch,
    T? mobile,
    T? tablet,
    T? desktop,
    T? tv,
    T? defaultValue,
  }) {
    final config = SmartUi.of(this);
    final width = MediaQuery.sizeOf(this).width;
    final currentBreakpoint = config.breakpoints.breakpointForWidth(width);

    final resolved = switch (currentBreakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch ?? mobile ?? tablet ?? desktop ?? tv,
    };

    if (resolved != null) {
      return resolved;
    }

    if (defaultValue != null) {
      return defaultValue;
    }

    throw ArgumentError(
      'No value provided for breakpoint ${currentBreakpoint.name} and no default value',
    );
  }

  /// Returns a value for mobile (and smaller) or larger breakpoints.
  ///
  /// A simplified responsive helper for the common case of mobile vs non-mobile.
  ///
  /// Example:
  /// ```dart
  /// final padding = context.mobileOr<double>(
  ///   mobile: 12,
  ///   other: 24,
  /// );
  /// ```
  T mobileOr<T>({
    required T mobile,
    required T other,
  }) {
    return isMobileOrSmaller ? mobile : other;
  }

  /// Returns a value for desktop (and larger) or smaller breakpoints.
  ///
  /// A simplified responsive helper for the common case of desktop vs non-desktop.
  ///
  /// Example:
  /// ```dart
  /// final maxWidth = context.desktopOr<double>(
  ///   desktop: 1200,
  ///   other: double.infinity,
  /// );
  /// ```
  T desktopOr<T>({
    required T desktop,
    required T other,
  }) {
    return isDesktopOrLarger ? desktop : other;
  }
}
