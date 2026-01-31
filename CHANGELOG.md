## 1.0.0

- **BREAKING CHANGE**: Shifted to high-performance `InheritedWidget` architecture.
- **BREAKING CHANGE**: Removed legacy static `ScreenAdaptiveConfig` and `ResponsiveCardConfig` singletons.
- **Feature**: Full `const` constructor support for responsive widgets.
- **Feature**: Granular rebuilds using `InheritedModel` aspects (widht/height specific).
- **Feature**:### New Features
- **Fluid Scaling (Proportional growth)**: Added `.aw(max, context)` and `.ah(max, context)` to `num` class for scaling any value (font, padding, dimensions) between two design points.
- **Granular Performance**: All fluid scaling extensions now use specialized aspects ('width'/'height') to minimize widget rebuilds.
- **BreakpointValue<T>**: Utility for discrete, step-based responsiveness (Mobile/Tablet/Desktop).
- **DPR Awareness**: Automatic scaling based on Device Pixel Ratio.
- **Post-Cleanup Audit**: Restored and documented `DeviceTypeConfig` and `ScreenInfo`.
- **Internal**: Removed `LayoutBuilder` dependency in core scaling, reducing `RenderObject` overhead.

## 0.1.0

- **Responsive Widgets**: Automatically adjust widget sizes based on the screen size.
- **Adaptive Text**: Scale text sizes dynamically.
- **Device-Specific Layouts**: Tailor your UI for different devices like phones, tablets, and
  desktops.
- **Orientation Handling**: Adapt to changes in screen orientation seamlessly.
- **Responsive Card Configuration**: Make entire card components responsive effortlessly.

## 0.0.2

- Update readme.md
- update with documentation.
- update pubspec.yaml

## 0.0.3

- Fix formatting issues.

## 0.0.4

- Update readme.md

## 0.0.5

- Update tuple package.
- Update flexi_ui_example.

## 0.0.6

- import optimization

## 0.0.7

- Feature Demo

## 0.0.8

- update screen_adaptive_config

## 0.0.9

- update screen_adaptive_config_provider( Import optimization)

## 0.1.0

- code format