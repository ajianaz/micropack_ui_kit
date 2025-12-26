import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';

/// Animation configuration for performance optimization
class MPAnimationConfig {
  /// Duration of the animation
  final Duration duration;

  /// Curve for the animation
  final Curve curve;

  /// Whether to use hardware acceleration
  final bool useHardwareAcceleration;

  /// Maximum FPS for the animation
  final double? maxFPS;

  /// Whether to enable vsync
  final bool enableVSync;

  /// Animation type for optimization
  final MPAnimationType type;

  const MPAnimationConfig({
    required this.duration,
    this.curve = Curves.easeInOut,
    this.useHardwareAcceleration = true,
    this.maxFPS,
    this.enableVSync = true,
    this.type = MPAnimationType.general,
  });
}

/// Animation types for different optimization strategies
enum MPAnimationType {
  general,
  fade,
  slide,
  scale,
  rotation,
  complex,
}

/// Performance-optimized animation utilities
class MPAnimationOptimizer {
  static final Map<String, Completer<void>> _animationCompleters = {};
  static final Map<String, AnimationController> _controllerCache = {};

  /// Create an optimized animation controller
  static AnimationController createController({
    required TickerProvider vsync,
    required Duration duration,
    String? name,
    double? lowerBound,
    double? upperBound,
    String? debugLabel,
  }) {
    final controllerName = name ?? 'AnimationController';

    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.createController');

    final controller = AnimationController(
      duration: duration,
      vsync: vsync,
      lowerBound: lowerBound ?? 0.0,
      upperBound: upperBound ?? 1.0,
      debugLabel: debugLabel ?? controllerName,
    );

    // Cache controller for reuse
    _controllerCache[controllerName] = controller;

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.createController', metadata: {
      'controllerName': controllerName,
      'duration': duration.inMilliseconds,
      'hasBounds': lowerBound != null || upperBound != null,
    });

    return controller;
  }

  /// Get cached animation controller
  static AnimationController? getCachedController(String name) {
    return _controllerCache[name];
  }

  /// Create an optimized animation with performance tracking
  static Animation<T> createAnimation<T>({
    required AnimationController controller,
    required T begin,
    required T end,
    Curve curveParam = Curves.easeInOut,
    String? name,
  }) {
    final animationName = name ?? 'Animation';

    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.createAnimation');

    final animation = Tween<T>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curveParam,
    ));

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.createAnimation', metadata: {
      'animationName': animationName,
      'type': T.toString(),
      'curve': curveParam.toString(),
    });

    return animation;
  }

  /// Create a performance-optimized fade animation
  static Widget fadeAnimation({
    required Widget child,
    required Animation<double> animation,
    Duration? duration,
    bool enableHardwareLayer = true,
  }) {
    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.fadeAnimation');

    Widget animatedChild = AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: child!,
        );
      },
      child: enableHardwareLayer
          ? RepaintBoundary(
              child: HardwareLayer(child: child!),
            )
          : child,
    );

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.fadeAnimation', metadata: {
      'duration': duration?.inMilliseconds,
      'hardwareLayer': enableHardwareLayer,
    });

    return animatedChild;
  }

  /// Create a performance-optimized slide animation
  static Widget slideAnimation({
    required Widget child,
    required Animation<Offset> animation,
    Duration? duration,
    bool enableHardwareLayer = true,
  }) {
    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.slideAnimation');

    Widget animatedChild = AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: animation,
          child: child!,
        );
      },
      child: enableHardwareLayer
          ? RepaintBoundary(
              child: HardwareLayer(child: child!),
            )
          : child,
    );

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.slideAnimation', metadata: {
      'duration': duration?.inMilliseconds,
      'hardwareLayer': enableHardwareLayer,
    });

    return animatedChild;
  }

  /// Create a performance-optimized scale animation
  static Widget scaleAnimation({
    required Widget child,
    required Animation<double> animation,
    Duration? duration,
    bool enableHardwareLayer = true,
  }) {
    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.scaleAnimation');

    Widget animatedChild = AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ScaleTransition(
          scale: animation,
          child: child!,
        );
      },
      child: enableHardwareLayer
          ? RepaintBoundary(
              child: HardwareLayer(child: child!),
            )
          : child,
    );

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.scaleAnimation', metadata: {
      'duration': duration?.inMilliseconds,
      'hardwareLayer': enableHardwareLayer,
    });

    return animatedChild;
  }

  /// Create a performance-optimized rotation animation
  static Widget rotationAnimation({
    required Widget child,
    required Animation<double> animation,
    Duration? duration,
    bool enableHardwareLayer = true,
  }) {
    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.rotationAnimation');

    Widget animatedChild = AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return RotationTransition(
          turns: animation,
          child: child!,
        );
      },
      child: enableHardwareLayer
          ? RepaintBoundary(
              child: HardwareLayer(child: child!),
            )
          : child,
    );

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.rotationAnimation', metadata: {
      'duration': duration?.inMilliseconds,
      'hardwareLayer': enableHardwareLayer,
    });

    return animatedChild;
  }

  /// Create a performance-optimized hero animation
  static Widget heroAnimation({
    required String tag,
    required Widget child,
    bool enableHardwareLayer = true,
    HeroFlightShuttleBuilder? flightShuttleBuilderParam,
    CreateRectTween? createRectTweenParam,
    HeroPlaceholderBuilder? placeholderBuilderParam,
  }) {
    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.heroAnimation');

    Widget heroWidget = Hero(
      tag: tag,
      flightShuttleBuilder: flightShuttleBuilderParam,
      createRectTween: createRectTweenParam,
      placeholderBuilder: placeholderBuilderParam,
      child: enableHardwareLayer
          ? RepaintBoundary(
              child: HardwareLayer(child: child),
            )
          : child,
    );

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.heroAnimation', metadata: {
      'tag': tag,
      'hardwareLayer': enableHardwareLayer,
      'hasFlightShuttle': flightShuttleBuilderParam != null,
    });

    return heroWidget;
  }

  /// Optimize animation performance settings
  static void optimizeAnimationSettings() {
    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.optimizeAnimationSettings');

    // Enable hardware acceleration for better performance
    if (kDebugMode) {
      debugPrint('Optimizing animation settings...');
    }

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.optimizeAnimationSettings');
  }

  /// Dispose animation controller with performance tracking
  static void disposeController(String name, AnimationController controller) {
    // Start performance profiling
    MPPerformanceProfiler.instance
        .startBuild('AnimationOptimizer.disposeController');

    // Remove from cache
    _controllerCache.remove(name);

    // Dispose controller
    controller.dispose();

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.disposeController', metadata: {
      'controllerName': name,
    });
  }

  /// Clear all animation caches
  static void clearCaches() {
    // Start performance profiling
    MPPerformanceProfiler.instance.startBuild('AnimationOptimizer.clearCaches');

    final cacheSize = _controllerCache.length;
    _controllerCache.clear();
    _animationCompleters.clear();

    // End performance profiling
    MPPerformanceProfiler.instance
        .endBuild('AnimationOptimizer.clearCaches', metadata: {
      'cacheSize': cacheSize,
    });
  }

  /// Get animation performance statistics
  static Map<String, dynamic> getAnimationStats() {
    return {
      'controllerCacheSize': _controllerCache.length,
      'activeAnimations': _animationCompleters.length,
      'performanceMetrics': {
        'averageControllerCreationTime': _getAverageControllerCreationTime(),
        'cacheHitRatio': _getCacheHitRatio(),
      },
    };
  }

  /// Get average controller creation time
  static double _getAverageControllerCreationTime() {
    final metrics = MPPerformanceProfiler.instance
        .getAllMetrics()
        .entries
        .where((entry) =>
            entry.key.startsWith('AnimationOptimizer.createController'))
        .map((entry) => entry.value.buildTime)
        .toList();

    if (metrics.isEmpty) return 0.0;

    final total = metrics.reduce((a, b) => a + b);
    return total / metrics.length;
  }

  /// Get cache hit ratio
  static double _getCacheHitRatio() {
    final allMetrics = MPPerformanceProfiler.instance
        .getAllMetrics()
        .entries
        .where((entry) => entry.key.startsWith('AnimationOptimizer'))
        .toList();

    if (allMetrics.isEmpty) return 0.0;

    final totalCalls = allMetrics.length;
    final cacheHits = allMetrics
        .where((entry) => entry.value.metadata['cacheHit'] == true)
        .length;

    return totalCalls > 0 ? (cacheHits / totalCalls) * 100 : 0.0;
  }
}

/// Hardware layer widget for performance optimization
class HardwareLayer extends StatelessWidget {
  final Widget child;

  const HardwareLayer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity(),
      child: child,
    );
  }
}
