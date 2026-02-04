import 'package:flutter/widgets.dart';

import '../constants/constants.dart';
import '../constants/flexi_aspect.dart';
import '../constants/flexi_breakpoint.dart';
import '../widgets/flexi_config.dart';

/// Semantic extensions for [BuildContext] to simplify access to Flexi UI data.
extension FlexiContext on BuildContext {
  /// Access the [FlexiHelper] to get responsive data without manually specifying aspects.
  ///
  /// **Note**: Accessing properties via `context.flexi...` will usually behave like
  /// a full data dependency unless the internal implementation is optimized.
  /// However, for cleaner syntax, this is preferred.
  ///
  /// Currently, accessing `context.flexi` does NOT trigger a rebuild itself,
  /// but accessing properties on the helper MIGHT if we wired it that way.
  /// But `FlexiHelper` is just a wrapper.
  ///
  /// To ensure efficient rebuilds, continue to use `Flexi.of(context, aspect: ...)`
  /// or this helper if it internally delegates correctly.
  ///
  /// Actually, for strictly granular rebuilds, `InheritedModel` requires `inheritFrom`
  /// with an aspect.
  ///
  /// If we want `context.flexi.breakpoint` to only rebuild on breakpoint changes,
  /// this extension needs to be careful.
  ///
  /// Proposed design:
  /// `context.flexi` returns a lightweight helper.
  /// `helper.breakpoint` calls `FlexiInheritedWidget.of(context, aspect: 'breakpoint')`.
  FlexiHelper get flexi => FlexiHelper(this);
}

/// Helper class to provide semantic access to [FlexiConfig] data.
class FlexiHelper {
  final BuildContext _context;

  FlexiHelper(this._context);

  /// The current semantic breakpoint (e.g., phone, tablet, desktop).
  ///
  /// Triggers a rebuild ONLY when the breakpoint changes.
  FlexiBreakpoint get breakpoint {
    // Explicitly listen to 'breakpoint' aspect
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.breakpoint);
    if (data == null) {
      // Fallback or throw? Ideally this shouldn't happen if FlexiConfig is present.
      // If null, we can't really do much. Return a default or throw helpful error.
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.breakpoint;
  }

  /// The current target device type (phone vs desktop design target).
  ///
  /// Triggers a rebuild if the configuration changes (rare).
  TargetDeviceType get deviceType {
    // We listen to breakpoint aspect since device type categorization 
    // is tied to screen dimension categories.
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.breakpoint);
    if (data == null) {
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return data.deviceTypeConfig.targetDeviceType;
  }

  /// The current screen size in logical pixels.
  ///
  /// Triggers a rebuild when width or height changes.
  Size get screenSize {
    // We listen to both width and height.
    // InheritedModel.inheritFrom allows only one aspect string usually,
    // or we call it twice? Calling it twice registers two dependencies.
    // Optimization: 'size' aspect?
    // But our updateShouldNotifyDependent handles 'width' and 'height'.
    // Let's just subscribe to nothing specific (full rebuild) or 'width' and 'height'.
    // The current implementation of updateShouldNotifyDependent checks for 'width' OR 'height'.
    // So if we pass 'width', we get rebuilds on width change.
    
    // Better: let's add 'size' aspect to FlexiInheritedWidget logic if we want strictness,
    // or just assume getting screenSize implies caring about dimensions.
    
    // For now, let's just use the raw data lookup which implicitly rebuilds
    // if we don't assume strict 'allowImplicitRebuilds = false' for this helper.
    // Wait, we ENFORCED explicit aspects.
    
    // So `FlexiInheritedWidget.of(_context)` with no aspect returns data,
    // but in strict mode, it WON'T trigger rebuilds if we return false in updateShouldNotifyDependent!
    
    // CORRECT FIX: We must specify aspects.
    FlexiInheritedWidget.of(_context, aspect: FlexiAspect.width);
    final data = FlexiInheritedWidget.of(_context, aspect: FlexiAspect.height);
    
    if (data == null) {
      throw FlutterError(
          'FlexiConfig not found in context. Make sure to wrap your app with FlexiConfig.');
    }
    return Size(data.screenWidth, data.screenHeight);
  }
}
