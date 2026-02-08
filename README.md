# Flexi UI 🚀

**A High-Performance, Type-Safe, Production-Ready Flutter Responsive & Adaptive UI Framework.**

[![Pub Version](https://img.shields.io/pub/v/flexi_ui?color=blue)](https://pub.dev/packages/flexi_ui)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/akshaySavanoor/flutter_flexi/blob/main/LICENSE)
[![Flutter](https://img.shields.io/badge/flutter-framework-blue.svg)](https://flutter.dev)

Flexi UI is a professional **Flutter responsive UI framework** designed for building scalable, adaptive applications on **Mobile, Tablet, and Desktop**. Built with a performance-first philosophy, it leverages a granular `InheritedModel` architecture to solve the "whole-screen rebuild" problem common in many responsive packages.

---

## 📚 Table of Contents
- Key Features
- When Should I Use Flexi UI?
- Core Architecture
- Getting Started
- Scaling System
- Layout & Adaptive Components
- Motion & Design Tokens
- Accessibility Helpers
- Configuration
- Performance Model
- Diagnostics
- Production Example App
- Community & Support

---

## ✨ Key Features

- Granular rebuild control with `InheritedModel`
- Type-safe breakpoints and aspect subscriptions
- Fluid and tiered scaling utilities
- Adaptive layouts for mobile, tablet, and desktop
- Motion and accessibility helpers built-in
- Debug overlay for real-time diagnostics

---

## 🤔 When Should I Use Flexi UI?

Flexi UI is ideal for:

- Apps targeting **mobile + tablet + desktop**
- Products with **design systems** that must scale predictably
- Dashboards, admin panels, enterprise tools
- Apps where performance during resizing matters

If your UI must adapt across drastically different screen sizes without layout hacks, Flexi UI provides a structured solution.

---

## 🏗️ Core Architecture

Flexi UI is built on the principle of **Granular Aspect Scoping**. Unlike frameworks that depend on a global `MediaQuery` or shared mutable state, Flexi UI allows widgets to subscribe only to the specific screen data they need.

### Why InheritedModel?
Standard `InheritedWidget` triggers a rebuild for every dependent when any value in the model changes. Flexi UI uses `InheritedModel` with specific **Aspects**, ensuring that:
- A widget listening to `FlexiAspect.width` **does not rebuild** when only the screen height changes.
- A widget listening to `FlexiAspect.breakpoint` **only rebuilds** when moving between device categories (e.g., Mobile to Tablet).

### Type-Safe Subscriptions
No more magic strings. Use `FlexiAspect` and `FlexiBreakpoint` enums for 100% compile-time safety.

---

## 🚀 Getting Started

### 1. Installation
Add `flexi_ui` to your `pubspec.yaml`:
```yaml
dependencies:
  flexi_ui: ^1.2.0
```

### 2. Wrap your App
Initialize `FlexiConfig` at the root. This sets up your design anchors—the dimensions your designers used for their mocks.

```dart
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlexiConfig(
      designMinWidth: 360, // Your mobile design width
      designMaxWidth: 1440, // Your desktop design width
      showDebugOverlay: true, // Perfect for development!
      child: MaterialApp(
        home: const DashboardScreen(),
      ),
    );
  }
}
```

### 3. Context Helper
Access responsive data anywhere using the `context.flexi` extension.

```dart
@override
Widget build(BuildContext context) {
  final flexi = context.flexi;
  
  return Scaffold(
    appBar: AppBar(title: Text('Active: ${flexi.breakpoint.name}')),
    body: flexi.isDesktop ? SidebarLayout() : MobileLayout(),
  );
}
```

---

## 📐 Scaling System (Flutter Screen Scaling)

Flexi UI provides precise utilities to adapt your UI across various Flutter responsive screen sizes.

### Scaling Extensions on `num`

| Method | Description | Best Use Case |
| :--- | :--- | :--- |
| `.rw(context)` | **Responsive Width**: Scales based on design width. | Padding, margins, container widths. |
| `.rh(context)` | **Responsive Height**: Scales based on design height. | Fixed-height elements, vertical spacing. |
| `.fr(context)` | **Fluid Radius**: Dampened scaling for circularity. | Card corner radius to stay proportional. |
| `.fStroke(context)`| **Fluid Stroke**: Heavy dampening for borders. | Keeping border lines clean on 4K monitors. |
| `.w(context)` | % of Screen Width (0.0 to 1.0). | Full-width banners, sidebars. |
| `.h(context)` | % of Screen Height (0.0 to 1.0). | Centering elements, dynamic spacers. |

### Advanced Interpolation

#### `aw(max, context)` (Adaptive Width)
Ideal for **Fluid Typography**. Linearly interpolates between your current value and a `max` value as the screen scales from `designMinWidth` to `designMaxWidth`.

```dart
Text(
  'Adaptive Header',
  style: TextStyle(fontSize: 18.aw(32, context)), // Scales 18->32 based on width
)
```

#### `Tuple2(val1, val2).d(context)` (Diagonal Scaling)
Scales based on the screen diagonal, preserving the vertical/horizontal relationship. Perfect for items that must keep a specific aspect ratio across radical size shifts.

#### `FlexiFluid3` (Tiered Scaling)
Smoothly transition values across different device classes: Mobile → Tablet → Desktop.
```dart
fontSize: const FlexiFluid3(
  mobile: 14, 
  tablet: 16, 
  desktop: 20,
).resolve(context),
```

---

## 🧩 Layout & Adaptive Components

Build modern **Flutter adaptive layouts** with dedicated structural widgets.

### `FlexiLayout`
Declaratively switch widget trees based on breakpoints.
```dart
FlexiLayout(
  mobile: const MobileView(),
  tablet: const TabletView(),
  desktop: const DesktopView(),
)
```

### `FlexiGrid`
A smart grid that automatically adjusts column counts based on a minimum item width. Respects `childAspectRatio` and maintains grid logic even in unconstrained scroll views.
```dart
FlexiGrid(
  minItemWidth: 200.rw(context),
  spacing: 16,
  children: [...],
)
```

### `FlexiMaxWidth`
Centers and constrains its child, preventing content from becoming unreadably wide on ultra-wide desktop monitors.
```dart
FlexiMaxWidth(
  maxWidth: 800,
  child: MyForm(),
)
```

### `FlexiVisibility`
Efficiently includes or excludes widgets from the build tree based on device type.
```dart
FlexiVisibility(
  mobile: true,
  tablet: false,
  desktop: false,
  child: const MobileFab(),
)
```

### `FlexiAdaptiveNav`
Automatically switches between a `BottomNavigationBar` on mobile and a `NavigationRail` or `Drawer` on desktop.

---

## 🎞 Motion & Design Tokens

### Responsive Animations
Avoid "clunky" desktop animations. `FlexiMotion` provides adaptive durations and curves that feel natural on every platform.
```dart
AnimatedContainer(
  duration: FlexiMotion.durationMedium(context), // 250ms (Mobile) | 350ms (Desktop)
  curve: Curves.easeInOut,
  // ...
)
```

---

## ♿ Accessibility Helpers

### `FlexiMinTapTarget`
Ensures interactive elements meet minimum touch target requirements (Default: 48x48dp) without forcing a specific widget size.

### `FlexiTextClamp`
Prevents text from scaling to extreme levels when users have high accessibility text magnification enabled, protecting your layout from catastrophic overflow.
```dart
FlexiTextClamp(
  maxScaleFactor: 1.3,
  child: Text('Protected Header'),
)
```

---

## ⚙ Configuration

| Parameter | Default | Description                                                        |
| :--- | :--- |:-------------------------------------------------------------------|
| `designMinWidth` | `375` | The width used in your mobile design mocks.                        |
| `designMaxWidth` | `1440` | The width used in your desktop design mocks.                       |
| `showDebugOverlay` | `false` | Enables a floating panel with live metrics.                        |
| `useParentConstraints`| `false` | If true, scaling is relative to parent size (Nested Support).      |
| `allowImplicitRebuilds`| `false` | Replaces granular aspects with full rebuilds (v1.0 compatibility). |

---

## ⚡ Performance Model

Flexi UI is designed for complex, production-grade applications. To optimize your **Flutter responsive framework** implementation:

1. **Be Granular**: Use `Flexi.of(context, aspect: FlexiAspect.breakpoint)` for widgets that only need to change layout structure (Mobile vs Desktop) and don't need scaling updates.
2. **Const Reference**: All Flexi UI components support `const` constructors. Use them to minimize build cycles.
3. **Avoid Implicit Listeners**: By default, `Flexi.of(context)` without an aspect does NOT subscribe to changes. This prevents accidental "rebuild-everything" scenarios.

---

## 🔍 Diagnostics

Enable `showDebugOverlay: true` to view a real-time diagnostics panel:
- **Active Breakpoint**: Direct feedback on layout classification.
- **Physical Metrics**: Current size, Device Pixel Ratio (DPR), and Orientation.
- **Scale Factors**: See exactly how much `.rw` and `.rh` are multiplying your values.

---

## 📱 Production Example App
The `example/` folder contains a professional, multi-screen application demonstrating:
- **Enterprise Dashboard**: Complex grids, fluid metric scaling, and responsive charts.
- **Adaptive List-Detail**: Sophisticated split-pane logic for tablets and desktop.
- **Dynamic Forms**: Using `FlexiMaxWidth` and `FlexiTextClamp` for accessible layouts.
- **Feature Showcase**: A visual encyclopedia of every scaling extension.

---

## 🤝 Community & Support

- **Bugs/Issues**: [Open an Issue](https://github.com/akshaySavanoor/flutter_flexi/issues)
- **Contributions**: Pull requests are welcome!

Made with ❤️ by [Akshay Savanoor](https://github.com/akshaySavanoor)
