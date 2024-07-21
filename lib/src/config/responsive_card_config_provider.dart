import 'responsive_card_config.dart';

extension AdaptiveSizeProvider on num {
  double get fw {
    return (ResponsiveCardConfig.currentParentWidthValue * this) /
        ResponsiveCardConfig.targetParentWidthValue;
  }

  double get fh {
    return (ResponsiveCardConfig.currentParentHeightValue * this) /
        ResponsiveCardConfig.targetParentHeightValue;
  }
}
