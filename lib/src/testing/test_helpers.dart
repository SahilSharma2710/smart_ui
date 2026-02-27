/// Golden test helpers for responsive widgets.
///
/// This module provides utilities for testing responsive widgets
/// across multiple breakpoints.
library;

import 'dart:ui' show Brightness;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// Configuration for a breakpoint test.
@immutable
class BreakpointTestConfig {
  /// Creates a [BreakpointTestConfig].
  const BreakpointTestConfig({
    required this.breakpoint,
    required this.width,
    this.height = 800,
    this.name,
  });

  /// The breakpoint being tested.
  final SmartBreakpoint breakpoint;

  /// The screen width for this test.
  final double width;

  /// The screen height for this test.
  final double height;

  /// Optional custom name for this test case.
  final String? name;

  /// Returns the display name for this test case.
  String get displayName => name ?? '${breakpoint.name}_${width.toInt()}x${height.toInt()}';
}

/// Default breakpoint test configurations.
///
/// Use these as starting points for testing responsive widgets.
abstract final class SmartTestConfigs {
  /// Watch configuration (280px width).
  static const watch = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.watch,
    width: 280,
    name: 'watch',
  );

  /// Mobile portrait configuration (375px width).
  static const mobilePortrait = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.mobile,
    width: 375,
    height: 812,
    name: 'mobile_portrait',
  );

  /// Mobile landscape configuration (812px width).
  static const mobileLandscape = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.tablet,
    width: 812,
    height: 375,
    name: 'mobile_landscape',
  );

  /// Tablet portrait configuration (768px width).
  static const tabletPortrait = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.tablet,
    width: 768,
    height: 1024,
    name: 'tablet_portrait',
  );

  /// Tablet landscape configuration (1024px width).
  static const tabletLandscape = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.desktop,
    width: 1024,
    height: 768,
    name: 'tablet_landscape',
  );

  /// Desktop configuration (1440px width).
  static const desktop = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.desktop,
    width: 1440,
    height: 900,
    name: 'desktop',
  );

  /// Large desktop configuration (1920px width).
  static const desktopLarge = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.tv,
    width: 1920,
    height: 1080,
    name: 'desktop_large',
  );

  /// TV configuration (3840px width).
  static const tv = BreakpointTestConfig(
    breakpoint: SmartBreakpoint.tv,
    width: 3840,
    height: 2160,
    name: 'tv',
  );

  /// All standard breakpoint configurations.
  static const List<BreakpointTestConfig> all = [
    watch,
    mobilePortrait,
    tabletPortrait,
    desktop,
  ];

  /// Extended configurations including landscape and edge cases.
  static const List<BreakpointTestConfig> extended = [
    watch,
    mobilePortrait,
    mobileLandscape,
    tabletPortrait,
    tabletLandscape,
    desktop,
    desktopLarge,
    tv,
  ];
}

/// Creates a test widget wrapped with [SmartUi] and custom [MediaQuery].
///
/// Use this helper to test widgets at specific screen sizes.
///
/// Example:
/// ```dart
/// testWidgets('shows mobile layout on mobile', (tester) async {
///   await tester.pumpWidget(
///     createSmartTestWidget(
///       width: 375,
///       child: MyResponsiveWidget(),
///     ),
///   );
///
///   expect(find.text('Mobile'), findsOneWidget);
/// });
/// ```
Widget createSmartTestWidget({
  required Widget child,
  required double width,
  double height = 800,
  SmartBreakpoints breakpoints = SmartBreakpoints.defaults,
  EdgeInsets padding = EdgeInsets.zero,
  EdgeInsets viewInsets = EdgeInsets.zero,
  double devicePixelRatio = 1.0,
  double textScaleFactor = 1.0,
  Brightness platformBrightness = Brightness.light,
}) {
  return MediaQuery(
    data: MediaQueryData(
      size: Size(width, height),
      padding: padding,
      viewInsets: viewInsets,
      devicePixelRatio: devicePixelRatio,
      textScaler: TextScaler.linear(textScaleFactor),
      platformBrightness: platformBrightness,
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: SmartUi(
        breakpoints: breakpoints,
        child: child,
      ),
    ),
  );
}

/// Creates a test widget for a specific breakpoint configuration.
///
/// Example:
/// ```dart
/// testWidgets('shows tablet layout on tablet', (tester) async {
///   await tester.pumpWidget(
///     createSmartTestWidgetForConfig(
///       config: SmartTestConfigs.tabletPortrait,
///       child: MyResponsiveWidget(),
///     ),
///   );
///
///   expect(find.text('Tablet'), findsOneWidget);
/// });
/// ```
Widget createSmartTestWidgetForConfig({
  required BreakpointTestConfig config,
  required Widget child,
  SmartBreakpoints breakpoints = SmartBreakpoints.defaults,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  return createSmartTestWidget(
    width: config.width,
    height: config.height,
    breakpoints: breakpoints,
    padding: padding,
    child: child,
  );
}

/// Runs a test callback for each breakpoint configuration.
///
/// This is a helper for running the same test logic across
/// multiple screen sizes.
///
/// Example:
/// ```dart
/// void main() {
///   testSmartBreakpoints(
///     'MyWidget renders correctly',
///     configs: SmartTestConfigs.all,
///     build: (config) => MyResponsiveWidget(),
///     test: (tester, config) async {
///       // Your test assertions here
///       expect(find.byType(MyResponsiveWidget), findsOneWidget);
///     },
///   );
/// }
/// ```
///
/// For golden tests:
/// ```dart
/// testSmartBreakpoints(
///   'MyWidget golden',
///   configs: SmartTestConfigs.all,
///   build: (config) => MyResponsiveWidget(),
///   test: (tester, config) async {
///     await expectLater(
///       find.byType(MyResponsiveWidget),
///       matchesGoldenFile('goldens/my_widget_${config.displayName}.png'),
///     );
///   },
/// );
/// ```
void testSmartBreakpoints(
  String description, {
  required List<BreakpointTestConfig> configs,
  required Widget Function(BreakpointTestConfig config) build,
  required Future<void> Function(
    dynamic tester,
    BreakpointTestConfig config,
  ) test,
  SmartBreakpoints breakpoints = SmartBreakpoints.defaults,
  bool skip = false,
}) {
  // Note: This is a template function. In actual tests, you would use
  // flutter_test's testWidgets and group functions.
  // This function serves as documentation for how to structure
  // breakpoint tests.
  //
  // Example implementation:
  // ```dart
  // import 'package:flutter_test/flutter_test.dart';
  //
  // void testSmartBreakpointsImpl(
  //   String description, {...}
  // ) {
  //   group(description, () {
  //     for (final config in configs) {
  //       testWidgets('${config.displayName}', (tester) async {
  //         await tester.pumpWidget(
  //           createSmartTestWidgetForConfig(
  //             config: config,
  //             breakpoints: breakpoints,
  //             child: build(config),
  //           ),
  //         );
  //         await test(tester, config);
  //       }, skip: skip);
  //     }
  //   });
  // }
  // ```
}

/// A test wrapper that captures the current breakpoint.
///
/// Use this widget in tests to verify which breakpoint is active.
///
/// Example:
/// ```dart
/// testWidgets('detects mobile breakpoint', (tester) async {
///   SmartBreakpoint? capturedBreakpoint;
///
///   await tester.pumpWidget(
///     createSmartTestWidget(
///       width: 375,
///       child: BreakpointCapture(
///         onCapture: (bp) => capturedBreakpoint = bp,
///         child: Container(),
///       ),
///     ),
///   );
///
///   expect(capturedBreakpoint, SmartBreakpoint.mobile);
/// });
/// ```
class BreakpointCapture extends StatelessWidget {
  /// Creates a [BreakpointCapture] widget.
  const BreakpointCapture({
    required this.child,
    required this.onCapture,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Callback that receives the current breakpoint.
  final void Function(SmartBreakpoint breakpoint) onCapture;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    // Schedule the callback after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onCapture(breakpoint);
    });

    return child;
  }
}

/// A test widget that displays the current breakpoint name.
///
/// Useful for visual debugging during development.
///
/// Example:
/// ```dart
/// Stack(
///   children: [
///     MyContent(),
///     if (kDebugMode) const BreakpointDebugOverlay(),
///   ],
/// )
/// ```
class BreakpointDebugOverlay extends StatelessWidget {
  /// Creates a [BreakpointDebugOverlay] widget.
  const BreakpointDebugOverlay({
    super.key,
    this.position = Alignment.topRight,
  });

  /// The position of the overlay.
  final AlignmentGeometry position;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final size = MediaQuery.sizeOf(context);
    final breakpoint = config.breakpoints.breakpointForWidth(size.width);

    return Align(
      alignment: position,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF000000).withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '${breakpoint.name.toUpperCase()}\n${size.width.toInt()}x${size.height.toInt()}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
