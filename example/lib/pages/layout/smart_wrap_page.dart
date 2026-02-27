import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartWrap widget
class SmartWrapPage extends StatefulWidget {
  const SmartWrapPage({super.key});

  @override
  State<SmartWrapPage> createState() => _SmartWrapPageState();
}

class _SmartWrapPageState extends State<SmartWrapPage> {
  // Wrap configuration
  int _mobileItemsPerRow = 2;
  int _tabletItemsPerRow = 4;
  int _desktopItemsPerRow = 6;
  double _spacing = 12.0;
  double _runSpacing = 12.0;
  bool _fillRow = false;
  int _itemCount = 8;

  // Chip selection
  Set<String> _selectedChips = {'Flutter', 'Dart'};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsive(
        mobile: PlaygroundTheme.spaceMd,
        desktop: PlaygroundTheme.spaceLg,
      )),
      child: SmartContainer.lg(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'SmartWrap',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'A responsive Wrap widget that limits items per row based on breakpoints. Perfect for tags, chips, badges, and any flowing content.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Control items per row at each breakpoint',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            SmartGrid(
              spacing: SmartSpacing.md,
              children: [
                SmartCol(
                  mobile: 12,
                  desktop: 4,
                  child: InteractiveControls(
                    children: [
                      SliderControl(
                        label: 'Mobile Items/Row',
                        value: _mobileItemsPerRow.toDouble(),
                        min: 1,
                        max: 6,
                        divisions: 5,
                        valueLabel: '$_mobileItemsPerRow',
                        onChanged: (value) =>
                            setState(() => _mobileItemsPerRow = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Tablet Items/Row',
                        value: _tabletItemsPerRow.toDouble(),
                        min: 1,
                        max: 8,
                        divisions: 7,
                        valueLabel: '$_tabletItemsPerRow',
                        onChanged: (value) =>
                            setState(() => _tabletItemsPerRow = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Desktop Items/Row',
                        value: _desktopItemsPerRow.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        valueLabel: '$_desktopItemsPerRow',
                        onChanged: (value) =>
                            setState(() => _desktopItemsPerRow = value.toInt()),
                      ),
                      const Divider(),
                      SliderControl(
                        label: 'Item Count',
                        value: _itemCount.toDouble(),
                        min: 1,
                        max: 16,
                        divisions: 15,
                        valueLabel: '$_itemCount',
                        onChanged: (value) =>
                            setState(() => _itemCount = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Spacing',
                        value: _spacing,
                        min: 0,
                        max: 24,
                        divisions: 6,
                        valueLabel: '${_spacing.toInt()}px',
                        onChanged: (value) => setState(() => _spacing = value),
                      ),
                      SliderControl(
                        label: 'Run Spacing',
                        value: _runSpacing,
                        min: 0,
                        max: 24,
                        divisions: 6,
                        valueLabel: '${_runSpacing.toInt()}px',
                        onChanged: (value) => setState(() => _runSpacing = value),
                      ),
                      SwitchControl(
                        label: 'Fill Row',
                        value: _fillRow,
                        description: 'Expand items to fill row width',
                        onChanged: (value) => setState(() => _fillRow = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _WrapDemo(
                    mobileItemsPerRow: _mobileItemsPerRow,
                    tabletItemsPerRow: _tabletItemsPerRow,
                    desktopItemsPerRow: _desktopItemsPerRow,
                    spacing: _spacing,
                    runSpacing: _runSpacing,
                    fillRow: _fillRow,
                    itemCount: _itemCount,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getWrapCode(),
              title: 'wrap_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartChipWrap Section
            SectionHeader(
              title: 'SmartChipWrap',
              subtitle: 'Built-in chip variant with selection support',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ChipWrapDemo(
              selectedChips: _selectedChips,
              onSelectionChanged: (chips) => setState(() => _selectedChips = chips),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Fill Row Example
            SectionHeader(
              title: 'Fill Row Mode',
              subtitle: 'Expand items to take equal width within each row',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _FillRowDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Use Cases Section
            SectionHeader(
              title: 'Common Use Cases',
              subtitle: 'Examples of SmartWrap in action',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _UseCasesDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartWrap parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getWrapCode() {
    return '''SmartWrap(
  mobileItemsPerRow: $_mobileItemsPerRow,
  tabletItemsPerRow: $_tabletItemsPerRow,
  desktopItemsPerRow: $_desktopItemsPerRow,
  spacing: $_spacing,
  runSpacing: $_runSpacing,
  fillRow: $_fillRow,
  children: items.map((item) => ItemWidget(item)).toList(),
)''';
  }
}

class _WrapDemo extends StatelessWidget {
  const _WrapDemo({
    required this.mobileItemsPerRow,
    required this.tabletItemsPerRow,
    required this.desktopItemsPerRow,
    required this.spacing,
    required this.runSpacing,
    required this.fillRow,
    required this.itemCount,
  });

  final int mobileItemsPerRow;
  final int tabletItemsPerRow;
  final int desktopItemsPerRow;
  final double spacing;
  final double runSpacing;
  final bool fillRow;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breakpoint indicator
          BreakpointBuilder(
            builder: (context, breakpoint) {
              final color = PlaygroundTheme.colorForBreakpoint(breakpoint.name);
              final itemsPerRow = switch (breakpoint) {
                SmartBreakpoint.mobile => mobileItemsPerRow,
                SmartBreakpoint.tablet => tabletItemsPerRow,
                SmartBreakpoint.desktop => desktopItemsPerRow,
                _ => mobileItemsPerRow,
              };
              return Container(
                margin: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      PlaygroundTheme.iconForBreakpoint(breakpoint.name),
                      size: 16,
                      color: color,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${breakpoint.name.toUpperCase()}: $itemsPerRow items/row',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Wrap
          SmartWrap(
            mobileItemsPerRow: mobileItemsPerRow,
            tabletItemsPerRow: tabletItemsPerRow,
            desktopItemsPerRow: desktopItemsPerRow,
            spacing: spacing,
            runSpacing: runSpacing,
            fillRow: fillRow,
            children: List.generate(itemCount, (index) => _WrapItem(index: index + 1)),
          ),
        ],
      ),
    );
  }
}

class _WrapItem extends StatelessWidget {
  const _WrapItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = [
      PlaygroundTheme.primary,
      PlaygroundTheme.accent,
      PlaygroundTheme.success,
      PlaygroundTheme.warning,
      PlaygroundTheme.error,
      PlaygroundTheme.info,
    ];
    final color = colors[(index - 1) % colors.length];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        'Item $index',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _ChipWrapDemo extends StatelessWidget {
  const _ChipWrapDemo({
    required this.selectedChips,
    required this.onSelectionChanged,
  });

  final Set<String> selectedChips;
  final ValueChanged<Set<String>> onSelectionChanged;

  static const _labels = [
    'Flutter',
    'Dart',
    'Responsive',
    'Adaptive',
    'UI',
    'Mobile',
    'Web',
    'Desktop',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Tags',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              SmartChipWrap(
                mobileItemsPerRow: 3,
                tabletItemsPerRow: 5,
                desktopItemsPerRow: 8,
                spacing: 8,
                runSpacing: 8,
                labels: _labels,
                selectedLabels: selectedChips,
                onSelected: (label) {
                  final newSelection = Set<String>.from(selectedChips);
                  if (newSelection.contains(label)) {
                    newSelection.remove(label);
                  } else {
                    newSelection.add(label);
                  }
                  onSelectionChanged(newSelection);
                },
                chipBuilder: (context, label, isSelected) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? PlaygroundTheme.primary.withValues(alpha: 0.15)
                          : context.surfaceElevatedColor,
                      borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
                      border: Border.all(
                        color: isSelected
                            ? PlaygroundTheme.primary
                            : context.borderColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected) ...[
                          Icon(
                            Icons.check,
                            size: 14,
                            color: PlaygroundTheme.primary,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected
                                ? PlaygroundTheme.primary
                                : context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.codeBgColor,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                ),
                child: Text(
                  'Selected: ${selectedChips.join(", ")}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: context.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartChipWrap(
  mobileItemsPerRow: 3,
  tabletItemsPerRow: 5,
  desktopItemsPerRow: 8,
  labels: ['Flutter', 'Dart', 'Responsive', ...],
  selectedLabels: selectedLabels,
  onSelected: (label) {
    // Toggle selection
  },
  chipBuilder: (context, label, isSelected) {
    return CustomChip(
      label: label,
      isSelected: isSelected,
    );
  },
)''',
          title: 'chip_wrap_example.dart',
        ),
      ],
    );
  }
}

class _FillRowDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _FillRowLabel(label: 'fillRow: false', isActive: false),
                  const SizedBox(width: PlaygroundTheme.spaceMd),
                  _FillRowLabel(label: 'fillRow: true', isActive: true),
                ],
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartWrap(
                          desktopItemsPerRow: 3,
                          spacing: 8,
                          runSpacing: 8,
                          fillRow: false,
                          children: List.generate(
                            5,
                            (i) => _FillRowItem(label: 'Item ${i + 1}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: PlaygroundTheme.spaceLg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartWrap(
                          desktopItemsPerRow: 3,
                          spacing: 8,
                          runSpacing: 8,
                          fillRow: true,
                          children: List.generate(
                            5,
                            (i) => _FillRowItem(label: 'Item ${i + 1}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''// Items expand to fill available width
SmartWrap(
  desktopItemsPerRow: 3,
  fillRow: true,  // <-- Enable fill row
  children: [...],
)''',
          title: 'fill_row_example.dart',
        ),
      ],
    );
  }
}

class _FillRowLabel extends StatelessWidget {
  const _FillRowLabel({required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? PlaygroundTheme.success.withValues(alpha: 0.1)
            : context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
        border: Border.all(
          color: isActive
              ? PlaygroundTheme.success.withValues(alpha: 0.3)
              : context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: isActive ? PlaygroundTheme.success : context.textMutedColor,
        ),
      ),
    );
  }
}

class _FillRowItem extends StatelessWidget {
  const _FillRowItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: PlaygroundTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: PlaygroundTheme.primary.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: PlaygroundTheme.primary,
          ),
        ),
      ),
    );
  }
}

class _UseCasesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _UseCase(
            title: 'Product Filters',
            icon: Icons.filter_list,
            child: SmartWrap(
              mobileItemsPerRow: 2,
              desktopItemsPerRow: 3,
              spacing: 8,
              runSpacing: 8,
              fillRow: true,
              children: ['All', 'Electronics', 'Clothing', 'Home', 'Sports']
                  .map((e) => _FilterChip(label: e, isActive: e == 'All'))
                  .toList(),
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _UseCase(
            title: 'Tags / Labels',
            icon: Icons.label_outline,
            child: SmartWrap(
              mobileItemsPerRow: 3,
              desktopItemsPerRow: 5,
              spacing: 6,
              runSpacing: 6,
              children: ['Flutter', 'Dart', 'UI', 'Responsive', 'Open Source']
                  .map((e) => _Tag(label: e))
                  .toList(),
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _UseCase(
            title: 'Action Buttons',
            icon: Icons.touch_app,
            child: SmartWrap(
              mobileItemsPerRow: 2,
              desktopItemsPerRow: 4,
              spacing: 8,
              runSpacing: 8,
              fillRow: true,
              children: [
                _ActionButton(icon: Icons.share, label: 'Share'),
                _ActionButton(icon: Icons.favorite_border, label: 'Like'),
                _ActionButton(icon: Icons.bookmark_border, label: 'Save'),
                _ActionButton(icon: Icons.more_horiz, label: 'More'),
              ],
            ),
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          child: _UseCase(
            title: 'Avatar Grid',
            icon: Icons.people,
            child: SmartWrap(
              mobileItemsPerRow: 5,
              desktopItemsPerRow: 8,
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                8,
                (i) => _Avatar(index: i),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UseCase extends StatelessWidget {
  const _UseCase({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: PlaygroundTheme.primary),
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
          const SizedBox(height: PlaygroundTheme.spaceMd),
          child,
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? PlaygroundTheme.primary : context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : context.textSecondaryColor,
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: PlaygroundTheme.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
      ),
      child: Text(
        '#$label',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: PlaygroundTheme.accent,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: context.textSecondaryColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = [
      PlaygroundTheme.primary,
      PlaygroundTheme.accent,
      PlaygroundTheme.success,
      PlaygroundTheme.warning,
      PlaygroundTheme.error,
      PlaygroundTheme.info,
    ];
    final color = colors[index % colors.length];

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          String.fromCharCode(65 + index),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ApiReference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          _ApiRow(
            param: 'mobileItemsPerRow',
            type: 'int?',
            description: 'Max items per row on mobile (null = no limit)',
          ),
          _ApiRow(
            param: 'tabletItemsPerRow',
            type: 'int?',
            description: 'Max items per row on tablet (null = no limit)',
          ),
          _ApiRow(
            param: 'desktopItemsPerRow',
            type: 'int?',
            description: 'Max items per row on desktop (null = no limit)',
          ),
          _ApiRow(
            param: 'spacing',
            type: 'double',
            description: 'Horizontal spacing between items (default: 8.0)',
          ),
          _ApiRow(
            param: 'runSpacing',
            type: 'double',
            description: 'Vertical spacing between rows (default: 8.0)',
          ),
          _ApiRow(
            param: 'fillRow',
            type: 'bool',
            description: 'Expand items to fill row width (default: false)',
          ),
          _ApiRow(
            param: 'alignment',
            type: 'WrapAlignment',
            description: 'How items are aligned horizontally',
          ),
          _ApiRow(
            param: 'children',
            type: 'List<Widget>',
            description: 'Widgets to display in the wrap',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({
    required this.param,
    required this.type,
    required this.description,
    this.isLast = false,
  });

  final String param;
  final String type;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: context.borderColor.withValues(alpha: 0.3),
                ),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              param,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: context.textMutedColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
