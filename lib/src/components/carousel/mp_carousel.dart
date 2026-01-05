import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_helper.dart';

import 'mp_carousel_variant.dart';

/// A carousel component with adaptive theming support
///
/// Follows theme rules:
/// - Uses adaptive background colors
/// - Indicators use semantic colors
/// - Supports all theme modes
class MPCarousel extends StatelessWidget {
  /// List of widgets to display in the carousel
  final List<Widget> items;

  /// Carousel display variant
  final MPCarouselVariant variant;

  /// Enable/disable page indicators
  final bool showIndicator;

  /// Auto-play duration in seconds
  final int autoPlayDuration;

  /// Enable infinite scroll
  final bool infiniteScroll;

  /// Enable auto-play
  final bool autoPlay;

  /// Height of the carousel
  final double? height;

  /// Aspect ratio (overrides height if provided)
  final double? aspectRatio;

  /// Callback when page changes
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  const MPCarousel({
    super.key,
    required this.items,
    this.variant = MPCarouselVariant.standard,
    this.showIndicator = true,
    this.autoPlayDuration = 3,
    this.infiniteScroll = true,
    this.autoPlay = true,
    this.height,
    this.aspectRatio,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.mp;

    // Get carousel height based on variant
    final carouselHeight = height ?? _getHeightForVariant(context);

    return CarouselSliderX(
      options: CarouselOptionsX(
        height: carouselHeight,
        aspectRatio: aspectRatio ?? 0.0,
        viewportFraction: _getViewportFraction(),
        initialPage: 0,
        enableInfiniteScroll: infiniteScroll,
        reverse: false,
        autoPlay: autoPlay,
        autoPlayInterval: Duration(seconds: autoPlayDuration),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: _shouldEnlargeCenterPage(),
        scrollDirection: Axis.horizontal,
        onPageChanged: onPageChanged,
      ),
      items: items.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: _getPadding(context),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: _getBorderRadius(),
                border: Border.all(
                  color: theme.borderColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.adaptiveShadowColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: _getBorderRadius(),
                child: item,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  double _getHeightForVariant(BuildContext context) {
    switch (variant) {
      case MPCarouselVariant.compact:
        return 150;
      case MPCarouselVariant.hero:
        return MediaQuery.of(context).size.height * 0.6;
      case MPCarouselVariant.fullWidth:
        return 250;
      case MPCarouselVariant.standard:
        return 200;
    }
  }

  double _getViewportFraction() {
    switch (variant) {
      case MPCarouselVariant.fullWidth:
        return 1.0;
      case MPCarouselVariant.hero:
        return 0.9;
      default:
        return 0.85;
    }
  }

  bool _shouldEnlargeCenterPage() {
    return variant == MPCarouselVariant.hero;
  }

  EdgeInsets _getPadding(BuildContext context) {
    switch (variant) {
      case MPCarouselVariant.fullWidth:
        return EdgeInsets.zero;
      case MPCarouselVariant.hero:
        return const EdgeInsets.symmetric(horizontal: 16);
      default:
        return const EdgeInsets.symmetric(horizontal: 8);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (variant) {
      case MPCarouselVariant.fullWidth:
        return BorderRadius.zero;
      case MPCarouselVariant.hero:
        return const BorderRadius.all(Radius.circular(16));
      default:
        return const BorderRadius.all(Radius.circular(12));
    }
  }
}
