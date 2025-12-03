import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Progressive image loading widget
/// 
/// This widget provides smooth image loading with thumbnail
/// preview, placeholder, and error states with configurable animations.
class MPProgressiveImage extends StatefulWidget {
  const MPProgressiveImage({
    super.key,
    required this.imageUrl,
    this.placeholderImage,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.placeholderWidget,
    this.errorWidget,
    this.loadingWidget,
    this.progressWidget,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeInOut,
    this.enableCache = true,
    this.retryCount = 3,
    this.onError,
    this.onLoaded,
    this.onProgress,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.showProgress = false,
    this.progressHeight = 4.0,
    this.progressColor,
    this.backgroundColor,
    this.semanticLabel,
  });

  final String imageUrl;
  final String? placeholderImage;
  final String? thumbnailUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget? Function(double progress)? progressWidget;
  final Duration animationDuration;
  final Curve animationCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final bool enableCache;
  final int retryCount;
  final VoidCallback? onError;
  final VoidCallback? onLoaded;
  final void Function(double progress)? onProgress;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final bool showProgress;
  final double progressHeight;
  final Color? progressColor;
  final Color? backgroundColor;
  final String? semanticLabel;

  @override
  State<MPProgressiveImage> createState() => _MPProgressiveImageState();
}

class _MPProgressiveImageState extends State<MPProgressiveImage>
    with TickerProviderStateMixin {
  late ImageProvider _imageProvider;
  late ImageProvider _thumbnailProvider;
  late ImageStream _imageStream;
  late ImageStream _thumbnailStream;
  
  ImageInfo? _imageInfo;
  ImageInfo? _thumbnailInfo;
  bool _isLoading = true;
  bool _hasError = false;
  bool _showThumbnail = false;
  double _loadingProgress = 0.0;
  int _currentRetry = 0;
  
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadImages();
  }

  @override
  void dispose() {
    _imageStream.removeListener(_handleImageStream);
    _thumbnailStream.removeListener(_handleThumbnailStream);
    _fadeController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: widget.fadeInDuration,
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: widget.fadeInCurve,
    ));
  }

  void _loadImages() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _loadingProgress = 0.0;
    });

    // Load main image
    _imageProvider = _getImageProvider(widget.imageUrl);
    _imageStream = _imageProvider.resolve(createLocalImageConfiguration(context));
    _imageStream.addListener(_handleImageStream);

    // Load thumbnail if provided
    if (widget.thumbnailUrl != null) {
      _thumbnailProvider = _getImageProvider(widget.thumbnailUrl!);
      _thumbnailStream = _thumbnailProvider.resolve(createLocalImageConfiguration(context));
      _thumbnailStream.addListener(_handleThumbnailStream);
    }
  }

  ImageProvider _getImageProvider(String url) {
    if (widget.enableCache) {
      return NetworkImage(url);
    } else {
      return NetworkImage(url, scale: 1.0);
    }
  }

  void _handleImageStream(ImageInfo info, bool synchronousCall) {
    setState(() {
      _imageInfo = info;
      _isLoading = false;
      _loadingProgress = 1.0;
      _showThumbnail = false;
    });
    
    _fadeController.forward();
    widget.onLoaded?.call();
    widget.onProgress?.call(1.0);
  }

  void _handleThumbnailStream(ImageInfo info, bool synchronousCall) {
    setState(() {
      _thumbnailInfo = info;
      _showThumbnail = true;
    });
  }

  void _handleError() {
    if (_currentRetry < widget.retryCount) {
      _currentRetry++;
      _loadImages();
    } else {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      
      widget.onError?.call();
    }
  }

  Widget _buildContent() {
    if (_hasError) {
      return _buildErrorWidget();
    }
    
    if (_imageInfo != null) {
      return _buildMainImage();
    }
    
    if (_showThumbnail && _thumbnailInfo != null) {
      return _buildThumbnailImage();
    }
    
    return _buildPlaceholderWidget();
  }

  Widget _buildMainImage() {
    return Stack(
      children: [
        // Main image
        RawImage(
          image: _imageInfo!.image,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          alignment: widget.alignment,
        ),
        
        // Fade in overlay
        AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                width: widget.width,
                height: widget.height,
                color: Colors.transparent,
              ),
            );
          },
        ),
        
        // Progress bar
        if (widget.showProgress) _buildProgressBar(),
      ],
    );
  }

  Widget _buildThumbnailImage() {
    return Stack(
      children: [
        // Thumbnail image
        RawImage(
          image: _thumbnailInfo!.image,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          alignment: widget.alignment,
          filterQuality: FilterQuality.low,
        ),
        
        // Loading overlay
        if (_isLoading) _buildLoadingOverlay(),
        
        // Progress bar
        if (widget.showProgress) _buildProgressBar(),
      ],
    );
  }

  Widget _buildPlaceholderWidget() {
    if (widget.placeholderWidget != null) {
      return Stack(
        children: [
          widget.placeholderWidget!,
          if (_isLoading) _buildLoadingOverlay(),
          if (widget.showProgress) _buildProgressBar(),
        ],
      );
    }

    if (widget.placeholderImage != null) {
      return Stack(
        children: [
          Image.network(
            widget.placeholderImage!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            alignment: widget.alignment,
            errorBuilder: (context, error, stackTrace) {
              return _buildDefaultPlaceholder();
            },
          ),
          if (_isLoading) _buildLoadingOverlay(),
          if (widget.showProgress) _buildProgressBar(),
        ],
      );
    }

    return Stack(
      children: [
        _buildDefaultPlaceholder(),
        if (_isLoading) _buildLoadingOverlay(),
        if (widget.showProgress) _buildProgressBar(),
      ],
    );
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor ?? context.mp.neutral20,
      child: Icon(
        Icons.image_outlined,
        size: _getPlaceholderIconSize(),
        color: context.mp.neutral60,
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.black.withValues(alpha: 0.2),
      child: Center(
        child: SpinKitCircle(
          color: context.mp.primary,
          size: _getLoadingSize(),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    if (widget.errorWidget != null) {
      return widget.errorWidget!;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor ?? context.mp.neutral20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image,
            size: _getErrorIconSize(),
            color: context.mp.neutral60,
          ),
          if (_currentRetry < widget.retryCount) ...[
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _currentRetry = 0;
                _loadImages();
              },
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    if (widget.progressWidget != null) {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: widget.progressWidget!(_loadingProgress),
      );
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: widget.progressHeight,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: (widget.width ?? double.infinity) * _loadingProgress,
            height: widget.progressHeight,
            decoration: BoxDecoration(
              color: widget.progressColor ?? context.mp.primary,
            ),
          ),
        ),
      ),
    );
  }

  double _getPlaceholderIconSize() {
    final minDimension = (widget.width ?? 0).clamp(0.0, widget.height ?? 0);
    return (minDimension * 0.2).clamp(24.0, 48.0);
  }

  double _getLoadingSize() {
    final minDimension = (widget.width ?? 0).clamp(0.0, widget.height ?? 0);
    return (minDimension * 0.15).clamp(16.0, 32.0);
  }

  double _getErrorIconSize() {
    final minDimension = (widget.width ?? 0).clamp(0.0, widget.height ?? 0);
    return (minDimension * 0.25).clamp(32.0, 64.0);
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = _buildContent();
    
    // Apply container styling
    if (widget.borderRadius != null || widget.border != null || widget.boxShadow != null) {
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: widget.border,
          boxShadow: widget.boxShadow,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          child: imageWidget,
        ),
      );
    }

    // Add semantics
    if (widget.semanticLabel != null) {
      imageWidget = Semantics(
        label: widget.semanticLabel,
        image: true,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

/// Progressive image styles for common use cases
class MPProgressiveImageStyles {
  /// Card image style
  static Widget card({
    required String imageUrl,
    String? placeholderImage,
    double? width,
    double height = 200.0,
    BorderRadius? borderRadius,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      placeholderImage: placeholderImage,
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      animationDuration: const Duration(milliseconds: 400),
      fadeInDuration: const Duration(milliseconds: 600),
      showProgress: true,
      progressHeight: 2.0,
    );
  }

  /// Avatar image style
  static Widget avatar({
    required String imageUrl,
    String? placeholderImage,
    double size = 48.0,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      placeholderImage: placeholderImage,
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
      fit: BoxFit.cover,
      animationDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 500),
      loadingWidget: CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.grey[300],
        child: SpinKitCircle(
          color: Colors.grey[600],
          size: size * 0.3,
        ),
      ),
    );
  }

  /// Hero image style
  static Widget hero({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double height = 300.0,
    bool showProgress = true,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      animationDuration: const Duration(milliseconds: 500),
      fadeInDuration: const Duration(milliseconds: 800),
      fadeInCurve: Curves.easeOutCubic,
      showProgress: showProgress,
      progressHeight: 3.0,
      progressColor: Colors.white,
    );
  }

  /// Gallery image style
  static Widget gallery({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double height = 150.0,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(4.0),
      animationDuration: const Duration(milliseconds: 250),
      fadeInDuration: const Duration(milliseconds: 400),
      showProgress: false,
      errorWidget: Container(
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }

  /// Thumbnail grid image style
  static Widget thumbnail({
    required String imageUrl,
    double size = 80.0,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(4.0),
      animationDuration: const Duration(milliseconds: 200),
      fadeInDuration: const Duration(milliseconds: 300),
      showProgress: false,
      placeholderWidget: Container(
        color: Colors.grey[200],
        child: const Icon(Icons.image, color: Colors.grey),
      ),
    );
  }

  /// Banner image style
  static Widget banner({
    required String imageUrl,
    String? thumbnailUrl,
    double? width,
    double height = 120.0,
  }) {
    return MPProgressiveImage(
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      animationDuration: const Duration(milliseconds: 600),
      fadeInDuration: const Duration(milliseconds: 1000),
      fadeInCurve: Curves.easeOutQuart,
      showProgress: true,
      progressHeight: 4.0,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

/// Progressive image with caching and optimization
class MPProgressiveImageOptimized extends StatelessWidget {
  const MPProgressiveImageOptimized({
    super.key,
    required this.imageUrl,
    this.placeholderImage,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.useMemCache = true,
    this.useDiskCache = true,
    this.compressionQuality = 85,
  });

  final String imageUrl;
  final String? placeholderImage;
  final String? thumbnailUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool useMemCache;
  final bool useDiskCache;
  final int compressionQuality;

  @override
  Widget build(BuildContext context) {
    // For optimization, we'd implement more sophisticated caching here
    // This is a simplified version that focuses on the basic progressive loading
    return MPProgressiveImage(
      imageUrl: imageUrl,
      placeholderImage: placeholderImage,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      enableCache: useMemCache,
      animationDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 500),
    );
  }
}
