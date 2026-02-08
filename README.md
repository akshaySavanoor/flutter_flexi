# Flexi UI 🚀

**A High-Performance, Type-Safe Flutter Responsive & Adaptive UI Framework**

[![Pub Version](https://img.shields.io/pub/v/flexi_ui?color=blue)](https://pub.dev/packages/flexi_ui)  
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/akshaySavanoor/flutter_flexi/blob/main/LICENSE)  
[![Flutter](https://img.shields.io/badge/flutter-framework-blue.svg)](https://flutter.dev)

**Flexi UI** is a production-ready **Flutter responsive framework** for building scalable, adaptive apps across **mobile, tablet, and desktop**.  
It combines **fluid scaling**, **breakpoint-based layouts**, **design tokens**, and a **granular performance model** powered by `InheritedModel`.

---

## ✨ Why Flexi UI?

Most responsive solutions only scale sizes. Flexi UI provides a **complete adaptive system**:

✔ Screen-based scaling  
✔ Parent-based component scaling  
✔ Discrete breakpoint logic  
✔ Fluid multi-stage interpolation  
✔ Responsive design tokens (spacing, typography, icons)  
✔ Built-in accessibility & motion helpers  
✔ Granular rebuild performance

---

## 📚 Table of Contents

- Getting Started
- API Quick Reference
- Scaling System
- Component-Level Responsiveness
- Layout & Adaptive Components
- Design Tokens
- Motion & Accessibility
- Breakpoints & Device Model
- Configuration
- Best Practices
- Performance Model
- Troubleshooting
- Debug Overlay
- Example App
- Support

---

## 🚀 Getting Started

### 1️⃣ Install

```yaml
dependencies:
  flexi_ui: ^1.2.1
```

### 2️⃣ Wrap Your App

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

### 3️⃣ Use Anywhere

```dart
@override
Widget build(BuildContext context) {
  final flexi = context.flexi;

  return Scaffold(
    appBar: AppBar(title: Text(flexi.breakpoint.name)),
    body: flexi.isDesktop ? DesktopLayout() : MobileLayout(),
  );
}
```

---

## 🧾 API Quick Reference

### Extensions on `num`
- `.w(context)` — % of screen width
- `.h(context)` — % of screen height
- `.rw(context)` — responsive width
- `.rh(context)` — responsive height
- `.fw(context)` — parent-based width
- `.fh(context)` — parent-based height
- `.aw(max, context)` — fluid width interpolation
- `.ah(max, context)` — fluid height interpolation
- `.fr(context)` — fluid radius scaling
- `.fStroke(context)` — dampened border scaling
- `.fs(context)` — safe uniform scaling
- `Tuple2(a, b).d(context)` — diagonal scaling

### Helpers
- `FlexiFluid3` — tiered fluid scaling
- `BreakpointValue<T>` — discrete breakpoint values
- `context.flexi` — semantic responsive helper

---

# 📐 Scaling System

## 🖥 Screen-Based Scaling

| Method | Description |
|-------|-------------|
| `.rw(context)` | Responsive width (design → screen) |
| `.rh(context)` | Responsive height |
| `.w(context)` | % of screen width |
| `.h(context)` | % of screen height |

---

## 🌊 Fluid Interpolation

```dart
fontSize: 18.aw(32, context)
```

---

## 🎚 Tiered Scaling

```dart
const FlexiFluid3(mobile: 14, tablet: 16, desktop: 20).resolve(context);
```

---

## 🎛 Visual Scaling

| Method | Purpose |
|-------|---------|
| `.fr(context)` | Fluid radius scaling |
| `.fStroke(context)` | Fluid border width |
| `.fs(context)` | Safe uniform scaling |

---

# 🧱 Component-Level Responsiveness

```dart
ResponsiveCard(
  targetWidth: 300,
  targetHeight: 400,
  child: Padding(
    padding: EdgeInsets.all(16.fw(context)),
  ),
)
```

### `FlexiCircle`

```dart
FlexiCircle(size: 48, child: Icon(Icons.person))
```

---

# 🧩 Layout & Adaptive Components

- **FlexiLayout** — breakpoint-based layouts
- **FlexiAdaptiveNav** — adaptive navigation
- **FlexiGrid** — responsive grid
- **FlexiMaxWidth** — max-width constraint
- **FlexiVisibility** — breakpoint visibility

---

# 🎨 Design Tokens

### Typography
```dart
FlexiTextStyles.h1(context)
```

### Spacing
```dart
FlexiSpacing.m(context)
```

### Icons
```dart
FlexiIconSize.m(context)
```

---

# 🎞 Motion & Accessibility

### Motion
```dart
FlexiMotion.durationMedium(context)
```

### Accessibility
- `FlexiMinTapTarget`
- `FlexiTextClamp`

---

# 📊 Breakpoints

| Breakpoint | Meaning |
|-----------|---------|
| mobilePortrait | Phone portrait |
| mobileLandscape | Phone landscape |
| tablet | Tablet layouts |
| desktop | Desktop layouts |

---

# ⚙ Configuration

```dart
FlexiConfig(
  designMinWidth: 360,
  designMaxWidth: 1440,
  mobilePortraitBreakpoint: 600,
  tabletLandscapeBreakpoint: 1100,
  spacing: FlexiSpacingConfig.defaultConfig,
  typography: FlexiTypographyConfig.defaultConfig,
  icons: FlexiIconConfig.defaultConfig,
)
```

### Advanced Flags

| Flag | Purpose |
|------|---------|
| `useParentConstraints` | Use parent layout instead of MediaQuery |
| `allowImplicitRebuilds` | Allow rebuilds without aspect (not recommended) |

---

# ✅ Best Practices

- Use `context.flexi.breakpoint` for layout switching
- Prefer design tokens over hardcoded sizes
- Use `.fs()` for circles/icons
- Keep `allowImplicitRebuilds` disabled

---

# ⚡ Performance Model

Flexi UI uses **InheritedModel aspect scoping** for minimal rebuilds.  
You get performance benefits automatically.

---

# ❗ Troubleshooting

**FlexiConfig not found** → Wrap your app root with `FlexiConfig`.  
**Circles distorted** → Use `.fs(context)`.  
**Unbounded constraints** → Use `FlexiMaxWidth` or constrained parent.

---

# 🔍 Debug Overlay

```dart
FlexiConfig(showDebugOverlay: true)
```

Shows screen metrics & breakpoints in debug mode.

---

# 📱 Example App

See `/example` for dashboard, grids, forms, and scaling showcase.

---

# 🤝 Support & Contributions

- Issues: https://github.com/akshaySavanoor/flutter_flexi/issues
- PRs welcome

Made with ❤️ for the Flutter community