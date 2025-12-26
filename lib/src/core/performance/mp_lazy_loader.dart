import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';

/// Lazy loading configuration for optimizing performance
class MPLazyLoaderConfig {
  /// Threshold for triggering lazy load (in pixels from viewport)
  final double threshold;

  /// Whether to preload items near viewport
  final bool preloadNearby;

  /// Number of items to preload when near viewport
  final int preloadCount;

  /// Whether to use placeholder while loading
  final bool usePlaceholder;

  /// Custom placeholder widget
  final Widget? placeholder;

  /// Custom loading widget
  final Widget? loadingWidget;

  /// Whether to enable memory optimization
  final bool enableMemoryOptimization;

  const MPLazyLoaderConfig({
    this.threshold = 200.0,
    this.preloadNearby = true,
    this.preloadCount = 3,
    this.usePlaceholder = true,
    this.placeholder,
    this.loadingWidget,
    this.enableMemoryOptimization = true,
  });
}

/// Lazy loading widget for optimizing performance with heavy content
class MPLazyLoader extends StatefulWidget {
  final Widget Function() builder;
  final MPLazyLoaderConfig? config;
  final bool enabled;
  final String? name;

  const MPLazyLoader({
    required this.builder,
    this.config,
    this.enabled = true,
    this.name,
  });

  @override
  State<MPLazyLoader> createState() => _MPLazyLoaderState();
}

class _MPLazyLoaderState extends State<MPLazyLoader> {
  bool _isLoaded = false;
  bool _isLoading = false;
  Widget? _cachedWidget;

  late final MPLazyLoaderConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.config ?? const MPLazyLoaderConfig();

    // Start lazy loading if enabled
    if (widget.enabled) {
      _scheduleLazyLoad();
    } else {
      _isLoaded = true;
    }
  }

  @override
  void dispose() {
    // Clear cache when disposing
    if (_config.enableMemoryOptimization) {
      _cachedWidget = null;
    }
    super.dispose();
  }

  void _scheduleLazyLoad() {
    // Delay loading to allow initial render to complete
    Future.delayed(const Duration(milliseconds: 16), () {
      if (mounted && !_isLoaded) {
        _loadWidget();
      }
    });
  }

  void _loadWidget() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Start performance profiling
      final profiler = MPPerformanceProfiler.instance;
      final name = widget.name ?? 'MPLazyLoader';
      profiler.startBuild(name);

      // Build the widget
      final builtWidget = widget.builder();

      // End profiling
      profiler.endBuild(name, metadata: {
        'lazyLoaded': true,
        'config': {
          'threshold': _config.threshold,
          'preloadNearby': _config.preloadNearby,
          'preloadCount': _config.preloadCount,
        },
      });

      if (mounted) {
        setState(() {
          _isLoaded = true;
          _isLoading = false;

          // Cache widget if memory optimization is enabled
          if (_config.enableMemoryOptimization) {
            _cachedWidget = builtWidget;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      debugPrint('Error in lazy loading: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.builder();
    }

    if (_isLoaded) {
      return _cachedWidget ?? widget.builder();
    }

    if (_isLoading) {
      return _config.loadingWidget ?? _buildDefaultLoading();
    }

    return _config.placeholder ?? _buildDefaultPlaceholder();
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildDefaultLoading() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// Lazy loading for list items
class MPLazyListItem<T> extends StatefulWidget {
  final T item;
  final Widget Function(BuildContext context, T item, int index) builder;
  final int index;
  final bool isVisible;
  final VoidCallback? onLoad;

  const MPLazyListItem({
    super.key,
    required this.item,
    required this.builder,
    required this.index,
    required this.isVisible,
    this.onLoad,
  });

  @override
  State<MPLazyListItem> createState() => _MPLazyListItemState<T>();
}

class _MPLazyListItemState<T> extends State<MPLazyListItem<T>> {
  bool _isLoaded = false;
  Widget? _cachedWidget;

  @override
  void initState() {
    super.initState();

    // Load item when it becomes visible
    if (widget.isVisible) {
      _loadItem();
    }
  }

  @override
  void didUpdateWidget(MPLazyListItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Load item when it becomes visible
    if (!oldWidget.isVisible && widget.isVisible && !_isLoaded) {
      _loadItem();
    }
  }

  @override
  void dispose() {
    _cachedWidget = null;
    super.dispose();
  }

  void _loadItem() async {
    if (_isLoaded) return;

    // Start performance profiling
    final profiler = MPPerformanceProfiler.instance;
    final name = 'MPLazyListItem_${T.toString()}';
    profiler.startBuild(name);

    try {
      // Build item
      final builtWidget = widget.builder(context, widget.item, widget.index);

      // End profiling
      profiler.endBuild(name, metadata: {
        'itemIndex': widget.index,
        'itemType': T.toString(),
        'lazyLoaded': true,
      });

      if (mounted) {
        setState(() {
          _isLoaded = true;
          _cachedWidget = builtWidget;
        });

        // Notify parent that item is loaded
        widget.onLoad?.call();
      }
    } catch (e) {
      debugPrint('Error in lazy list item loading: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded) {
      return _cachedWidget ??
          widget.builder(context, widget.item, widget.index);
    }

    // Return placeholder while loading
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

/// Lazy loading utilities
class MPLazyUtils {
  /// Create a lazy loading image widget
  static Widget lazyImage({
    required String imageUrl,
    double? width,
    double? height,
    Widget? placeholder,
    BoxFit? fit,
    String? semanticLabel,
  }) {
    return MPLazyLoader(
      name: 'LazyImage',
      config: const MPLazyLoaderConfig(
        threshold: 100.0,
        preloadNearby: true,
        preloadCount: 2,
      ),
      builder: () {
        return Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          semanticLabel: semanticLabel,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey.withValues(alpha: 0.2),
              child: const Icon(Icons.broken_image),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child; // Image is fully loaded
            }
            return placeholder ?? const SizedBox.shrink();
          },
        );
      },
    );
  }

  /// Create a lazy loading list
  static Widget lazyList<T>({
    required List<T> items,
    required Widget Function(BuildContext context, T item, int index)
        itemBuilder,
    required bool Function(int index) isVisible,
    Widget Function()? separatorBuilder,
    ScrollController? scrollController,
    EdgeInsets? padding,
    bool shrinkWrap = false,
  }) {
    return ListView.builder(
      controller: scrollController,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final itemIsVisible = isVisible(index);

        Widget listItem = MPLazyListItem<T>(
          key: ValueKey(item),
          item: item,
          index: index,
          isVisible: itemIsVisible,
          builder: itemBuilder,
        );

        // Add separator if provided
        if (separatorBuilder != null && index < items.length - 1) {
          return Column(
            children: [
              listItem,
              separatorBuilder!(),
            ],
          );
        }

        return listItem;
      },
    );
  }

  /// Create a lazy loading grid
  static Widget lazyGrid<T>({
    required List<T> items,
    required Widget Function(BuildContext context, T item, int index)
        itemBuilder,
    required bool Function(int index) isVisible,
    int crossAxisCount = 2,
    double? childAspectRatio,
    EdgeInsets? padding,
    SliverGridDelegate? gridDelegate,
  }) {
    return GridView.builder(
      padding: padding,
      gridDelegate: gridDelegate ??
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio ?? 1.0,
          ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final itemIsVisible = isVisible(index);

        return MPLazyListItem<T>(
          key: ValueKey(item),
          item: item,
          index: index,
          isVisible: itemIsVisible,
          builder: itemBuilder,
        );
      },
    );
  }

  /// Check if an item is visible based on scroll position
  static bool isItemVisible({
    required int index,
    required ScrollController scrollController,
    required double itemHeight,
    required double viewportHeight,
    int bufferSize = 3,
  }) {
    if (!scrollController.hasClients) return true;

    final offset = scrollController.offset;
    final itemTop = index * itemHeight;
    final itemBottom = itemTop + itemHeight;
    final viewportTop = offset;
    final viewportBottom = offset + viewportHeight;

    // Item is visible if it's in or near viewport
    return itemBottom >= viewportTop - (bufferSize * itemHeight) &&
        itemTop <= viewportBottom + (bufferSize * itemHeight);
  }

  /// Create a lazy loading page view
  static Widget lazyPageView<T>({
    required List<T> items,
    required Widget Function(BuildContext context, T item, int index)
        itemBuilder,
    required bool Function(int index) isVisible,
    PageController? pageController,
    void Function(int index)? onPageChanged,
    Axis scrollDirection = Axis.horizontal,
  }) {
    return PageView.builder(
      controller: pageController,
      scrollDirection: scrollDirection,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final itemIsVisible = isVisible(index);

        return MPLazyListItem<T>(
          key: ValueKey(item),
          item: item,
          index: index,
          isVisible: itemIsVisible,
          builder: itemBuilder,
          onLoad: () => onPageChanged?.call(index),
        );
      },
    );
  }
}
