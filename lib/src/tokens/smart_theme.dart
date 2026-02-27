/// Breakpoint-aware design tokens.
///
/// This module provides a theming system where design tokens
/// (spacing, fontSize, padding) change based on the current breakpoint.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// Breakpoint-aware theme configuration.
///
/// Use [SmartTheme] to define design tokens that automatically
/// change based on the current breakpoint.
///
/// Example:
/// ```dart
/// SmartTheme(
///   mobile: SmartThemeData(
///     baseFontSize: 14,
///     baseSpacing: 8,
///     basePadding: EdgeInsets.all(12),
///     baseRadius: 8,
///   ),
///   tablet: SmartThemeData(
///     baseFontSize: 15,
///     baseSpacing: 12,
///     basePadding: EdgeInsets.all(16),
///     baseRadius: 10,
///   ),
///   desktop: SmartThemeData(
///     baseFontSize: 16,
///     baseSpacing: 16,
///     basePadding: EdgeInsets.all(24),
///     baseRadius: 12,
///   ),
///   child: MyApp(),
/// )
/// ```
///
/// Then access the current theme:
/// ```dart
/// final theme = SmartTheme.of(context);
/// Text('Hello', style: TextStyle(fontSize: theme.baseFontSize));
/// ```
class SmartTheme extends StatelessWidget {
  /// Creates a [SmartTheme] widget.
  ///
  /// At least one of [watch], [mobile], [tablet], [desktop], or [tv]
  /// must be provided.
  const SmartTheme({
    required this.child,
    super.key,
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
  }) : assert(
          watch != null ||
              mobile != null ||
              tablet != null ||
              desktop != null ||
              tv != null,
          'At least one breakpoint theme must be provided',
        );

  /// The child widget tree.
  final Widget child;

  /// Theme for watch-sized screens.
  final SmartThemeData? watch;

  /// Theme for mobile-sized screens.
  final SmartThemeData? mobile;

  /// Theme for tablet-sized screens.
  final SmartThemeData? tablet;

  /// Theme for desktop-sized screens.
  final SmartThemeData? desktop;

  /// Theme for TV-sized screens.
  final SmartThemeData? tv;

  /// Returns the [SmartThemeData] for the current breakpoint.
  ///
  /// If no [SmartTheme] ancestor exists, returns [SmartThemeData.defaults].
  static SmartThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<_SmartThemeScope>();
    if (widget != null) {
      return widget.data;
    }
    return SmartThemeData.defaults;
  }

  /// Returns the [SmartThemeData] without establishing a dependency.
  static SmartThemeData maybeOf(BuildContext context) {
    final widget = context.getInheritedWidgetOfExactType<_SmartThemeScope>();
    if (widget != null) {
      return widget.data;
    }
    return SmartThemeData.defaults;
  }

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final data = _resolveTheme(breakpoint);

    return _SmartThemeScope(
      data: data,
      child: child,
    );
  }

  SmartThemeData _resolveTheme(SmartBreakpoint breakpoint) {
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

/// Inherited widget that provides [SmartThemeData] to descendants.
class _SmartThemeScope extends InheritedWidget {
  const _SmartThemeScope({
    required this.data,
    required super.child,
  });

  final SmartThemeData data;

  @override
  bool updateShouldNotify(_SmartThemeScope oldWidget) => data != oldWidget.data;
}

/// Theme data containing breakpoint-specific design tokens.
///
/// Use [SmartThemeData] to define consistent design tokens that
/// change based on the current breakpoint.
@immutable
class SmartThemeData {
  /// Creates a [SmartThemeData] with the given values.
  const SmartThemeData({
    this.baseFontSize = 16.0,
    this.smallFontSize = 14.0,
    this.largeFontSize = 18.0,
    this.headingFontSize = 24.0,
    this.baseSpacing = 16.0,
    this.smallSpacing = 8.0,
    this.largeSpacing = 24.0,
    this.basePadding = const EdgeInsets.all(16),
    this.smallPadding = const EdgeInsets.all(8),
    this.largePadding = const EdgeInsets.all(24),
    this.baseRadius = 8.0,
    this.smallRadius = 4.0,
    this.largeRadius = 16.0,
    this.containerMaxWidth,
    this.iconSize = 24.0,
    this.buttonHeight = 48.0,
    this.inputHeight = 48.0,
    this.gridColumns = 12,
    this.customTokens = const {},
  });

  /// Default theme values.
  static const SmartThemeData defaults = SmartThemeData();

  /// Creates a mobile-optimized theme.
  static const SmartThemeData mobile = SmartThemeData(
    baseFontSize: 14,
    smallFontSize: 12,
    largeFontSize: 16,
    headingFontSize: 20,
    baseSpacing: 12,
    smallSpacing: 6,
    largeSpacing: 18,
    basePadding: EdgeInsets.all(12),
    smallPadding: EdgeInsets.all(6),
    largePadding: EdgeInsets.all(18),
    baseRadius: 8,
    smallRadius: 4,
    largeRadius: 12,
    iconSize: 20,
    buttonHeight: 44,
    inputHeight: 44,
    gridColumns: 4,
  );

  /// Creates a tablet-optimized theme.
  static const SmartThemeData tablet = SmartThemeData(
    baseFontSize: 15,
    smallFontSize: 13,
    largeFontSize: 17,
    headingFontSize: 22,
    baseSpacing: 14,
    smallSpacing: 7,
    largeSpacing: 21,
    basePadding: EdgeInsets.all(16),
    smallPadding: EdgeInsets.all(8),
    largePadding: EdgeInsets.all(24),
    baseRadius: 10,
    smallRadius: 5,
    largeRadius: 14,
    containerMaxWidth: 768,
    iconSize: 22,
    buttonHeight: 46,
    inputHeight: 46,
    gridColumns: 8,
  );

  /// Creates a desktop-optimized theme.
  static const SmartThemeData desktop = SmartThemeData(
    baseFontSize: 16,
    smallFontSize: 14,
    largeFontSize: 18,
    headingFontSize: 28,
    baseSpacing: 16,
    smallSpacing: 8,
    largeSpacing: 24,
    basePadding: EdgeInsets.all(24),
    smallPadding: EdgeInsets.all(12),
    largePadding: EdgeInsets.all(32),
    baseRadius: 12,
    smallRadius: 6,
    largeRadius: 16,
    containerMaxWidth: 1200,
    iconSize: 24,
    buttonHeight: 48,
    inputHeight: 48,
    gridColumns: 12,
  );

  // Typography
  /// Base font size for body text.
  final double baseFontSize;

  /// Small font size for labels and captions.
  final double smallFontSize;

  /// Large font size for emphasized text.
  final double largeFontSize;

  /// Font size for headings.
  final double headingFontSize;

  // Spacing
  /// Base spacing value.
  final double baseSpacing;

  /// Small spacing value.
  final double smallSpacing;

  /// Large spacing value.
  final double largeSpacing;

  // Padding
  /// Base padding for containers.
  final EdgeInsets basePadding;

  /// Small padding for tight layouts.
  final EdgeInsets smallPadding;

  /// Large padding for spacious layouts.
  final EdgeInsets largePadding;

  // Border radius
  /// Base border radius.
  final double baseRadius;

  /// Small border radius.
  final double smallRadius;

  /// Large border radius.
  final double largeRadius;

  // Layout
  /// Maximum width for content containers.
  final double? containerMaxWidth;

  /// Default icon size.
  final double iconSize;

  /// Default button height.
  final double buttonHeight;

  /// Default input field height.
  final double inputHeight;

  /// Number of grid columns.
  final int gridColumns;

  // Custom tokens
  /// Custom design tokens as a map.
  ///
  /// Use this for project-specific tokens.
  final Map<String, dynamic> customTokens;

  /// Gets a custom token value.
  ///
  /// Example:
  /// ```dart
  /// final cardElevation = theme.token<double>('cardElevation') ?? 4.0;
  /// ```
  T? token<T>(String key) {
    final value = customTokens[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Creates a copy of this [SmartThemeData] with the given values replaced.
  SmartThemeData copyWith({
    double? baseFontSize,
    double? smallFontSize,
    double? largeFontSize,
    double? headingFontSize,
    double? baseSpacing,
    double? smallSpacing,
    double? largeSpacing,
    EdgeInsets? basePadding,
    EdgeInsets? smallPadding,
    EdgeInsets? largePadding,
    double? baseRadius,
    double? smallRadius,
    double? largeRadius,
    double? containerMaxWidth,
    double? iconSize,
    double? buttonHeight,
    double? inputHeight,
    int? gridColumns,
    Map<String, dynamic>? customTokens,
  }) {
    return SmartThemeData(
      baseFontSize: baseFontSize ?? this.baseFontSize,
      smallFontSize: smallFontSize ?? this.smallFontSize,
      largeFontSize: largeFontSize ?? this.largeFontSize,
      headingFontSize: headingFontSize ?? this.headingFontSize,
      baseSpacing: baseSpacing ?? this.baseSpacing,
      smallSpacing: smallSpacing ?? this.smallSpacing,
      largeSpacing: largeSpacing ?? this.largeSpacing,
      basePadding: basePadding ?? this.basePadding,
      smallPadding: smallPadding ?? this.smallPadding,
      largePadding: largePadding ?? this.largePadding,
      baseRadius: baseRadius ?? this.baseRadius,
      smallRadius: smallRadius ?? this.smallRadius,
      largeRadius: largeRadius ?? this.largeRadius,
      containerMaxWidth: containerMaxWidth ?? this.containerMaxWidth,
      iconSize: iconSize ?? this.iconSize,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      inputHeight: inputHeight ?? this.inputHeight,
      gridColumns: gridColumns ?? this.gridColumns,
      customTokens: customTokens ?? this.customTokens,
    );
  }

  /// Linearly interpolates between two [SmartThemeData] objects.
  static SmartThemeData lerp(SmartThemeData a, SmartThemeData b, double t) {
    return SmartThemeData(
      baseFontSize: _lerpDouble(a.baseFontSize, b.baseFontSize, t),
      smallFontSize: _lerpDouble(a.smallFontSize, b.smallFontSize, t),
      largeFontSize: _lerpDouble(a.largeFontSize, b.largeFontSize, t),
      headingFontSize: _lerpDouble(a.headingFontSize, b.headingFontSize, t),
      baseSpacing: _lerpDouble(a.baseSpacing, b.baseSpacing, t),
      smallSpacing: _lerpDouble(a.smallSpacing, b.smallSpacing, t),
      largeSpacing: _lerpDouble(a.largeSpacing, b.largeSpacing, t),
      basePadding: EdgeInsets.lerp(a.basePadding, b.basePadding, t)!,
      smallPadding: EdgeInsets.lerp(a.smallPadding, b.smallPadding, t)!,
      largePadding: EdgeInsets.lerp(a.largePadding, b.largePadding, t)!,
      baseRadius: _lerpDouble(a.baseRadius, b.baseRadius, t),
      smallRadius: _lerpDouble(a.smallRadius, b.smallRadius, t),
      largeRadius: _lerpDouble(a.largeRadius, b.largeRadius, t),
      containerMaxWidth: a.containerMaxWidth != null && b.containerMaxWidth != null
          ? _lerpDouble(a.containerMaxWidth!, b.containerMaxWidth!, t)
          : b.containerMaxWidth,
      iconSize: _lerpDouble(a.iconSize, b.iconSize, t),
      buttonHeight: _lerpDouble(a.buttonHeight, b.buttonHeight, t),
      inputHeight: _lerpDouble(a.inputHeight, b.inputHeight, t),
      gridColumns: t < 0.5 ? a.gridColumns : b.gridColumns,
      customTokens: t < 0.5 ? a.customTokens : b.customTokens,
    );
  }

  static double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartThemeData &&
          runtimeType == other.runtimeType &&
          baseFontSize == other.baseFontSize &&
          smallFontSize == other.smallFontSize &&
          largeFontSize == other.largeFontSize &&
          headingFontSize == other.headingFontSize &&
          baseSpacing == other.baseSpacing &&
          smallSpacing == other.smallSpacing &&
          largeSpacing == other.largeSpacing &&
          basePadding == other.basePadding &&
          smallPadding == other.smallPadding &&
          largePadding == other.largePadding &&
          baseRadius == other.baseRadius &&
          smallRadius == other.smallRadius &&
          largeRadius == other.largeRadius &&
          containerMaxWidth == other.containerMaxWidth &&
          iconSize == other.iconSize &&
          buttonHeight == other.buttonHeight &&
          inputHeight == other.inputHeight &&
          gridColumns == other.gridColumns;

  @override
  int get hashCode => Object.hash(
        baseFontSize,
        smallFontSize,
        largeFontSize,
        headingFontSize,
        baseSpacing,
        smallSpacing,
        largeSpacing,
        basePadding,
        smallPadding,
        largePadding,
        baseRadius,
        smallRadius,
        largeRadius,
        containerMaxWidth,
        iconSize,
        buttonHeight,
        inputHeight,
        gridColumns,
      );

  @override
  String toString() => 'SmartThemeData('
      'baseFontSize: $baseFontSize, '
      'baseSpacing: $baseSpacing, '
      'baseRadius: $baseRadius, '
      'gridColumns: $gridColumns)';
}

/// Extension on [BuildContext] for accessing [SmartThemeData].
extension SmartThemeExtension on BuildContext {
  /// Returns the current [SmartThemeData].
  SmartThemeData get smartTheme => SmartTheme.of(this);
}
