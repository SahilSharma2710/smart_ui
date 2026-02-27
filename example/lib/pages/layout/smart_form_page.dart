import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for SmartForm widget
class SmartFormPage extends StatefulWidget {
  const SmartFormPage({super.key});

  @override
  State<SmartFormPage> createState() => _SmartFormPageState();
}

class _SmartFormPageState extends State<SmartFormPage> {
  // Form configuration
  int _mobileColumns = 1;
  int _tabletColumns = 2;
  int _desktopColumns = 3;
  double _spacing = 16.0;

  // Form field values
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';

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
              'SmartForm',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceSm),
            Text(
              'A responsive form layout that automatically adjusts columns based on the current breakpoint. Perfect for building forms that look great on all devices.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                  ),
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Interactive Demo Section
            SectionHeader(
              title: 'Interactive Demo',
              subtitle: 'Configure form columns per breakpoint',
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
                        label: 'Mobile Columns',
                        value: _mobileColumns.toDouble(),
                        min: 1,
                        max: 3,
                        divisions: 2,
                        valueLabel: '$_mobileColumns cols',
                        onChanged: (value) =>
                            setState(() => _mobileColumns = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Tablet Columns',
                        value: _tabletColumns.toDouble(),
                        min: 1,
                        max: 4,
                        divisions: 3,
                        valueLabel: '$_tabletColumns cols',
                        onChanged: (value) =>
                            setState(() => _tabletColumns = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Desktop Columns',
                        value: _desktopColumns.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        valueLabel: '$_desktopColumns cols',
                        onChanged: (value) =>
                            setState(() => _desktopColumns = value.toInt()),
                      ),
                      SliderControl(
                        label: 'Spacing',
                        value: _spacing,
                        min: 8,
                        max: 32,
                        divisions: 6,
                        valueLabel: '${_spacing.toInt()}px',
                        onChanged: (value) => setState(() => _spacing = value),
                      ),
                    ],
                  ),
                ),
                SmartCol(
                  mobile: 12,
                  desktop: 8,
                  child: _FormDemo(
                    mobileColumns: _mobileColumns,
                    tabletColumns: _tabletColumns,
                    desktopColumns: _desktopColumns,
                    spacing: _spacing,
                    name: _name,
                    email: _email,
                    phone: _phone,
                    address: _address,
                    onNameChanged: (v) => setState(() => _name = v),
                    onEmailChanged: (v) => setState(() => _email = v),
                    onPhoneChanged: (v) => setState(() => _phone = v),
                    onAddressChanged: (v) => setState(() => _address = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            CodePreview(
              code: _getFormCode(),
              title: 'form_example.dart',
            ),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartFormField Section
            SectionHeader(
              title: 'SmartFormField',
              subtitle: 'Wrap fields with span control',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _FormFieldDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // SmartFormSection Section
            SectionHeader(
              title: 'SmartFormSection',
              subtitle: 'Group related fields with titles',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _FormSectionDemo(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // Complete Example
            SectionHeader(
              title: 'Complete Form Example',
              subtitle: 'A full registration form with multiple sections',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _CompleteFormExample(),
            const SizedBox(height: PlaygroundTheme.spaceXl),

            // API Reference
            SectionHeader(
              title: 'API Reference',
              subtitle: 'SmartForm parameters',
            ),
            const SizedBox(height: PlaygroundTheme.spaceMd),
            _ApiReference(),
            const SizedBox(height: PlaygroundTheme.spaceXl),
          ],
        ),
      ),
    );
  }

  String _getFormCode() {
    return '''SmartForm(
  mobileColumns: $_mobileColumns,
  tabletColumns: $_tabletColumns,
  desktopColumns: $_desktopColumns,
  spacing: SpacingSize.md,
  children: [
    SmartFormField(
      child: TextField(
        decoration: InputDecoration(labelText: 'Name'),
      ),
    ),
    SmartFormField(
      child: TextField(
        decoration: InputDecoration(labelText: 'Email'),
      ),
    ),
    SmartFormField(
      child: TextField(
        decoration: InputDecoration(labelText: 'Phone'),
      ),
    ),
    SmartFormField(
      span: 2, // Takes 2 columns
      child: TextField(
        decoration: InputDecoration(labelText: 'Address'),
      ),
    ),
  ],
)''';
  }
}

class _FormDemo extends StatelessWidget {
  const _FormDemo({
    required this.mobileColumns,
    required this.tabletColumns,
    required this.desktopColumns,
    required this.spacing,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onAddressChanged,
  });

  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final String name;
  final String email;
  final String phone;
  final String address;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<String> onAddressChanged;

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
              final columns = switch (breakpoint) {
                SmartBreakpoint.mobile => mobileColumns,
                SmartBreakpoint.tablet => tabletColumns,
                SmartBreakpoint.desktop => desktopColumns,
                _ => mobileColumns,
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
                      '${breakpoint.name.toUpperCase()}: $columns column${columns > 1 ? 's' : ''}',
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
          // Form
          SmartForm(
            mobileColumns: mobileColumns,
            tabletColumns: tabletColumns,
            desktopColumns: desktopColumns,
            spacing: SpacingSize.md,
            children: [
              SmartFormField(
                child: _FormTextField(
                  label: 'Name',
                  value: name,
                  onChanged: onNameChanged,
                  icon: Icons.person_outline,
                ),
              ),
              SmartFormField(
                child: _FormTextField(
                  label: 'Email',
                  value: email,
                  onChanged: onEmailChanged,
                  icon: Icons.email_outlined,
                ),
              ),
              SmartFormField(
                child: _FormTextField(
                  label: 'Phone',
                  value: phone,
                  onChanged: onPhoneChanged,
                  icon: Icons.phone_outlined,
                ),
              ),
              SmartFormField(
                span: 2,
                child: _FormTextField(
                  label: 'Address (span: 2)',
                  value: address,
                  onChanged: onAddressChanged,
                  icon: Icons.location_on_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        ),
        filled: true,
        fillColor: context.surfaceElevatedColor,
      ),
    );
  }
}

class _FormFieldDemo extends StatelessWidget {
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
                'Field Spans',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceSm),
              Text(
                'Control how many columns each field spans. If span exceeds available columns, it will be clamped.',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(height: PlaygroundTheme.spaceMd),
              SmartForm(
                mobileColumns: 1,
                tabletColumns: 3,
                desktopColumns: 3,
                children: [
                  SmartFormField(
                    span: 1,
                    child: _SpanIndicator(span: 1),
                  ),
                  SmartFormField(
                    span: 1,
                    child: _SpanIndicator(span: 1),
                  ),
                  SmartFormField(
                    span: 1,
                    child: _SpanIndicator(span: 1),
                  ),
                  SmartFormField(
                    span: 2,
                    child: _SpanIndicator(span: 2),
                  ),
                  SmartFormField(
                    span: 1,
                    child: _SpanIndicator(span: 1),
                  ),
                  SmartFormField(
                    span: 3,
                    child: _SpanIndicator(span: 3),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartFormField(
  span: 2, // Takes 2 columns on tablet/desktop
  child: TextField(
    decoration: InputDecoration(
      labelText: 'Full Address',
    ),
  ),
)''',
          title: 'span_example.dart',
        ),
      ],
    );
  }
}

class _SpanIndicator extends StatelessWidget {
  const _SpanIndicator({required this.span});

  final int span;

  @override
  Widget build(BuildContext context) {
    final colors = [
      PlaygroundTheme.primary,
      PlaygroundTheme.accent,
      PlaygroundTheme.success,
    ];
    final color = colors[(span - 1) % colors.length];

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(
          'span: $span',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _FormSectionDemo extends StatelessWidget {
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
          child: SmartFormSection(
            title: 'Personal Information',
            description: 'Enter your basic details below.',
            titleStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
            descriptionStyle: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
            ),
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 2,
            children: [
              SmartFormField(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(PlaygroundTheme.radiusMd),
                    ),
                  ),
                ),
              ),
              SmartFormField(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(PlaygroundTheme.radiusMd),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: '''SmartFormSection(
  title: 'Personal Information',
  description: 'Enter your basic details below.',
  mobileColumns: 1,
  tabletColumns: 2,
  desktopColumns: 2,
  children: [
    SmartFormField(
      child: TextField(decoration: InputDecoration(labelText: 'First Name')),
    ),
    SmartFormField(
      child: TextField(decoration: InputDecoration(labelText: 'Last Name')),
    ),
  ],
)''',
          title: 'section_example.dart',
        ),
      ],
    );
  }
}

class _CompleteFormExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Registration',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceXl),

          // Account Section
          SmartFormSection(
            title: 'Account Details',
            description: 'Create your account credentials.',
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            children: [
              SmartFormField(
                child: _DemoField(label: 'Username', icon: Icons.account_circle_outlined),
              ),
              SmartFormField(
                child: _DemoField(label: 'Email', icon: Icons.email_outlined),
              ),
              SmartFormField(
                child: _DemoField(label: 'Password', icon: Icons.lock_outlined),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceXl),

          // Personal Section
          SmartFormSection(
            title: 'Personal Information',
            description: 'Tell us about yourself.',
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            children: [
              SmartFormField(
                child: _DemoField(label: 'First Name', icon: Icons.person_outline),
              ),
              SmartFormField(
                child: _DemoField(label: 'Last Name', icon: Icons.person_outline),
              ),
              SmartFormField(
                child: _DemoField(label: 'Phone', icon: Icons.phone_outlined),
              ),
              SmartFormField(
                span: 2,
                child: _DemoField(label: 'Address', icon: Icons.location_on_outlined),
              ),
              SmartFormField(
                child: _DemoField(label: 'City', icon: Icons.location_city_outlined),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),

          // Submit Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              const SizedBox(width: PlaygroundTheme.spaceMd),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Create Account'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DemoField extends StatelessWidget {
  const _DemoField({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        ),
        filled: true,
        fillColor: context.surfaceElevatedColor,
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
            param: 'watchColumns',
            type: 'int',
            description: 'Number of columns on watch screens (default: 1)',
          ),
          _ApiRow(
            param: 'mobileColumns',
            type: 'int',
            description: 'Number of columns on mobile screens (default: 1)',
          ),
          _ApiRow(
            param: 'tabletColumns',
            type: 'int',
            description: 'Number of columns on tablet screens (default: 2)',
          ),
          _ApiRow(
            param: 'desktopColumns',
            type: 'int',
            description: 'Number of columns on desktop screens (default: 3)',
          ),
          _ApiRow(
            param: 'tvColumns',
            type: 'int',
            description: 'Number of columns on TV screens (default: 4)',
          ),
          _ApiRow(
            param: 'spacing',
            type: 'SpacingSize',
            description: 'Horizontal spacing between columns',
          ),
          _ApiRow(
            param: 'runSpacing',
            type: 'SpacingSize',
            description: 'Vertical spacing between rows',
          ),
          _ApiRow(
            param: 'children',
            type: 'List<SmartFormField>',
            description: 'Form field widgets wrapped in SmartFormField',
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
            width: 130,
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
            width: 140,
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
