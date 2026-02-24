/// Adaptive switch widget.
///
/// This module provides a switch widget that automatically adapts
/// to the current platform (Material on Android, Cupertino on iOS).
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core/platform_info.dart';

/// An adaptive switch that uses Material or Cupertino styling.
///
/// On Android and other platforms, displays a [Switch].
/// On iOS and macOS, displays a [CupertinoSwitch].
///
/// Example:
/// ```dart
/// SmartSwitch(
///   value: isDarkMode,
///   onChanged: (value) => setState(() => isDarkMode = value),
/// )
/// ```
class SmartSwitch extends StatelessWidget {
  /// Creates an adaptive switch.
  const SmartSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.activeColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.focusColor,
    this.forceMaterial = false,
    this.forceCupertino = false,
    this.dragStartBehavior,
  });

  /// Whether this switch is on or off.
  final bool value;

  /// Called when the user toggles the switch.
  final ValueChanged<bool>? onChanged;

  /// The color when the switch is on.
  final Color? activeColor;

  /// The color of the inactive track.
  final Color? inactiveTrackColor;

  /// The color of the thumb.
  final Color? thumbColor;

  /// The color for focus highlight.
  final Color? focusColor;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  /// Determines the way that drag start behavior is handled.
  final DragStartBehavior? dragStartBehavior;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
        inactiveTrackColor: inactiveTrackColor,
        thumbColor: thumbColor,
        focusColor: focusColor,
        dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      );
    }

    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      inactiveTrackColor: inactiveTrackColor,
      thumbColor:
          thumbColor != null ? WidgetStateProperty.all(thumbColor) : null,
      focusColor: focusColor,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
    );
  }
}

/// An adaptive checkbox.
///
/// On Android and other platforms, displays a [Checkbox].
/// On iOS and macOS, displays a circular checkbox style.
class SmartCheckbox extends StatelessWidget {
  /// Creates an adaptive checkbox.
  const SmartCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
    this.activeColor,
    this.checkColor,
    this.tristate = false,
    this.forceMaterial = false,
    this.forceCupertino = false,
  });

  /// Whether this checkbox is checked.
  final bool? value;

  /// Called when the user toggles the checkbox.
  final ValueChanged<bool?>? onChanged;

  /// The color when the checkbox is checked.
  final Color? activeColor;

  /// The color of the check icon.
  final Color? checkColor;

  /// If true, the checkbox's value can be true, false, or null.
  final bool tristate;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      // Cupertino doesn't have a native checkbox, so we create a custom one
      return GestureDetector(
        onTap: onChanged != null
            ? () {
                if (tristate) {
                  onChanged!(value == null ? true : (value! ? false : null));
                } else {
                  onChanged!(!(value ?? false));
                }
              }
            : null,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: value == true
                  ? (activeColor ?? CupertinoColors.activeBlue)
                  : CupertinoColors.systemGrey3,
              width: 2,
            ),
            color: value == true
                ? (activeColor ?? CupertinoColors.activeBlue)
                : null,
          ),
          child: (value ?? false)
              ? Icon(
                  CupertinoIcons.check_mark,
                  size: 14,
                  color: checkColor ?? CupertinoColors.white,
                )
              : value == null
                  ? Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeColor ?? CupertinoColors.activeBlue,
                      ),
                    )
                  : null,
        ),
      );
    }

    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      checkColor: checkColor,
      tristate: tristate,
    );
  }
}

/// An adaptive radio button.
class SmartRadio<T> extends StatelessWidget {
  /// Creates an adaptive radio button.
  const SmartRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
    this.activeColor,
    this.forceMaterial = false,
    this.forceCupertino = false,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for the group.
  final T? groupValue;

  /// Called when this radio button is selected.
  final ValueChanged<T?>? onChanged;

  /// The color when the radio is selected.
  final Color? activeColor;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      return GestureDetector(
        onTap: onChanged != null ? () => onChanged!(value) : null,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _isSelected
                  ? (activeColor ?? CupertinoColors.activeBlue)
                  : CupertinoColors.systemGrey3,
              width: 2,
            ),
          ),
          child: _isSelected
              ? Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor ?? CupertinoColors.activeBlue,
                    ),
                  ),
                )
              : null,
        ),
      );
    }

    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor,
    );
  }
}
