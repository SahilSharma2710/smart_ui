import 'package:flutter/material.dart';

/// Design system for the adaptive_kit playground
/// Inspired by Tailwind CSS docs, Material 3 demo, and Storybook.js
class PlaygroundTheme {
  PlaygroundTheme._();

  // Brand Colors
  static const Color primary = Color(0xFF6366F1); // Indigo - brand color
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color accent = Color(0xFF22D3EE); // Cyan for highlights
  static const Color accentLight = Color(0xFF67E8F9);

  // Background & Surface (Dark Mode)
  static const Color backgroundDark = Color(0xFF0F0F0F);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceElevatedDark = Color(0xFF262626);
  static const Color cardDark = Color(0xFF1F1F1F);
  static const Color codeBgDark = Color(0xFF111827);

  // Background & Surface (Light Mode)
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceElevatedLight = Color(0xFFF1F5F9);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color codeBgLight = Color(0xFFF1F5F9);

  // Text Colors (Dark Mode)
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Text Colors (Light Mode)
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Border Colors
  static const Color borderDark = Color(0xFF374151);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Breakpoint Colors (for visualizer)
  static const Color watchColor = Color(0xFFEC4899); // Pink
  static const Color mobileColor = Color(0xFFF97316); // Orange
  static const Color tabletColor = Color(0xFF22C55E); // Green
  static const Color desktopColor = Color(0xFF3B82F6); // Blue
  static const Color tvColor = Color(0xFF8B5CF6); // Purple

  // Code syntax colors
  static const Color codeKeyword = Color(0xFFC678DD);
  static const Color codeString = Color(0xFF98C379);
  static const Color codeComment = Color(0xFF5C6370);
  static const Color codeNumber = Color(0xFFD19A66);
  static const Color codeClass = Color(0xFF61AFEF);
  static const Color codeFunction = Color(0xFF61AFEF);
  static const Color codeProperty = Color(0xFFE06C75);
  static const Color codePunctuation = Color(0xFFABB2BF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
      Color(0xFFA855F7),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glass morphism overlay
  static Color glassOverlayDark = Colors.white.withValues(alpha: 0.05);
  static Color glassOverlayLight = Colors.black.withValues(alpha: 0.03);

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusXxl = 24.0;
  static const double radiusFull = 9999.0;

  // Spacing
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double spaceXxl = 48.0;
  static const double space3xl = 64.0;

  // Shadows
  static List<BoxShadow> cardShadowDark = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> cardShadowLight = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> glowShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.3),
      blurRadius: 20,
      spreadRadius: -5,
    ),
  ];

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Curves
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveSnappy = Curves.easeOutCubic;
  static const Curve curveSmooth = Curves.easeInOutCubic;

  /// Get dark theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: surfaceDark,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: textPrimaryDark,
      ),
      cardTheme: CardTheme(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: BorderSide(color: borderDark.withValues(alpha: 0.5)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimaryDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: textPrimaryDark),
      ),
      dividerTheme: DividerThemeData(
        color: borderDark.withValues(alpha: 0.5),
        thickness: 1,
      ),
      iconTheme: const IconThemeData(color: textSecondaryDark),
      textTheme: _buildTextTheme(isDark: true),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceElevatedDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: borderDark.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimaryDark,
          side: BorderSide(color: borderDark),
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceMd,
            vertical: spaceSm,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceElevatedDark,
        labelStyle: const TextStyle(color: textSecondaryDark),
        side: BorderSide(color: borderDark.withValues(alpha: 0.5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceElevatedDark,
        contentTextStyle: const TextStyle(color: textPrimaryDark),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceDark,
        indicatorColor: primary.withValues(alpha: 0.15),
        selectedIconTheme: const IconThemeData(color: primary),
        unselectedIconTheme: const IconThemeData(color: textSecondaryDark),
        selectedLabelTextStyle: const TextStyle(
          color: primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: const TextStyle(color: textSecondaryDark),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceDark,
        indicatorColor: primary.withValues(alpha: 0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primary);
          }
          return const IconThemeData(color: textSecondaryDark);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(color: textSecondaryDark, fontSize: 12);
        }),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: surfaceDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radiusLg),
            bottomRight: Radius.circular(radiusLg),
          ),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceElevatedDark,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: borderDark.withValues(alpha: 0.5)),
        ),
        textStyle: const TextStyle(color: textPrimaryDark, fontSize: 12),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(borderDark),
        radius: const Radius.circular(radiusFull),
      ),
    );
  }

  /// Get light theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: accent,
        surface: surfaceLight,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: textPrimaryLight,
      ),
      cardTheme: CardTheme(
        color: cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: BorderSide(color: borderLight),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimaryLight,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: textPrimaryLight),
      ),
      dividerTheme: DividerThemeData(
        color: borderLight,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(color: textSecondaryLight),
      textTheme: _buildTextTheme(isDark: false),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceElevatedLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimaryLight,
          side: BorderSide(color: borderLight),
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceMd,
            vertical: spaceSm,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceElevatedLight,
        labelStyle: const TextStyle(color: textSecondaryLight),
        side: BorderSide(color: borderLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimaryLight,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceLight,
        indicatorColor: primary.withValues(alpha: 0.1),
        selectedIconTheme: const IconThemeData(color: primary),
        unselectedIconTheme: const IconThemeData(color: textSecondaryLight),
        selectedLabelTextStyle: const TextStyle(
          color: primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: const TextStyle(color: textSecondaryLight),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceLight,
        indicatorColor: primary.withValues(alpha: 0.1),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primary);
          }
          return const IconThemeData(color: textSecondaryLight);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(color: textSecondaryLight, fontSize: 12);
        }),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: surfaceLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radiusLg),
            bottomRight: Radius.circular(radiusLg),
          ),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: textPrimaryLight,
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(borderLight),
        radius: const Radius.circular(radiusFull),
      ),
    );
  }

  static TextTheme _buildTextTheme({required bool isDark}) {
    final textColor = isDark ? textPrimaryDark : textPrimaryLight;
    final secondaryColor = isDark ? textSecondaryDark : textSecondaryLight;

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0,
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0,
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Get color for a breakpoint
  static Color colorForBreakpoint(String breakpoint) {
    switch (breakpoint.toLowerCase()) {
      case 'watch':
        return watchColor;
      case 'mobile':
        return mobileColor;
      case 'tablet':
        return tabletColor;
      case 'desktop':
        return desktopColor;
      case 'tv':
        return tvColor;
      default:
        return primary;
    }
  }

  /// Get icon for a breakpoint
  static IconData iconForBreakpoint(String breakpoint) {
    switch (breakpoint.toLowerCase()) {
      case 'watch':
        return Icons.watch_outlined;
      case 'mobile':
        return Icons.phone_android_outlined;
      case 'tablet':
        return Icons.tablet_android_outlined;
      case 'desktop':
        return Icons.desktop_windows_outlined;
      case 'tv':
        return Icons.tv_outlined;
      default:
        return Icons.devices_outlined;
    }
  }
}

/// Extension for easier color access based on theme brightness
extension PlaygroundThemeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get backgroundColor => isDarkMode
      ? PlaygroundTheme.backgroundDark
      : PlaygroundTheme.backgroundLight;

  Color get surfaceColor =>
      isDarkMode ? PlaygroundTheme.surfaceDark : PlaygroundTheme.surfaceLight;

  Color get surfaceElevatedColor => isDarkMode
      ? PlaygroundTheme.surfaceElevatedDark
      : PlaygroundTheme.surfaceElevatedLight;

  Color get cardColor =>
      isDarkMode ? PlaygroundTheme.cardDark : PlaygroundTheme.cardLight;

  Color get codeBgColor =>
      isDarkMode ? PlaygroundTheme.codeBgDark : PlaygroundTheme.codeBgLight;

  Color get borderColor =>
      isDarkMode ? PlaygroundTheme.borderDark : PlaygroundTheme.borderLight;

  Color get textPrimaryColor => isDarkMode
      ? PlaygroundTheme.textPrimaryDark
      : PlaygroundTheme.textPrimaryLight;

  Color get textSecondaryColor => isDarkMode
      ? PlaygroundTheme.textSecondaryDark
      : PlaygroundTheme.textSecondaryLight;

  Color get textMutedColor => isDarkMode
      ? PlaygroundTheme.textMutedDark
      : PlaygroundTheme.textMutedLight;

  Color get glassOverlay => isDarkMode
      ? PlaygroundTheme.glassOverlayDark
      : PlaygroundTheme.glassOverlayLight;

  List<BoxShadow> get cardShadow => isDarkMode
      ? PlaygroundTheme.cardShadowDark
      : PlaygroundTheme.cardShadowLight;
}
