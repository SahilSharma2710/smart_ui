/// Adaptive dialog widget.
///
/// This module provides dialog utilities that automatically adapt
/// to the current platform (Material on Android, Cupertino on iOS).
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/platform_info.dart';

/// Shows an adaptive alert dialog.
///
/// On Android and other platforms, shows a [AlertDialog].
/// On iOS and macOS, shows a [CupertinoAlertDialog].
///
/// Example:
/// ```dart
/// final result = await showSmartDialog<bool>(
///   context: context,
///   title: 'Confirm',
///   content: 'Are you sure you want to delete this item?',
///   actions: [
///     SmartDialogAction(
///       label: 'Cancel',
///       onPressed: () => Navigator.of(context).pop(false),
///     ),
///     SmartDialogAction(
///       label: 'Delete',
///       isDestructive: true,
///       onPressed: () => Navigator.of(context).pop(true),
///     ),
///   ],
/// );
/// ```
Future<T?> showSmartDialog<T>({
  required BuildContext context,
  String? title,
  String? content,
  Widget? contentWidget,
  List<SmartDialogAction>? actions,
  bool forceMaterial = false,
  bool forceCupertino = false,
  bool barrierDismissible = true,
}) {
  final useCupertino =
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  if (useCupertino) {
    return showCupertinoDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: contentWidget ?? (content != null ? Text(content) : null),
        actions: actions?.map((action) {
              return CupertinoDialogAction(
                onPressed: action.onPressed,
                isDefaultAction: action.isDefault,
                isDestructiveAction: action.isDestructive,
                child: Text(action.label),
              );
            }).toList() ??
            [],
      ),
    );
  }

  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: contentWidget ?? (content != null ? Text(content) : null),
      actions: actions?.map((action) {
        return TextButton(
          onPressed: action.onPressed,
          child: Text(
            action.label,
            style: action.isDestructive
                ? TextStyle(color: Theme.of(context).colorScheme.error)
                : null,
          ),
        );
      }).toList(),
    ),
  );
}

/// Shows an adaptive confirmation dialog.
///
/// Returns `true` if the user confirmed, `false` otherwise.
Future<bool> showSmartConfirmDialog({
  required BuildContext context,
  String? title,
  String? content,
  Widget? contentWidget,
  String confirmLabel = 'OK',
  String cancelLabel = 'Cancel',
  bool isDestructive = false,
  bool forceMaterial = false,
  bool forceCupertino = false,
}) async {
  final result = await showSmartDialog<bool>(
    context: context,
    title: title,
    content: content,
    contentWidget: contentWidget,
    forceMaterial: forceMaterial,
    forceCupertino: forceCupertino,
    actions: [
      SmartDialogAction(
        label: cancelLabel,
        onPressed: () => Navigator.of(context).pop(false),
      ),
      SmartDialogAction(
        label: confirmLabel,
        isDestructive: isDestructive,
        isDefault: true,
        onPressed: () => Navigator.of(context).pop(true),
      ),
    ],
  );
  return result ?? false;
}

/// Represents an action in a [SmartDialog].
class SmartDialogAction {
  /// Creates a dialog action.
  const SmartDialogAction({
    required this.label,
    required this.onPressed,
    this.isDefault = false,
    this.isDestructive = false,
  });

  /// The label text for this action.
  final String label;

  /// Called when this action is pressed.
  final VoidCallback? onPressed;

  /// Whether this is the default action (bold on Cupertino).
  final bool isDefault;

  /// Whether this is a destructive action (red text).
  final bool isDestructive;
}

/// An adaptive modal bottom sheet.
class SmartBottomSheet extends StatelessWidget {
  /// Creates an adaptive bottom sheet.
  const SmartBottomSheet({
    required this.child,
    super.key,
    this.title,
    this.forceMaterial = false,
    this.forceCupertino = false,
  });

  /// The content of the bottom sheet.
  final Widget child;

  /// Optional title for the bottom sheet.
  final String? title;

  /// Force Material style regardless of platform.
  final bool forceMaterial;

  /// Force Cupertino style regardless of platform.
  final bool forceCupertino;

  bool get _useCupertino =>
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  @override
  Widget build(BuildContext context) {
    if (_useCupertino) {
      return CupertinoActionSheet(
        title: title != null ? Text(title!) : null,
        actions: [child],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        child,
      ],
    );
  }
}

/// Shows an adaptive modal bottom sheet.
Future<T?> showSmartBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool forceMaterial = false,
  bool forceCupertino = false,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  final useCupertino =
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  if (useCupertino) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => SmartBottomSheet(
        title: title,
        forceCupertino: true,
        child: child,
      ),
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (context) => SmartBottomSheet(
      title: title,
      forceMaterial: true,
      child: child,
    ),
  );
}

/// Shows an adaptive action sheet.
Future<T?> showSmartActionSheet<T>({
  required BuildContext context,
  String? title,
  String? message,
  required List<SmartSheetAction> actions,
  SmartSheetAction? cancelAction,
  bool forceMaterial = false,
  bool forceCupertino = false,
}) {
  final useCupertino =
      forceCupertino || (!forceMaterial && SmartPlatformInfo.usesCupertino);

  if (useCupertino) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: title != null ? Text(title) : null,
        message: message != null ? Text(message) : null,
        actions: actions.map((action) {
          return CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              action.onPressed?.call();
            },
            isDefaultAction: action.isDefault,
            isDestructiveAction: action.isDestructive,
            child: Text(action.label),
          );
        }).toList(),
        cancelButton: cancelAction != null
            ? CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  cancelAction.onPressed?.call();
                },
                child: Text(cancelAction.label),
              )
            : null,
      ),
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          if (message != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          const Divider(),
          ...actions.map((action) {
            return ListTile(
              title: Text(
                action.label,
                textAlign: TextAlign.center,
                style: action.isDestructive
                    ? TextStyle(color: Theme.of(context).colorScheme.error)
                    : null,
              ),
              onTap: () {
                Navigator.of(context).pop();
                action.onPressed?.call();
              },
            );
          }),
          if (cancelAction != null) ...[
            const Divider(),
            ListTile(
              title: Text(
                cancelAction.label,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.of(context).pop();
                cancelAction.onPressed?.call();
              },
            ),
          ],
        ],
      ),
    ),
  );
}

/// Represents an action in an action sheet.
class SmartSheetAction {
  /// Creates a sheet action.
  const SmartSheetAction({
    required this.label,
    this.onPressed,
    this.isDefault = false,
    this.isDestructive = false,
  });

  /// The label text for this action.
  final String label;

  /// Called when this action is pressed.
  final VoidCallback? onPressed;

  /// Whether this is the default action.
  final bool isDefault;

  /// Whether this is a destructive action.
  final bool isDestructive;
}
