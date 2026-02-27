import 'package:flutter/material.dart';
import '../theme/playground_theme.dart';

/// A panel of interactive controls (knobs) for modifying widget properties
class InteractiveControls extends StatelessWidget {
  const InteractiveControls({
    super.key,
    required this.children,
    this.title = 'Controls',
  });

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Row(
              children: [
                Icon(
                  Icons.tune,
                  size: 18,
                  color: PlaygroundTheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.borderColor.withValues(alpha: 0.3),
          ),
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

/// A slider control with label and value display
class SliderControl extends StatelessWidget {
  const SliderControl({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
    this.valueLabel,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int? divisions;
  final String? valueLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: context.textSecondaryColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: PlaygroundTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                ),
                child: Text(
                  valueLabel ?? value.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: PlaygroundTheme.primary,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: PlaygroundTheme.primary,
              inactiveTrackColor: context.borderColor.withValues(alpha: 0.3),
              thumbColor: PlaygroundTheme.primary,
              overlayColor: PlaygroundTheme.primary.withValues(alpha: 0.1),
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// A dropdown control
class DropdownControl<T> extends StatelessWidget {
  const DropdownControl({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.optionLabels,
  });

  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final Map<T, String>? optionLabels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
              border: Border.all(
                color: context.borderColor.withValues(alpha: 0.5),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                icon: Icon(
                  Icons.expand_more,
                  color: context.textMutedColor,
                ),
                dropdownColor: context.surfaceElevatedColor,
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                style: TextStyle(
                  fontSize: 14,
                  color: context.textPrimaryColor,
                ),
                items: options.map((option) {
                  return DropdownMenuItem<T>(
                    value: option,
                    child: Text(optionLabels?[option] ?? option.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A switch/toggle control
class SwitchControl extends StatelessWidget {
  const SwitchControl({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.description,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.textSecondaryColor,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    description!,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.textMutedColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: PlaygroundTheme.primary,
              inactiveThumbColor: context.textMutedColor,
              inactiveTrackColor: context.borderColor.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// A checkbox group control
class CheckboxGroupControl extends StatelessWidget {
  const CheckboxGroupControl({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.optionLabels,
  });

  final String label;
  final List<String> options;
  final Set<String> selectedValues;
  final ValueChanged<Set<String>> onChanged;
  final Map<String, String>? optionLabels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = selectedValues.contains(option);
              return _CheckboxChip(
                label: optionLabels?[option] ?? option,
                isSelected: isSelected,
                onTap: () {
                  final newValues = Set<String>.from(selectedValues);
                  if (isSelected) {
                    newValues.remove(option);
                  } else {
                    newValues.add(option);
                  }
                  onChanged(newValues);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _CheckboxChip extends StatefulWidget {
  const _CheckboxChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_CheckboxChip> createState() => _CheckboxChipState();
}

class _CheckboxChipState extends State<_CheckboxChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PlaygroundTheme.durationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? PlaygroundTheme.primary.withValues(alpha: 0.15)
                : _hovered
                    ? context.surfaceElevatedColor
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
            border: Border.all(
              color: widget.isSelected
                  ? PlaygroundTheme.primary
                  : context.borderColor.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isSelected
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                size: 16,
                color: widget.isSelected
                    ? PlaygroundTheme.primary
                    : context.textMutedColor,
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  color: widget.isSelected
                      ? PlaygroundTheme.primary
                      : context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A color picker control
class ColorPickerControl extends StatelessWidget {
  const ColorPickerControl({
    super.key,
    required this.label,
    required this.value,
    required this.colors,
    required this.onChanged,
  });

  final String label;
  final Color value;
  final List<Color> colors;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: colors.map((color) {
              final isSelected = color.value == value.value;
              return GestureDetector(
                onTap: () => onChanged(color),
                child: AnimatedContainer(
                  duration: PlaygroundTheme.durationFast,
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.white
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: color.withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: color.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// A segmented control
class SegmentedControl<T> extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.optionLabels,
    this.optionIcons,
  });

  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final Map<T, String>? optionLabels;
  final Map<T, IconData>? optionIcons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
              border: Border.all(
                color: context.borderColor.withValues(alpha: 0.3),
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(
              children: options.map((option) {
                final isSelected = option == value;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(option),
                    child: AnimatedContainer(
                      duration: PlaygroundTheme.durationFast,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? PlaygroundTheme.primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          PlaygroundTheme.radiusSm,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (optionIcons?[option] != null) ...[
                            Icon(
                              optionIcons![option],
                              size: 16,
                              color: isSelected
                                  ? PlaygroundTheme.primary
                                  : context.textMutedColor,
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            optionLabels?[option] ?? option.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected
                                  ? PlaygroundTheme.primary
                                  : context.textMutedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// A text input control
class TextInputControl extends StatelessWidget {
  const TextInputControl({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.placeholder,
    this.maxLines = 1,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final String? placeholder;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                color: context.textMutedColor,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              color: context.textPrimaryColor,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
