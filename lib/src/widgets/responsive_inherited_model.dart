import 'package:flutter/widgets.dart';

import '../../flexi_ui.dart';

/// An [InheritedModel] that provides [ResponsiveCardData] to its descendants.
///
/// This allows widgets to subscribe to changes in responsive configuration.
/// Using [InheritedModel] allows for granular rebuilds, though in this specific case,
/// width and height changes usually happen together.
class ResponsiveInheritedModel extends InheritedModel<String> {
  final ResponsiveCardData data;

  const ResponsiveInheritedModel({
    super.key,
    required this.data,
    required super.child,
  });

  static ResponsiveCardData? of(BuildContext context, {String? aspect}) {
    return InheritedModel.inheritFrom<ResponsiveInheritedModel>(context,
            aspect: aspect)
        ?.data;
  }

  @override
  bool updateShouldNotify(ResponsiveInheritedModel oldWidget) {
    return data != oldWidget.data;
  }

  @override
  bool updateShouldNotifyDependent(
    ResponsiveInheritedModel oldWidget,
    Set<String> dependencies,
  ) {
    if (dependencies.contains('width') &&
        data.currentParentWidth != oldWidget.data.currentParentWidth) {
      return true;
    }
    if (dependencies.contains('height') &&
        data.currentParentHeight != oldWidget.data.currentParentHeight) {
      return true;
    }
    // If no specific aspect is requested, rebuild on any data change
    if (dependencies.isEmpty) {
      return data != oldWidget.data;
    }
    return false;
  }
}
