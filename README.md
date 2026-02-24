# adaptive_kit

[![pub package](https://img.shields.io/pub/v/adaptive_kit.svg)](https://pub.dev/packages/adaptive_kit)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-blue.svg)](https://flutter.dev)

**The Tailwind CSS of Flutter.** Zero-config adaptive UI toolkit with responsive breakpoints, platform-aware widgets, design tokens, and powerful extensions.

---

## Why adaptive_kit?

Building responsive & adaptive UIs in Flutter is painful:

| Problem | Solution |
|---------|----------|
| MediaQuery boilerplate everywhere | `context.responsive()` returns values per breakpoint |
| No unified breakpoint system | 5-tier system: watch, mobile, tablet, desktop, tv |
| Manual Material vs Cupertino checks | `SmartButton`, `SmartSwitch` auto-adapt to platform |
| Magic numbers for spacing | Design tokens: `SmartSpacing.md`, `SmartRadius.lg` |
| No grid system like Bootstrap | `SmartGrid` + `SmartCol` with 12-column layout |

### Before vs After

```dart
// BEFORE: Verbose MediaQuery checks
final columns = MediaQuery.of(context).size.width > 900
    ? 4 : MediaQuery.of(context).size.width > 600 ? 2 : 1;

// AFTER: Declarative responsive values
final columns = context.responsive<int>(mobile: 1, tablet: 2, desktop: 4);
```

```dart
// BEFORE: Platform checks everywhere
if (Platform.isIOS) {
  return CupertinoButton(child: Text('Save'), onPressed: () {});
}
return ElevatedButton(child: Text('Save'), onPressed: () {});

// AFTER: Auto platform adaptation
SmartButton(onPressed: () {}, child: Text('Save'))
```

```dart
// BEFORE: Magic numbers
Padding(padding: EdgeInsets.all(16.0), child: ...)

// AFTER: Design tokens
SmartPadding.all(SpacingSize.md, child: ...)
```

---

## Features

| Category | Features |
|----------|----------|
| **Responsive** | 5 breakpoints, `context.responsive()`, `SmartLayout`, `ResponsiveBuilder` |
| **Grid System** | 12-column `SmartGrid`, `SmartCol` with per-breakpoint spans |
| **Adaptive Widgets** | `SmartButton`, `SmartSwitch`, `SmartDialog`, `SmartScaffold` |
| **Design Tokens** | `SmartSpacing`, `SmartTypography`, `SmartRadius` |
| **Visibility** | `SmartVisible`, `MobileOnly`, `DesktopOnly`, `HideOnMobile` |
| **Extensions** | Context, Widget, and Number extensions |
| **Platform** | Auto Material/Cupertino, platform detection |

**Zero dependencies** - Only Flutter SDK, fully tree-shakeable.

---

## Quick Start

### 1. Install

```yaml
dependencies:
  adaptive_kit: ^1.0.1
```

### 2. Wrap Your App (Optional)

```dart
import 'package:adaptive_kit/adaptive_kit.dart';

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
// Responsive values
final columns = context.responsive<int>(mobile: 1, tablet: 2, desktop: 4);

// Breakpoint checks
if (context.isDesktop) {
  return DesktopLayout();
}

// Design tokens
SmartPadding.all(SpacingSize.md, child: MyWidget())
```

---

## Breakpoints

Five-tier responsive system with smart defaults:

| Breakpoint | Min Width | Use Case |
|------------|-----------|----------|
| `watch` | 0px | Wearables |
| `mobile` | 300px | Phones |
| `tablet` | 600px | Tablets |
| `desktop` | 900px | Laptops/Desktops |
| `tv` | 1200px | Large screens |

```dart
// Boolean checks
context.isMobile           // true on mobile
context.isTablet           // true on tablet
context.isDesktop          // true on desktop
context.isTabletOrLarger   // tablet, desktop, or tv
context.isMobileOrSmaller  // watch or mobile

// Get current breakpoint
final bp = context.breakpoint; // SmartBreakpoint.tablet
```

---

## Responsive Values

Get different values based on the current breakpoint:

```dart
// Generic
final columns = context.responsive<int>(
  mobile: 1,
  tablet: 2,
  desktop: 4,
);

// Convenience methods
final padding = context.responsiveDouble(mobile: 8, tablet: 16, desktop: 24);
final showSidebar = context.responsiveBool(mobile: false, desktop: true);
final edges = context.responsivePadding(
  mobile: EdgeInsets.all(8),
  tablet: EdgeInsets.all(16),
);
```

---

## SmartLayout

Switch entire layouts based on breakpoint:

```dart
SmartLayout(
  mobile: MobileHomeScreen(),
  tablet: TabletHomeScreen(),
  desktop: DesktopHomeScreen(),
  builder: (context, breakpoint, child) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: child,
    );
  },
)
```

---

## Responsive Grid

Bootstrap-style 12-column grid:

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
    SmartCol(
      mobile: 12,
      tablet: 6,
      desktop: 4,
      child: ProductCard(),
    ),
    SmartCol(
      mobile: 12,
      tablet: 6,
      desktop: 4,
      child: ProductCard(),
    ),
  ],
)
```

---

## Adaptive Widgets

Widgets that automatically use Material on Android and Cupertino on iOS/macOS:

### SmartButton

```dart
SmartButton(onPressed: () {}, child: Text('Default'))
SmartButton.filled(onPressed: () {}, child: Text('Filled'))
SmartButton.outlined(onPressed: () {}, child: Text('Outlined'))
SmartButton.text(onPressed: () {}, child: Text('Text'))

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
SmartIndicator()                    // Indeterminate
SmartIndicator(value: 0.5)          // 50% progress
SmartLinearIndicator(value: 0.7)    // Linear bar
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

Adaptive navigation: bottom nav on mobile, rail on tablet, drawer on desktop.

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

---

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

// Padding widget
SmartPadding.all(SpacingSize.md, child: ...)
SmartPadding.symmetric(horizontal: SpacingSize.lg, child: ...)

// Gap widgets
VGap.md()   // Vertical 16px gap
HGap.sm()   // Horizontal 8px gap
```

### Typography

```dart
SmartText('Heading', style: TypographyStyle.headlineLarge)
SmartText('Body text', style: TypographyStyle.bodyMedium)

// Responsive typography
SmartText.responsive(
  'Title',
  mobile: TypographyStyle.titleSmall,
  tablet: TypographyStyle.titleMedium,
  desktop: TypographyStyle.titleLarge,
)
```

| Style | Size |
|-------|------|
| `displayLarge` | 57px |
| `displayMedium` | 45px |
| `displaySmall` | 36px |
| `headlineLarge` | 32px |
| `headlineMedium` | 28px |
| `headlineSmall` | 24px |
| `titleLarge` | 22px |
| `titleMedium` | 16px |
| `titleSmall` | 14px |
| `bodyLarge` | 16px |
| `bodyMedium` | 14px |
| `bodySmall` | 12px |
| `labelLarge` | 14px |
| `labelMedium` | 12px |
| `labelSmall` | 11px |

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
  decoration: BoxDecoration(borderRadius: SmartRadius.md),
)
```

---

## Visibility

Show/hide widgets by breakpoint:

```dart
// Show only on specific breakpoints
SmartVisible(
  visibleOn: [SmartBreakpoint.desktop, SmartBreakpoint.tv],
  child: Sidebar(),
)

// Hide on specific breakpoints
SmartVisible(
  hiddenOn: [SmartBreakpoint.mobile, SmartBreakpoint.watch],
  child: AdvancedOptions(),
)

// Convenience widgets
MobileOnly(child: BottomNav())
TabletOnly(child: SidePanel())
DesktopOnly(child: Sidebar())
HideOnMobile(child: DetailedView())
HideOnDesktop(child: MobileMenu())

// Widget extensions
myWidget.showOnMobile()
myWidget.hideOnDesktop()
```

---

## Context Extensions

```dart
// Screen dimensions
context.screenWidth
context.screenHeight
context.aspectRatio
context.devicePixelRatio

// Orientation
context.isPortrait
context.isLandscape

// Platform
context.platform         // SmartPlatform enum
context.isIOS
context.isAndroid
context.isWeb
context.isMacOS
context.usesMaterial
context.usesCupertino

// Safe areas
context.safeAreaPadding
context.viewInsets
context.isKeyboardVisible
```

---

## Widget Extensions

```dart
// Padding
myWidget.paddedAll(16)
myWidget.paddedHorizontal(8)
myWidget.withPadding(SpacingSize.md)

// Layout
myWidget.centered()
myWidget.expanded()
myWidget.flexible()
myWidget.sized(width: 100, height: 50)

// Decoration
myWidget.clipped(borderRadius: SmartRadius.md)
myWidget.opacity(0.5)

// Gestures
myWidget.onTap(() => print('tapped'))

// Safe area & scrolling
myWidget.safeArea()
myWidget.scrollable()
```

---

## Number Extensions

```dart
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

---

## Comparison

| Feature | adaptive_kit | sizer | flutter_screenutil | responsive_framework |
|---------|--------------|-------|-------------------|---------------------|
| Breakpoint system | 5-tier | No | No | 4-tier |
| Responsive values | `context.responsive()` | No | No | Limited |
| 12-column grid | `SmartGrid` | No | No | No |
| Adaptive widgets | 10+ widgets | No | No | No |
| Design tokens | Spacing, Typography, Radius | No | No | No |
| Platform detection | Full | No | No | No |
| Zero dependencies | Yes | Yes | Yes | No |

---

## Dashboard Preview

🌐 **[Live Demo →](https://sahilsharma2710.github.io/smart_ui/)**
The example app includes an interactive playground to test all features:

```bash
cd example
flutter run -d chrome    # Web
flutter run -d macos     # macOS
```

**8 demo pages:**
- Home / Overview
- Breakpoints Demo
- Responsive Layout Demo
- Responsive Grid Demo
- Adaptive Widgets Demo
- Design Tokens Demo
- Visibility Demo
- Extensions Demo

---

## Custom Breakpoints

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

---

## Contributing

Contributions welcome! Please read our contributing guidelines.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

MIT License - see [LICENSE](LICENSE) for details.
