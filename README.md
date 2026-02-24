# adaptive_kit

[![pub package](https://img.shields.io/pub/v/adaptive_kit.svg)](https://pub.dev/packages/adaptive_kit)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

**The Tailwind CSS of Flutter** - A zero-config, declarative adaptive UI toolkit for responsive, platform-aware Flutter apps.

## Why adaptive_kit?

Building responsive & adaptive UIs in Flutter is painful:
- MediaQuery boilerplate everywhere for breakpoints
- No unified breakpoint system across the app
- Platform-adaptive widgets require manual if/else (Material vs Cupertino)
- No design token system for consistent spacing/typography

**adaptive_kit solves all of this in one package.**

### Before vs After

**Before (vanilla Flutter):**
```dart
// Responsive values - verbose!
final columns = MediaQuery.of(context).size.width > 900
    ? 4
    : MediaQuery.of(context).size.width > 600
        ? 2
        : 1;

// Platform checks everywhere
Widget build(BuildContext context) {
  if (Platform.isIOS) {
    return CupertinoButton(...);
  }
  return ElevatedButton(...);
}

// Inconsistent spacing
Padding(padding: EdgeInsets.all(16.0), ...)  // magic numbers
```

**After (with smartui):**
```dart
// Responsive values - declarative!
final columns = context.responsive<int>(
  mobile: 1,
  tablet: 2,
  desktop: 4,
);

// Auto platform adaptation
SmartButton(onPressed: () {}, child: Text('Save'))

// Design tokens
SmartPadding.all(SpacingSize.md, child: ...)
```

## Features

- **Responsive Breakpoints** - Mobile, tablet, desktop detection with customizable thresholds
- **Responsive Values** - `context.responsive<T>()` for breakpoint-based values
- **Responsive Grid** - 12-column grid system like Bootstrap
- **Adaptive Widgets** - Auto Material/Cupertino switching (buttons, switches, dialogs)
- **Adaptive Navigation** - Bottom nav on mobile, rail on tablet, drawer on desktop
- **Design Tokens** - Spacing, typography, and radius constants
- **Extensions** - Convenient context, widget, and num extensions
- **Zero Dependencies** - Only Flutter SDK, fully tree-shakeable

## Quick Start

### 1. Install

```yaml
dependencies:
  adaptive_kit: ^0.1.0
```

### 2. Wrap Your App (Optional)

```dart
import 'package:adaptive_kit/smartui.dart';

void main() {
  runApp(
    SmartUi(
      // Custom breakpoints (optional)
      breakpoints: SmartBreakpoints.custom(
        mobile: 320,
        tablet: 768,
        desktop: 1024,
      ),
      child: MyApp(),
    ),
  );
}
```

### 3. Use It!

```dart
// Check breakpoints
if (context.isMobile) {
  return MobileLayout();
}

// Responsive values
final fontSize = context.responsive<double>(
  mobile: 14,
  tablet: 16,
  desktop: 18,
);

// Design tokens
SmartPadding.all(SpacingSize.md, child: Text('Hello'))
```

## Responsive Features

### Breakpoint Detection

```dart
// Boolean checks
context.isMobile      // true on mobile
context.isTablet      // true on tablet
context.isDesktop     // true on desktop
context.isTabletOrLarger   // true on tablet, desktop, tv
context.isMobileOrSmaller  // true on watch, mobile

// Get current breakpoint
final breakpoint = context.breakpoint; // SmartBreakpoint.tablet
```

### Responsive Values

```dart
// Generic responsive value
final columns = context.responsive<int>(
  mobile: 1,
  tablet: 2,
  desktop: 4,
);

// Convenience methods
final padding = context.responsiveDouble(mobile: 8, tablet: 16, desktop: 24);
final showSidebar = context.responsiveBool(mobile: false, tablet: true);
final edges = context.responsivePadding(
  mobile: EdgeInsets.all(8),
  tablet: EdgeInsets.all(16),
);
```

### SmartLayout

Switch entire layouts based on breakpoint:

```dart
SmartLayout(
  mobile: MobileHomeScreen(),
  tablet: TabletHomeScreen(),
  desktop: DesktopHomeScreen(),
  builder: (context, breakpoint, child) {
    // Optional: wrap with animation
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: child,
    );
  },
)
```

### Responsive Grid

12-column grid system:

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
    // ... more columns
  ],
)
```

### Responsive Visibility

Show/hide widgets by breakpoint:

```dart
// Show only on desktop
SmartVisible(
  visibleOn: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
  child: Sidebar(),
)

// Hide on mobile
SmartVisible(
  hiddenOn: [SmartBreakpoint.mobile, SmartBreakpoint.watch],
  child: AdvancedOptions(),
)

// Convenience widgets
MobileOnly(child: BottomNav())
DesktopOnly(child: Sidebar())
HideOnMobile(child: DetailedView())

// Widget extensions
myWidget.showOnly([SmartBreakpoint.desktop])
myWidget.hideOn([SmartBreakpoint.mobile])
```

### ResponsiveBuilder

Get full breakpoint info:

```dart
ResponsiveBuilder(
  builder: (context, info) {
    return Text(
      'Breakpoint: ${info.breakpoint.name}\n'
      'Screen: ${info.screenWidth} x ${info.screenHeight}\n'
      'Portrait: ${info.isPortrait}'
    );
  },
)
```

## Adaptive Widgets

Widgets that automatically use Material on Android and Cupertino on iOS/macOS:

### SmartButton

```dart
SmartButton(
  onPressed: () {},
  child: Text('Save'),
)

SmartButton.filled(onPressed: () {}, child: Text('Primary'))
SmartButton.text(onPressed: () {}, child: Text('Text'))
SmartButton.outlined(onPressed: () {}, child: Text('Outlined'))

// Force specific style
SmartButton(forceCupertino: true, ...)
```

### SmartSwitch, SmartCheckbox, SmartRadio

```dart
SmartSwitch(
  value: isDarkMode,
  onChanged: (value) => setState(() => isDarkMode = value),
)

SmartCheckbox(value: isChecked, onChanged: (v) => ...)

SmartRadio<String>(
  value: 'option1',
  groupValue: selectedOption,
  onChanged: (value) => ...,
)
```

### SmartIndicator

```dart
// Indeterminate
SmartIndicator()

// Determinate (0.0 to 1.0)
SmartIndicator(value: 0.5)

// Linear
SmartLinearIndicator(value: 0.7)
```

### SmartDialog

```dart
// Alert dialog
showSmartDialog(
  context: context,
  title: 'Alert',
  content: 'Something happened!',
  actions: [
    SmartDialogAction(
      label: 'OK',
      onPressed: () => Navigator.pop(context),
    ),
  ],
);

// Confirm dialog
final confirmed = await showSmartConfirmDialog(
  context: context,
  title: 'Delete Item?',
  content: 'This cannot be undone.',
  isDestructive: true,
);
```

### SmartScaffold

Adaptive navigation that switches between bottom nav, rail, and drawer:

```dart
SmartScaffold(
  selectedIndex: _currentIndex,
  onDestinationSelected: (index) => setState(() => _currentIndex = index),
  destinations: [
    SmartDestination(icon: Icon(Icons.home), label: 'Home'),
    SmartDestination(icon: Icon(Icons.search), label: 'Search'),
    SmartDestination(icon: Icon(Icons.settings), label: 'Settings'),
  ],
  body: _pages[_currentIndex],
)
```

## Design Tokens

### Spacing

```dart
// Constants
SmartSpacing.xs   // 4px
SmartSpacing.sm   // 8px
SmartSpacing.md   // 16px
SmartSpacing.lg   // 24px
SmartSpacing.xl   // 32px
SmartSpacing.xxl  // 48px

// Widgets
SmartPadding.all(SpacingSize.md, child: ...)
SmartPadding.symmetric(horizontal: SpacingSize.lg, child: ...)

SmartGap.md()   // Adds 16px gap (auto horizontal/vertical)
VGap.lg()       // Vertical 24px gap
HGap.sm()       // Horizontal 8px gap

// Custom tokens
SmartUi(
  spacingTokens: SmartSpacingTokens(
    xs: 2, sm: 4, md: 8, lg: 16, xl: 24, xxl: 32,
  ),
  child: MyApp(),
)
```

### Typography

```dart
SmartText('Heading', style: TypographyStyle.headlineLarge)
SmartText('Body text', style: TypographyStyle.bodyMedium)

// All styles
TypographyStyle.displayLarge    // 57px
TypographyStyle.displayMedium   // 45px
TypographyStyle.displaySmall    // 36px
TypographyStyle.headlineLarge   // 32px
TypographyStyle.headlineMedium  // 28px
TypographyStyle.headlineSmall   // 24px
TypographyStyle.titleLarge      // 22px
TypographyStyle.titleMedium     // 16px
TypographyStyle.titleSmall      // 14px
TypographyStyle.bodyLarge       // 16px
TypographyStyle.bodyMedium      // 14px
TypographyStyle.bodySmall       // 12px
TypographyStyle.labelLarge      // 14px
TypographyStyle.labelMedium     // 12px
TypographyStyle.labelSmall      // 11px

// Responsive typography
SmartText.responsive(
  'Title',
  mobile: TypographyStyle.titleSmall,
  tablet: TypographyStyle.titleMedium,
  desktop: TypographyStyle.titleLarge,
)
```

### Border Radius

```dart
SmartRadius.none   // 0
SmartRadius.xs     // 2px
SmartRadius.sm     // 4px
SmartRadius.md     // 8px
SmartRadius.lg     // 12px
SmartRadius.xl     // 16px
SmartRadius.xxl    // 24px
SmartRadius.full   // 9999px (circular)

Container(
  decoration: BoxDecoration(
    borderRadius: SmartRadius.md,
  ),
)
```

## Extensions

### Context Extensions

```dart
// Screen dimensions
context.screenWidth
context.screenHeight
context.screenSize

// Orientation
context.isPortrait
context.isLandscape
context.aspectRatio

// Breakpoints
context.breakpoint       // SmartBreakpoint enum
context.isMobile
context.isTablet
context.isDesktop
context.isTabletOrLarger
context.isMobileOrSmaller

// Platform
context.platform         // SmartPlatform enum
context.isIOS
context.isAndroid
context.isWeb
context.isMobilePlatform
context.isDesktopPlatform
context.usesMaterial
context.usesCupertino

// Safe areas
context.safeAreaPadding
context.viewInsets
context.isKeyboardVisible
```

### Widget Extensions

```dart
// Visibility
myWidget.showOnly([SmartBreakpoint.desktop])
myWidget.hideOn([SmartBreakpoint.mobile])
myWidget.showOnMobile()
myWidget.showOnDesktop()
myWidget.hideOnMobile()

// Padding
myWidget.withPadding(SpacingSize.md)
myWidget.responsivePadding(mobile: EdgeInsets.all(8), tablet: EdgeInsets.all(16))
myWidget.paddedAll(16)
myWidget.paddedHorizontal(8)

// Layout
myWidget.centered()
myWidget.expanded()
myWidget.flexible()
myWidget.sized(width: 100, height: 50)
myWidget.constrained(maxWidth: 600)
myWidget.aligned(Alignment.topLeft)

// Decoration
myWidget.clipped(borderRadius: SmartRadius.md)
myWidget.opacity(0.5)

// Gestures
myWidget.onTap(() => print('tapped'))
myWidget.inkWell(onTap: () => print('tapped'))

// Safe area
myWidget.safeArea()

// Scrolling
myWidget.scrollable()
```

### Num Extensions

```dart
// Scaled sizes (requires SmartSizeInit)
100.w    // Scaled width
50.h     // Scaled height
16.sp    // Scaled text size

// Percentage of screen
50.sw    // 50% of screen width
25.sh    // 25% of screen height

// Spacing
16.horizontalSpace   // SizedBox(width: 16)
16.verticalSpace     // SizedBox(height: 16)

// EdgeInsets
16.paddingAll        // EdgeInsets.all(16)
16.paddingHorizontal // EdgeInsets.symmetric(horizontal: 16)

// BorderRadius
8.borderRadius       // BorderRadius.circular(8)

// Duration
300.ms               // Duration(milliseconds: 300)
2.seconds            // Duration(seconds: 2)
```

## Comparison

| Feature | smartui | sizer | flutter_screenutil | responsive_framework |
|---------|----------|-------|-------------------|---------------------|
| Breakpoint system | Yes | No | No | Yes |
| Responsive values | Yes | No | No | Limited |
| 12-column grid | Yes | No | No | No |
| Adaptive widgets | Yes | No | No | No |
| Design tokens | Yes | No | No | No |
| Platform detection | Yes | No | No | No |
| Scaled sizing | Yes | Yes | Yes | No |
| Zero dependencies | Yes | Yes | Yes | No |

## Default Breakpoints

| Breakpoint | Min Width |
|------------|-----------|
| watch | 0px |
| mobile | 300px |
| tablet | 600px |
| desktop | 900px |
| tv | 1200px |

Customize with:
```dart
SmartUi(
  breakpoints: SmartBreakpoints.custom(
    watch: 0,
    mobile: 320,
    tablet: 768,
    desktop: 1024,
    tv: 1440,
  ),
  child: MyApp(),
)
```

## Contributing

Contributions are welcome! Please read our contributing guidelines before submitting PRs.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

MIT License - see [LICENSE](LICENSE) for details.
