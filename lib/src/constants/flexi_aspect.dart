/// Aspects that can be used to listen for specific changes in Flexi UI.
///
/// Using these aspects allows widgets to rebuild only when the relevant
/// piece of responsive data changes, improving performance by avoiding
/// unnecessary rebuilds.
enum FlexiAspect {
  /// Listen for changes to the screen width.
  width,

  /// Listen for changes to the screen height.
  height,

  /// Listen for changes to the device pixel ratio.
  pixelRatio,

  /// Listen for changes to the semantic breakpoint.
  breakpoint,

  /// Internal aspect used when no explicit aspect is provided.
  /// Used to manage strict mode rebuilds.
  implicit,
}
