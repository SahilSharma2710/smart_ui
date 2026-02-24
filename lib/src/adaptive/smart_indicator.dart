/// Adaptive progress indicator widget.
///
/// This module provides progress indicator widgets that automatically adapt
/// to the current platform (Material on Android, Cupertino on iOS).
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/platform_info.dart';

/// An adaptive circular progress indicator.
///
/// On Android and other platforms, displays a [CircularProgressIndicator].
/// On iOS and macOS, displays a [CupertinoActivityIndicator].
///
/// Example:
/// ```dart
/// // Indeterminate progress
/// SmartIndicator()
///
/// // Determinate progress (0.0 to 1.0)
/// SmartIndicator(value: 0.5)
/// ```
class SmartIndicator extends StatelessWidget {
  /// Creates an adaptive progress indicator.
  const SmartIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.radius,
  });

  /// The progress value (0.0 to 1.0) for determinate progress.
  ///
  /// If null, shows an indeterminate progress indicator.
  final double? value;

  /// The color of the progress indicator.
  final Color? color;

  /// The background color of the progress track.
  final Color? backgroundColor;

  /// The width of the progress stroke (Material only).
  final double? strokeWidth;

  /// The radius of the indicator (Cupertino only).
  final double? radius;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      // CupertinoActivityIndicator doesn't support determinate progress
      return CupertinoActivityIndicator(
        radius: radius ?? 10,
        color: color,
      );
    }

    return CircularProgressIndicator(
      value: value,
      color: color,
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth ?? 4,
    );
  }
}

/// An adaptive linear progress indicator.
///
/// On Android and other platforms, displays a [LinearProgressIndicator].
/// On iOS and macOS, displays a custom linear progress bar with iOS styling.
class SmartLinearIndicator extends StatelessWidget {
  /// Creates an adaptive linear progress indicator.
  const SmartLinearIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.minHeight,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.borderRadius,
  });

  /// The progress value (0.0 to 1.0) for determinate progress.
  final double? value;

  /// The color of the progress indicator.
  final Color? color;

  /// The background color of the progress track.
  final Color? backgroundColor;

  /// The minimum height of the indicator.
  final double? minHeight;

  /// The border radius of the indicator.
  final BorderRadius? borderRadius;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      return _CupertinoLinearProgressIndicator(
        value: value,
        color: color ?? CupertinoColors.activeBlue,
        backgroundColor: backgroundColor ?? CupertinoColors.systemGrey5,
        height: minHeight ?? 4,
        borderRadius: borderRadius ?? BorderRadius.circular(2),
      );
    }

    return LinearProgressIndicator(
      value: value,
      color: color,
      backgroundColor: backgroundColor,
      minHeight: minHeight ?? 4,
      borderRadius: borderRadius ?? BorderRadius.circular(2),
    );
  }
}

class _CupertinoLinearProgressIndicator extends StatelessWidget {
  const _CupertinoLinearProgressIndicator({
    this.value,
    required this.color,
    required this.backgroundColor,
    required this.height,
    required this.borderRadius,
  });

  final double? value;
  final Color color;
  final Color backgroundColor;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      // Indeterminate - use animation
      return _IndeterminateLinearIndicator(
        color: color,
        backgroundColor: backgroundColor,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value!.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}

class _IndeterminateLinearIndicator extends StatefulWidget {
  const _IndeterminateLinearIndicator({
    required this.color,
    required this.backgroundColor,
    required this.height,
    required this.borderRadius,
  });

  final Color color;
  final Color backgroundColor;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<_IndeterminateLinearIndicator> createState() =>
      _IndeterminateLinearIndicatorState();
}

class _IndeterminateLinearIndicatorState
    extends State<_IndeterminateLinearIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = _controller.value;
            final width = 0.3;
            final position = value * (1.0 + width) - width;

            return FractionallySizedBox(
              alignment: Alignment(position * 2 - 1, 0),
              widthFactor: width,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: widget.borderRadius,
                ),
              ),
            );
          },
        ),
      );
}

/// A loading overlay with an adaptive progress indicator.
class SmartLoadingOverlay extends StatelessWidget {
  /// Creates a loading overlay.
  const SmartLoadingOverlay({
    super.key,
    this.message,
    this.color,
    this.backgroundColor,
    this.forceMaterial = false,
    this.forceCupertino = false,
  });

  /// Optional message to display below the indicator.
  final String? message;

  /// The color of the progress indicator.
  final Color? color;

  /// The background color of the overlay.
  final Color? backgroundColor;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  @override
  Widget build(BuildContext context) => Container(
        color: backgroundColor ?? Colors.black54,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmartIndicator(
                color: color ?? Colors.white,
                forceMaterial: forceMaterial,
                forceCupertino: forceCupertino,
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      );
}

/// A refresh indicator that adapts to the platform.
class SmartRefreshIndicator extends StatelessWidget {
  /// Creates an adaptive refresh indicator.
  const SmartRefreshIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
    this.color,
    this.backgroundColor,
    this.forceMaterial = false,
    this.forceCupertino = false,
  });

  /// The scrollable child widget.
  final Widget child;

  /// Called when the user pulls to refresh.
  final Future<void> Function() onRefresh;

  /// The color of the refresh indicator.
  final Color? color;

  /// The background color of the refresh indicator.
  final Color? backgroundColor;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      return CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverToBoxAdapter(child: child),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
