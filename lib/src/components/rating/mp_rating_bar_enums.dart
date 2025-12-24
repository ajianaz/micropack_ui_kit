part of 'mp_rating_bar.dart';

/// The visual style variant of a rating bar.
enum MPRatingVariant {
  /// Star icons (default)
  stars,

  /// Heart icons
  hearts,

  /// Thumb up icons
  thumbs,

  /// Custom icons (use [filledIcon] and [emptyIcon])
  custom,
}

/// The size of a rating bar.
enum MPRatingSize {
  /// Small size (16px icons)
  small,

  /// Medium size (24px icons, default)
  medium,

  /// Large size (32px icons)
  large,

  /// Extra large size (48px icons)
  extraLarge,
}
