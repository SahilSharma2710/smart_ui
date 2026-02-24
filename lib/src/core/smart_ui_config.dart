/// Global configuration for smartui.
///
/// This module provides the configuration system for customizing
/// breakpoints, tokens, and other smartui settings.
library;

import 'package:flutter/widgets.dart';

import '../tokens/spacing.dart';
import 'breakpoints.dart';

/// Global configuration widget for smartui.
///
/// Wrap your app with [SmartUi] to provide custom configuration
/// for breakpoints, tokens, and other settings.
///
/// Example:
/// ```dart
/// SmartUi(
///   breakpoints: SmartBreakpoints.custom(
///     mobile: 320,
///     tablet: 768,
///     desktop: 1024,
///   ),
///   spacingTokens: SmartSpacingTokens.custom(
///     xs: 2,
///     sm: 4,
///     md: 8,
///     lg: 16,
///     xl: 24,
///     xxl: 32,
///   ),
///   child: MyApp(),
/// )
/// ```
class SmartUi extends InheritedWidget {
  /// Creates a [SmartUi] configuration widget.
  const SmartUi({
    required super.child,
    super.key,
    this.breakpoints = SmartBreakpoints.defaults,
    this.spacingTokens = SmartSpacingTokens.defaults,
    this.designSize,
  });

  /// The breakpoint configuration.
  ///
  /// Defaults to [SmartBreakpoints.defaults].
  final SmartBreakpoints breakpoints;

  /// The spacing token configuration.
  ///
  /// Defaults to [SmartSpacingTokens.defaults].
  final SmartSpacingTokens spacingTokens;

  /// The reference design size for scaling calculations.
  ///
  /// If provided, values using `.sp`, `.w`, `.h` extensions
  /// will be scaled relative to this size.
  final Size? designSize;

  /// Returns the [SmartUiData] from the closest [SmartUi] ancestor.
  ///
  /// If no [SmartUi] ancestor exists, returns default configuration.
  ///
  /// Example:
  /// ```dart
  /// final config = SmartUi.of(context);
  /// final breakpoint = config.breakpoints.breakpointForWidth(width);
  /// ```
  static SmartUiData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<SmartUi>();
    if (widget != null) {
      return SmartUiData(
        breakpoints: widget.breakpoints,
        spacingTokens: widget.spacingTokens,
        designSize: widget.designSize,
      );
    }
    return SmartUiData.defaults;
  }

  /// Returns the [SmartUiData] without establishing a dependency.
  ///
  /// Use this when you need the configuration but don't want to
  /// rebuild when it changes.
  static SmartUiData maybeOf(BuildContext context) {
    final widget = context.getInheritedWidgetOfExactType<SmartUi>();
    if (widget != null) {
      return SmartUiData(
        breakpoints: widget.breakpoints,
        spacingTokens: widget.spacingTokens,
        designSize: widget.designSize,
      );
    }
    return SmartUiData.defaults;
  }

  @override
  bool updateShouldNotify(SmartUi oldWidget) =>
      breakpoints != oldWidget.breakpoints ||
      spacingTokens != oldWidget.spacingTokens ||
      designSize != oldWidget.designSize;
}

/// Data class containing smartui configuration.
///
/// This is returned by [SmartUi.of] and contains all the
/// configuration values from the nearest [SmartUi] ancestor.
@immutable
class SmartUiData {
  /// Creates a [SmartUiData] with the given configuration.
  const SmartUiData({
    required this.breakpoints,
    required this.spacingTokens,
    this.designSize,
  });

  /// Default configuration values.
  static const SmartUiData defaults = SmartUiData(
    breakpoints: SmartBreakpoints.defaults,
    spacingTokens: SmartSpacingTokens.defaults,
  );

  /// The breakpoint configuration.
  final SmartBreakpoints breakpoints;

  /// The spacing token configuration.
  final SmartSpacingTokens spacingTokens;

  /// The reference design size for scaling calculations.
  final Size? designSize;

  /// Returns the current [SmartBreakpoint] for the given [width].
  SmartBreakpoint breakpointForWidth(double width) =>
      breakpoints.breakpointForWidth(width);

  /// Creates a copy of this [SmartUiData] with the given values replaced.
  SmartUiData copyWith({
    SmartBreakpoints? breakpoints,
    SmartSpacingTokens? spacingTokens,
    Size? designSize,
  }) =>
      SmartUiData(
        breakpoints: breakpoints ?? this.breakpoints,
        spacingTokens: spacingTokens ?? this.spacingTokens,
        designSize: designSize ?? this.designSize,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartUiData &&
          runtimeType == other.runtimeType &&
          breakpoints == other.breakpoints &&
          spacingTokens == other.spacingTokens &&
          designSize == other.designSize;

  @override
  int get hashCode => Object.hash(breakpoints, spacingTokens, designSize);
}
