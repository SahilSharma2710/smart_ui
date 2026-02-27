/// adaptive_kit - The Tailwind CSS of Flutter
///
/// A zero-config, declarative adaptive UI toolkit for responsive,
/// platform-aware Flutter apps.
///
/// ## Features
///
/// - **Responsive breakpoint system** - 5 breakpoints with cascading values
/// - **Adaptive widgets** - Material/Cupertino auto-switching
/// - **Design tokens** - Spacing, typography, radius, and themes
/// - **Animated transitions** - Smooth breakpoint changes
/// - **Sliver support** - Responsive slivers for CustomScrollView
/// - **Golden test helpers** - Test across all breakpoints
/// - **Convenient extensions** - BuildContext, Widget, and num extensions
///
/// ## Quick Start
///
/// ```dart
/// import 'package:adaptive_kit/adaptive_kit.dart';
///
/// // Use SmartApp for zero-config setup
/// SmartApp(
///   title: 'My App',
///   home: HomeScreen(),
/// )
///
/// // Or wrap with SmartUi for custom config
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
/// final columns = context.bp<int>(
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
/// // Animated layout switching
/// SmartLayout(
///   transition: SmartTransition.fadeSlide,
///   mobile: MobileView(),
///   desktop: DesktopView(),
/// )
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
export 'src/core/smart_app.dart';
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
export 'src/responsive/smart_sliver.dart';
export 'src/responsive/smart_wrap.dart';

// Testing
export 'src/testing/test_helpers.dart';

// Tokens
export 'src/tokens/radius.dart';
export 'src/tokens/smart_theme.dart';
export 'src/tokens/spacing.dart';
export 'src/tokens/typography.dart';

// Widgets
export 'src/widgets/smart_container.dart';
export 'src/widgets/smart_form.dart';
export 'src/widgets/smart_gap.dart';
export 'src/widgets/smart_image.dart';
export 'src/widgets/smart_padding.dart';
export 'src/widgets/smart_safe_area.dart';
export 'src/widgets/smart_text.dart';
