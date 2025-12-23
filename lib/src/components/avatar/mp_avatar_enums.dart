part of 'mp_avatar.dart';

/// Size variants for avatar
enum MPAvatarSize {
  /// Extra small (24px)
  xs,

  /// Small (32px)
  small,

  /// Medium (40px)
  medium,

  /// Large (56px)
  large,

  /// Extra large (72px)
  xl,

  /// Double extra large (96px)
  xxl,
}

/// Content type for avatar
enum MPAvatarType {
  /// Image from provider
  image,

  /// Initials from name
  initials,

  /// Icon only
  icon,

  /// Placeholder (no content)
  placeholder,
}

/// Shape variant for avatar
enum MPAvatarShape {
  /// Circular avatar
  circle,

  /// Rounded square avatar
  roundedSquare,
}
