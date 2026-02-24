import 'package:flutter/material.dart';
import 'package:smartui/smartui.dart';

void main() {
  runApp(const SmartUiExampleApp());
}

class SmartUiExampleApp extends StatelessWidget {
  const SmartUiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SmartUi(
      child: MaterialApp(
        title: 'smartui Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _pages = const [
    GridDemoPage(),
    LayoutDemoPage(),
    AdaptiveDemoPage(),
    TokensDemoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SmartScaffold(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      destinations: const [
        SmartDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view),
          label: 'Grid',
        ),
        SmartDestination(
          icon: Icon(Icons.view_quilt_outlined),
          selectedIcon: Icon(Icons.view_quilt),
          label: 'Layout',
        ),
        SmartDestination(
          icon: Icon(Icons.widgets_outlined),
          selectedIcon: Icon(Icons.widgets),
          label: 'Adaptive',
        ),
        SmartDestination(
          icon: Icon(Icons.palette_outlined),
          selectedIcon: Icon(Icons.palette),
          label: 'Tokens',
        ),
      ],
      appBar: AppBar(
        title: const Text('smartui Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }

  void _showInfoDialog(BuildContext context) {
    showSmartDialog<void>(
      context: context,
      title: 'smartui',
      content: 'The Tailwind CSS of Flutter. A zero-config, declarative '
          'adaptive UI toolkit for responsive, platform-aware Flutter apps.',
      actions: [
        SmartDialogAction(
          label: 'OK',
          isDefault: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

// Grid Demo Page
class GridDemoPage extends StatelessWidget {
  const GridDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SmartSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SmartText(
            'Responsive Grid',
            style: TypographyStyle.headlineMedium,
          ),
          const VGap.md(),
          ResponsiveBuilder(
            builder: (context, info) {
              return SmartText(
                'Current breakpoint: ${info.breakpoint.name} '
                '(${info.screenWidth.toInt()}px)',
                style: TypographyStyle.bodyMedium,
              );
            },
          ),
          const VGap.lg(),
          SmartGrid(
            columns: 12,
            spacing: SmartSpacing.md,
            runSpacing: SmartSpacing.md,
            children: List.generate(6, (index) {
              return SmartCol(
                mobile: 12,
                tablet: 6,
                desktop: 4,
                child: _ProductCard(index: index),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: colors[index % colors.length].withOpacity(0.2),
              borderRadius: SmartRadius.top(12),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 48,
                color: colors[index % colors.length],
              ),
            ),
          ),
          SmartPadding.all(
            SpacingSize.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(
                  'Product ${index + 1}',
                  style: TypographyStyle.titleMedium,
                ),
                const VGap.xs(),
                SmartText(
                  'This is a description of the product.',
                  style: TypographyStyle.bodySmall,
                  textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const VGap.sm(),
                SmartText(
                  '\$${(index + 1) * 19.99}',
                  style: TypographyStyle.titleLarge,
                  textColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Layout Demo Page
class LayoutDemoPage extends StatelessWidget {
  const LayoutDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SmartLayout(
      mobile: _MobileLayout(),
      tablet: _TabletLayout(),
      desktop: _DesktopLayout(),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SmartSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SmartText(
            'Mobile Layout',
            style: TypographyStyle.headlineMedium,
          ),
          const VGap.md(),
          const SmartText(
            'This layout is optimized for mobile devices. '
            'Content is displayed in a single column.',
            style: TypographyStyle.bodyMedium,
          ),
          const VGap.lg(),
          ...List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: SmartSpacing.md),
              child: _ContentCard(
                title: 'Item ${index + 1}',
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SmartSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SmartText(
            'Tablet Layout',
            style: TypographyStyle.headlineMedium,
          ),
          const VGap.md(),
          const SmartText(
            'This layout is optimized for tablets. '
            'Content is displayed in two columns.',
            style: TypographyStyle.bodyMedium,
          ),
          const VGap.lg(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: SmartSpacing.md),
                      child: _ContentCard(
                        title: 'Left ${index + 1}',
                        color: Colors
                            .primaries[(index * 2) % Colors.primaries.length],
                      ),
                    );
                  }),
                ),
              ),
              const HGap.md(),
              Expanded(
                child: Column(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: SmartSpacing.md),
                      child: _ContentCard(
                        title: 'Right ${index + 1}',
                        color: Colors.primaries[
                            (index * 2 + 1) % Colors.primaries.length],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SmartSpacing.xl),
      child: SmartContainer(
        maxWidth: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SmartText(
              'Desktop Layout',
              style: TypographyStyle.headlineMedium,
            ),
            const VGap.md(),
            const SmartText(
              'This layout is optimized for desktop. '
              'Content uses a max-width container with three columns.',
              style: TypographyStyle.bodyMedium,
            ),
            const VGap.lg(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(3, (colIndex) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: colIndex == 0 ? 0 : SmartSpacing.md / 2,
                      right: colIndex == 2 ? 0 : SmartSpacing.md / 2,
                    ),
                    child: Column(
                      children: List.generate(2, (rowIndex) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: SmartSpacing.md),
                          child: _ContentCard(
                            title: 'Col ${colIndex + 1}, Row ${rowIndex + 1}',
                            color: Colors.primaries[(colIndex * 2 + rowIndex) %
                                Colors.primaries.length],
                          ),
                        );
                      }),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(SmartSpacing.md),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: color, width: 4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartText(title, style: TypographyStyle.titleMedium),
            const VGap.sm(),
            SmartText(
              'This is sample content for the card.',
              style: TypographyStyle.bodySmall,
              textColor: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

// Adaptive Demo Page
class AdaptiveDemoPage extends StatefulWidget {
  const AdaptiveDemoPage({super.key});

  @override
  State<AdaptiveDemoPage> createState() => _AdaptiveDemoPageState();
}

class _AdaptiveDemoPageState extends State<AdaptiveDemoPage> {
  bool _switchValue = false;
  bool _checkboxValue = false;
  String _radioValue = 'option1';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SmartSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SmartText(
            'Adaptive Widgets',
            style: TypographyStyle.headlineMedium,
          ),
          const VGap.md(),
          const SmartText(
            'These widgets automatically adapt to the current platform. '
            'On iOS, they show Cupertino styling. On Android, Material.',
            style: TypographyStyle.bodyMedium,
          ),
          const VGap.lg(),

          // Buttons section
          const SmartText('Buttons', style: TypographyStyle.titleLarge),
          const VGap.md(),
          Wrap(
            spacing: SmartSpacing.md,
            runSpacing: SmartSpacing.sm,
            children: [
              SmartButton(
                onPressed: () =>
                    _showSnackBar(context, 'Default button pressed'),
                child: const Text('Default'),
              ),
              SmartButton.filled(
                onPressed: () =>
                    _showSnackBar(context, 'Filled button pressed'),
                child: const Text('Filled'),
              ),
              SmartButton.text(
                onPressed: () => _showSnackBar(context, 'Text button pressed'),
                child: const Text('Text'),
              ),
              SmartButton.outlined(
                onPressed: () =>
                    _showSnackBar(context, 'Outlined button pressed'),
                child: const Text('Outlined'),
              ),
            ],
          ),
          const VGap.xl(),

          // Switch section
          const SmartText('Switch', style: TypographyStyle.titleLarge),
          const VGap.md(),
          Row(
            children: [
              SmartSwitch(
                value: _switchValue,
                onChanged: (value) => setState(() => _switchValue = value),
              ),
              const HGap.md(),
              Text(_switchValue ? 'On' : 'Off'),
            ],
          ),
          const VGap.xl(),

          // Checkbox section
          const SmartText('Checkbox', style: TypographyStyle.titleLarge),
          const VGap.md(),
          Row(
            children: [
              SmartCheckbox(
                value: _checkboxValue,
                onChanged: (value) =>
                    setState(() => _checkboxValue = value ?? false),
              ),
              const HGap.md(),
              Text(_checkboxValue ? 'Checked' : 'Unchecked'),
            ],
          ),
          const VGap.xl(),

          // Radio section
          const SmartText('Radio', style: TypographyStyle.titleLarge),
          const VGap.md(),
          Row(
            children: [
              SmartRadio<String>(
                value: 'option1',
                groupValue: _radioValue,
                onChanged: (value) =>
                    setState(() => _radioValue = value ?? 'option1'),
              ),
              const HGap.sm(),
              const Text('Option 1'),
              const HGap.lg(),
              SmartRadio<String>(
                value: 'option2',
                groupValue: _radioValue,
                onChanged: (value) =>
                    setState(() => _radioValue = value ?? 'option1'),
              ),
              const HGap.sm(),
              const Text('Option 2'),
            ],
          ),
          const VGap.xl(),

          // Progress indicators
          const SmartText('Progress Indicators',
              style: TypographyStyle.titleLarge),
          const VGap.md(),
          const Row(
            children: [
              SmartIndicator(),
              HGap.lg(),
              SmartIndicator(value: 0.7),
            ],
          ),
          const VGap.md(),
          const SmartLinearIndicator(value: 0.5),
          const VGap.xl(),

          // Dialogs
          const SmartText('Dialogs', style: TypographyStyle.titleLarge),
          const VGap.md(),
          SmartButton(
            onPressed: () => _showAlertDialog(context),
            child: const Text('Show Alert Dialog'),
          ),
          const VGap.md(),
          SmartButton(
            onPressed: () => _showConfirmDialog(context),
            child: const Text('Show Confirm Dialog'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showSmartDialog<void>(
      context: context,
      title: 'Alert',
      content: 'This is an adaptive alert dialog.',
      actions: [
        SmartDialogAction(
          label: 'OK',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showConfirmDialog(BuildContext context) async {
    final confirmed = await showSmartConfirmDialog(
      context: context,
      title: 'Confirm Action',
      content: 'Are you sure you want to proceed?',
      confirmLabel: 'Yes',
      cancelLabel: 'No',
    );

    if (context.mounted) {
      _showSnackBar(context, confirmed ? 'Confirmed!' : 'Cancelled');
    }
  }
}

// Tokens Demo Page
class TokensDemoPage extends StatelessWidget {
  const TokensDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SmartSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SmartText(
            'Design Tokens',
            style: TypographyStyle.headlineMedium,
          ),
          const VGap.lg(),

          // Typography section
          const SmartText('Typography', style: TypographyStyle.titleLarge),
          const VGap.md(),
          const _TypographyShowcase(),
          const VGap.xl(),

          // Spacing section
          const SmartText('Spacing', style: TypographyStyle.titleLarge),
          const VGap.md(),
          const _SpacingShowcase(),
          const VGap.xl(),

          // Radius section
          const SmartText('Border Radius', style: TypographyStyle.titleLarge),
          const VGap.md(),
          const _RadiusShowcase(),
        ],
      ),
    );
  }
}

class _TypographyShowcase extends StatelessWidget {
  const _TypographyShowcase();

  @override
  Widget build(BuildContext context) {
    final styles = [
      ('displayLarge', TypographyStyle.displayLarge),
      ('displayMedium', TypographyStyle.displayMedium),
      ('displaySmall', TypographyStyle.displaySmall),
      ('headlineLarge', TypographyStyle.headlineLarge),
      ('headlineMedium', TypographyStyle.headlineMedium),
      ('headlineSmall', TypographyStyle.headlineSmall),
      ('titleLarge', TypographyStyle.titleLarge),
      ('titleMedium', TypographyStyle.titleMedium),
      ('titleSmall', TypographyStyle.titleSmall),
      ('bodyLarge', TypographyStyle.bodyLarge),
      ('bodyMedium', TypographyStyle.bodyMedium),
      ('bodySmall', TypographyStyle.bodySmall),
      ('labelLarge', TypographyStyle.labelLarge),
      ('labelMedium', TypographyStyle.labelMedium),
      ('labelSmall', TypographyStyle.labelSmall),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: styles.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
          child: SmartText(item.$1, style: item.$2),
        );
      }).toList(),
    );
  }
}

class _SpacingShowcase extends StatelessWidget {
  const _SpacingShowcase();

  @override
  Widget build(BuildContext context) {
    final spacings = [
      ('xs (4px)', SmartSpacing.xs),
      ('sm (8px)', SmartSpacing.sm),
      ('md (16px)', SmartSpacing.md),
      ('lg (24px)', SmartSpacing.lg),
      ('xl (32px)', SmartSpacing.xl),
      ('xxl (48px)', SmartSpacing.xxl),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: spacings.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: SmartSpacing.sm),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: SmartText(item.$1, style: TypographyStyle.bodyMedium),
              ),
              Container(
                width: item.$2,
                height: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _RadiusShowcase extends StatelessWidget {
  const _RadiusShowcase();

  @override
  Widget build(BuildContext context) {
    final radii = [
      ('none', SmartRadius.none),
      ('xs (2px)', SmartRadius.xs),
      ('sm (4px)', SmartRadius.sm),
      ('md (8px)', SmartRadius.md),
      ('lg (12px)', SmartRadius.lg),
      ('xl (16px)', SmartRadius.xl),
      ('xxl (24px)', SmartRadius.xxl),
      ('full', SmartRadius.full),
    ];

    return Wrap(
      spacing: SmartSpacing.md,
      runSpacing: SmartSpacing.md,
      children: radii.map((item) {
        return Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: item.$2,
              ),
            ),
            const VGap.xs(),
            SmartText(item.$1, style: TypographyStyle.labelSmall),
          ],
        );
      }).toList(),
    );
  }
}
