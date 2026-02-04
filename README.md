# Flexi UI 🚀

**The Most Performant, Type-Safe, and Developer-Friendly Responsive Framework for Flutter.**

[![Pub Version](https://img.shields.io/pub/v/flexi_ui?color=blue)](https://pub.dev/packages/flexi_ui)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/akshaySavanoor/flutter_flexi/blob/main/LICENSE)
[![Flutter](https://img.shields.io/badge/flutter-framework-blue.svg)](https://flutter.dev)

Flexi UI is a high-performance **Flutter responsive UI framework** for building scalable, adaptive layouts on **Mobile, Tablet, and Desktop** using a clean, type-safe `InheritedModel` architecture.

## Flutter Responsive Alternatives

Flexi UI is an alternative to:
- flutter_screenutil
- responsive_framework
- layout_builder
- mediaquery-based layouts

Unlike these, Flexi UI provides:
- granular rebuild control
- const-safe widgets
- semantic breakpoints
- nested responsive contexts
---

## When Should You Use Flexi UI?

Use Flexi UI if you are:
- building Flutter apps for Web + Desktop
- maintaining large design systems
- struggling with MediaQuery rebuilds
- tired of screen_util breaking const widgets

## 🌟 Why Flexi UI?

- **⚡ Blazing Performance**: Built on `InheritedModel`. Widgets only rebuild when the specific dimension they subscribe to (width, height, or breakpoint) actually changes.
- **🏗️ SOLID Architecture**: Decouples UI from device-specific magic numbers. Designed for testability and maintainability.
- **✨ Full `const` Support**: Unlike `screen_util`, Flexi UI does not require global mutable state, so `const` widgets remain valid and optimizable.
- **🛡️ Type-Safe Aspects**: No more magic strings! Use the `FlexiAspect` enum to precisely control when your widgets rebuild.
- **🔍 Debug Overlay**: Built-in visual tools to see your screen metrics, breakpoints, and orientations in real-time.
- **📦 Minimal Dependencies: Lightweight and focused (only depends on `tuple`).**

---

## ⚙️ Core Concepts

### 1. The Root: `FlexiConfig`
Wrap your `MaterialApp` with `FlexiConfig`. This provides responsive context to your entire application.

```dart
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const FlexiConfig(
      showDebugOverlay: true, // Perfect for development!
      child: MaterialApp(home: HomeScreen()),
    );
  }
}
```

### 2. Semantic Breakpoints
Flexi UI categorizes screens into semantic buckets. Stop checking for `width > 600` and start thinking in device types.

```dart
if (context.flexi.breakpoint == FlexiBreakpoint.desktop) {
  return SidebarLayout();
}
```

### 3. Granular Subscriptions (The Performance Secret)
Avoid the "Whole Screen Rebuild" problem. Subscribe only to what you need.

```dart
// Rebuilds ONLY when width changes
final width = context.flexi.screenSize.width; 

// Rebuilds ONLY when the breakpoint (Mobile -> Tablet) changes
final bp = context.flexi.breakpoint; 
```

---

## 📐 Adaptive Scaling

| Method | Description | Example                                      |
| :--- | :--- |:---------------------------------------------|
| `.w(context)` | % of Screen Width | `0.5.w(context)` (Fraction of Screen Width)  |
| `.h(context)` | % of Screen Height | `0.2.h(context)` (Fraction of Screen Height) |
| `.rw(context)` | Design-Width Scaled | `100.rw(context)`                            |
| `.aw(max, context)`| **Fluid Scaling** | `16.aw(32, context)` (Font scales 16->32)    |
| `.fw(context)` | **Nested (Card) Scaling** | `10.fw(context)` (Scales relative to parent) |

---

## 🛠 Advanced Tools

### 🌊 Universal Fluid Scaling
Smoothly transition font sizes, padding, and spacing between your mobile design and desktop design.

```dart
Padding(
  padding: EdgeInsets.all(16.aw(32, context)), // Scales between 16 and 32
  child: Text(
    'Fluid Typography',
    style: TextStyle(fontSize: 18.aw(32, context)),
  ),
)
```

### 📦 Nested Responsive Support
Need a specific widget (like a Dialog or Side Panel) to have its own responsive context?

```dart
FlexiConfig(
  useParentConstraints: true, // Scales children relative to this container
  child: MyComponent(),
)
```

### 🐞 Debug Overlay
Enable `showDebugOverlay: true` to see a floating panel with:
- Current Width & Height
- Semantic Breakpoint
- Orientation & DPR
- Target Device Type

---

## 🔄 Migration to v1.1.0

Version 1.1.0 introduces **Type-Safe Aspects** and **Strict Performance Mode**.

- **Type safety**: Replace `aspect: 'width'` with `aspect: FlexiAspect.width`.
- **Strict Mode**: By default, `Flexi.of(context)` without an aspect will NOT trigger rebuilds.
- **Fix**: Use `context.flexi.screenSize` or specify an aspect to receive updates.

> [!TIP]
> If you need backward compatibility, set `allowImplicitRebuilds: true` in your root `FlexiConfig`.

---

## 🤝 Community & Support

- **Bugs/Issues**: [Open an Issue](https://github.com/akshaySavanoor/flutter_flexi/issues)
- **Contributions**: [Submit a PR](https://github.com/akshaySavanoor/flutter_flexi/pulls)

Made with ❤️ by [Akshay Savanoor](https://github.com/akshaySavanoor)
