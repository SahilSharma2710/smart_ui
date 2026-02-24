# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0+2] - 2026-02-24

### Changed
- Complete rewrite with improved API design
- Zero dependencies (only Flutter SDK)
- Comprehensive test coverage

## [0.1.0] - 2024-01-01

### Added

- **Core Module**
  - `SmartBreakpoint` enum with watch, mobile, tablet, desktop, and tv breakpoints
  - `SmartBreakpoints` class for customizable breakpoint configuration
  - `SmartUi` widget for global configuration with InheritedWidget
  - `SmartPlatform` enum and platform detection utilities

- **Responsive Module**
  - `context.responsive<T>()` extension for breakpoint-based values
  - `SmartLayout` widget for breakpoint-driven layout switching
  - `SmartGrid` and `SmartCol` for 12-column responsive grid system
  - `ResponsiveBuilder` widget with breakpoint information
  - `SmartVisible` widget for conditional visibility by breakpoint

- **Tokens Module**
  - `SmartSpacing` constants (xs, sm, md, lg, xl, xxl)
  - `SmartTypography` scale with responsive text styles
  - `SmartRadius` tokens for consistent border radii

- **Widgets Module**
  - `SmartPadding` for token-based padding
  - `SmartGap` for responsive spacing
  - `SmartText` for responsive typography
  - `SmartContainer` for responsive max-width containers

- **Adaptive Module**
  - `SmartScaffold` with auto-switching navigation (bottom nav / rail / drawer)
  - `SmartButton` for Material/Cupertino auto-switch
  - `SmartSwitch` for adaptive toggle switches
  - `SmartDialog` for adaptive dialogs
  - `SmartIndicator` for adaptive progress indicators
  - `SmartNavigation` for adaptive navigation patterns

- **Extensions Module**
  - Context extensions: `.isMobile`, `.isTablet`, `.isDesktop`, `.breakpoint`, etc.
  - Widget extensions: `.showOnly()`, `.hideOn()`, `.responsivePadding()`
  - Num extensions: `.sp`, `.w`, `.h` for responsive sizing

### Documentation

- Comprehensive README with examples and API reference
- Full example app demonstrating all features
