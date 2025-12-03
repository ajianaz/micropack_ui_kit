import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Performance monitoring utilities for UI components
/// 
/// This class provides tools to monitor and optimize widget performance
/// including rebuild tracking, render time measurement, and memory usage.
class MPPerformanceMonitor {
  static final Map<String, int> _rebuildCounts = {};
  static final Map<String, DateTime> _lastRebuildTimes = {};
  static final Map<String, Stopwatch> _renderTimes = {};
  static bool _isMonitoringEnabled = false;

  /// Enable/disable performance monitoring
  static void enableMonitoring(bool enabled) {
    _isMonitoringEnabled = enabled;
    if (enabled) {
      debugPrint('🔍 MP Performance Monitor: ENABLED');
    } else {
      debugPrint('⏹️ MP Performance Monitor: DISABLED');
    }
  }

  /// Track widget rebuild
  static void trackRebuild(String widgetName, {String? key}) {
    if (!_isMonitoringEnabled) return;

    final identifier = key != null ? '$widgetName($key)' : widgetName;
    _rebuildCounts[identifier] = (_rebuildCounts[identifier] ?? 0) + 1;
    _lastRebuildTimes[identifier] = DateTime.now();

    // Warn about excessive rebuilds
    if (_rebuildCounts[identifier]! > 10) {
      debugPrint(
        '⚠️ WARNING: $widgetName has been rebuilt '
        '${_rebuildCounts[identifier]} times - consider optimization',
      );
    }
  }

  /// Start measuring render time
  static void startRenderTimer(String widgetName) {
    if (!_isMonitoringEnabled) return;

    _renderTimes[widgetName] = Stopwatch()..start();
  }

  /// End measuring render time and report
  static void endRenderTimer(String widgetName) {
    if (!_isMonitoringEnabled) return;

    final stopwatch = _renderTimes[widgetName];
    if (stopwatch != null) {
      stopwatch.stop();
      final renderTime = stopwatch.elapsedMilliseconds;

      // Warn about slow renders (>16ms for 60fps)
      if (renderTime > 16) {
        debugPrint(
          '⚠️ SLOW RENDER: $widgetName took ${renderTime}ms '
          '(target: <16ms for 60fps)',
        );
      }

      _renderTimes.remove(widgetName);
    }
  }

  /// Get rebuild statistics
  static Map<String, dynamic> getStats() {
    return {
      'rebuildCounts': _rebuildCounts,
      'lastRebuildTimes': _lastRebuildTimes,
      'isMonitoringEnabled': _isMonitoringEnabled,
    };
  }

  /// Reset all monitoring data
  static void reset() {
    _rebuildCounts.clear();
    _lastRebuildTimes.clear();
    _renderTimes.clear();
    debugPrint('🔄 MP Performance Monitor: RESET');
  }

  /// Print performance summary
  static void printSummary() {
    if (!_isMonitoringEnabled) {
      debugPrint('Performance monitoring is disabled');
      return;
    }

    debugPrint('\n📊 PERFORMANCE SUMMARY:');
    debugPrint('========================');

    // Show top rebuild offenders
    if (_rebuildCounts.isNotEmpty) {
      final sortedRebuilds = _rebuildCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      debugPrint('TOP REBUILD OFFENDERS:');
      for (int i = 0; i < sortedRebuilds.length && i < 5; i++) {
        final entry = sortedRebuilds[i];
        debugPrint(
          '  ${i + 1}. ${entry.key}: ${entry.value} rebuilds',
        );
      }
    }

    debugPrint('========================\n');
  }
}

/// Performance-aware StatefulWidget mixin
/// 
/// Mix this into State classes to automatically track performance
mixin MPPerformanceWidgetMixin<T extends StatefulWidget> on State<T> {
  String get _widgetName => T.toString();

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    MPPerformanceMonitor.trackRebuild(_widgetName, key: widget.key.toString());
  }

  @override
  Widget build(BuildContext context) {
    MPPerformanceMonitor.trackRebuild(_widgetName);
    MPPerformanceMonitor.startRenderTimer(_widgetName);
    
    final result = super.build(context);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MPPerformanceMonitor.endRenderTimer(_widgetName);
    });
    
    return result;
  }
}

/// Performance-aware StatelessWidget mixin
/// 
/// Mix this into StatelessWidget classes to automatically track performance
mixin MPPerformanceWidgetMixinStateless {
  String get _widgetName => runtimeType.toString();

  Widget buildWithPerformanceTracking(BuildContext context, Widget Function() builder) {
    MPPerformanceMonitor.trackRebuild(_widgetName);
    MPPerformanceMonitor.startRenderTimer(_widgetName);
    
    final result = builder();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MPPerformanceMonitor.endRenderTimer(_widgetName);
    });
    
    return result;
  }
}

/// Widget performance wrapper for performance monitoring
class MPPerformanceWrapper extends StatelessWidget {
  final Widget child;
  final String? name;

  const MPPerformanceWrapper({
    super.key,
    required this.child,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        MPPerformanceMonitor.trackRebuild(
          name ?? child.runtimeType.toString(),
        );
        return child;
      },
    );
  }
}
