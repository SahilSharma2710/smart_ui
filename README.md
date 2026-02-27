<p align="center">
  <img src="https://raw.githubusercontent.com/SahilSharma2710/smart_ui/main/assets/banner.svg" width="100%" alt="adaptive_kit banner">
</p>

<p align="center">
  <a href="https://pub.dev/packages/adaptive_kit"><img src="https://img.shields.io/pub/v/adaptive_kit.svg?style=for-the-badge&color=6366F1" alt="pub package"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge" alt="License: MIT"></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.10+-02569B.svg?style=for-the-badge&logo=flutter" alt="Flutter"></a>
  <a href="https://pub.dev/packages/adaptive_kit/score"><img src="https://img.shields.io/pub/points/adaptive_kit?style=for-the-badge&color=34D399&label=pub%20points" alt="pub points"></a>
</p>

<p align="center">
  <b>The Tailwind CSS of Flutter.</b><br/>
  Zero-config adaptive UI toolkit with responsive breakpoints, platform-aware widgets, design tokens, and powerful extensions.
</p>

<p align="center">
  <a href="https://sahilsharma2710.github.io/smart_ui/"><img src="https://img.shields.io/badge/🚀_LIVE_DASHBOARD-Try_It_Now!-6366F1?style=for-the-badge&logoColor=white" alt="Live Dashboard" height="50"></a>
</p>

<p align="center">
  <a href="https://pub.dev/packages/adaptive_kit">📦 pub.dev</a> · 
  <a href="https://github.com/SahilSharma2710/smart_ui">⭐ GitHub</a>
</p>

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

<p align="center">
  <img src="https://raw.githubusercontent.com/SahilSharma2710/smart_ui/main/assets/features.svg" width="100%" alt="adaptive_kit features">
</p>

## Features

| Category | Features |
|----------|----------|
| **Responsive** | 5 breakpoints, `context.responsive()`, `SmartLayout`, `ResponsiveBuilder` |
| **Grid System** | 12-column `SmartGrid`, `SmartCol` with per-breakpoint spans |
| **Adaptive Widgets** | `SmartButton`, `SmartSwitch`, `SmartDialog`, `SmartScaffold` |
| **Design Tokens** | `SmartSpacing`, `SmartTypography`, `SmartRadius`, `SmartTheme` |
| **Visibility** | `SmartVisible`, `MobileOnly`, `DesktopOnly`, `HideOnMobile` |
| **Extensions** | Context, Widget, and Number extensions |
| **Platform** | Auto Material/Cupertino, platform detection |
| **v2.0 NEW** | `SmartApp`, `SmartImage`, `SmartForm`, `SmartWrap`, Animated Transitions, Slivers, Test Helpers |

**Zero dependencies** - Only Flutter SDK, fully tree-shakeable.

---

## Quick Start

### 1. Install

```yaml
dependencies:
  adaptive_kit: ^2.0.0
```

### 2. Wrap Your App

**Option A: Zero-config with SmartApp (Recommended)**

```dart
import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  runApp(
    SmartApp(
      title: 'My App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    ),
  );
}
```

**Option B: With Router (go_router, auto_route, etc.)**

```dart
SmartApp.router(
  routerConfig: myGoRouter,
)
```

**Option C: Manual SmartUi wrapper**

```dart
SmartUi(
  breakpoints: SmartBreakpoints.custom(
    mobile: 320,
    tablet: 768,
    desktop: 1024,
  ),
  child: MaterialApp(...),
)
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

Switch entire layouts based on breakpoint with optional animated transitions:

```dart
// Basic usage
SmartLayout(
  mobile: MobileHomeScreen(),
  tablet: TabletHomeScreen(),
  desktop: DesktopHomeScreen(),
)

// With animated transitions (NEW in v2.0)
SmartLayout(
  transition: SmartTransition.fadeSlide,
  transitionDuration: Duration(milliseconds: 300),
  mobile: MobileHomeScreen(),
  desktop: DesktopHomeScreen(),
)

// Available transitions: none, fade, fadeSlide, crossFade, scale
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

## 🌐 Dashboard Preview

<p align="center">
  <a href="https://sahilsharma2710.github.io/smart_ui/">
    <img src="https://img.shields.io/badge/🌐_Live_Demo-Try_it_Now-6366F1?style=for-the-badge&labelColor=0D1117" alt="Live Demo">
  </a>
</p>

The example app is a premium interactive playground with 8 demo pages:

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

## v2.0 New Features

### SmartImage - Responsive Images

```dart
SmartImage(
  mobile: AssetImage('assets/hero_mobile.png'),
  tablet: AssetImage('assets/hero_tablet.png'),
  desktop: AssetImage('assets/hero_desktop.png'),
  fit: BoxFit.cover,
)

// From asset paths
SmartImage.asset(
  mobile: 'assets/mobile.png',
  desktop: 'assets/desktop.png',
)

// From network URLs
SmartImage.network(
  mobile: 'https://example.com/small.jpg',
  desktop: 'https://example.com/large.jpg',
)
```

### SmartForm - Responsive Forms

```dart
SmartForm(
  // Auto: 1 col mobile, 2 col tablet, 3 col desktop
  children: [
    SmartFormField(child: TextField(decoration: InputDecoration(labelText: 'Name'))),
    SmartFormField(child: TextField(decoration: InputDecoration(labelText: 'Email'))),
    SmartFormField(
      span: 2, // Takes 2 columns
      child: TextField(decoration: InputDecoration(labelText: 'Address')),
    ),
  ],
)
```

### SmartWrap - Responsive Wrap

```dart
SmartWrap(
  mobileItemsPerRow: 2,
  tabletItemsPerRow: 4,
  desktopItemsPerRow: 6,
  fillRow: true,
  children: items.map((i) => ItemChip(i)).toList(),
)
```

### SmartTheme - Breakpoint-Aware Tokens

```dart
SmartTheme(
  mobile: SmartThemeData.mobile,
  tablet: SmartThemeData.tablet,
  desktop: SmartThemeData.desktop,
  child: MyApp(),
)

// Access in widgets
final theme = SmartTheme.of(context);
Text('Hello', style: TextStyle(fontSize: theme.baseFontSize));
```

### SmartSliver Widgets

```dart
CustomScrollView(
  slivers: [
    SmartSliverGrid(
      mobileColumns: 2,
      desktopColumns: 4,
      children: items.map((i) => Card(child: i)).toList(),
    ),
    SliverSmartPadding(
      mobile: EdgeInsets.all(8),
      desktop: EdgeInsets.all(24),
      sliver: SliverList(...),
    ),
    SliverSmartVisible(
      visibleOn: [SmartBreakpoint.desktop],
      sliver: SliverToBoxAdapter(child: DesktopBanner()),
    ),
  ],
)
```

### New Context Extensions

```dart
// Platform-adaptive values
final radius = context.adaptive<double>(material: 4.0, cupertino: 8.0);

// Show/hide helpers
context.showOnly(breakpoints: [SmartBreakpoint.desktop], child: Sidebar());
context.hideOn(breakpoints: [SmartBreakpoint.mobile], child: Options());

// Shorter responsive syntax
final cols = context.bp<int>(mobile: 1, tablet: 2, desktop: 4);

// Simple mobile/desktop checks
final padding = context.mobileOr<double>(mobile: 12, other: 24);
final maxWidth = context.desktopOr<double>(desktop: 1200, other: double.infinity);
```

### Golden Test Helpers

```dart
testWidgets('renders correctly on mobile', (tester) async {
  await tester.pumpWidget(
    createSmartTestWidget(
      width: 375,
      child: MyResponsiveWidget(),
    ),
  );
  expect(find.text('Mobile'), findsOneWidget);
});

// Test multiple breakpoints
for (final config in SmartTestConfigs.all) {
  testWidgets('works on ${config.displayName}', (tester) async {
    await tester.pumpWidget(
      createSmartTestWidgetForConfig(config: config, child: MyWidget()),
    );
  });
}
```

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
