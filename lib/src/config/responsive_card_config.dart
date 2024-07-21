/// A class for configuring a responsive card based on the size of the parent container.
///
/// This class helps in adapting the size of a card and its children based on the dimensions of
/// the parent container. You can set the current dimensions of the parent and the target dimensions
/// that you want the card to adapt to.
class ResponsiveCardConfig {
  /// The current width of the parent container.
  static late double currentParentWidthValue;

  /// The current height of the parent container.
  static late double currentParentHeightValue;

  /// The target width of the card, which the responsive card should adapt to.
  static late double targetParentWidthValue;

  /// The target height of the card, which the responsive card should adapt to.
  static late double targetParentHeightValue;

  /// Initializes the configuration for a responsive card.
  ///
  /// This method sets the dimensions of the parent container and the target dimensions for the card.
  ///
  /// [currentParentWidth] is the width of the parent container.
  /// [currentParentHeight] is the height of the parent container.
  /// [targetParentWidth] is the width that the card should adapt to. Defaults to 300.
  /// [targetParentHeight] is the height that the card should adapt to. Defaults to 400.
  void init({
    required double currentParentWidth,
    required double currentParentHeight,
    double targetParentWidth = 300,
    double targetParentHeight = 400,
  }) {
    currentParentHeightValue = currentParentHeight;
    currentParentWidthValue = currentParentWidth;
    targetParentHeightValue = targetParentHeight;
    targetParentWidthValue = targetParentWidth;
  }
}
