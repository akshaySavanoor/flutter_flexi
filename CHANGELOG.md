## 1.0.0

### ⚠️ Breaking Changes
- Migrated to a high-performance `InheritedModel` architecture.
- Removed legacy static `ScreenAdaptiveConfig` and `ResponsiveCardConfig` singletons.

### 🚀 New Features
- **Fluid Scaling**: Added `.aw(max, context)` and `.ah(max, context)` extensions to scale values proportionally between design sizes.
- **Granular Performance**: Width/height aspect-based rebuilds using `InheritedModel`.
- **BreakpointValue<T>**: Utility for discrete, step-based responsiveness (Mobile / Tablet / Desktop).
- **DPR Awareness**: Automatic scaling based on device pixel ratio.
- **Const Constructors**: Full `const` support across responsive widgets.

### 🛠 Improvements
- Restored and documented `DeviceTypeConfig` and `ScreenInfo`.
- Removed `LayoutBuilder` dependency in core scaling to reduce render overhead.

---

## 0.1.0

- Initial responsive widget system
- Adaptive text scaling
- Device-specific layout handling
- Orientation responsiveness
- Responsive card configuration

---

## 0.0.9
- Import optimization for `screen_adaptive_config_provider`

## 0.0.8
- Updated `screen_adaptive_config`

## 0.0.7
- Feature demo added

## 0.0.6
- Import optimizations

## 0.0.5
- Updated `tuple` dependency
- Improved example app

## 0.0.4
- README update

## 0.0.3
- Formatting fixes

## 0.0.2
- Documentation improvements
- README update
- pubspec update