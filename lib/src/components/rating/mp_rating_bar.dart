import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

part 'mp_rating_bar_enums.dart';

/// A rating bar component for displaying and collecting star/heart ratings.
///
/// This component provides a flexible rating indicator with multiple variants,
/// sizes, and theme support.
///
/// Example:
/// ```dart
/// MPRatingBar(
///   rating: 4.5,
///   starCount: 5,
///   onRatingChanged: (rating) => print('Rated: $rating'),
/// )
/// ```
class MPRatingBar extends StatelessWidget {
  /// Creates a new [MPRatingBar] widget.
  const MPRatingBar({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.variant = MPRatingVariant.stars,
    this.size = MPRatingSize.medium,
    this.allowHalfRating = true,
    this.readOnly = false,
    this.filledIcon,
    this.emptyIcon,
    this.halfFilledIcon,
    this.color,
    this.unfilledColor,
    this.itemSize,
    this.spacing = 4.0,
    this.onRatingChanged,
    this.semanticLabel,
  });

  /// The current rating value.
  ///
  /// Must be between 0 and [starCount].
  final double rating;

  /// The total number of rating items (stars, hearts, etc.).
  ///
  /// Defaults to 5.
  final int starCount;

  /// The visual style variant of the rating bar.
  final MPRatingVariant variant;

  /// The size of the rating items.
  final MPRatingSize size;

  /// Whether to allow half-step ratings (e.g., 3.5 stars).
  ///
  /// Defaults to true.
  final bool allowHalfRating;

  /// Whether the rating bar is read-only (no interaction).
  ///
  /// Defaults to false.
  final bool readOnly;

  /// Custom icon for filled rating items.
  ///
  /// If null and [variant] is not custom, uses the variant's default icon.
  final IconData? filledIcon;

  /// Custom icon for empty rating items.
  ///
  /// If null and [variant] is not custom, uses the variant's default icon.
  final IconData? emptyIcon;

  /// Custom icon for half-filled rating items.
  ///
  /// If null, a half-filled version of [filledIcon] is used.
  final IconData? halfFilledIcon;

  /// Custom color for filled rating items.
  ///
  /// If null, uses theme color based on [variant].
  final Color? color;

  /// Custom color for unfilled rating items.
  ///
  /// If null, uses a default unfilled color.
  final Color? unfilledColor;

  /// Custom size for rating items.
  ///
  /// If null, uses size based on [size] parameter.
  final double? itemSize;

  /// Spacing between rating items.
  ///
  /// Defaults to 4.0.
  final double spacing;

  /// Callback when the rating changes.
  ///
  /// If null, the rating bar is read-only.
  final ValueChanged<double>? onRatingChanged;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final config = _MPRatingBarConfig();

    final effectiveItemSize = itemSize ?? config.getItemSize(size);
    final effectiveFilledColor = color ?? config.getColor(context);
    final effectiveUnfilledColor =
        unfilledColor ?? config.getUnfilledColor(context);
    final effectiveFilledIcon = filledIcon ?? config.getFilledIcon(variant);
    final effectiveEmptyIcon = emptyIcon ?? config.getEmptyIcon(variant);

    return Semantics(
      label: semanticLabel ?? 'Rating: $rating of $starCount',
      value: rating.toStringAsFixed(allowHalfRating ? 1 : 0),
      hint: readOnly ? 'Read-only rating' : 'Tap to set rating',
      child: _RatingBarWidget(
        rating: rating,
        starCount: starCount,
        allowHalfRating: allowHalfRating,
        readOnly: readOnly || onRatingChanged == null,
        itemSize: effectiveItemSize,
        spacing: spacing,
        filledColor: effectiveFilledColor,
        unfilledColor: effectiveUnfilledColor,
        filledIcon: effectiveFilledIcon,
        emptyIcon: effectiveEmptyIcon,
        halfFilledIcon: halfFilledIcon,
        onRatingChanged: onRatingChanged,
      ),
    );
  }
}

/// Internal widget that handles the actual rating bar rendering and interaction.
class _RatingBarWidget extends StatelessWidget {
  const _RatingBarWidget({
    required this.rating,
    required this.starCount,
    required this.allowHalfRating,
    required this.readOnly,
    required this.itemSize,
    required this.spacing,
    required this.filledColor,
    required this.unfilledColor,
    required this.filledIcon,
    required this.emptyIcon,
    this.halfFilledIcon,
    this.onRatingChanged,
  });

  final double rating;
  final int starCount;
  final bool allowHalfRating;
  final bool readOnly;
  final double itemSize;
  final double spacing;
  final Color filledColor;
  final Color unfilledColor;
  final IconData filledIcon;
  final IconData emptyIcon;
  final IconData? halfFilledIcon;
  final ValueChanged<double>? onRatingChanged;

  Widget _buildStar(int index, BuildContext context) {
    final starValue = index + 1;
    final difference = starValue - rating;

    Widget iconWidget;

    if (difference >= 1) {
      // Empty star
      iconWidget = Icon(
        emptyIcon,
        size: itemSize,
        color: unfilledColor,
      );
    } else if (!allowHalfRating || difference >= 0.5) {
      // Filled star
      iconWidget = Icon(
        filledIcon,
        size: itemSize,
        color: filledColor,
      );
    } else {
      // Half-filled star
      if (halfFilledIcon != null) {
        iconWidget = Icon(
          halfFilledIcon,
          size: itemSize,
          color: filledColor,
        );
      } else {
        // Use a clipping trick to show half-filled star
        iconWidget = SizedBox(
          width: itemSize,
          height: itemSize,
          child: Stack(
            children: [
              Icon(
                emptyIcon,
                size: itemSize,
                color: unfilledColor,
              ),
              ClipRect(
                clipper: _HalfClipper(),
                child: Icon(
                  filledIcon,
                  size: itemSize,
                  color: filledColor,
                ),
              ),
            ],
          ),
        );
      }
    }

    if (readOnly) {
      return iconWidget;
    }

    return GestureDetector(
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.globalToLocal(details.globalPosition);
        final i = (position.dx / (itemSize + spacing)).floor();
        final tapRating = _calculateRating(position.dx, i);
        onRatingChanged
            ?.call(tapRating.clamp(0.0, starCount.toDouble()));
      },
      child: iconWidget,
    );
  }

  double _calculateRating(double dx, int index) {
    if (index < 0 || index >= starCount) return rating;
    final itemWidth = itemSize + spacing;
    final relativeX = dx - (index * itemWidth);
    final ratio = relativeX / itemWidth;
    final value = index + 1.0;

    if (!allowHalfRating) {
      return ratio > 0.5 ? value : value - 1;
    }

    // For half rating, use thresholds
    if (ratio < 0.25) {
      return value - 1;
    } else if (ratio < 0.75) {
      return value - 0.5;
    } else {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index < starCount - 1 ? spacing : 0,
          ),
          child: Builder(
            builder: (context) => _buildStar(index, context),
          ),
        );
      }),
    );
  }
}

/// Clipper for creating half-filled stars.
class _HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

/// Configuration class for MPRatingBar
class _MPRatingBarConfig {
  double getItemSize(MPRatingSize size) {
    switch (size) {
      case MPRatingSize.small:
        return 16;
      case MPRatingSize.medium:
        return 24;
      case MPRatingSize.large:
        return 32;
      case MPRatingSize.extraLarge:
        return 48;
    }
  }

  IconData getFilledIcon(MPRatingVariant variant) {
    switch (variant) {
      case MPRatingVariant.stars:
        return Icons.star;
      case MPRatingVariant.hearts:
        return Icons.favorite;
      case MPRatingVariant.thumbs:
        return Icons.thumb_up;
      case MPRatingVariant.custom:
        return Icons.star;
    }
  }

  IconData getEmptyIcon(MPRatingVariant variant) {
    switch (variant) {
      case MPRatingVariant.stars:
        return Icons.star_border;
      case MPRatingVariant.hearts:
        return Icons.favorite_border;
      case MPRatingVariant.thumbs:
        return Icons.thumb_up_outlined;
      case MPRatingVariant.custom:
        return Icons.star_border;
    }
  }

  Color getColor(BuildContext context) {
    return Colors.amber;
  }

  Color getUnfilledColor(BuildContext context) {
    return context.mp.isDarkMode
        ? const Color(0xFF374151)
        : const Color(0xFFE5E7EB);
  }
}
