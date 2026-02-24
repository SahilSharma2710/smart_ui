# smartui — Product Requirements Document

## Vision
The "Tailwind CSS" of Flutter. A zero-config, declarative adaptive UI toolkit that makes responsive, platform-aware Flutter apps effortless.

## Problem Statement
Building responsive & adaptive UIs in Flutter is painful:
- MediaQuery boilerplate everywhere for breakpoints
- No unified breakpoint system across the app
- Platform-adaptive widgets require manual if/else (Material vs Cupertino)
- No design token system for consistent spacing/typography/colors
- Existing packages (sizer, flutter_screenutil, responsive_framework) only solve PART of the problem
- No single package combines: responsive layouts + adaptive widgets + design tokens + utilities

## Target Users
- Every Flutter developer building apps that run on multiple screen sizes
- Teams building cross-platform (iOS + Android + Web + Desktop) apps
- Developers who want Tailwind-like utility-first approach in Flutter

## Core Principles
1. **Zero config** — works out of the box with sensible defaults
2. **Declarative** — describe WHAT you want, not HOW to calculate it
3. **Composable** — mix and match any feature, no lock-in
4. **Pure Dart** — no native code, no code generation, no build_runner
5. **Lightweight** — only import what you use, tree-shakeable
6. **Customizable** — override any default (breakpoints, tokens, theme)

## Package Structure (Monorepo)
```
smartui/                    # Main package
├── lib/
│   ├── smartui.dart        # Barrel export
│   ├── src/
│   │   ├── core/
│   │   │   ├── breakpoints.dart       # Breakpoint definitions & detection
│   │   │   ├── smartui_config.dart   # Global configuration
│   │   │   └── platform_info.dart     # Platform detection utilities
│   │   ├── responsive/
│   │   │   ├── responsive_value.dart  # context.responsive() extension
│   │   │   ├── smart_layout.dart      # Breakpoint-driven layout switching
│   │   │   ├── responsive_grid.dart   # Responsive grid system (12-col)
│   │   │   ├── responsive_builder.dart # Builder with breakpoint info
│   │   │   └── responsive_visibility.dart # Show/hide by breakpoint
│   │   ├── adaptive/
│   │   │   ├── smart_scaffold.dart    # Adaptive scaffold (bottom nav / rail / drawer)
│   │   │   ├── smart_button.dart      # Material / Cupertino auto-switch
│   │   │   ├── smart_dialog.dart      # Adaptive dialogs
│   │   │   ├── smart_switch.dart      # Adaptive switch
│   │   │   ├── smart_slider.dart      # Adaptive slider
│   │   │   ├── smart_indicator.dart   # Adaptive progress indicator
│   │   │   └── smart_navigation.dart  # Bottom nav / nav rail / drawer auto
│   │   ├── tokens/
│   │   │   ├── spacing.dart           # Spacing tokens (xs, sm, md, lg, xl, 2xl)
│   │   │   ├── typography.dart        # Typography scale
│   │   │   ├── colors.dart            # Semantic color tokens
│   │   │   └── radius.dart            # Border radius tokens
│   │   ├── widgets/
│   │   │   ├── smart_padding.dart     # Token-based padding widget
│   │   │   ├── smart_gap.dart         # Responsive gap/spacer
│   │   │   ├── smart_text.dart        # Responsive text with auto-sizing
│   │   │   ├── smart_image.dart       # Responsive image with breakpoint sources
│   │   │   ├── smart_container.dart   # Responsive max-width container
│   │   │   └── smart_wrap.dart        # Intelligent responsive wrap
│   │   └── extensions/
│   │       ├── context_extensions.dart   # BuildContext extensions
│   │       ├── widget_extensions.dart    # Widget extensions (.responsive, .adaptive)
│   │       └── num_extensions.dart       # Number extensions (.sp, .w, .h)
│   └── smartui.dart
├── example/                 # Full example app
├── test/                    # Comprehensive tests
└── playground/              # Interactive web playground
```

## Feature Specifications

### 1. Breakpoint System
```dart
// Default breakpoints (customizable)
SmartBreakpoints(
  watch: 0,      // 0 - 299
  mobile: 300,   // 300 - 599
  tablet: 600,   // 600 - 899
  desktop: 900,  // 900 - 1199
  tv: 1200,      // 1200+
)

// Usage
SmartUi(
  breakpoints: SmartBreakpoints.custom(mobile: 320, tablet: 768, desktop: 1024),
  child: MyApp(),
)
```

### 2. Responsive Values
```dart
// Extension method on BuildContext
final fontSize = context.responsive<double>(
  mobile: 14,
  tablet: 16,
  desktop: 18,
);

// Shorthand for common types
final columns = context.responsiveInt(mobile: 1, tablet: 2, desktop: 3);
final padding = context.responsiveDouble(mobile: 16, tablet: 24, desktop: 32);

// With default fallback
final value = context.responsive(
  defaultValue: 16.0,
  tablet: 24.0,
  // mobile uses default, desktop uses tablet value
);
```

### 3. Smart Layout
```dart
SmartLayout(
  mobile: MobileHomeScreen(),
  tablet: TabletHomeScreen(),
  desktop: DesktopHomeScreen(),
  // Optional: custom builder for fine-grained control
  builder: (context, breakpoint, child) {
    return child; // child is the matched layout
  },
)
```

### 4. Responsive Grid (12-column)
```dart
SmartGrid(
  columns: 12,
  spacing: SmartSpacing.md,
  children: [
    SmartCol(
      mobile: 12,   // Full width on mobile
      tablet: 6,    // Half width on tablet
      desktop: 4,   // Third width on desktop
      child: ProductCard(),
    ),
    // ...
  ],
)
```

### 5. Adaptive Widgets
```dart
// Auto-detects platform and uses appropriate style
SmartButton(
  label: 'Save',
  onPressed: () {},
  // Uses ElevatedButton on Android, CupertinoButton on iOS
)

SmartScaffold(
  // BottomNavigationBar on mobile
  // NavigationRail on tablet
  // Full NavigationDrawer on desktop
  destinations: [...],
  body: content,
)

SmartSwitch(value: isDark, onChanged: (v) => ...)
// Material Switch on Android, CupertinoSwitch on iOS
```

### 6. Design Tokens
```dart
// Spacing
SmartPadding.all(SmartSpacing.md, child: ...)  // 16px
SmartPadding.symmetric(h: SmartSpacing.lg, v: SmartSpacing.sm, child: ...)
SmartGap.md()  // SizedBox with responsive height/width

// Typography
SmartText('Hello', style: SmartTypography.headlineLarge)
SmartText('Body', style: SmartTypography.bodyMedium)

// Can be customized globally
SmartUi(
  tokens: SmartTokens(
    spacing: SmartSpacingTokens(xs: 2, sm: 4, md: 8, lg: 16, xl: 24, xxl: 32),
    typography: SmartTypographyTokens(...),
  ),
  child: MyApp(),
)
```

### 7. Extensions
```dart
// Context extensions
context.breakpoint          // Current breakpoint enum
context.isMobile            // bool
context.isTablet            // bool  
context.isDesktop           // bool
context.screenWidth         // double
context.screenHeight        // double
context.isPortrait          // bool
context.isLandscape         // bool
context.platform            // SmartPlatform enum
context.isIOS               // bool
context.isAndroid            // bool
context.isWeb               // bool

// Widget extensions
myWidget.responsivePadding(mobile: 8, tablet: 16, desktop: 24)
myWidget.showOnly(SmartBreakpoint.desktop)
myWidget.hideOn(SmartBreakpoint.mobile)

// Num extensions
16.sp   // Scaled font size
100.w   // Percentage of screen width
50.h    // Percentage of screen height
```

### 8. Responsive Visibility
```dart
SmartVisible(
  visibleOn: [SmartBreakpoint.tablet, SmartBreakpoint.desktop],
  child: Sidebar(),
)

// Or widget extension
Sidebar().showOnly(SmartBreakpoint.desktop)
MobileNav().hideOn(SmartBreakpoint.desktop)
```

## Example App Requirements
- Show ALL features working together
- Home page with responsive grid of cards
- Adaptive navigation (bottom nav ↔ rail ↔ drawer)
- Settings page with adaptive widgets
- Dashboard with responsive columns
- Light/dark theme toggle
- Platform preview (see how it looks on iOS vs Android)

## Playground Requirements
- Web-deployable Flutter app
- Interactive breakpoint slider
- Live widget preview at different sizes
- Code snippets that copy to clipboard
- Hosted on GitHub Pages

## Quality Requirements
- 90%+ test coverage
- All public APIs documented with dartdoc
- README with animated GIFs/images showing responsiveness
- CHANGELOG following keep-a-changelog format
- Example app that works on all platforms
- Pub.dev score: 160/160
