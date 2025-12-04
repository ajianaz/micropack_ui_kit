import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Loading states for progressive image
enum MPProgressiveImageState {
  loading,
  thumbnailLoaded,
  imageLoaded,
  error,
}

/// Placeholder types for progressive image
enum MPProgressiveImagePlaceholder {
  none,
  shimmer,
  skeleton,
  custom,
}

/// Progressive image widget with smooth loading transitions
///
/// This widget provides:
/// - Thumbnail preview loading
/// - Smooth fade-in animations
/// - Error handling with retry mechanisms
/// - Progress indicators
/// - Memory and caching optimizations
/// - Multiple placeholder options
class MPProgressiveImage extends StatefulWidget {
  const MPProgressiveImage({
    super.key,
    required this.imageUrl,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholderType = MPProgressiveImagePlaceholder.shimmer,
    this.customPlaceholder,
    this.errorPlaceholder,
    this.showProgress = false,
    this.progressColor,
    this.placeholderColor,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.errorRetryDuration = const Duration(seconds: 3),
    this.maxRetries = 3,
    this.cacheWidth,
    this.cacheHeight,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.onLoaded,
    this.onError,
    this.onRetry,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.boxShadow,
    this.border,
  });

  /// Main image URL to load
  final String imageUrl;

  /// Optional thumbnail URL for preview
  final String? thumbnailUrl;

  /// Image dimensions
  final double? width;
  final double? height;

  /// How the image should be inscribed into the space
  final BoxFit fit;

  /// Type of placeholder to show while loading
  final MPProgressiveImagePlaceholder placeholderType;

  /// Custom placeholder widget
  final Widget? customPlaceholder;

  /// Custom error placeholder widget
  final Widget? errorPlaceholder;

  /// Show progress indicator during loading
  final bool showProgress;

  /// Progress indicator color
  final Color? progressColor;

  /// Placeholder background color
  final Color? placeholderColor;

  /// Duration for fade-in animation
  final Duration fadeDuration;

  /// Duration before automatic retry on error
  final Duration errorRetryDuration;

  /// Maximum number of retry attempts
  final int maxRetries;

  /// Optional cache dimensions for optimization
  final int? cacheWidth;
  final int? cacheHeight;

  /// Semantic description for accessibility
  final String? semanticLabel;

  /// Whether to exclude from semantics
  final bool excludeFromSemantics;

  /// Callback when image loads successfully
  final VoidCallback? onLoaded;

  /// Callback when image fails to load
  final VoidCallback? onError;

  /// Callback when retry is attempted
  final VoidCallback? onRetry;

  /// Border radius for the image
  final BorderRadius? borderRadius;

  /// Clip behavior for the image
  final Clip clipBehavior;

  /// Box shadow for the image
  final List<BoxShadow>? boxShadow;

  /// Border for the image
  final Border? border;

  @override
  State<MPProgressiveImage> createState() => _MPProgressiveImageState();
}

class _MPProgressiveImageState extends State<MPProgressiveImage>
    with TickerProviderStateMixin {
  MPProgressiveImageState _imageState = MPProgressiveImageState.loading;
  int _retryCount = 0;
  double _loadingProgress = 0.0;
  ImageStream? _imageStream;
  ImageStream? _thumbnailStream;
  ImageInfo? _thumbnailInfo;
  ImageInfo? _imageInfo;
  Timer? _retryTimer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadImage();
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_imageStreamListener));
    _thumbnailStream
        ?.removeListener(ImageStreamListener(_thumbnailStreamListener));
    _retryTimer?.cancel();
    _fadeController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MPProgressiveImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl ||
        oldWidget.thumbnailUrl != widget.thumbnailUrl) {
      _resetAndLoad();
    }
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: widget.fadeDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    if (widget.placeholderType == MPProgressiveImagePlaceholder.shimmer) {
      _shimmerController.repeat();
    }
  }

  void _resetAndLoad() {
    _imageStream?.removeListener(ImageStreamListener(_imageStreamListener));
    _thumbnailStream
        ?.removeListener(ImageStreamListener(_thumbnailStreamListener));
    _retryTimer?.cancel();
    _retryCount = 0;
    _loadingProgress = 0.0;
    _thumbnailInfo = null;
    _imageInfo = null;
    _fadeController.reset();
    setState(() {
      _imageState = MPProgressiveImageState.loading;
    });
    _loadImage();
  }

  void _loadImage() {
    // Load thumbnail first if available
    if (widget.thumbnailUrl != null) {
      _loadThumbnail();
    } else {
      _loadMainImage();
    }
  }

  void _loadThumbnail() {
    final thumbnailImage = Image.network(
      widget.thumbnailUrl!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      cacheWidth: widget.cacheWidth,
      cacheHeight: widget.cacheHeight,
    );

    _thumbnailStream = thumbnailImage.image.resolve(const ImageConfiguration());
    _thumbnailStream!
        .addListener(ImageStreamListener(_thumbnailStreamListener));
  }

  void _loadMainImage() {
    final image = Image.network(
      widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      cacheWidth: widget.cacheWidth,
      cacheHeight: widget.cacheHeight,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null && widget.showProgress) {
          final total = loadingProgress.expectedTotalBytes ?? 1;
          final loaded = loadingProgress.cumulativeBytesLoaded;
          _loadingProgress = loaded / total;
          if (mounted) setState(() {});
        }
        return child;
      },
    );

    _imageStream = image.image.resolve(const ImageConfiguration());
    _imageStream!.addListener(ImageStreamListener(_imageStreamListener));
  }

  void _thumbnailStreamListener(ImageInfo info, bool sync) {
    if (mounted) {
      setState(() {
        _thumbnailInfo = info;
        _imageState = MPProgressiveImageState.thumbnailLoaded;
      });
      _loadMainImage();
    }
  }

  void _imageStreamListener(ImageInfo info, bool sync) {
    if (mounted) {
      setState(() {
        _imageInfo = info;
        _imageState = MPProgressiveImageState.imageLoaded;
      });
      _fadeController.forward();
      widget.onLoaded?.call();
    }
  }

  void _handleError() {
    if (mounted) {
      setState(() {
        _imageState = MPProgressiveImageState.error;
      });
      widget.onError?.call();

      if (_retryCount < widget.maxRetries) {
        _scheduleRetry();
      }
    }
  }

  void _scheduleRetry() {
    _retryTimer = Timer(widget.errorRetryDuration, () {
      _retryCount++;
      widget.onRetry?.call();
      _loadImage();
    });
  }

  void _retryManually() {
    _retryCount++;
    widget.onRetry?.call();
    setState(() {
      _imageState = MPProgressiveImageState.loading;
    });
    _loadImage();
  }

  Widget _buildPlaceholder() {
    switch (widget.placeholderType) {
      case MPProgressiveImagePlaceholder.none:
        return Container(
          width: widget.width,
          height: widget.height,
          color: widget.placeholderColor ?? context.mp.neutral20,
        );
      case MPProgressiveImagePlaceholder.shimmer:
        return _buildShimmerPlaceholder();
      case MPProgressiveImagePlaceholder.skeleton:
        return _buildSkeletonPlaceholder();
      case MPProgressiveImagePlaceholder.custom:
        return widget.customPlaceholder ?? _buildDefaultPlaceholder();
    }
  }

  Widget _buildShimmerPlaceholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.placeholderColor ?? context.mp.neutral20,
        borderRadius: widget.borderRadius,
      ),
      child: AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              gradient: LinearGradient(
                begin: Alignment(_shimmerAnimation.value, 0),
                end: Alignment(_shimmerAnimation.value + 1, 0),
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonPlaceholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.placeholderColor ?? context.mp.neutral20,
        borderRadius: widget.borderRadius,
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: context.mp.neutral40,
        ),
      ),
    );
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.placeholderColor ?? context.mp.neutral20,
      child: Center(
        child: SpinKitCircle(
          color: widget.progressColor ?? context.mp.primary,
          size: 32.0,
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    if (widget.errorPlaceholder != null) {
      return widget.errorPlaceholder!;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.placeholderColor ?? context.mp.neutral20,
        borderRadius: widget.borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 48,
            color: context.mp.neutral40,
          ),
          const SizedBox(height: 8),
          Text(
            'Failed to load image',
            style: TextStyle(
              color: context.mp.neutral60,
              fontSize: 14,
            ),
          ),
          if (_retryCount < widget.maxRetries) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _retryManually,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: context.mp.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Retry',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (!widget.showProgress) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: widget.progressColor ?? context.mp.primary,
              size: 32.0,
            ),
            if (_loadingProgress > 0) ...[
              const SizedBox(height: 12),
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: LinearProgressIndicator(
                  value: _loadingProgress,
                  backgroundColor: context.mp.neutral20,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.progressColor ?? context.mp.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(_loadingProgress * 100).round()}%',
                style: TextStyle(
                  color: context.mp.neutral60,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    Widget imageWidget;

    switch (_imageState) {
      case MPProgressiveImageState.loading:
        imageWidget = _buildPlaceholder();
      case MPProgressiveImageState.thumbnailLoaded:
        imageWidget = RawImage(
          image: _thumbnailInfo?.image,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      case MPProgressiveImageState.imageLoaded:
        imageWidget = FadeTransition(
          opacity: _fadeAnimation,
          child: RawImage(
            image: _imageInfo?.image,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          ),
        );
      case MPProgressiveImageState.error:
        imageWidget = _buildErrorWidget();
    }

    // Add progress indicator if loading
    if (_imageState == MPProgressiveImageState.loading && widget.showProgress) {
      imageWidget = Stack(
        children: [
          imageWidget,
          _buildProgressIndicator(),
        ],
      );
    }

    // Apply border radius and other decorations
    if (widget.borderRadius != null ||
        widget.boxShadow != null ||
        widget.border != null) {
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
          border: widget.border,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          clipBehavior: widget.clipBehavior,
          child: imageWidget,
        ),
      );
    }

    return imageWidget;
  }

  @override
  Widget build(BuildContext context) {
    Widget image = _buildImage();

    if (widget.semanticLabel != null && !widget.excludeFromSemantics) {
      image = Semantics(
        label: widget.semanticLabel,
        image: true,
        child: image,
      );
    }

    return image;
  }
}

/// Predefined styles for MPProgressiveImage
class MPProgressiveImageStyles {
  /// Card image style with rounded corners and shadow
  static Widget card({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    VoidCallback? onLoaded,
    VoidCallback? onError,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      fit: fit,
      placeholderType: MPProgressiveImagePlaceholder.shimmer,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      onLoaded: onLoaded,
      onError: onError,
    );
  }

  /// Avatar style with circular shape
  static Widget avatar({
    required String imageUrl,
    String? thumbnailUrl,
    double size = 48,
    VoidCallback? onLoaded,
    VoidCallback? onError,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholderType: MPProgressiveImagePlaceholder.skeleton,
      borderRadius: BorderRadius.circular(size / 2),
      onLoaded: onLoaded,
      onError: onError,
    );
  }

  /// Hero image style for full-width images
  static Widget hero({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double? height,
    VoidCallback? onLoaded,
    VoidCallback? onError,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholderType: MPProgressiveImagePlaceholder.shimmer,
      showProgress: true,
      fadeDuration: const Duration(milliseconds: 500),
      onLoaded: onLoaded,
      onError: onError,
    );
  }

  /// Thumbnail style for small preview images
  static Widget thumbnail({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double? height,
    VoidCallback? onLoaded,
    VoidCallback? onError,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholderType: MPProgressiveImagePlaceholder.skeleton,
      borderRadius: BorderRadius.circular(8),
      fadeDuration: const Duration(milliseconds: 200),
      onLoaded: onLoaded,
      onError: onError,
    );
  }

  /// Gallery style with enhanced error handling
  static Widget gallery({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double? height,
    VoidCallback? onLoaded,
    VoidCallback? onError,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholderType: MPProgressiveImagePlaceholder.shimmer,
      showProgress: true,
      maxRetries: 5,
      errorRetryDuration: const Duration(seconds: 2),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      onLoaded: onLoaded,
      onError: onError,
    );
  }

  /// Minimal style with no placeholder
  static Widget minimal({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double? height,
    VoidCallback? onLoaded,
    VoidCallback? onError,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholderType: MPProgressiveImagePlaceholder.none,
      fadeDuration: const Duration(milliseconds: 150),
      onLoaded: onLoaded,
      onError: onError,
    );
  }
}
