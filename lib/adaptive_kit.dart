/// smartui - The Tailwind CSS of Flutter
///
/// A zero-config, declarative adaptive UI toolkit for responsive,
/// platform-aware Flutter apps.
///
/// Features:
/// - Responsive breakpoint system
/// - Adaptive widgets (Material/Cupertino auto-switch)
/// - Design tokens for spacing, typography, and radius
/// - Convenient extensions for BuildContext, Widget, and num
///
/// ## Quick Start
///
/// ```dart
/// import 'package:adaptive_kit/adaptive_kit.dart';
///
/// // Wrap your app with SmartUi for custom config (optional)
/// SmartUi(
///   breakpoints: SmartBreakpoints.custom(
///     mobile: 320,
///     tablet: 768,
///     desktop: 1024,
///   ),
///   child: MaterialApp(...),
/// )
///
/// // Use responsive values
/// final columns = context.responsive<int>(
///   mobile: 1,
///   tablet: 2,
///   desktop: 4,
/// );
///
/// // Check breakpoints
/// if (context.isMobile) {
///   return MobileLayout();
/// }
///
/// // Use adaptive widgets
/// SmartButton(onPressed: () {}, child: Text('Save'));
/// SmartSwitch(value: isDark, onChanged: (v) => ...);
///
/// // Use design tokens
/// SmartPadding.all(SpacingSize.md, child: ...);
/// SmartGap.lg();
/// SmartText('Hello', style: TypographyStyle.headlineLarge);
/// ```
library;

// Adaptive
export 'src/adaptive/smart_button.dart';
export 'src/adaptive/smart_dialog.dart';
export 'src/adaptive/smart_indicator.dart';
export 'src/adaptive/smart_navigation.dart';
export 'src/adaptive/smart_scaffold.dart';
export 'src/adaptive/smart_switch.dart';

// Core
export 'src/core/breakpoints.dart';
export 'src/core/platform_info.dart';
export 'src/core/smart_ui_config.dart';

// Extensions
export 'src/extensions/context_extensions.dart';
export 'src/extensions/num_extensions.dart';
export 'src/extensions/widget_extensions.dart';

// Responsive
export 'src/responsive/responsive_builder.dart';
export 'src/responsive/responsive_grid.dart';
export 'src/responsive/responsive_value.dart';
export 'src/responsive/responsive_visibility.dart';
export 'src/responsive/smart_layout.dart';

// Tokens
export 'src/tokens/radius.dart';
export 'src/tokens/spacing.dart';
export 'src/tokens/typography.dart';

// Widgets
export 'src/widgets/smart_container.dart';
export 'src/widgets/smart_gap.dart';
export 'src/widgets/smart_padding.dart';
export 'src/widgets/smart_text.dart';
