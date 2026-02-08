/// Defines the semantic breakpoint category for the current screen width.
///
/// This enum allows developers to write responsive logic using semantic names
/// (e.g., `if (breakpoint == FlexiBreakpoint.tablet)`) rather than raw numbers.
enum FlexiBreakpoint {
  /// Small phone in portrait mode.
  mobilePortrait,

  /// Large phone or small tablet in landscape mode.
  mobileLandscape,

  /// Tablet in landscape mode or small desktop window.
  tablet,

  /// Desktop or large screen.
  desktop,
}
