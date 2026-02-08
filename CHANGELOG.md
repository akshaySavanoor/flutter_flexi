## 1.2.1

### 📚 Documentation Updates
- Complete README overhaul for clarity and SEO
- Added API quick reference for scaling extensions
- Documented parent-based responsiveness (ResponsiveLayout, ResponsiveCard)
- Added design token documentation (Typography, Spacing, Icons)
- Documented visual scaling helpers (.fr, .fStroke, .fs)
- Expanded layout & adaptive components section
- Added configuration guidance, best practices, and troubleshooting
- Improved performance model explanation

## 1.2.0 (Production Hardening & Elite Example)

### 🛠 Hardening & Reliability
- **FlexiGrid Stability**: Refactored `FlexiGrid` to consistently use grid-based logic even in unconstrained contexts (dialogs, scroll views). Removed `Wrap` fallback for more predictable layouts.
- **Infinite Width Safety**: Implemented `safeWidth` calculation in `FlexiGrid` using screen fallbacks when parent constraints are infinite.
- **FlexiHelper Expansion**: Added `orientation`, `devicePixelRatio`, `screenWidth`, and `screenHeight` to `context.flexi` for improved developer experience.
- **Fluid Math Safety**: Added `max(1.0, divisor)` to linear interpolation methods to prevent `DivisionByZero` errors in extreme edge cases.

### 🍱 Production Example App
- **Project Overhaul**: Replaced the single-file demo with a realistic, multi-screen example application using production UI patterns.
- **Screen Showcase**: Added Dashboard, List-Detail (Split-Pane), Responsive Form, and Diagnostics screens.
- **Performance Audit**: Verified `InheritedModel` scoping with automated rebuild tracking tests.

### 📚 Documentation
- **Production Guide**: Rewrote `README.md` with a focus on production best practices and enterprise-grade implementation patterns.

## 1.1.0 (DX & DevTools Update)

### 🚀 New Features
- **Semantic Breakpoints**: Introduced the `FlexiBreakpoint` enum (`phonePortrait`, `phoneLandscape`, `tablet`, `desktop`) for intuitive responsive logic.
- **Nested Responsive Support**: Added `useParentConstraints` to `FlexiConfig`, enabling component-level scaling based on container constraints.
- **Developer Tools**: Added `FlexiDebugOverlay` for real-time visualization of screen metrics, breakpoints, and orientations.
- **Semantic Helpers**: Added `context.flexi` extension (`breakpoint`, `screenSize`, `deviceType`) for cleaner access to data.
- **Type-Safe Aspects**: Replaced aspect strings with the `FlexiAspect` enum for improved DX and typo prevention.

### ⚡ Performance & Correctness
- **Strict Aspect Mode**: Enforced granular rebuilds. Widgets won't rebuild unless they subscribe to a specific `FlexiAspect`.
- **Implicit Rebuild Escape Hatch**: Added `allowImplicitRebuilds` flag to `FlexiConfig` for backward compatibility.
- **Intelligent Orientation**: Refactored orientation logic to be derived from local dimensions, fixing issues in nested/split-screen layouts.
- **Zero-Warning Architecture**: Refactored all internal helpers and extensions to use explicit aspects, eliminating console noise.

### ⚠️ Breaking Changes
- `Flexi.of(context)` and `FlexiInheritedWidget.of(context)` now require a `FlexiAspect` enum instead of a `String`.
- By default, `Flexi.of(context)` without an aspect will NOT trigger a rebuild. Use `context.flexi.breakpoint` or specify an aspect to receive updates.

---

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