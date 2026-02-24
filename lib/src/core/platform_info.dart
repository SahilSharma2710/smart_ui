/// Platform detection utilities.
///
/// This module provides platform detection capabilities for
/// building platform-adaptive Flutter applications.
library;

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Represents the different platforms supported by Flutter.
///
/// Use [SmartPlatformInfo.current] to detect the current platform.
///
/// Example:
/// ```dart
/// if (SmartPlatformInfo.current == SmartPlatform.ios) {
///   // Use Cupertino widgets
/// }
/// ```
enum SmartPlatform {
  /// Android platform.
  android,

  /// iOS platform.
  ios,

  /// macOS platform.
  macos,

  /// Windows platform.
  windows,

  /// Linux platform.
  linux,

  /// Fuchsia platform.
  fuchsia,

  /// Web platform.
  web,

  /// Unknown platform.
  unknown;

  /// Returns `true` if this is a mobile platform (Android or iOS).
  bool get isMobile => this == android || this == ios;

  /// Returns `true` if this is a desktop platform (macOS, Windows, or Linux).
  bool get isDesktop => this == macos || this == windows || this == linux;

  /// Returns `true` if this is an Apple platform (iOS or macOS).
  bool get isApple => this == ios || this == macos;

  /// Returns `true` if this uses Material design by default (Android).
  bool get usesMaterial => this == android;

  /// Returns `true` if this uses Cupertino design by default (iOS/macOS).
  bool get usesCupertino => isApple;
}

/// Provides information about the current platform.
///
/// This class offers static methods for detecting the platform
/// and its characteristics. Uses [defaultTargetPlatform] for
/// cross-platform compatibility including web.
///
/// Example:
/// ```dart
/// // Check current platform
/// if (SmartPlatformInfo.isIOS) {
///   // iOS-specific code
/// }
///
/// // Get the platform enum value
/// final platform = SmartPlatformInfo.current;
/// ```
abstract final class SmartPlatformInfo {
  /// Returns the current [SmartPlatform].
  static SmartPlatform get current {
    if (kIsWeb) return SmartPlatform.web;
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => SmartPlatform.android,
      TargetPlatform.iOS => SmartPlatform.ios,
      TargetPlatform.macOS => SmartPlatform.macos,
      TargetPlatform.windows => SmartPlatform.windows,
      TargetPlatform.linux => SmartPlatform.linux,
      TargetPlatform.fuchsia => SmartPlatform.fuchsia,
    };
  }

  /// Returns `true` if running on Android.
  static bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Returns `true` if running on iOS.
  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Returns `true` if running on macOS.
  static bool get isMacOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  /// Returns `true` if running on Windows.
  static bool get isWindows =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  /// Returns `true` if running on Linux.
  static bool get isLinux =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  /// Returns `true` if running on Fuchsia.
  static bool get isFuchsia =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Returns `true` if running on the web.
  static bool get isWeb => kIsWeb;

  /// Returns `true` if running on a mobile platform (Android or iOS).
  static bool get isMobile => isAndroid || isIOS;

  /// Returns `true` if running on a desktop platform (macOS, Windows, Linux).
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Returns `true` if running on an Apple platform (iOS or macOS).
  static bool get isApple => isIOS || isMacOS;

  /// Returns `true` if the platform uses Material design by default.
  static bool get usesMaterial => isAndroid;

  /// Returns `true` if the platform uses Cupertino design by default.
  static bool get usesCupertino => isApple;
}
