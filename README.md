# Flexi UI 🚀

**A High-Performance, Type-Safe Flutter Responsive & Adaptive UI Framework**

[![Pub Version](https://img.shields.io/pub/v/flexi_ui?color=blue)](https://pub.dev/packages/flexi_ui)  
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/akshaySavanoor/flutter_flexi/blob/main/LICENSE)  
[![Flutter](https://img.shields.io/badge/flutter-framework-blue.svg)](https://flutter.dev)

**Flexi UI** is a production-ready **Flutter responsive framework** designed to help you build scalable, adaptive user interfaces across **mobile, tablet, and desktop**.

Unlike simple scaling utilities, Flexi UI provides a **complete responsive system** with:

- 📐 Screen-based responsive scaling
- 🧱 Parent-based component scaling
- 📱 Breakpoint-driven adaptive layouts
- 🌊 Smooth value interpolation across screen sizes
- 🎚 Tiered values for mobile, tablet, and desktop
- 🎨 Built-in design tokens (spacing, typography, icons)
- ♿ Accessibility helpers
- 🎞 Adaptive motion durations
- ⚡ Granular rebuild performance using `InheritedModel`

---

# 🚀 Getting Started

### 1️⃣ Install

```yaml
dependencies:
  flexi_ui: ^1.2.0
```

### 2️⃣ Wrap Your App with `FlexiConfig`

```dart
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlexiConfig(
      designMinWidth: 360,
      designMaxWidth: 1440,
      showDebugOverlay: true,
      child: const MaterialApp(home: DashboardScreen()),
    );
  }
}
```

`FlexiConfig` provides screen metrics, scaling logic, breakpoints, and design tokens to your entire widget tree.

---

# ⚡ Most Common Usage

### Scale spacing and sizes based on screen width
```dart
padding: EdgeInsets.all(16.rw(context));
width: 0.8.w(context);
```

### Responsive typography
```dart
Text("Welcome", style: FlexiTextStyles.h1(context));
```

### Responsive spacing tokens
```dart
SizedBox(height: FlexiSpacing.m(context));
```

### Switch layouts per device
```dart
FlexiLayout(
  mobile: MobileHome(),
  tablet: TabletHome(),
  desktop: DesktopHome(),
);
```

### Scale widgets relative to their parent container
```dart
ResponsiveCard(
  child: Padding(
    padding: EdgeInsets.all(12.fw(context)),
    child: Text("Card Content"),
  ),
);
```

---

# 🧭 Which Scaling Method Should I Use?

| Situation | Recommended Tool |
|----------|------------------|
| Padding, margins, container width | `.rw(context)` |
| Heights tied to screen | `.rh(context)` |
| Full-width elements | `.w(context)` |
| Smooth font scaling between sizes | `.aw(max, context)` |
| Different values per device type | `FlexiFluid3` |
| Border radius | `.fr(context)` |
| Border thickness | `.fStroke(context)` |
| Circles & icons (no distortion) | `.fs(context)` |
| Scaling inside cards/components | `.fw(context) / .fh(context)` |
| Switching entire layouts | `FlexiLayout` |

---

# 📐 Responsive Scaling System

Different UI properties need different scaling behavior.

---

## 🖥 Screen-Based Scaling
**Use when elements should adapt relative to the entire screen size.**

```dart
padding: EdgeInsets.all(16.rw(context));
height: 200.rh(context);
width: 0.8.w(context);
```

| Method | What It Does |
|--------|---------------|
| `.rw(context)` | Scales a value based on screen width vs design width |
| `.rh(context)` | Scales based on screen height vs design height |
| `.w(context)` | Uses a percentage of screen width |
| `.h(context)` | Uses a percentage of screen height |

---

## 🌊 Smooth Interpolation
**Use when a value should gradually increase as screen size grows.**

```dart
fontSize: 18.aw(32, context);
```

This means the value scales smoothly between a minimum and maximum based on screen width.

| Method | Purpose |
|--------|---------|
| `.aw(max)` | Smooth width-based scaling |
| `.ah(max)` | Smooth height-based scaling |
| `Tuple2(a, b).d()` | Diagonal scaling based on screen size |

---

## 🎚 Tiered Scaling
**Use when values should change per device type (mobile/tablet/desktop).**

```dart
const FlexiFluid3(mobile: 14, tablet: 16, desktop: 20).resolve(context);
```

Best for typography, spacing, or layout gaps.

---

## 🎛 Dampened Visual Scaling
**Use when visual properties should scale gently, not aggressively.**

```dart
borderRadius: BorderRadius.circular(12.fr(context));
border: Border.all(width: 1.fStroke(context));
```

| Method | Purpose |
|--------|---------|
| `.fr(context)` | Radius scaling that avoids extreme rounding |
| `.fStroke(context)` | Border scaling that stays visually thin |
| `.fs(context)` | Uniform scaling that preserves shape (great for circles) |

---

# 🧱 Component-Level Responsiveness

When widgets must scale relative to their **parent container**, not the screen.

## ResponsiveLayout vs ResponsiveCard

`ResponsiveLayout` provides parent-based scaling context.  
`ResponsiveCard` is a convenience wrapper that uses it internally.

Use **ResponsiveCard** for reusable components.  
Use **ResponsiveLayout** when you need custom parent scaling control.

```dart
ResponsiveCard(
  targetWidth: 300,
  targetHeight: 400,
  child: Padding(
    padding: EdgeInsets.all(12.fw(context)),
    child: Text("Responsive Card"),
  ),
);
```

| Method | Description |
|--------|-------------|
| `.fw(context)` | Width relative to parent |
| `.fh(context)` | Height relative to parent |

---

## FlexiCircle

Ensures circular widgets remain circles during scaling.

```dart
FlexiCircle(
  size: 48,
  child: Icon(Icons.person, size: 20.fs(context)),
);
```

---

# 🧩 Adaptive Layout Widgets

## FlexiLayout
Switch widget trees based on device type.

```dart
FlexiLayout(
  mobile: MobileHome(),
  tablet: TabletHome(),
  desktop: DesktopHome(),
);
```

## Other Adaptive Widgets

| Widget | Purpose |
|-------|---------|
| `FlexiGrid` | Automatically adjusts grid columns based on width |
| `FlexiMaxWidth` | Prevents content from stretching too wide |
| `FlexiVisibility` | Show/hide widgets per breakpoint |
| `FlexiAdaptiveNav` | Switch navigation patterns per device |

---

# 🎨 Built-In Design Tokens

Flexi UI includes responsive design tokens.

### Typography
```dart
Text("Title", style: FlexiTextStyles.h1(context));
```

### Spacing
```dart
Padding(padding: EdgeInsets.all(FlexiSpacing.m(context)));
```

### Icons
```dart
Icon(Icons.settings, size: FlexiIconSize.m(context));
```

These tokens adapt automatically across mobile, tablet, and desktop.

---

# 🎞 Motion & Accessibility

## Adaptive Motion Durations

```dart
duration: FlexiMotion.durationMedium(context);
```

Use `FlexiMotion` instead of hardcoded durations so animations feel natural on all devices.

## Accessibility Helpers

| Widget | Purpose |
|--------|---------|
| `FlexiMinTapTarget` | Ensures minimum 48×48 tap areas |
| `FlexiTextClamp` | Prevents layout breakage from extreme text scaling |

---

# 📊 Breakpoints

| Breakpoint | Device Type |
|-----------|-------------|
| mobilePortrait | Phone portrait |
| mobileLandscape | Phone landscape |
| tablet | Tablet |
| desktop | Desktop |

```dart
BreakpointValue<int>(mobile: 1, tablet: 2, desktop: 4).v(context);
```

---

# ⚙ Configuration

```dart
FlexiConfig(
  designMinWidth: 360,
  designMaxWidth: 1440,
  designMinHeight: 480,
  designMaxHeight: 1024,
  mobilePortraitBreakpoint: 600,
  mobileLandscapeBreakpoint: 768,
  tabletLandscapeBreakpoint: 1100,
)
```

### Advanced Flags

| Flag | Description |
|------|-------------|
| `useParentConstraints` | Scale relative to parent layout instead of screen |
| `allowImplicitRebuilds` | Allow rebuilds without specifying aspects (less efficient) |

---

# ⚡ Performance Model

Flexi UI uses **InheritedModel aspect scoping**.  
Widgets rebuild **only when the responsive data they use changes**, ensuring excellent performance even in large apps.

---

# ❗ Troubleshooting

**FlexiConfig not found** → Wrap your root widget with `FlexiConfig`  
**Circle distortion** → Use `.fs(context)` or `FlexiCircle`  
**Unbounded constraints** → Use `FlexiMaxWidth`

---

# 🔍 Debug Overlay

```dart
FlexiConfig(showDebugOverlay: true)
```

Displays live screen metrics during development.

---

# 📱 Example App

The `/example` folder demonstrates dashboards, grids, forms, and responsive scaling in action.

---

# 🤝 Support & Contributions

- Issues: https://github.com/akshaySavanoor/flutter_flexi/issues
- PRs welcome

Made with ❤️ for the Flutter community