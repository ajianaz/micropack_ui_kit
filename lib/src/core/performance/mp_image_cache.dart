import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// Image cache entry with metadata
class MPImageCacheEntry {
  final Uint8List bytes;
  final DateTime timestamp;
  final String? etag;
  final int size;
  final Duration? maxAge;

  const MPImageCacheEntry({
    required this.bytes,
    required this.timestamp,
    this.etag,
    required this.size,
    this.maxAge,
  });

  /// Check if cache entry is expired
  bool get isExpired {
    if (maxAge == null) return false;
    return DateTime.now().difference(timestamp) > maxAge!;
  }
}

/// Memory-efficient image cache with LRU eviction
class MPImageCache {
  static const int _maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const int _maxEntries = 500;

  final Map<String, MPImageCacheEntry> _cache = {};
  final List<String> _accessOrder = [];
  int _currentSize = 0;

  /// Get cached image if available and not expired
  Uint8List? get(String url) {
    final entry = _cache[url];
    if (entry == null || entry.isExpired) {
      _cache.remove(url);
      _accessOrder.remove(url);
      return null;
    }

    // Move to end of access order (LRU)
    _accessOrder.remove(url);
    _accessOrder.add(url);

    return entry.bytes;
  }

  /// Store image in cache with size management
  void put(String url, Uint8List bytes, {String? etag, Duration? maxAge}) {
    final entry = MPImageCacheEntry(
      bytes: bytes,
      timestamp: DateTime.now(),
      etag: etag,
      size: bytes.length,
      maxAge: maxAge,
    );

    // Remove existing entry if present
    final existingEntry = _cache[url];
    if (existingEntry != null) {
      _currentSize -= existingEntry.size;
    }

    _cache[url] = entry;
    _currentSize += bytes.length;
    _accessOrder.remove(url);
    _accessOrder.add(url);

    // Evict entries if cache is too large
    _evictIfNecessary();
  }

  /// Evict entries based on LRU and size limits
  void _evictIfNecessary() {
    // Evict based on size limit
    while (_currentSize > _maxCacheSize && _accessOrder.isNotEmpty) {
      final oldestKey = _accessOrder.removeAt(0);
      final removedEntry = _cache.remove(oldestKey);
      if (removedEntry != null) {
        _currentSize -= removedEntry.size;
      }
    }

    // Evict based on entry count limit
    while (_cache.length > _maxEntries && _accessOrder.isNotEmpty) {
      final oldestKey = _accessOrder.removeAt(0);
      final removedEntry = _cache.remove(oldestKey);
      if (removedEntry != null) {
        _currentSize -= removedEntry.size;
      }
    }
  }

  /// Clear cache
  void clear() {
    _cache.clear();
    _accessOrder.clear();
    _currentSize = 0;
  }

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    return {
      'entryCount': _cache.length,
      'currentSizeBytes': _currentSize,
      'currentSizeMB': (_currentSize / (1024 * 1024)).toStringAsFixed(2),
      'maxSizeBytes': _maxCacheSize,
      'maxEntries': _maxEntries,
    };
  }
}

/// Disk cache for persistent image storage
class MPImageDiskCache {
  static const String _cacheDirName = 'mp_image_cache';

  /// Get cache directory
  Future<Directory?> get _cacheDir async {
    try {
      final directory = await getTemporaryDirectory();
      return Directory('${directory.path}/$_cacheDirName');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to get cache directory: $e');
      }
      return null;
    }
  }

  /// Get cached image from disk
  Future<Uint8List?> get(String url) async {
    try {
      final dir = await _cacheDir;
      if (dir == null) return null;

      final file = File('${dir.path}/${_hashUrl(url)}');
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        return bytes;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to read cached image: $e');
      }
    }
    return null;
  }

  /// Store image to disk cache
  Future<void> put(String url, Uint8List bytes) async {
    try {
      final dir = await _cacheDir;
      if (dir == null) return;

      final file = File('${dir.path}/${_hashUrl(url)}');
      await file.writeAsBytes(bytes);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to cache image to disk: $e');
      }
    }
  }

  /// Clear disk cache
  Future<void> clear() async {
    try {
      final dir = await _cacheDir;
      if (dir != null && await dir.exists()) {
        final entities = dir.listSync();
        for (final entity in entities) {
          if (entity is File) {
            await entity.delete();
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to clear disk cache: $e');
      }
    }
  }

  /// Generate hash for URL (simplified)
  String _hashUrl(String url) {
    return url.hashCode.toString();
  }
}

/// Hybrid image cache with memory and disk storage
class MPImageCacheManager {
  static final MPImageCacheManager _instance = MPImageCacheManager._();

  final MPImageCache _memoryCache = MPImageCache();
  final MPImageDiskCache _diskCache = MPImageDiskCache();

  // Cache configuration
  int _memoryThreshold = 50 * 1024; // 50KB
  Duration _maxDiskAge = const Duration(days: 7);

  MPImageCacheManager._();

  /// Get singleton instance
  static MPImageCacheManager get instance => _instance;

  /// Configure cache behavior
  void configure({
    int? memoryThreshold,
    Duration? maxDiskAge,
  }) {
    if (memoryThreshold != null) {
      _memoryThreshold = memoryThreshold;
    }
    if (maxDiskAge != null) {
      _maxDiskAge = maxDiskAge;
    }
  }

  /// Get cached image (memory first, then disk)
  Future<ui.Image?> getImage(String url, {bool? useDiskCache}) async {
    useDiskCache ??= true;

    // Try memory cache first
    final cachedBytes = _memoryCache.get(url);
    if (cachedBytes != null) {
      try {
        final codec = await ui.instantiateImageCodec(cachedBytes);
        final frame = await codec.getNextFrame();
        return frame.image;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Failed to decode cached image: $e');
        }
      }
    }

    // Try disk cache if enabled
    if (useDiskCache == true) {
      final diskBytes = await _diskCache.get(url);
      if (diskBytes != null) {
        // Load into memory cache for future use
        _memoryCache.put(url, diskBytes, maxAge: _maxDiskAge);

        try {
          final codec = await ui.instantiateImageCodec(diskBytes);
          final frame = await codec.getNextFrame();
          return frame.image;
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Failed to decode disk cached image: $e');
          }
        }
      }
    }

    return null;
  }

  /// Preload images into cache
  Future<void> preloadImages(List<String> urls) async {
    final futures = urls.map((url) => _preloadImage(url)).toList();
    await Future.wait(futures);
  }

  /// Preload single image
  Future<void> _preloadImage(String url) async {
    try {
      // For network images, we'd need to download them first
      // This is a simplified implementation
      final Uri uri = Uri.parse(url);
      if (uri.scheme == 'http' || uri.scheme == 'https') {
        // Network image preloading would require HTTP client
        // For now, just trigger disk cache check
        await _diskCache.get(url);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to preload image: $url, error: $e');
      }
    }
  }

  /// Store image in cache
  Future<void> putImage(String url, Uint8List bytes,
      {bool? persistToDisk}) async {
    persistToDisk ??= false;

    // Store in memory cache
    final shouldUseMemoryOnly = bytes.length <= _memoryThreshold;
    _memoryCache.put(url, bytes, maxAge: _maxDiskAge);

    // Store in disk cache if large or persistence requested
    if (!shouldUseMemoryOnly && persistToDisk == true) {
      await _diskCache.put(url, bytes);
    }
  }

  /// Clear all caches
  Future<void> clearAll() async {
    _memoryCache.clear();
    await _diskCache.clear();
  }

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    return {
      'memoryCache': _memoryCache.getStats(),
      'memoryThreshold': _memoryThreshold,
      'maxDiskAge': _maxDiskAge.inHours,
    };
  }
}

/// Widget for cached images with loading states
class MPCachedImage extends StatefulWidget {
  final String imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool useDiskCache;
  final Duration? fadeInDuration;

  const MPCachedImage({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit,
    this.useDiskCache = true,
    this.fadeInDuration,
  }) : super(key: key);

  @override
  State<MPCachedImage> createState() => _MPCachedImageState();
}

class _MPCachedImageState extends State<MPCachedImage>
    with SingleTickerProviderStateMixin {
  ui.Image? _cachedImage;
  bool _isLoading = false;
  bool _hasError = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: widget.fadeInDuration ?? const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _loadImage();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _loadImage() async {
    if (_isLoading || _hasError) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
      _cachedImage = null;
    });

    try {
      final image = await MPImageCacheManager.instance.getImage(
        widget.imageUrl,
        useDiskCache: widget.useDiskCache,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          _cachedImage = image;
          _fadeController.forward();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        if (_cachedImage != null) {
          return RawImage(
            image: _cachedImage!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        }

        if (_isLoading) {
          return widget.placeholder ??
              Container(
                width: widget.width,
                height: widget.height,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
        }

        if (_hasError) {
          return widget.errorWidget ??
              Container(
                width: widget.width,
                height: widget.height,
                color: Colors.grey[200],
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey[400],
                ),
              );
        }

        return Container(
          width: widget.width,
          height: widget.height,
          color: Colors.transparent,
        );
      },
    );
  }
}
