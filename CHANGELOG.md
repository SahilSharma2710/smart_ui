# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-02-27

### Added

- **SmartApp** - Zero-config MaterialApp wrapper that auto-configures SmartUi
  - `SmartApp` for Navigator-based apps
  - `SmartApp.router` for Router-based apps (go_router, auto_route, etc.)
  - `SmartCupertinoApp` and `SmartCupertinoApp.router` for Cupertino apps
  - Automatically wraps with SmartUi via MaterialApp.builder

- **SmartImage** - Responsive image widget with breakpoint-specific assets
  - Different images per breakpoint (mobile, tablet, desktop, etc.)
  - `SmartImage.asset()` for asset images with path strings
  - `SmartImage.network()` for network images with URLs
  - `SmartDecorationImage` for responsive background images
  - Cascading resolution (falls back to smaller breakpoint images)

- **SmartForm** - Responsive form layout with automatic column adjustment
  - Auto 1-column on mobile, 2-column on tablet, 3-column on desktop
  - `SmartFormField` with span support for multi-column fields
  - `SmartFormRow` for custom row layouts
  - `SmartFormSection` with title, description, and grouped fields
  - Customizable column counts per breakpoint

- **SmartSliver widgets** - Responsive slivers for CustomScrollView
  - `SmartSliverGrid` with breakpoint-based column counts
  - `SmartSliverGrid.builder` for lazy grid building
  - `SmartSliverGridExtent` for max extent-based grids
  - `SliverSmartPadding` for responsive sliver padding
  - `SliverSmartVisible` for breakpoint-conditional slivers
  - `SliverSmartList` with different builders per breakpoint

- **SmartWrap** - Responsive Wrap with maxItemsPerRow per breakpoint
  - `SmartWrap.spaced()` with token-based spacing
  - `fillRow` option to expand items to fill available width
  - `SmartChipWrap` for chip/tag layouts with selection support

- **Animated Breakpoint Transitions** - Smooth transitions when breakpoints change
  - `SmartTransition` enum: none, fade, fadeSlide, crossFade, scale
  - `transition`, `transitionDuration`, `transitionCurve` on SmartLayout
  - `transitionBuilder` for custom animations on SmartLayout
  - Same transition options on SmartVisible
  - AnimatedSwitcher integration with proper keying

- **SmartTheme** - Breakpoint-aware design token system
  - `SmartTheme` widget for providing responsive theme data
  - `SmartThemeData` with typography, spacing, padding, radius, and layout tokens
  - Pre-built themes: `SmartThemeData.mobile`, `.tablet`, `.desktop`
  - `SmartThemeData.lerp()` for animated theme transitions
  - Custom tokens via `customTokens` map and `token<T>()` accessor
  - `context.smartTheme` extension for easy access

- **SmartSafeArea** - Responsive safe area wrapper
  - Per-breakpoint control of safe area edges
  - `SmartSafeArea.mobileOnly()` - safe area only on mobile
  - `SmartSafeArea.topOnlyMobile()` - top safe area only on mobile
  - `SliverSmartSafeArea` for slivers
  - New context extensions: `safeAreaTop`, `safeAreaBottom`, `safeAreaLeft`, `safeAreaRight`
  - `safeAreaHorizontal`, `safeAreaVertical`, `hasSafeAreaPadding`, `hasTopSafeArea`, `hasBottomSafeArea`

- **Golden Test Helpers** - Utilities for testing responsive widgets
  - `BreakpointTestConfig` for defining test configurations
  - `SmartTestConfigs` with pre-built configs (watch, mobile, tablet, desktop, tv)
  - `createSmartTestWidget()` helper for widget tests
  - `createSmartTestWidgetForConfig()` for config-based tests
  - `testSmartBreakpoints()` template for multi-breakpoint testing
  - `BreakpointCapture` widget for capturing current breakpoint in tests
  - `BreakpointDebugOverlay` for visual debugging

- **New Context Extensions**
  - `context.adaptive<T>(material:, cupertino:)` - platform-based value selection
  - `context.adaptiveWidget(material:, cupertino:)` - platform-based widget selection
  - `context.showOnly(breakpoints:, child:)` - show widget on specific breakpoints
  - `context.hideOn(breakpoints:, child:)` - hide widget on specific breakpoints
  - `context.bp<T>()` - shorter alias for responsive value selection
  - `context.mobileOr<T>(mobile:, other:)` - mobile vs non-mobile value
  - `context.desktopOr<T>(desktop:, other:)` - desktop vs non-desktop value

### Changed

- **BREAKING**: Minimum Flutter version is now 3.10.0
- Improved documentation throughout all public APIs
- Enhanced cascading logic for better breakpoint fallbacks

### Fixed

- Consistent patterns across all responsive widgets
- Better null safety handling in cascading resolution

## [1.1.3] - 2025-02-24

### Fixed
- Fixed all deprecated API warnings for Flutter 3.32+ (activeColor, groupValue, onChanged in SmartRadio)
- Added big dashboard button to README
- Full 160/160 pub points compliance

## [1.0.2] - 2025-02-24

### Added
- **Interactive Dashboard Example App**
  - 8 demo pages showcasing all package features
  - Home/Overview with feature grid and quick stats
  - Breakpoints Demo with live breakpoint detection
  - Responsive Layout Demo with SmartLayout examples
  - Responsive Grid Demo with interactive sliders
  - Adaptive Widgets Demo with all SmartButton, SmartSwitch, SmartDialog variants
  - Design Tokens Demo with typography, spacing, and radius scales
  - Visibility Demo with SmartVisible and shortcut widgets
  - Extensions Demo with context, widget, and number extensions
  - Dark/Light theme toggle
  - Responsive design using adaptive_kit itself

### Changed
- **README.md completely rewritten**
  - Added comparison table with other packages
  - Added before/after code examples
  - Added comprehensive feature documentation
  - Added dashboard preview section
  - Improved code examples with adaptive_kit naming

### Fixed
- Updated all code examples to use `adaptive_kit` instead of `smartui`
- Fixed import paths in documentation

## [1.0.1] - 2025-02-24

### Fixed
- Added web support with conditional dart:io imports
- Fixed repository and homepage URLs to point to correct GitHub repo
- Fixed lint warnings for pub.dev compliance
- Updated SDK constraint to ^3.7.0

## [1.0.0] - 2025-02-24

### Changed
- **Package renamed from `smartui` to `adaptive_kit`** for pub.dev availability
- Complete API rewrite with improved design
- Zero dependencies (only Flutter SDK)
- Comprehensive test coverage

### Added

- **Core Module**
  - `SmartBreakpoint` enum with watch, mobile, tablet, desktop, and tv breakpoints
  - `SmartBreakpoints` class for customizable breakpoint configuration
  - `SmartUi` widget for global configuration with InheritedWidget
  - `SmartPlatform` enum and platform detection utilities

- **Responsive Module**
  - `context.responsive<T>()` extension for breakpoint-based values
  - `context.responsiveInt()`, `context.responsiveDouble()`, `context.responsiveBool()`
  - `context.responsivePadding()` for responsive EdgeInsets
  - `SmartLayout` widget for breakpoint-driven layout switching
  - `SmartGrid` and `SmartCol` for 12-column responsive grid system
  - `ResponsiveBuilder` widget with comprehensive breakpoint information
  - `BreakpointBuilder` for simple breakpoint access
  - `BreakpointObserver` that only rebuilds on breakpoint changes
  - `SmartVisible` widget for conditional visibility by breakpoint
  - `MobileOnly`, `TabletOnly`, `DesktopOnly` convenience widgets
  - `HideOnMobile`, `HideOnDesktop` convenience widgets

- **Tokens Module**
  - `SmartSpacing` constants (zero, xs, sm, md, lg, xl, xxl)
  - `SmartSpacingTokens` for custom spacing configuration
  - `SmartTypography` scale with 15 text styles (display, headline, title, body, label)
  - `SmartRadius` tokens (none, xs, sm, md, lg, xl, xxl, full)
  - `RadiusSize` enum with `.borderRadius` and `.value` getters

- **Widgets Module**
  - `SmartPadding` with `.all()`, `.symmetric()`, `.only()`, `.responsive()` constructors
  - `SmartHorizontalPadding`, `SmartVerticalPadding` convenience widgets
  - `SmartGap` with `.xs()`, `.sm()`, `.md()`, `.lg()`, `.xl()`, `.xxl()`, `.responsive()`
  - `VGap`, `HGap` for vertical and horizontal gaps
  - `SmartText` with `.responsive()` constructor for breakpoint-based typography
  - `DisplayText`, `HeadlineText`, `BodyText`, `LabelText` convenience widgets
  - `SmartContainer` with `.sm()`, `.md()`, `.lg()`, `.xl()`, `.xxl()`, `.fluid()`, `.responsive()`
  - `ResponsivePaddedContainer`, `CenteredContent` convenience widgets
  - `SmartRow` for rows with token-based spacing

- **Adaptive Module**
  - `SmartScaffold` with auto-switching navigation (bottom nav on mobile, rail on tablet, drawer on desktop)
  - `SmartAppScaffold` for simple scaffold without navigation
  - `SmartDestination` for navigation destinations with badges
  - `SmartNavigation` for standalone adaptive navigation
  - `SmartNavItem` for navigation items
  - `SmartButton` with `.filled()`, `.text()`, `.outlined()` variants
  - `SmartIconButton` for icon buttons
  - `SmartSwitch` for adaptive toggle switches
  - `SmartCheckbox` for adaptive checkboxes
  - `SmartRadio<T>` for adaptive radio buttons
  - `showSmartDialog()` for adaptive alert dialogs
  - `showSmartConfirmDialog()` for adaptive confirmation dialogs
  - `showSmartBottomSheet()` for adaptive bottom sheets
  - `showSmartActionSheet()` for adaptive action sheets
  - `SmartDialogAction`, `SmartSheetAction` for dialog/sheet actions
  - `SmartIndicator` for circular progress (determinate and indeterminate)
  - `SmartLinearIndicator` for linear progress
  - `SmartLoadingOverlay` for loading states
  - `SmartRefreshIndicator` for pull-to-refresh
  - `SmartTabBar` for adaptive tab bars
  - `SmartBreadcrumbs` for navigation breadcrumbs

- **Extensions Module**
  - **Context extensions:**
    - Screen: `.screenWidth`, `.screenHeight`, `.screenSize`, `.devicePixelRatio`, `.textScaleFactor`
    - Orientation: `.isPortrait`, `.isLandscape`, `.orientation`, `.aspectRatio`
    - Breakpoints: `.breakpoint`, `.isWatch`, `.isMobile`, `.isTablet`, `.isDesktop`, `.isTv`
    - Breakpoint ranges: `.isMobileOrSmaller`, `.isTabletOrLarger`, `.isDesktopOrLarger`
    - Platform: `.platform`, `.isAndroid`, `.isIOS`, `.isMacOS`, `.isWindows`, `.isLinux`, `.isWeb`
    - Platform groups: `.isMobilePlatform`, `.isDesktopPlatform`, `.isApplePlatform`
    - Design system: `.usesMaterial`, `.usesCupertino`
    - Safe areas: `.safeAreaPadding`, `.viewPadding`, `.viewInsets`, `.isKeyboardVisible`
    - Config: `.smartUiConfig`, `.breakpoints`
  - **Widget extensions:**
    - Visibility: `.showOnly()`, `.hideOn()`, `.showOnMobile()`, `.showOnTablet()`, `.showOnDesktop()`, `.hideOnMobile()`, `.hideOnDesktop()`
    - Padding: `.responsivePadding()`, `.withPadding()`, `.withSymmetricPadding()`, `.withPaddingOnly()`, `.padded()`, `.paddedAll()`, `.paddedSymmetric()`, `.paddedHorizontal()`, `.paddedVertical()`
    - Layout: `.centered()`, `.expanded()`, `.flexible()`, `.sized()`, `.constrained()`, `.aligned()`
    - Decoration: `.clipped()`, `.decorated()`, `.opacity()`
    - Gestures: `.onTap()`, `.inkWell()`
    - Safe area: `.safeArea()`
    - Scrolling: `.scrollable()`
  - **Number extensions:**
    - Scaled sizing: `.w`, `.h`, `.sp` (with SmartSize initialization)
    - Screen percentage: `.sw`, `.sh`
    - Spacing: `.horizontalSpace`, `.verticalSpace`, `.horizontalSpaceScaled`, `.verticalSpaceScaled`
    - Padding: `.paddingAll`, `.paddingHorizontal`, `.paddingVertical`, `.paddingLeft`, `.paddingRight`, `.paddingTop`, `.paddingBottom`
    - Decoration: `.borderRadius`, `.radius`
    - Duration: `.ms`, `.seconds`, `.minutes`

### Documentation
- Comprehensive README with comparison table and code examples
- Interactive example app with 8 demo pages
- Full API documentation for all public classes and methods

## [0.1.0] - 2024-01-01

### Added
- Initial release with basic responsive utilities
- Basic breakpoint detection
- Simple responsive widgets
