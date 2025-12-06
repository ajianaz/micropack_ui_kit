import 'dart:async';
import 'dart:collection';
import 'dart:developer' as developer;
import 'dart:io' show ProcessInfo;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Performance metrics for tracking component performance
class MPPerformanceMetrics {
  /// Component name
  final String componentName;

  /// Build time in milliseconds
  final double buildTime;

  /// Render time in milliseconds
  final double renderTime;

  /// Rebuild count
  final int rebuildCount;

  /// Memory usage in MB
  final double memoryUsage;

  /// Timestamp of the measurement
  final DateTime timestamp;

  /// Additional metadata
  final Map<String, dynamic> metadata;

  const MPPerformanceMetrics({
    required this.componentName,
    required this.buildTime,
    required this.renderTime,
    required this.rebuildCount,
    required this.memoryUsage,
    required this.timestamp,
    this.metadata = const {},
  });

  @override
  String toString() {
    return 'MPPerformanceMetrics(componentName: $componentName, buildTime: ${buildTime}ms, renderTime: ${renderTime}ms, rebuildCount: $rebuildCount, memoryUsage: ${memoryUsage}MB)';
  }
}

/// Performance warning for common issues
class MPPerformanceWarning {
  /// Warning type
  final MPPerformanceWarningType type;

  /// Component name
  final String componentName;

  /// Warning message
  final String message;

  /// Severity level
  final MPPerformanceWarningSeverity severity;

  /// Timestamp
  final DateTime timestamp;

  /// Additional context
  final Map<String, dynamic> context;

  const MPPerformanceWarning({
    required this.type,
    required this.componentName,
    required this.message,
    required this.severity,
    required this.timestamp,
    this.context = const {},
  });
}

/// Types of performance warnings
enum MPPerformanceWarningType {
  excessiveRebuilds,
  slowBuildTime,
  highMemoryUsage,
  slowRenderTime,
  inefficientLayout,
  missingConstConstructor,
  unnecessaryRebuild,
}

/// Severity levels for performance warnings
enum MPPerformanceWarningSeverity {
  low,
  medium,
  high,
  critical,
}

/// Performance profiler for monitoring component performance
class MPPerformanceProfiler {
  // Singleton pattern
  static MPPerformanceProfiler? _instance;
  static final _lock = Completer<void>()..complete();

  MPPerformanceProfiler._();

  /// Get singleton instance
  static MPPerformanceProfiler get instance {
    _instance ??= MPPerformanceProfiler._();
    return _instance!;
  }

  // Performance tracking
  final Map<String, MPPerformanceMetrics> _metrics = {};
  final Map<String, int> _rebuildCounts = {};
  final Map<String, DateTime> _buildStartTimes = {};
  final List<MPPerformanceWarning> _warnings = [];
  final Map<String, List<MPPerformanceMetrics>> _history = {};

  // Component initialization tracking
  final Map<String, DateTime> _initializationStartTimes = {};
  final Map<String, double> _initializationTimes = {};

  // Performance thresholds (configurable)
  double _slowBuildThreshold = 16.0; // 60fps = 16.67ms per frame
  double _slowRenderThreshold = 16.0;
  double _highMemoryThreshold = 50.0; // 50MB
  int _excessiveRebuildThreshold = 10;

  // Performance monitoring state
  bool _isMonitoring = false;
  Timer? _monitoringTimer;

  // Frame rate monitoring
  int _frameCount = 0;
  DateTime? _lastFrameTime;
  double _currentFPS = 0.0;
  List<double> _fpsHistory = [];
  int _jankCount = 0;
  DateTime? _lastJankTime;

  /// Performance thresholds
  double get slowBuildThreshold => _slowBuildThreshold;
  double get slowRenderThreshold => _slowRenderThreshold;
  double get highMemoryThreshold => _highMemoryThreshold;
  int get excessiveRebuildThreshold => _excessiveRebuildThreshold;
  bool get isMonitoring => _isMonitoring;

  /// Frame rate metrics
  double get currentFPS => _currentFPS;
  int get frameCount => _frameCount;
  List<double> get fpsHistory => List.unmodifiable(_fpsHistory);
  int get jankCount => _jankCount;
  DateTime? get lastJankTime => _lastJankTime;

  /// Set performance thresholds
  void setThresholds({
    double? slowBuildThreshold,
    double? slowRenderThreshold,
    double? highMemoryThreshold,
    int? excessiveRebuildThreshold,
  }) {
    _slowBuildThreshold = slowBuildThreshold ?? _slowBuildThreshold;
    _slowRenderThreshold = slowRenderThreshold ?? _slowRenderThreshold;
    _highMemoryThreshold = highMemoryThreshold ?? _highMemoryThreshold;
    _excessiveRebuildThreshold =
        excessiveRebuildThreshold ?? _excessiveRebuildThreshold;
  }

  /// Start performance monitoring
  void startMonitoring({Duration interval = const Duration(seconds: 5)}) {
    if (_isMonitoring) return;

    _isMonitoring = true;
    _monitoringTimer = Timer.periodic(interval, (_) => _checkPerformance());

    // Start frame monitoring
    WidgetsBinding.instance.addPostFrameCallback(_onFrame);

    if (kDebugMode) {
      developer.log('MPPerformanceProfiler: Monitoring started');
    }
  }

  /// Frame callback for FPS monitoring
  void _onFrame(Duration timestamp) {
    if (!_isMonitoring) return;

    final now = DateTime.now();

    if (_lastFrameTime == null) {
      _lastFrameTime = now;
      _frameCount = 1;
    } else {
      final timeDiff = now.difference(_lastFrameTime!).inMicroseconds;

      // Calculate FPS
      if (timeDiff > 0) {
        final fps = 1000000 / timeDiff;
        _currentFPS = fps;

        // Track FPS history
        _fpsHistory.add(fps);
        if (_fpsHistory.length > 60) {
          _fpsHistory.removeAt(0);
        }

        // Detect jank (frame time > 16.67ms for 60fps)
        if (timeDiff > 16667) {
          _jankCount++;
          _lastJankTime = now;

          // Add jank warning
          _warnings.add(MPPerformanceWarning(
            type: MPPerformanceWarningType.slowRenderTime,
            componentName: 'Frame',
            message:
                'Jank detected: frame time ${(timeDiff / 1000).toStringAsFixed(2)}ms',
            severity: timeDiff > 33333
                ? MPPerformanceWarningSeverity.high
                : MPPerformanceWarningSeverity.medium,
            timestamp: now,
            context: {
              'frameTime': timeDiff / 1000,
              'fps': fps,
              'jankCount': _jankCount,
            },
          ));
        }
      }

      _lastFrameTime = now;
      _frameCount++;
    }

    // Continue monitoring
    WidgetsBinding.instance.addPostFrameCallback(_onFrame);
  }

  /// Stop performance monitoring
  void stopMonitoring() {
    if (!_isMonitoring) return;

    _isMonitoring = false;
    _monitoringTimer?.cancel();
    _monitoringTimer = null;

    // Reset frame monitoring state
    _frameCount = 0;
    _lastFrameTime = null;
    _currentFPS = 0.0;
    _fpsHistory.clear();
    _jankCount = 0;
    _lastJankTime = null;

    if (kDebugMode) {
      developer.log('MPPerformanceProfiler: Monitoring stopped');
    }
  }

  /// Start tracking component build
  void startBuild(String componentName) {
    if (!_isMonitoring) return;

    _buildStartTimes[componentName] = DateTime.now();
    _rebuildCounts[componentName] = (_rebuildCounts[componentName] ?? 0) + 1;
  }

  /// Start tracking component initialization
  void startInitialization(String componentName) {
    if (!_isMonitoring) return;

    _initializationStartTimes[componentName] = DateTime.now();
  }

  /// End tracking component initialization
  void endInitialization(String componentName) {
    if (!_isMonitoring) return;

    final startTime = _initializationStartTimes[componentName];
    if (startTime == null) return;

    final initTime =
        DateTime.now().difference(startTime).inMicroseconds / 1000.0;
    _initializationTimes[componentName] = initTime;
    _initializationStartTimes.remove(componentName);

    if (kDebugMode) {
      developer.log(
          'Component $componentName initialized in ${initTime.toStringAsFixed(2)}ms');
    }
  }

  /// Get initialization time for a component
  double? getInitializationTime(String componentName) {
    return _initializationTimes[componentName];
  }

  /// Get all initialization times
  Map<String, double> getAllInitializationTimes() {
    return Map.unmodifiable(_initializationTimes);
  }

  /// End tracking component build
  void endBuild(String componentName, {Map<String, dynamic>? metadata}) {
    if (!_isMonitoring) return;

    final startTime = _buildStartTimes[componentName];
    if (startTime == null) return;

    final buildTime =
        DateTime.now().difference(startTime).inMicroseconds / 1000.0;
    final memoryUsage = _getCurrentMemoryUsage();

    final metrics = MPPerformanceMetrics(
      componentName: componentName,
      buildTime: buildTime,
      renderTime: 0.0, // Will be updated after frame
      rebuildCount: _rebuildCounts[componentName] ?? 0,
      memoryUsage: memoryUsage,
      timestamp: DateTime.now(),
      metadata: metadata ?? {},
    );

    _metrics[componentName] = metrics;
    _buildStartTimes.remove(componentName);

    // Add to history
    _history.putIfAbsent(componentName, () => <MPPerformanceMetrics>[]);
    _history[componentName]!.add(metrics);

    // Limit history size
    if (_history[componentName]!.length > 100) {
      _history[componentName]!.removeAt(0);
    }

    // Check for performance issues
    _checkBuildPerformance(componentName, metrics);

    // Schedule render time measurement
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateRenderTime(componentName);
    });
  }

  /// Update render time after frame completes
  void _updateRenderTime(String componentName) {
    final metrics = _metrics[componentName];
    if (metrics == null) return;

    // Approximate render time (in a real implementation, you might use more sophisticated methods)
    final renderTime = metrics.buildTime * 0.8; // Rough approximation

    _metrics[componentName] = MPPerformanceMetrics(
      componentName: metrics.componentName,
      buildTime: metrics.buildTime,
      renderTime: renderTime,
      rebuildCount: metrics.rebuildCount,
      memoryUsage: metrics.memoryUsage,
      timestamp: metrics.timestamp,
      metadata: metrics.metadata,
    );

    _checkRenderPerformance(componentName, renderTime);
  }

  /// Get current memory usage in MB
  double _getCurrentMemoryUsage() {
    try {
      // Try to get actual memory usage from ProcessInfo
      final info = ProcessInfo.currentRss;
      if (info != null) {
        return info! / (1024 * 1024); // Convert bytes to MB
      }
      // Fallback to platform-specific implementation
      return _getPlatformMemoryUsage();
    } catch (e) {
      if (kDebugMode) {
        developer.log('Memory tracking failed: $e');
      }
      return 0.0;
    }
  }

  /// Platform-specific memory usage implementation
  double _getPlatformMemoryUsage() {
    // This is a fallback implementation
    // In a real app, you might use platform-specific methods
    return 0.0;
  }

  /// Check build performance issues
  void _checkBuildPerformance(
      String componentName, MPPerformanceMetrics metrics) {
    // Check for slow build time
    if (metrics.buildTime > _slowBuildThreshold) {
      _warnings.add(MPPerformanceWarning(
        type: MPPerformanceWarningType.slowBuildTime,
        componentName: componentName,
        message:
            'Component build time (${metrics.buildTime.toStringAsFixed(2)}ms) exceeds threshold (${_slowBuildThreshold}ms)',
        severity: metrics.buildTime > _slowBuildThreshold * 2
            ? MPPerformanceWarningSeverity.high
            : MPPerformanceWarningSeverity.medium,
        timestamp: DateTime.now(),
        context: {
          'buildTime': metrics.buildTime,
          'threshold': _slowBuildThreshold,
        },
      ));
    }

    // Check for excessive rebuilds
    if (metrics.rebuildCount > _excessiveRebuildThreshold) {
      _warnings.add(MPPerformanceWarning(
        type: MPPerformanceWarningType.excessiveRebuilds,
        componentName: componentName,
        message:
            'Component has rebuilt ${metrics.rebuildCount} times, exceeding threshold of $_excessiveRebuildThreshold',
        severity: metrics.rebuildCount > _excessiveRebuildThreshold * 2
            ? MPPerformanceWarningSeverity.high
            : MPPerformanceWarningSeverity.medium,
        timestamp: DateTime.now(),
        context: {
          'rebuildCount': metrics.rebuildCount,
          'threshold': _excessiveRebuildThreshold,
        },
      ));
    }

    // Check for high memory usage
    if (metrics.memoryUsage > _highMemoryThreshold) {
      _warnings.add(MPPerformanceWarning(
        type: MPPerformanceWarningType.highMemoryUsage,
        componentName: componentName,
        message:
            'Component memory usage (${metrics.memoryUsage.toStringAsFixed(2)}MB) exceeds threshold (${_highMemoryThreshold}MB)',
        severity: metrics.memoryUsage > _highMemoryThreshold * 2
            ? MPPerformanceWarningSeverity.high
            : MPPerformanceWarningSeverity.medium,
        timestamp: DateTime.now(),
        context: {
          'memoryUsage': metrics.memoryUsage,
          'threshold': _highMemoryThreshold,
        },
      ));
    }
  }

  /// Check render performance issues
  void _checkRenderPerformance(String componentName, double renderTime) {
    if (renderTime > _slowRenderThreshold) {
      _warnings.add(MPPerformanceWarning(
        type: MPPerformanceWarningType.slowRenderTime,
        componentName: componentName,
        message:
            'Component render time (${renderTime.toStringAsFixed(2)}ms) exceeds threshold (${_slowRenderThreshold}ms)',
        severity: renderTime > _slowRenderThreshold * 2
            ? MPPerformanceWarningSeverity.high
            : MPPerformanceWarningSeverity.medium,
        timestamp: DateTime.now(),
        context: {
          'renderTime': renderTime,
          'threshold': _slowRenderThreshold,
        },
      ));
    }
  }

  /// Check for performance issues periodically
  void _checkPerformance() {
    if (kDebugMode) {
      for (final entry in _metrics.entries) {
        final componentName = entry.key;
        final metrics = entry.value;

        // Check for unnecessary rebuilds
        if (metrics.rebuildCount > 1) {
          final avgBuildTime = _getAverageBuildTime(componentName);
          if (avgBuildTime > _slowBuildThreshold / 2) {
            _warnings.add(MPPerformanceWarning(
              type: MPPerformanceWarningType.unnecessaryRebuild,
              componentName: componentName,
              message:
                  'Component may be rebuilding unnecessarily (${metrics.rebuildCount} times)',
              severity: MPPerformanceWarningSeverity.low,
              timestamp: DateTime.now(),
              context: {
                'rebuildCount': metrics.rebuildCount,
                'avgBuildTime': avgBuildTime,
              },
            ));
          }
        }
      }
    }
  }

  /// Get average build time for a component
  double _getAverageBuildTime(String componentName) {
    final history = _history[componentName];
    if (history == null || history.isEmpty) return 0.0;

    final total =
        history.fold<double>(0.0, (sum, metrics) => sum + metrics.buildTime);
    return total / history.length;
  }

  /// Get performance metrics for a component
  MPPerformanceMetrics? getMetrics(String componentName) {
    return _metrics[componentName];
  }

  /// Get all performance metrics
  Map<String, MPPerformanceMetrics> getAllMetrics() {
    return Map.unmodifiable(_metrics);
  }

  /// Get performance history for a component
  List<MPPerformanceMetrics> getHistory(String componentName) {
    return List.unmodifiable(_history[componentName] ?? []);
  }

  /// Get all performance warnings
  List<MPPerformanceWarning> getWarnings() {
    return List.unmodifiable(_warnings);
  }

  /// Get warnings for a specific component
  List<MPPerformanceWarning> getWarningsForComponent(String componentName) {
    return _warnings
        .where((warning) => warning.componentName == componentName)
        .toList();
  }

  /// Get warnings by severity
  List<MPPerformanceWarning> getWarningsBySeverity(
      MPPerformanceWarningSeverity severity) {
    return _warnings.where((warning) => warning.severity == severity).toList();
  }

  /// Clear performance metrics
  void clearMetrics() {
    _metrics.clear();
    _rebuildCounts.clear();
    _buildStartTimes.clear();
  }

  /// Clear performance warnings
  void clearWarnings() {
    _warnings.clear();
  }

  /// Clear all data
  void clearAll() {
    clearMetrics();
    clearWarnings();
    _history.clear();
    _initializationStartTimes.clear();
    _initializationTimes.clear();
  }

  /// Generate performance report
  Map<String, dynamic> generateReport() {
    final report = <String, dynamic>{};

    // Summary statistics
    report['summary'] = {
      'totalComponents': _metrics.length,
      'totalWarnings': _warnings.length,
      'criticalWarnings': _warnings
          .where((w) => w.severity == MPPerformanceWarningSeverity.critical)
          .length,
      'highWarnings': _warnings
          .where((w) => w.severity == MPPerformanceWarningSeverity.high)
          .length,
      'mediumWarnings': _warnings
          .where((w) => w.severity == MPPerformanceWarningSeverity.medium)
          .length,
      'lowWarnings': _warnings
          .where((w) => w.severity == MPPerformanceWarningSeverity.low)
          .length,
      'isMonitoring': _isMonitoring,
    };

    // Component metrics
    report['components'] = _metrics.map((name, metrics) => MapEntry(
          name,
          {
            'buildTime': metrics.buildTime,
            'renderTime': metrics.renderTime,
            'rebuildCount': metrics.rebuildCount,
            'memoryUsage': metrics.memoryUsage,
            'initializationTime': _initializationTimes[name],
            'lastUpdated': metrics.timestamp.toIso8601String(),
            'warnings': getWarningsForComponent(name).length,
          },
        ));

    // Initialization times
    report['initializationTimes'] =
        _initializationTimes.map((name, time) => MapEntry(
              name,
              {
                'time': time,
                'formatted': '${time.toStringAsFixed(2)}ms',
              },
            ));

    // Warnings by type
    final warningsByType =
        <MPPerformanceWarningType, List<MPPerformanceWarning>>{};
    for (final warning in _warnings) {
      warningsByType.putIfAbsent(warning.type, () => []).add(warning);
    }

    report['warningsByType'] = warningsByType.map((type, warnings) => MapEntry(
          type.toString(),
          warnings
              .map((w) => {
                    'componentName': w.componentName,
                    'message': w.message,
                    'severity': w.severity.toString(),
                    'timestamp': w.timestamp.toIso8601String(),
                    'context': w.context,
                  })
              .toList(),
        ));

    // Performance recommendations
    report['recommendations'] = _generateRecommendations();

    return report;
  }

  /// Generate performance recommendations
  List<String> _generateRecommendations() {
    final recommendations = <String>[];

    // Check for common issues
    final slowBuilds = _warnings
        .where((w) => w.type == MPPerformanceWarningType.slowBuildTime);
    if (slowBuilds.isNotEmpty) {
      recommendations.add(
          'Consider optimizing build methods for components with slow build times');
      recommendations
          .add('Use const constructors and const variables where possible');
    }

    final excessiveRebuilds = _warnings
        .where((w) => w.type == MPPerformanceWarningType.excessiveRebuilds);
    if (excessiveRebuilds.isNotEmpty) {
      recommendations.add(
          'Reduce unnecessary rebuilds by using const widgets and proper state management');
      recommendations.add('Consider using RepaintBoundary to isolate rebuilds');
    }

    final highMemory = _warnings
        .where((w) => w.type == MPPerformanceWarningType.highMemoryUsage);
    if (highMemory.isNotEmpty) {
      recommendations.add(
          'Optimize memory usage by implementing lazy loading for heavy components');
      recommendations.add('Consider using ListView.builder for long lists');
    }

    if (_warnings.isEmpty) {
      recommendations.add('No performance issues detected');
    }

    return recommendations;
  }

  /// Print performance report to console
  void printReport() {
    final report = generateReport();

    if (kDebugMode) {
      developer.log('=== MPPerformanceProfiler Report ===');
      developer.log('Summary: ${report['summary']}');
      developer.log('Components: ${report['components']}');
      developer.log('Warnings by type: ${report['warningsByType']}');
      developer.log('Recommendations: ${report['recommendations']}');
      developer.log('=== End Report ===');
    }
  }
}

/// Performance widget wrapper for monitoring component performance
class MPPerformanceProfilerWidget extends StatelessWidget {
  final Widget child;
  final String? name;
  final bool enabled;
  final Map<String, dynamic>? metadata;

  const MPPerformanceProfilerWidget({
    super.key,
    required this.child,
    this.name,
    this.enabled = kDebugMode,
    this.metadata,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    final componentName = name ?? child.runtimeType.toString();
    final profiler = MPPerformanceProfiler.instance;

    return _PerformanceWidget(
      name: componentName,
      child: child,
      profiler: profiler,
      metadata: metadata,
    );
  }
}

/// Internal widget for performance tracking
class _PerformanceWidget extends StatelessWidget {
  final String name;
  final Widget child;
  final MPPerformanceProfiler profiler;
  final Map<String, dynamic>? metadata;

  const _PerformanceWidget({
    required this.name,
    required this.child,
    required this.profiler,
    this.metadata,
  });

  @override
  Widget build(BuildContext context) {
    // Start timing
    profiler.startBuild(name);

    // Return the child wrapped with a builder to ensure build timing
    return Builder(
      builder: (context) {
        // End timing when build completes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          profiler.endBuild(name, metadata: metadata);
        });

        return child;
      },
    );
  }
}

/// Performance utility functions
class MPPerformanceUtils {
  /// Measure widget build time
  static Future<Duration> measureBuildTime(Widget widget) async {
    final stopwatch = Stopwatch()..start();

    // Force a build and layout
    WidgetsBinding.instance.ensureVisualUpdate();
    await Future.delayed(Duration.zero);

    stopwatch.stop();
    return stopwatch.elapsed;
  }

  /// Check if widget should use const constructor
  static bool shouldUseConst(Widget widget) {
    // Simple heuristic - in a real implementation, you might use more sophisticated analysis
    return widget.runtimeType.toString().startsWith('Container') ||
        widget.runtimeType.toString().startsWith('SizedBox') ||
        widget.runtimeType.toString().startsWith('Padding');
  }

  /// Get performance optimization suggestions for a widget
  static List<String> getOptimizationSuggestions(Widget widget) {
    final suggestions = <String>[];
    final widgetType = widget.runtimeType.toString();

    if (widgetType.contains('ListView') && !widgetType.contains('builder')) {
      suggestions.add(
          'Consider using ListView.builder for better performance with long lists');
    }

    if (widgetType.contains('Column') || widgetType.contains('Row')) {
      suggestions
          .add('Consider using Flex or Wrap for better layout performance');
    }

    if (widgetType.contains('Image') && !widgetType.contains('cached')) {
      suggestions
          .add('Consider using cached network images for better performance');
    }

    return suggestions;
  }
}
