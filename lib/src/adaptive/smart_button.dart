/// Adaptive button widget.
///
/// This module provides a button widget that automatically adapts
/// to the current platform (Material on Android, Cupertino on iOS).
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/platform_info.dart';

/// An adaptive button that uses Material or Cupertino styling.
///
/// On Android and other platforms, displays a [ElevatedButton].
/// On iOS and macOS, displays a [CupertinoButton].
///
/// Example:
/// ```dart
/// SmartButton(
///   onPressed: () => print('Pressed'),
///   child: Text('Save'),
/// )
///
/// SmartButton.filled(
///   onPressed: () => print('Pressed'),
///   child: Text('Submit'),
/// )
/// ```
class SmartButton extends StatelessWidget {
  /// Creates an adaptive button.
  const SmartButton({
    required this.child,
    super.key,
    this.onPressed,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.padding,
    this.color,
    this.disabledColor,
  })  : _filled = false,
        _text = false,
        _outlined = false;

  /// Creates an adaptive filled/primary button.
  const SmartButton.filled({
    required this.child,
    super.key,
    this.onPressed,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.padding,
    this.color,
    this.disabledColor,
  })  : _filled = true,
        _text = false,
        _outlined = false;

  /// Creates an adaptive text button.
  const SmartButton.text({
    required this.child,
    super.key,
    this.onPressed,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.padding,
    this.color,
    this.disabledColor,
  })  : _filled = false,
        _text = true,
        _outlined = false;

  /// Creates an adaptive outlined button.
  const SmartButton.outlined({
    required this.child,
    super.key,
    this.onPressed,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.padding,
    this.color,
    this.disabledColor,
  })  : _filled = false,
        _text = false,
        _outlined = true;

  /// The button's child widget, typically a [Text].
  final Widget child;

  /// Called when the button is pressed.
  final VoidCallback? onPressed;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  /// The padding around the child.
  final EdgeInsetsGeometry? padding;

  /// The button's background color.
  final Color? color;

  /// The button's background color when disabled.
  final Color? disabledColor;

  final bool _filled;
  final bool _text;
  final bool _outlined;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      return _buildCupertinoButton(context);
    }
    return _buildMaterialButton(context);
  }

  Widget _buildMaterialButton(BuildContext context) {
    if (_filled) {
      return FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          padding: padding,
          backgroundColor: color,
          disabledBackgroundColor: disabledColor,
        ),
        child: child,
      );
    }

    if (_text) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: padding,
          foregroundColor: color,
        ),
        child: child,
      );
    }

    if (_outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          foregroundColor: color,
        ),
        child: child,
      );
    }

    // Default elevated button
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: color,
        disabledBackgroundColor: disabledColor,
      ),
      child: child,
    );
  }

  Widget _buildCupertinoButton(BuildContext context) {
    if (_filled) {
      return CupertinoButton.filled(
        onPressed: onPressed,
        padding: padding,
        disabledColor: disabledColor ?? CupertinoColors.quaternarySystemFill,
        child: child,
      );
    }

    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      color: _text || _outlined ? null : color,
      disabledColor: disabledColor ?? CupertinoColors.quaternarySystemFill,
      child: child,
    );
  }
}

/// An adaptive icon button.
///
/// Displays an [IconButton] on Material platforms and a
/// [CupertinoButton] with an icon on Cupertino platforms.
class SmartIconButton extends StatelessWidget {
  /// Creates an adaptive icon button.
  const SmartIconButton({
    required this.icon,
    super.key,
    this.onPressed,
    this.tooltip,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.iconSize,
    this.color,
    this.padding,
  });

  /// The icon to display.
  final Widget icon;

  /// Called when the button is pressed.
  final VoidCallback? onPressed;

  /// The tooltip for the button.
  final String? tooltip;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  /// The size of the icon.
  final double? iconSize;

  /// The color of the icon.
  final Color? color;

  /// The padding around the icon.
  final EdgeInsetsGeometry? padding;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      return CupertinoButton(
        padding: padding ?? EdgeInsets.zero,
        onPressed: onPressed,
        child: IconTheme(
          data: IconThemeData(
            size: iconSize ?? 24,
            color: color,
          ),
          child: icon,
        ),
      );
    }

    return IconButton(
      icon: icon,
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: iconSize,
      color: color,
      padding: padding,
    );
  }
}
