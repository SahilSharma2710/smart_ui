import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../../theme/playground_theme.dart';
import '../../components/components.dart';

/// Documentation page for platform detection (SmartPlatformInfo).
class PlatformPage extends StatefulWidget {
  const PlatformPage({super.key});

  @override
  State<PlatformPage> createState() => _PlatformPageState();
}

class _PlatformPageState extends State<PlatformPage> {
  Color _getPlatformColor(SmartPlatform platform) {
    switch (platform) {
      case SmartPlatform.android:
        return const Color(0xFF3DDC84); // Android green
      case SmartPlatform.ios:
        return const Color(0xFF007AFF); // iOS blue
      case SmartPlatform.macos:
        return const Color(0xFF000000); // macOS black
      case SmartPlatform.windows:
        return const Color(0xFF0078D4); // Windows blue
      case SmartPlatform.linux:
        return const Color(0xFFFCC624); // Linux yellow
      case SmartPlatform.web:
        return const Color(0xFFFF5722); // Web orange
      case SmartPlatform.fuchsia:
        return const Color(0xFFE91E63); // Fuchsia pink
      case SmartPlatform.unknown:
        return Colors.grey;
    }
  }

  IconData _getPlatformIcon(SmartPlatform platform) {
    switch (platform) {
      case SmartPlatform.android:
        return Icons.android;
      case SmartPlatform.ios:
        return Icons.phone_iphone;
      case SmartPlatform.macos:
        return Icons.laptop_mac;
      case SmartPlatform.windows:
        return Icons.desktop_windows;
      case SmartPlatform.linux:
        return Icons.computer;
      case SmartPlatform.web:
        return Icons.language;
      case SmartPlatform.fuchsia:
        return Icons.devices_other;
      case SmartPlatform.unknown:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundPage(
      title: 'Platform Detection',
      subtitle:
          'Detect the running platform and build adaptive UIs with SmartPlatformInfo.',
      children: [
        // Current Platform Display
        _buildCurrentPlatformDisplay(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // All Platform Checks
        SectionHeader(
          title: 'Platform Checks',
          subtitle: 'Live detection results for the current platform',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildAllPlatformChecks(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Platform Categories
        SectionHeader(
          title: 'Platform Categories',
          subtitle: 'Group platforms by their characteristics',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildPlatformCategories(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Usage Examples
        SectionHeader(
          title: 'Usage Examples',
          subtitle: 'How to use platform detection in your code',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildUsageExamples(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // Adaptive Widgets Demo
        SectionHeader(
          title: 'Adaptive Helpers',
          subtitle: 'Build platform-adaptive UIs with context extensions',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildAdaptiveHelpers(),
        const SizedBox(height: PlaygroundTheme.spaceXl),

        // SmartPlatform Enum
        SectionHeader(
          title: 'SmartPlatform Enum',
          subtitle: 'All available platform values',
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        _buildPlatformEnumGrid(),
        const SizedBox(height: PlaygroundTheme.spaceXl),
      ],
    );
  }

  Widget _buildCurrentPlatformDisplay() {
    final platform = SmartPlatformInfo.current;
    final color = _getPlatformColor(platform);
    final icon = _getPlatformIcon(platform);

    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Platform',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  Text(
                    platform.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (platform.isMobile)
                _PlatformBadge(label: 'Mobile', color: PlaygroundTheme.mobileColor),
              if (platform.isDesktop)
                _PlatformBadge(label: 'Desktop', color: PlaygroundTheme.desktopColor),
              if (platform.isApple)
                _PlatformBadge(label: 'Apple', color: const Color(0xFF555555)),
              if (platform.usesMaterial)
                _PlatformBadge(label: 'Material', color: PlaygroundTheme.primary),
              if (platform.usesCupertino)
                _PlatformBadge(label: 'Cupertino', color: const Color(0xFF007AFF)),
              if (SmartPlatformInfo.isWeb)
                _PlatformBadge(label: 'Web', color: const Color(0xFFFF5722)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllPlatformChecks() {
    return SmartLayout(
      mobile: Column(
        children: [
          _buildPlatformChecksCard(),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _buildCategoryChecksCard(),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildPlatformChecksCard()),
          const SizedBox(width: PlaygroundTheme.spaceMd),
          Expanded(child: _buildCategoryChecksCard()),
        ],
      ),
    );
  }

  Widget _buildPlatformChecksCard() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
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
          Row(
            children: [
              Icon(
                Icons.devices,
                color: PlaygroundTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Individual Platforms',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isAndroid',
            shortLabel: 'context.isAndroid',
            value: SmartPlatformInfo.isAndroid,
            icon: Icons.android,
            color: const Color(0xFF3DDC84),
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isIOS',
            shortLabel: 'context.isIOS',
            value: SmartPlatformInfo.isIOS,
            icon: Icons.phone_iphone,
            color: const Color(0xFF007AFF),
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isMacOS',
            shortLabel: 'context.isMacOS',
            value: SmartPlatformInfo.isMacOS,
            icon: Icons.laptop_mac,
            color: const Color(0xFF555555),
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isWindows',
            shortLabel: 'context.isWindows',
            value: SmartPlatformInfo.isWindows,
            icon: Icons.desktop_windows,
            color: const Color(0xFF0078D4),
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isLinux',
            shortLabel: 'context.isLinux',
            value: SmartPlatformInfo.isLinux,
            icon: Icons.computer,
            color: const Color(0xFFFCC624),
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isWeb',
            shortLabel: 'context.isWeb',
            value: SmartPlatformInfo.isWeb,
            icon: Icons.language,
            color: const Color(0xFFFF5722),
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isFuchsia',
            shortLabel: 'context.isFuchsia',
            value: SmartPlatformInfo.isFuchsia,
            icon: Icons.devices_other,
            color: const Color(0xFFE91E63),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChecksCard() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
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
          Row(
            children: [
              Icon(
                Icons.category,
                color: PlaygroundTheme.accent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Platform Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isMobile',
            shortLabel: 'context.isMobilePlatform',
            value: SmartPlatformInfo.isMobile,
            icon: Icons.smartphone,
            color: PlaygroundTheme.mobileColor,
            description: 'Android or iOS',
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isDesktop',
            shortLabel: 'context.isDesktopPlatform',
            value: SmartPlatformInfo.isDesktop,
            icon: Icons.desktop_mac,
            color: PlaygroundTheme.desktopColor,
            description: 'macOS, Windows, or Linux',
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.isApple',
            shortLabel: 'context.isApplePlatform',
            value: SmartPlatformInfo.isApple,
            icon: Icons.apple,
            color: const Color(0xFF555555),
            description: 'iOS or macOS',
          ),
          const Divider(height: 24),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.usesMaterial',
            shortLabel: 'context.usesMaterial',
            value: SmartPlatformInfo.usesMaterial,
            icon: Icons.android,
            color: PlaygroundTheme.primary,
            description: 'Android only',
          ),
          _PlatformCheckRow(
            label: 'SmartPlatformInfo.usesCupertino',
            shortLabel: 'context.usesCupertino',
            value: SmartPlatformInfo.usesCupertino,
            icon: Icons.apple,
            color: const Color(0xFF007AFF),
            description: 'iOS or macOS',
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformCategories() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: [
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _CategoryCard(
            title: 'Mobile Platforms',
            subtitle: 'Touchscreen-first devices',
            platforms: ['Android', 'iOS'],
            icon: Icons.smartphone,
            color: PlaygroundTheme.mobileColor,
            isActive: SmartPlatformInfo.isMobile,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _CategoryCard(
            title: 'Desktop Platforms',
            subtitle: 'Mouse and keyboard devices',
            platforms: ['macOS', 'Windows', 'Linux'],
            icon: Icons.desktop_mac,
            color: PlaygroundTheme.desktopColor,
            isActive: SmartPlatformInfo.isDesktop,
          ),
        ),
        SmartCol(
          mobile: 12,
          tablet: 6,
          desktop: 4,
          child: _CategoryCard(
            title: 'Apple Platforms',
            subtitle: 'Cupertino design system',
            platforms: ['iOS', 'macOS'],
            icon: Icons.apple,
            color: const Color(0xFF555555),
            isActive: SmartPlatformInfo.isApple,
          ),
        ),
      ],
    );
  }

  Widget _buildUsageExamples() {
    return Column(
      children: [
        CodePreviewSplit(
          code: '''// Using SmartPlatformInfo directly
if (SmartPlatformInfo.isAndroid) {
  // Android-specific code
}

// Using context extensions
if (context.isIOS) {
  // iOS-specific code
}

// Get current platform enum
final platform = SmartPlatformInfo.current;
switch (platform) {
  case SmartPlatform.android:
    return MaterialButton(...);
  case SmartPlatform.ios:
    return CupertinoButton(...);
  default:
    return ElevatedButton(...);
}

// Category checks
if (context.isMobilePlatform) {
  // Show mobile-friendly UI
} else if (context.isDesktopPlatform) {
  // Show desktop UI with more features
}''',
          codeTitle: 'platform_detection.dart',
          preview: _buildPlatformDemoPreview(),
        ),
      ],
    );
  }

  Widget _buildPlatformDemoPreview() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Platform-Specific UI',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          Text(
            'Current platform: ${SmartPlatformInfo.current.name}',
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          context.adaptiveWidget(
            material: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.android),
              label: const Text('Material Button'),
            ),
            cupertino: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF007AFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.apple, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Cupertino Button',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdaptiveHelpers() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
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
          Text(
            'Adaptive Context Extensions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Text(
            'Use these helpers to build platform-adaptive UIs easily:',
            style: TextStyle(
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          CodePreview(
            code: '''// Return different values based on platform
final borderRadius = context.adaptive<double>(
  material: 4.0,   // For Android
  cupertino: 8.0,  // For iOS/macOS
);

// Return different widgets based on platform
context.adaptiveWidget(
  material: ElevatedButton(
    onPressed: onTap,
    child: Text('Submit'),
  ),
  cupertino: CupertinoButton.filled(
    onPressed: onTap,
    child: Text('Submit'),
  ),
)''',
            title: 'adaptive_helpers.dart',
          ),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          Row(
            children: [
              Expanded(
                child: _AdaptiveValueDemo(
                  label: 'Material Value',
                  value: '4.0',
                  isActive: SmartPlatformInfo.usesMaterial,
                  color: PlaygroundTheme.primary,
                ),
              ),
              const SizedBox(width: PlaygroundTheme.spaceMd),
              Expanded(
                child: _AdaptiveValueDemo(
                  label: 'Cupertino Value',
                  value: '8.0',
                  isActive: SmartPlatformInfo.usesCupertino,
                  color: const Color(0xFF007AFF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformEnumGrid() {
    return SmartGrid(
      spacing: SmartSpacing.md,
      children: SmartPlatform.values.map((platform) {
        final isCurrentPlatform = platform == SmartPlatformInfo.current;
        return SmartCol(
          mobile: 6,
          tablet: 4,
          desktop: 3,
          child: _PlatformEnumCard(
            platform: platform,
            icon: _getPlatformIcon(platform),
            color: _getPlatformColor(platform),
            isActive: isCurrentPlatform,
          ),
        );
      }).toList(),
    );
  }
}

class _PlatformBadge extends StatelessWidget {
  const _PlatformBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _PlatformCheckRow extends StatelessWidget {
  const _PlatformCheckRow({
    required this.label,
    required this.shortLabel,
    required this.value,
    required this.icon,
    required this.color,
    this.description,
  });

  final String label;
  final String shortLabel;
  final bool value;
  final IconData icon;
  final Color color;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: value
                  ? color.withValues(alpha: 0.15)
                  : context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Icon(
              icon,
              size: 16,
              color: value ? color : context.textMutedColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shortLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: value
                        ? context.textPrimaryColor
                        : context.textMutedColor,
                  ),
                ),
                if (description != null)
                  Text(
                    description!,
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
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: value
                  ? PlaygroundTheme.success.withValues(alpha: 0.15)
                  : context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Text(
              value ? 'true' : 'false',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: value
                    ? PlaygroundTheme.success
                    : context.textMutedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.platforms,
    required this.icon,
    required this.color,
    required this.isActive,
  });

  final String title;
  final String subtitle;
  final List<String> platforms;
  final IconData icon;
  final Color color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PlaygroundTheme.durationFast,
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: isActive
            ? color.withValues(alpha: 0.1)
            : context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: isActive
              ? color.withValues(alpha: 0.5)
              : context.borderColor.withValues(alpha: 0.5),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              const Spacer(),
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        BorderRadius.circular(PlaygroundTheme.radiusFull),
                  ),
                  child: Text(
                    'CURRENT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: platforms.map((p) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: context.surfaceElevatedColor,
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
              ),
              child: Text(
                p,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: context.textSecondaryColor,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _AdaptiveValueDemo extends StatelessWidget {
  const _AdaptiveValueDemo({
    required this.label,
    required this.value,
    required this.isActive,
    required this.color,
  });

  final String label;
  final String value;
  final bool isActive;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PlaygroundTheme.durationFast,
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: isActive
            ? color.withValues(alpha: 0.1)
            : context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
        border: Border.all(
          color: isActive
              ? color.withValues(alpha: 0.5)
              : context.borderColor.withValues(alpha: 0.3),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? color : context.textMutedColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              color: isActive ? color : context.textMutedColor,
            ),
          ),
          if (isActive) ...[
            const SizedBox(height: 4),
            Text(
              'Active',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlatformEnumCard extends StatelessWidget {
  const _PlatformEnumCard({
    required this.platform,
    required this.icon,
    required this.color,
    required this.isActive,
  });

  final SmartPlatform platform;
  final IconData icon;
  final Color color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PlaygroundTheme.durationFast,
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: isActive
            ? color.withValues(alpha: 0.1)
            : context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: isActive
              ? color.withValues(alpha: 0.5)
              : context.borderColor.withValues(alpha: 0.5),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: isActive ? color : context.textMutedColor,
          ),
          const SizedBox(height: 8),
          Text(
            platform.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? color : context.textSecondaryColor,
            ),
          ),
          if (isActive) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
              ),
              child: Text(
                'CURRENT',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
