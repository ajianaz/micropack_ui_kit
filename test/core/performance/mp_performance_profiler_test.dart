import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';

void main() {
  group('MPPerformanceProfiler Tests', () {
    setUpAll(() async {
      // Initialize test environment
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      // Clear profiler before each test
      MPPerformanceProfiler.instance.clearAll();
    });

    tearDown(() {
      // Stop monitoring after each test
      MPPerformanceProfiler.instance.stopMonitoring();
    });

    test('provides singleton instance', () {
      final profiler1 = MPPerformanceProfiler.instance;
      final profiler2 = MPPerformanceProfiler.instance;

      // Should be the same instance
      expect(identical(profiler1, profiler2), isTrue);
    });

    test('tracks build metrics', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Start a build operation
      profiler.startBuild('TestWidget');

      // Simulate some work
      for (int i = 0; i < 100; i++) {
        // Simple computation to simulate work
        i * i;
      }

      // End a build operation
      profiler.endBuild('TestWidget');

      // Get metrics
      final metrics = profiler.getMetrics('TestWidget');

      expect(metrics, isNotNull);
      expect(metrics!.buildTime, greaterThan(0));
      expect(metrics.renderTime, greaterThanOrEqualTo(0.0));
      expect(metrics.rebuildCount, greaterThan(0));
      expect(metrics.componentName, equals('TestWidget'));

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('tracks initialization metrics', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Start an initialization operation
      profiler.startInitialization('TestInit');

      // Simulate some work
      for (int i = 0; i < 50; i++) {
        // Simple computation to simulate work
        i * i;
      }

      // End an initialization operation
      profiler.endInitialization('TestInit');

      // Get initialization time
      final initTime = profiler.getInitializationTime('TestInit');

      expect(initTime, isNotNull);
      expect(initTime!, greaterThan(0));

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('gets all initialization times', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Add some initialization times
      profiler.startInitialization('Init1');
      profiler.endInitialization('Init1');

      profiler.startInitialization('Init2');
      profiler.endInitialization('Init2');

      // Get all initialization times
      final allInitTimes = profiler.getAllInitializationTimes();

      expect(allInitTimes, isNotNull);
      expect(allInitTimes.length, equals(2));
      expect(allInitTimes.containsKey('Init1'), isTrue);
      expect(allInitTimes.containsKey('Init2'), isTrue);

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('aggregates multiple operations', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Perform multiple build operations
      for (int i = 0; i < 5; i++) {
        profiler.startBuild('TestWidget$i');
        // Simulate work
        for (int j = 0; j < 20; j++) {
          j * j;
        }
        profiler.endBuild('TestWidget$i');
      }

      // Get metrics for first widget
      final metrics = profiler.getMetrics('TestWidget0');

      expect(metrics, isNotNull);
      expect(metrics!.rebuildCount, equals(1));

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('provides all metrics summary', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Add some metrics
      profiler.startBuild('Widget1');
      profiler.endBuild('Widget1');

      profiler.startInitialization('Init1');
      profiler.endInitialization('Init1');

      // Add a small delay to ensure metrics are recorded
      Future.delayed(Duration(milliseconds: 10));

      // Get all metrics
      final allMetrics = profiler.getAllMetrics();

      expect(allMetrics, isNotNull);
      expect(allMetrics.length, equals(2));
      expect(allMetrics.containsKey('Widget1'), isTrue);
      expect(allMetrics.containsKey('Init1'), isTrue);

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('generates performance report', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Add some metrics
      profiler.startBuild('FastWidget');
      profiler.endBuild('FastWidget');

      profiler.startBuild('SlowWidget');
      // Simulate slower work
      for (int i = 0; i < 1000; i++) {
        i * i;
      }
      profiler.endBuild('SlowWidget');

      // Generate report
      final report = profiler.generateReport();

      expect(report, isNotNull);
      expect(report.containsKey('summary'), isTrue);
      expect(report.containsKey('components'), isTrue);
      expect(report.containsKey('warningsByType'), isTrue);
      expect(report.containsKey('recommendations'), isTrue);

      final summary = report['summary'] as Map<String, dynamic>;
      expect(summary['totalComponents'], equals(2));

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('clears metrics', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Add some metrics
      profiler.startBuild('TestWidget');
      profiler.endBuild('TestWidget');

      // Verify metrics exist
      expect(profiler.getAllMetrics().isNotEmpty, isTrue);

      // Clear metrics
      profiler.clearMetrics();

      // Verify metrics are cleared
      expect(profiler.getAllMetrics().isEmpty, isTrue);

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('handles missing operations gracefully', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // End operation without starting it
      profiler.endBuild('NonExistent');

      // Should not crash and should not create metrics
      final metrics = profiler.getMetrics('NonExistent');
      expect(metrics, isNull);

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('gets operation history', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Add some operations
      for (int i = 0; i < 3; i++) {
        profiler.startBuild('Widget$i');
        profiler.endBuild('Widget$i');
      }

      // Get operation history
      final history = profiler.getHistory('Widget0');

      expect(history, isNotNull);
      expect(history.length, equals(1));
      expect(history[0].componentName, equals('Widget0'));

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('sets and gets thresholds', () {
      final profiler = MPPerformanceProfiler.instance;

      // Set custom thresholds
      profiler.setThresholds(
        slowBuildThreshold: 20.0,
        slowRenderThreshold: 25.0,
        highMemoryThreshold: 100.0,
        excessiveRebuildThreshold: 15,
      );

      // Verify thresholds
      expect(profiler.slowBuildThreshold, equals(20.0));
      expect(profiler.slowRenderThreshold, equals(25.0));
      expect(profiler.highMemoryThreshold, equals(100.0));
      expect(profiler.excessiveRebuildThreshold, equals(15));

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('starts and stops monitoring', () {
      final profiler = MPPerformanceProfiler.instance;

      // Initially not monitoring
      expect(profiler.isMonitoring, isFalse);

      // Start monitoring
      profiler.startMonitoring();

      // Should be monitoring
      expect(profiler.isMonitoring, isTrue);

      // Stop monitoring
      profiler.stopMonitoring();

      // Should not be monitoring
      expect(profiler.isMonitoring, isFalse);
    });

    test('provides performance recommendations', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Generate report with recommendations
      final report = profiler.generateReport();

      expect(report, isNotNull);
      expect(report.containsKey('recommendations'), isTrue);

      final recommendations = report['recommendations'] as List<String>;
      expect(recommendations, isNotNull);
      expect(recommendations.length, greaterThan(0));

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('prints report', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Add some metrics
      profiler.startBuild('TestWidget');
      profiler.endBuild('TestWidget');

      // Print report (should not crash)
      profiler.printReport();

      // If we get here without crashing, test passes
      expect(true, isTrue);

      // Stop monitoring
      profiler.stopMonitoring();
    });

    test('clears all data', () {
      final profiler = MPPerformanceProfiler.instance;

      // Start monitoring for this test
      profiler.startMonitoring();

      // Add some metrics and warnings
      profiler.startBuild('TestWidget');
      profiler.endBuild('TestWidget');

      // Verify data exists
      expect(profiler.getAllMetrics().isNotEmpty, isTrue);

      // Clear all data
      profiler.clearAll();

      // Verify all data is cleared
      expect(profiler.getAllMetrics().isEmpty, isTrue);
      expect(profiler.getWarnings().isEmpty, isTrue);
      expect(profiler.getAllInitializationTimes().isEmpty, isTrue);

      // Stop monitoring
      profiler.stopMonitoring();
    });
  });
}
