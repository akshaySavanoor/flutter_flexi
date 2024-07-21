/// Defines the type of user device based on its orientation and form factor.
///
/// This enum categorizes devices into different types based on their orientation and
/// screen size. It helps in determining how to adapt UI elements for different device types.
enum UserDeviceType {
  /// Represents a phone in portrait mode.
  phonePortrait,

  /// Represents a phone in landscape mode.
  phoneLandscape,

  /// Represents a tablet in landscape mode.
  tabletLandscape,

  /// Represents a desktop computer.
  desktop,
}

/// Defines the target device type for responsive design.
///
/// This enum specifies the target device types for which the responsive design should be optimized.
/// It is used to determine the design values and how the UI should adapt to different screen sizes.
enum TargetDeviceType {
  /// Represents a phone in portrait mode.
  phonePortrait,

  /// Represents a desktop computer.
  desktop,
}
