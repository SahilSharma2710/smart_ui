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

  // ============ Configuration ============

  /// The smartui configuration.
  SmartUiData get smartUiConfig => SmartUi.of(this);

  /// The breakpoints configuration.
  SmartBreakpoints get breakpoints => SmartUi.of(this).breakpoints;
}
