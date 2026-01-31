# Flutter Flexi UI

**High-Performance, Context-Aware, and SOLID Responsive Design for Flutter.**

Flexi UI is a modern responsive framework designed to solve the common pitfalls of existing packages like `screen_util`. It provides a declarative, `InheritedWidget`-based architecture that allows for **full `const` constructor support**, **high-performance granular rebuilds**, and clean, maintainable code.

## 🚀 Key Advantages

- **Full `const` Support**: Unlike other packages, Flexi UI works perfectly with `const` widgets, allowing Flutter to cache your UI tree and skip unnecessary builds.
- **Granular Rebuilds (Aspects)**: Using `InheritedModel`, widgets only rebuild when the specific dimension they care about (width or height) actually changes.
- **Zero LayoutBuilder Overhead**: By eliminating the need for deeply nested `LayoutBuilder` widgets, you reduce `RenderObject` calculation time significantly.
- **Directional Awareness**: Separate `width` and `height` tracking ensures high-fidelity scaling.
- **SOLID Design**: Decouples responsive logic from global state, making your widgets testable and predictable.

## ⚙️ Core Concepts

### 1. Root Configuration
Wrap your `MaterialApp` in a `FlexiConfig` widget. This replaces the old imperative initialization.

```dart
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlexiConfig( // High performance!
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
```

### 2. Context-Aware Extensions
Access responsive values using the `BuildContext`. This allows Flutter to track the dependency correctly.

| Extension | Purpose | Example |
| :--- | :--- | :--- |
| `.w(context)` | % of Screen Width | `0.5.w(context)` |
| `.h(context)` | % of Screen Height | `0.2.h(context)` |
| `.rw(context)` | Scaled Width (Design) | `100.rw(context)` |
| `.aw(context)` | Adaptive (Tuple-based) | `const Tuple2(12, 40).aw(context)` |

### 3. Parent-Relative Responsiveness
Need a card to scale its children based on *its* size rather than the whole screen? Use `ResponsiveLayout`.

```dart
const ResponsiveLayout(
  targetWidth: 300,
  child: MyResponsiveCard(), // Inside, use .fw(context)
)
```

## 🔄 Migration Guide (0.x -> 1.0.0)

Version 1.0.0 is a planned breaking change to ensure high performance and SOLID principles.

### 1. Root Setup
**Old (Imperative):**
```dart
ScreenAdaptiveConfig.init(context: context, orientation: orientation);
```
**New (Declarative):**
```dart
const FlexiConfig(child: MaterialApp(...));
```

### 2. Extension Methods
All responsive extensions now require the `BuildContext` to enable granular updates. Remove `_legacy` suffixes.

| Old (v0.x) | New (v1.0.0) |
| :--- | :--- |
| `100.w` | `100.w(context)` |
| `100.rw` | `100.rw(context)` |
| `Tuple2(12, 40).aw` | `Tuple2(12, 40).aw(context)` |
| `10.fw` | `10.fw(context)` |

> [!TIP]
> Use **Command + .** (VS Code) or **Alt + Enter** (Android Studio) to quickly add `context` to your extensions.

### 3. Parent-Relative Scaling
**Old**: Used `LayoutBuilder` manually with `ResponsiveCardConfig`.  
**New**: Wrap your widget in `ResponsiveLayout`.

---

## 🛠 Advanced Features

### Discrete Breakpoints
Use `BreakpointValue` to provide specific values for different device types instead of linear scaling.

```dart
const columns = BreakpointValue<int>(
  mobile: 2,
  tablet: 4,
  desktop: 6,
);

// Resolve it anywhere
int current = columns.v(context);
```

### 🌊 Universal Fluid Scaling (Continuous)
Sometimes you want values to grow proportionally between your mobile and desktop designs. This isn't just for typography—it works for **padding, margins, spacing, and any numeric dimension**.

Use the `.aw(max, context)` extension for width-based scaling or `.ah(max, context)` for height-based scaling.

```dart
Column(
  children: [
    Padding(
      padding: EdgeInsets.all(16.aw(32, context)), // Fluid padding: 16 -> 32
      child: Text(
        'Fluid EVERYTHING',
        style: TextStyle(
          fontSize: 18.aw(36, context), // Fluid font: 18 -> 36
        ),
      ),
    ),
    SizedBox(height: 10.aw(20, context)), // Fluid spacing: 10 -> 20
  ],
)
```

> [!IMPORTANT]
> **Performance Optimized**: `aw` only subscribes to 'width' changes, and `ah` only to 'height' changes. Your widgets won't rebuild unnecessarily if other screen properties (like pixel ratio) change.

### Device Pixel Ratio Awareness
Flexi UI is sensitive to DPR, ensuring that your UI looks crisp and scaled correctly even when moving apps between high-density and low-density displays.

## 📊 Performance Visualization
The new architecture ensures that "Heavy Widgets" (expensive to build) can be marked as `const`. As long as they don't use the responsive extensions themselves, they will **remain cached** even while other parts of the UI scale dynamically.

## 🤝 Community & Support

- **Bugs/Issues**: [Open an Issue](https://github.com/akshaySavanoor/flutter_flexi/issues)
- **Contributions**: [Submit a PR](https://github.com/akshaySavanoor/flutter_flexi/pulls)

Made with ❤️ for the Flutter Community.
