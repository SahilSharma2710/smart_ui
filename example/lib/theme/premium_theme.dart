import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Premium color palette for adaptive_kit dashboard
class PremiumColors {
  PremiumColors._();

  // Base dark theme colors (deep navy/charcoal)
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color surfaceVariant = Color(0xFF21262D);
  static const Color surfaceElevated = Color(0xFF1C2128);

  // Card glass morphism base
  static const Color cardBackground = Color(0xFF1A1F27);
  static const Color cardBorder = Color(0xFF30363D);

  // Primary gradient (indigo → purple → pink)
  static const Color gradientStart = Color(0xFF6366F1);
  static const Color gradientMiddle = Color(0xFF8B5CF6);
  static const Color gradientEnd = Color(0xFFEC4899);

  // Accent colors
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color secondary = Color(0xFF6366F1);

  // Gold/amber highlights
  static const Color gold = Color(0xFFFBBF24);
  static const Color amber = Color(0xFFF59E0B);
  static const Color goldLight = Color(0xFFFDE68A);

  // Text colors
  static const Color textPrimary = Color(0xFFF0F6FC);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted = Color(0xFF6E7681);

  // Status colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Breakpoint colors (updated for premium feel)
  static const Color watchColor = Color(0xFFA855F7);
  static const Color mobileColor = Color(0xFF3B82F6);
  static const Color tabletColor = Color(0xFF10B981);
  static const Color desktopColor = Color(0xFFF59E0B);
  static const Color tvColor = Color(0xFFEF4444);
}

/// Premium gradients
class PremiumGradients {
  PremiumGradients._();

  static const LinearGradient primary = LinearGradient(
    colors: [
      PremiumColors.gradientStart,
      PremiumColors.gradientMiddle,
      PremiumColors.gradientEnd,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryHorizontal = LinearGradient(
    colors: [
      PremiumColors.gradientStart,
      PremiumColors.gradientMiddle,
      PremiumColors.gradientEnd,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient subtle = LinearGradient(
    colors: [
      Color(0xFF1A1F27),
      Color(0xFF0D1117),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardShine = LinearGradient(
    colors: [
      Color(0x15FFFFFF),
      Color(0x05FFFFFF),
      Color(0x00FFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gold = LinearGradient(
    colors: [
      PremiumColors.gold,
      PremiumColors.amber,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient headerGradient = LinearGradient(
    colors: [
      PremiumColors.surface,
      PremiumColors.background.withOpacity(0.95),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Premium text styles using Google Fonts
class PremiumTypography {
  PremiumTypography._();

  static TextStyle get displayLarge => GoogleFonts.plusJakartaSans(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.1,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get displayMedium => GoogleFonts.plusJakartaSans(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.15,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get displaySmall => GoogleFonts.plusJakartaSans(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.2,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get headlineLarge => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        height: 1.25,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
        height: 1.3,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get headlineSmall => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.35,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get titleLarge => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.4,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.5,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.6,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.6,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
        color: PremiumColors.textSecondary,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
        color: PremiumColors.textSecondary,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
        color: PremiumColors.textMuted,
      );

  static TextStyle get code => GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.5,
        color: PremiumColors.textPrimary,
      );

  static TextStyle get codeSmall => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.6,
        color: PremiumColors.textSecondary,
      );
}

/// Premium theme data
ThemeData createPremiumTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: PremiumColors.background,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: PremiumColors.primary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF2D2250),
      onPrimaryContainer: PremiumColors.primaryLight,
      secondary: PremiumColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF1E2A5E),
      onSecondaryContainer: Color(0xFFA5B4FC),
      tertiary: PremiumColors.gold,
      onTertiary: Colors.black,
      tertiaryContainer: Color(0xFF3D2E00),
      onTertiaryContainer: PremiumColors.goldLight,
      error: PremiumColors.error,
      onError: Colors.white,
      surface: PremiumColors.surface,
      onSurface: PremiumColors.textPrimary,
      surfaceContainerHighest: PremiumColors.surfaceVariant,
      onSurfaceVariant: PremiumColors.textSecondary,
      outline: PremiumColors.cardBorder,
      outlineVariant: Color(0xFF21262D),
    ),
    textTheme: TextTheme(
      displayLarge: PremiumTypography.displayLarge,
      displayMedium: PremiumTypography.displayMedium,
      displaySmall: PremiumTypography.displaySmall,
      headlineLarge: PremiumTypography.headlineLarge,
      headlineMedium: PremiumTypography.headlineMedium,
      headlineSmall: PremiumTypography.headlineSmall,
      titleLarge: PremiumTypography.titleLarge,
      titleMedium: PremiumTypography.titleMedium,
      titleSmall: PremiumTypography.titleSmall,
      bodyLarge: PremiumTypography.bodyLarge,
      bodyMedium: PremiumTypography.bodyMedium,
      bodySmall: PremiumTypography.bodySmall,
      labelLarge: PremiumTypography.labelLarge,
      labelMedium: PremiumTypography.labelMedium,
      labelSmall: PremiumTypography.labelSmall,
    ),
    cardTheme: CardTheme(
      color: PremiumColors.cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: PremiumColors.cardBorder,
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: PremiumColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: PremiumTypography.titleLarge,
      iconTheme: const IconThemeData(
        color: PremiumColors.textPrimary,
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: PremiumColors.surface,
      indicatorColor: PremiumColors.primary.withOpacity(0.2),
      selectedIconTheme: const IconThemeData(
        color: PremiumColors.primary,
      ),
      unselectedIconTheme: const IconThemeData(
        color: PremiumColors.textMuted,
      ),
      selectedLabelTextStyle: PremiumTypography.labelMedium.copyWith(
        color: PremiumColors.primary,
      ),
      unselectedLabelTextStyle: PremiumTypography.labelMedium.copyWith(
        color: PremiumColors.textMuted,
      ),
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: PremiumColors.surface,
      indicatorColor: PremiumColors.primary.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return PremiumTypography.labelLarge.copyWith(
            color: PremiumColors.primary,
          );
        }
        return PremiumTypography.labelLarge.copyWith(
          color: PremiumColors.textSecondary,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: PremiumColors.primary);
        }
        return const IconThemeData(color: PremiumColors.textMuted);
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: PremiumColors.surface,
      selectedItemColor: PremiumColors.primary,
      unselectedItemColor: PremiumColors.textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: PremiumTypography.labelSmall.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: PremiumTypography.labelSmall,
    ),
    dividerTheme: const DividerThemeData(
      color: PremiumColors.cardBorder,
      thickness: 1,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: PremiumColors.primary,
      inactiveTrackColor: PremiumColors.surfaceVariant,
      thumbColor: PremiumColors.primary,
      overlayColor: PremiumColors.primary.withOpacity(0.2),
      trackHeight: 4,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return PremiumColors.primary;
        }
        return PremiumColors.textMuted;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return PremiumColors.primary.withOpacity(0.5);
        }
        return PremiumColors.surfaceVariant;
      }),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: PremiumColors.surfaceVariant,
      labelStyle: PremiumTypography.labelMedium,
      side: const BorderSide(color: PremiumColors.cardBorder),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: PremiumColors.surfaceVariant,
      contentTextStyle: PremiumTypography.bodyMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: PremiumColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: PremiumTypography.titleLarge,
      contentTextStyle: PremiumTypography.bodyMedium,
    ),
    iconTheme: const IconThemeData(
      color: PremiumColors.textSecondary,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: PremiumColors.primary,
      linearTrackColor: PremiumColors.surfaceVariant,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: PremiumColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: PremiumColors.cardBorder),
      ),
      textStyle: PremiumTypography.bodySmall.copyWith(
        color: PremiumColors.textPrimary,
      ),
    ),
  );
}

/// Light theme for accessibility (fallback)
ThemeData createPremiumLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: PremiumColors.primary,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      displayLarge:
          PremiumTypography.displayLarge.copyWith(color: Colors.black87),
      displayMedium:
          PremiumTypography.displayMedium.copyWith(color: Colors.black87),
      displaySmall:
          PremiumTypography.displaySmall.copyWith(color: Colors.black87),
      headlineLarge:
          PremiumTypography.headlineLarge.copyWith(color: Colors.black87),
      headlineMedium:
          PremiumTypography.headlineMedium.copyWith(color: Colors.black87),
      headlineSmall:
          PremiumTypography.headlineSmall.copyWith(color: Colors.black87),
      titleLarge: PremiumTypography.titleLarge.copyWith(color: Colors.black87),
      titleMedium:
          PremiumTypography.titleMedium.copyWith(color: Colors.black87),
      titleSmall: PremiumTypography.titleSmall.copyWith(color: Colors.black87),
      bodyLarge: PremiumTypography.bodyLarge.copyWith(color: Colors.black87),
      bodyMedium: PremiumTypography.bodyMedium.copyWith(color: Colors.black87),
      bodySmall: PremiumTypography.bodySmall.copyWith(color: Colors.black54),
      labelLarge: PremiumTypography.labelLarge.copyWith(color: Colors.black87),
      labelMedium:
          PremiumTypography.labelMedium.copyWith(color: Colors.black54),
      labelSmall: PremiumTypography.labelSmall.copyWith(color: Colors.black38),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
    ),
  );
}
