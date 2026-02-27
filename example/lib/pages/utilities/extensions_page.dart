import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for BuildContext responsive extensions.
class ExtensionsPage extends StatefulWidget {
  const ExtensionsPage({super.key});

  @override
  State<ExtensionsPage> createState() => _ExtensionsPageState();
}

class _ExtensionsPageState extends State<ExtensionsPage> {
  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'Context Extensions',
      subtitle:
          'Convenient BuildContext extensions for responsive design and platform detection.',
      children: [
        // Screen Info Section
        SectionHeader(
          title: 'Screen Information',
          subtitle: 'Access screen dimensions and display properties',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildScreenInfoSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Orientation Section
        SectionHeader(
          title: 'Orientation',
          subtitle: 'Detect screen orientation',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildOrientationSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Breakpoint Section
        SectionHeader(
          title: 'Breakpoint Detection',
          subtitle: 'Check current breakpoint and compare sizes',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildBreakpointSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Platform Section
        SectionHeader(
          title: 'Platform Detection',
          subtitle: 'Identify the current platform and design system',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildPlatformSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Safe Area Section
        SectionHeader(
          title: 'Safe Area',
          subtitle: 'Access safe area padding and insets',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildSafeAreaSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Responsive Helpers Section
        SectionHeader(
          title: 'Responsive Helpers',
          subtitle: 'Methods for breakpoint-based value selection',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildResponsiveHelpersSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Adaptive Helpers Section
        SectionHeader(
          title: 'Adaptive Helpers',
          subtitle: 'Platform-based value selection',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildAdaptiveHelpersSection(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildScreenInfoSection() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: _ExtensionCategory(
            title: 'Screen Dimensions',
            extensions: [
              _ExtensionItem(
                name: 'context.screenWidth',
                value: '${context.screenWidth.toStringAsFixed(1)}',
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.screenHeight',
                value: '${context.screenHeight.toStringAsFixed(1)}',
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.screenSize',
                value:
                    '${context.screenSize.width.toInt()} x ${context.screenSize.height.toInt()}',
                type: 'Size',
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: _ExtensionCategory(
            title: 'Display Properties',
            extensions: [
              _ExtensionItem(
                name: 'context.devicePixelRatio',
                value: context.devicePixelRatio.toStringAsFixed(2),
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.textScaleFactor',
                value: context.textScaleFactor.toStringAsFixed(2),
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.aspectRatio',
                value: context.aspectRatio.toStringAsFixed(2),
                type: 'double',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrientationSection() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: _ExtensionCategory(
            title: 'Orientation Checks',
            extensions: [
              _ExtensionItem(
                name: 'context.isPortrait',
                value: context.isPortrait.toString(),
                type: 'bool',
                isActive: context.isPortrait,
              ),
              _ExtensionItem(
                name: 'context.isLandscape',
                value: context.isLandscape.toString(),
                type: 'bool',
                isActive: context.isLandscape,
              ),
              _ExtensionItem(
                name: 'context.orientation',
                value: context.orientation.name,
                type: 'Orientation',
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: CodePreview(
            code: '''// Check orientation
if (context.isPortrait) {
  return PortraitLayout();
}

if (context.isLandscape) {
  return LandscapeLayout();
}

// Get orientation enum
final orientation = context.orientation;
// Orientation.portrait or Orientation.landscape''',
            title: 'orientation_example.dart',
          ),
        ),
      ],
    );
  }

  Widget _buildBreakpointSection() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: _ExtensionCategory(
            title: 'Exact Breakpoint Checks',
            extensions: [
              _ExtensionItem(
                name: 'context.isWatch',
                value: context.isWatch.toString(),
                type: 'bool',
                isActive: context.isWatch,
              ),
              _ExtensionItem(
                name: 'context.isMobile',
                value: context.isMobile.toString(),
                type: 'bool',
                isActive: context.isMobile,
              ),
              _ExtensionItem(
                name: 'context.isTablet',
                value: context.isTablet.toString(),
                type: 'bool',
                isActive: context.isTablet,
              ),
              _ExtensionItem(
                name: 'context.isDesktop',
                value: context.isDesktop.toString(),
                type: 'bool',
                isActive: context.isDesktop,
              ),
              _ExtensionItem(
                name: 'context.isTv',
                value: context.isTv.toString(),
                type: 'bool',
                isActive: context.isTv,
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: _ExtensionCategory(
            title: 'Range Checks',
            extensions: [
              _ExtensionItem(
                name: 'context.isMobileOrSmaller',
                value: context.isMobileOrSmaller.toString(),
                type: 'bool',
                isActive: context.isMobileOrSmaller,
                description: 'watch or mobile',
              ),
              _ExtensionItem(
                name: 'context.isTabletOrLarger',
                value: context.isTabletOrLarger.toString(),
                type: 'bool',
                isActive: context.isTabletOrLarger,
                description: 'tablet, desktop, or tv',
              ),
              _ExtensionItem(
                name: 'context.isDesktopOrLarger',
                value: context.isDesktopOrLarger.toString(),
                type: 'bool',
                isActive: context.isDesktopOrLarger,
                description: 'desktop or tv',
              ),
              _ExtensionItem(
                name: 'context.breakpoint',
                value: context.breakpoint.name,
                type: 'SmartBreakpoint',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformSection() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _ExtensionCategory(
            title: 'Operating System',
            extensions: [
              _ExtensionItem(
                name: 'context.isAndroid',
                value: context.isAndroid.toString(),
                type: 'bool',
                isActive: context.isAndroid,
              ),
              _ExtensionItem(
                name: 'context.isIOS',
                value: context.isIOS.toString(),
                type: 'bool',
                isActive: context.isIOS,
              ),
              _ExtensionItem(
                name: 'context.isMacOS',
                value: context.isMacOS.toString(),
                type: 'bool',
                isActive: context.isMacOS,
              ),
              _ExtensionItem(
                name: 'context.isWindows',
                value: context.isWindows.toString(),
                type: 'bool',
                isActive: context.isWindows,
              ),
              _ExtensionItem(
                name: 'context.isLinux',
                value: context.isLinux.toString(),
                type: 'bool',
                isActive: context.isLinux,
              ),
              _ExtensionItem(
                name: 'context.isWeb',
                value: context.isWeb.toString(),
                type: 'bool',
                isActive: context.isWeb,
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _ExtensionCategory(
            title: 'Platform Categories',
            extensions: [
              _ExtensionItem(
                name: 'context.isMobilePlatform',
                value: context.isMobilePlatform.toString(),
                type: 'bool',
                isActive: context.isMobilePlatform,
                description: 'Android or iOS',
              ),
              _ExtensionItem(
                name: 'context.isDesktopPlatform',
                value: context.isDesktopPlatform.toString(),
                type: 'bool',
                isActive: context.isDesktopPlatform,
                description: 'macOS, Windows, or Linux',
              ),
              _ExtensionItem(
                name: 'context.isApplePlatform',
                value: context.isApplePlatform.toString(),
                type: 'bool',
                isActive: context.isApplePlatform,
                description: 'iOS or macOS',
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 12,
          desktop: 4,
          child: _ExtensionCategory(
            title: 'Design System',
            extensions: [
              _ExtensionItem(
                name: 'context.usesMaterial',
                value: context.usesMaterial.toString(),
                type: 'bool',
                isActive: context.usesMaterial,
              ),
              _ExtensionItem(
                name: 'context.usesCupertino',
                value: context.usesCupertino.toString(),
                type: 'bool',
                isActive: context.usesCupertino,
              ),
              _ExtensionItem(
                name: 'context.platform',
                value: context.platform.name,
                type: 'SmartPlatform',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSafeAreaSection() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: _ExtensionCategory(
            title: 'Safe Area Padding',
            extensions: [
              _ExtensionItem(
                name: 'context.safeAreaTop',
                value: '${context.safeAreaTop.toStringAsFixed(1)}',
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.safeAreaBottom',
                value: '${context.safeAreaBottom.toStringAsFixed(1)}',
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.safeAreaLeft',
                value: '${context.safeAreaLeft.toStringAsFixed(1)}',
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.safeAreaRight',
                value: '${context.safeAreaRight.toStringAsFixed(1)}',
                type: 'double',
              ),
              _ExtensionItem(
                name: 'context.safeAreaHorizontal',
                value: '${context.safeAreaHorizontal.toStringAsFixed(1)}',
                type: 'double',
                description: 'left + right',
              ),
              _ExtensionItem(
                name: 'context.safeAreaVertical',
                value: '${context.safeAreaVertical.toStringAsFixed(1)}',
                type: 'double',
                description: 'top + bottom',
              ),
            ],
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: _ExtensionCategory(
            title: 'Safe Area Checks',
            extensions: [
              _ExtensionItem(
                name: 'context.hasSafeAreaPadding',
                value: context.hasSafeAreaPadding.toString(),
                type: 'bool',
                isActive: context.hasSafeAreaPadding,
              ),
              _ExtensionItem(
                name: 'context.hasTopSafeArea',
                value: context.hasTopSafeArea.toString(),
                type: 'bool',
                isActive: context.hasTopSafeArea,
                description: 'Notch or status bar',
              ),
              _ExtensionItem(
                name: 'context.hasBottomSafeArea',
                value: context.hasBottomSafeArea.toString(),
                type: 'bool',
                isActive: context.hasBottomSafeArea,
                description: 'Home indicator',
              ),
              _ExtensionItem(
                name: 'context.isKeyboardVisible',
                value: context.isKeyboardVisible.toString(),
                type: 'bool',
                isActive: context.isKeyboardVisible,
              ),
              _ExtensionItem(
                name: 'context.viewInsets.bottom',
                value: '${context.viewInsets.bottom.toStringAsFixed(1)}',
                type: 'double',
                description: 'Keyboard height',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveHelpersSection() {
    final examplePadding = context.responsive<double>(
      mobile: 16,
      tablet: 24,
      desktop: 32,
    );

    final exampleColumns = context.bp<int>(
      mobile: 1,
      tablet: 2,
      desktop: 4,
    );

    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: CodePreview(
            code: '''// Get breakpoint-specific values
final padding = context.responsive<double>(
  mobile: 16,
  tablet: 24,
  desktop: 32,
);

// Shorthand version
final columns = context.bp<int>(
  mobile: 1,
  tablet: 2,
  desktop: 4,
);

// Mobile vs other helper
final showSidebar = context.mobileOr<bool>(
  mobile: false,
  other: true,
);

// Desktop vs other helper
final maxWidth = context.desktopOr<double>(
  desktop: 1200,
  other: double.infinity,
);''',
            title: 'responsive_helpers.dart',
          ),
        ),
        SmartCol(
          mobile: 12,
          desktop: 6,
          child: Container(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
              border: Border.all(
                  color: context.borderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Values',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                _LiveValueRow(
                  label: 'context.responsive(mobile: 16, tablet: 24, desktop: 32)',
                  value: '${examplePadding.toInt()}',
                ),
                _LiveValueRow(
                  label: 'context.bp(mobile: 1, tablet: 2, desktop: 4)',
                  value: '$exampleColumns',
                ),
                _LiveValueRow(
                  label: 'context.mobileOr(mobile: false, other: true)',
                  value: '${context.mobileOr(mobile: false, other: true)}',
                ),
                _LiveValueRow(
                  label: 'context.desktopOr(desktop: 1200, other: infinity)',
                  value: context.isDesktopOrLarger ? '1200' : 'infinity',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdaptiveHelpersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodePreview(
          code: '''// Select values based on platform design system
final borderRadius = context.adaptive<double>(
  material: 4.0,
  cupertino: 8.0,
);

// Select widgets based on platform
final button = context.adaptiveWidget(
  material: ElevatedButton(
    onPressed: () {},
    child: Text('Material Button'),
  ),
  cupertino: CupertinoButton(
    onPressed: () {},
    child: Text('Cupertino Button'),
  ),
);''',
          title: 'adaptive_helpers.dart',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        Container(
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border:
                Border.all(color: context.borderColor.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18,
                color: PlaygroundTheme.info,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Current design system: ${context.usesMaterial ? "Material" : "Cupertino"}',
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExtensionCategory extends StatelessWidget {
  const _ExtensionCategory({
    required this.title,
    required this.extensions,
  });

  final String title;
  final List<_ExtensionItem> extensions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: context.borderColor.withValues(alpha: 0.3),
          ),
          ...extensions.asMap().entries.map((entry) {
            final isLast = entry.key == extensions.length - 1;
            return _ExtensionRow(
              item: entry.value,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _ExtensionItem {
  const _ExtensionItem({
    required this.name,
    required this.value,
    required this.type,
    this.isActive,
    this.description,
  });

  final String name;
  final String value;
  final String type;
  final bool? isActive;
  final String? description;
}

class _ExtensionRow extends StatelessWidget {
  const _ExtensionRow({
    required this.item,
    this.isLast = false,
  });

  final _ExtensionItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PlaygroundTheme.spaceMd,
        vertical: PlaygroundTheme.spaceSm,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: context.borderColor.withValues(alpha: 0.2),
                ),
              ),
      ),
      child: Row(
        children: [
          if (item.isActive != null) ...[
            Icon(
              item.isActive! ? Icons.check_circle : Icons.cancel_outlined,
              size: 14,
              color: item.isActive!
                  ? PlaygroundTheme.success
                  : context.textMutedColor.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: item.isActive == true
                        ? context.textPrimaryColor
                        : context.textSecondaryColor,
                  ),
                ),
                if (item.description != null)
                  Text(
                    item.description!,
                    style: TextStyle(
                      fontSize: 10,
                      color: context.textMutedColor,
                    ),
                  ),
              ],
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
              item.value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: context.textMutedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveValueRow extends StatelessWidget {
  const _LiveValueRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: PlaygroundTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: PlaygroundTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
