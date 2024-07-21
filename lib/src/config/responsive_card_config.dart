class ResponsiveCardConfig {
  static late double currentParentWidthValue;
  static late double currentParentHeightValue;
  static late double targetParentWidthValue;
  static late double targetParentHeightValue;

  void init({
    required double currentParentWidth,
    required double currentParentHeight,
    double targetParentWidth = 328,
    double targetParentHeight = 452,
  }) {
    currentParentHeightValue = currentParentHeight;
    currentParentWidthValue = currentParentWidth;
    targetParentHeightValue = targetParentHeight;
    targetParentWidthValue = targetParentWidth;
  }
}
