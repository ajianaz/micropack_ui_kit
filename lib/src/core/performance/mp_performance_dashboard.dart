import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mp_performance_profiler.dart';

/// Performance monitoring dashboard with real-time metrics
class MPPerformanceDashboard extends StatefulWidget {
  final bool showInDebugModeOnly;
  final Duration updateInterval;
  final VoidCallback? onClose;

  const MPPerformanceDashboard({
    Key? key,
    this.showInDebugModeOnly = true,
    this.updateInterval = const Duration(milliseconds: 500),
    this.onClose,
  }) : super(key: key);

  @override
  State<MPPerformanceDashboard> createState() => _MPPerformanceDashboardState();
}

class _MPPerformanceDashboardState extends State<MPPerformanceDashboard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  Timer? _updateTimer;
  MPPerformanceMetrics? _currentMetrics;
  List<MPPerformanceMetrics> _metricsHistory = [];
  bool _isExpanded = false;

  // Performance alerts
  final List<PerformanceAlert> _alerts = [];
  final Map<String, DateTime> _lastAlertTimes = {};

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Show dashboard in debug mode or if configured
    if (!widget.showInDebugModeOnly || kDebugMode) {
      _slideController.forward();
      _fadeController.forward();
      _startMetricsUpdates();
    }
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _startMetricsUpdates() {
    _updateTimer = Timer.periodic(widget.updateInterval, (_) {
      if (mounted) {
        _updateMetrics();
      }
    });

    // Initial update
    _updateMetrics();
  }

  void _updateMetrics() {
    final allMetrics = MPPerformanceProfiler.instance.getAllMetrics();
    final warnings = MPPerformanceProfiler.instance.getWarnings();

    // Calculate aggregated metrics
    final aggregatedMetrics = _calculateAggregatedMetrics(allMetrics);
    final previousMetrics = _currentMetrics;

    setState(() {
      _currentMetrics = aggregatedMetrics;
      _metricsHistory.add(aggregatedMetrics);

      // Keep only last 100 entries
      if (_metricsHistory.length > 100) {
        _metricsHistory.removeAt(0);
      }
    });

    // Check for performance alerts
    _checkPerformanceAlerts(aggregatedMetrics, previousMetrics, warnings);
  }

  MPPerformanceMetrics _calculateAggregatedMetrics(
      Map<String, MPPerformanceMetrics> allMetrics) {
    if (allMetrics.isEmpty) {
      return MPPerformanceMetrics(
        componentName: 'System',
        buildTime: 0.0,
        renderTime: 0.0,
        rebuildCount: 0,
        memoryUsage: _getCurrentMemoryUsage(),
        timestamp: DateTime.now(),
      );
    }

    double totalBuildTime = 0.0;
    double totalRenderTime = 0.0;
    int totalRebuilds = 0;
    double totalMemoryUsage = 0.0;

    for (final metrics in allMetrics.values) {
      totalBuildTime += metrics.buildTime;
      totalRenderTime += metrics.renderTime;
      totalRebuilds += metrics.rebuildCount;
      totalMemoryUsage += metrics.memoryUsage;
    }

    final count = allMetrics.length;
    return MPPerformanceMetrics(
      componentName: 'System',
      buildTime: totalBuildTime / count,
      renderTime: totalRenderTime / count,
      rebuildCount: totalRebuilds,
      memoryUsage: _getCurrentMemoryUsage(),
      timestamp: DateTime.now(),
    );
  }

  double _getCurrentMemoryUsage() {
    try {
      // Use the profiler's internal method to get memory usage
      final profiler = MPPerformanceProfiler.instance;
      // Access private method through reflection or create a public method
      return 0.0; // Fallback
    } catch (e) {
      return 0.0;
    }
  }

  void _checkPerformanceAlerts(MPPerformanceMetrics current,
      MPPerformanceMetrics? previous, List<MPPerformanceWarning> warnings) {
    final now = DateTime.now();

    // Memory usage alert
    if (current.memoryUsage > 100) {
      _addAlert(PerformanceAlert(
        type: AlertType.memory,
        message:
            'High memory usage: ${current.memoryUsage.toStringAsFixed(1)}MB',
        severity: AlertSeverity.warning,
        timestamp: now,
      ));
    }

    // Build time alert
    if (current.buildTime > 16.67) {
      _addAlert(PerformanceAlert(
        type: AlertType.buildTime,
        message: 'Slow build time: ${current.buildTime.toStringAsFixed(1)}ms',
        severity: AlertSeverity.warning,
        timestamp: now,
      ));
    }

    // Add warnings from profiler
    for (final warning in warnings) {
      _addAlert(PerformanceAlert(
        type: _mapWarningType(warning.type),
        message: warning.message,
        severity: _mapWarningSeverity(warning.severity),
        timestamp: warning.timestamp,
      ));
    }
  }

  AlertType _mapWarningType(MPPerformanceWarningType type) {
    switch (type) {
      case MPPerformanceWarningType.excessiveRebuilds:
        return AlertType.buildTime;
      case MPPerformanceWarningType.slowBuildTime:
        return AlertType.buildTime;
      case MPPerformanceWarningType.highMemoryUsage:
        return AlertType.memory;
      case MPPerformanceWarningType.slowRenderTime:
        return AlertType.fps;
      default:
        return AlertType.error;
    }
  }

  AlertSeverity _mapWarningSeverity(MPPerformanceWarningSeverity severity) {
    switch (severity) {
      case MPPerformanceWarningSeverity.low:
        return AlertSeverity.info;
      case MPPerformanceWarningSeverity.medium:
        return AlertSeverity.warning;
      case MPPerformanceWarningSeverity.high:
        return AlertSeverity.error;
      case MPPerformanceWarningSeverity.critical:
        return AlertSeverity.critical;
    }
  }

  void _addAlert(PerformanceAlert alert) {
    final key = '${alert.type}_${alert.message}';
    final now = DateTime.now();

    // Throttle alerts of the same type
    if (_lastAlertTimes.containsKey(key)) {
      final lastTime = _lastAlertTimes[key]!;
      if (now.difference(lastTime) < const Duration(seconds: 5)) {
        return;
      }
    }

    setState(() {
      _alerts.add(alert);
      _lastAlertTimes[key] = now;

      // Keep only last 20 alerts
      if (_alerts.length > 20) {
        _alerts.removeAt(0);
      }
    });

    // Auto-remove warning alerts after 10 seconds
    if (alert.severity == AlertSeverity.warning) {
      Timer(const Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            _alerts.remove(alert);
          });
        }
      });
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _clearAlerts() {
    setState(() {
      _alerts.clear();
      _lastAlertTimes.clear();
    });
  }

  void _exportMetrics() {
    final data = {
      'timestamp': DateTime.now().toIso8601String(),
      'currentMetrics': _currentMetrics?.toString(),
      'metricsHistory': _metricsHistory.map((m) => m.toString()).toList(),
      'alerts': _alerts.map((a) => a.toJson()).toList(),
    };

    if (kDebugMode) {
      debugPrint('Performance Metrics Export: ${data.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showInDebugModeOnly && !kDebugMode) {
      return const SizedBox.shrink();
    }

    if (_currentMetrics == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            elevation: 8,
            color: Colors.black87,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  _buildHeader(),

                  // Main content
                  if (_isExpanded) _buildExpandedContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Status indicator
          _buildStatusIndicator(),

          const SizedBox(width: 12),

          // Quick stats
          Expanded(
            child: Row(
              children: [
                _buildQuickStat(
                    'FPS',
                    MPPerformanceProfiler.instance.currentFPS
                        .toStringAsFixed(1)),
                const SizedBox(width: 16),
                _buildQuickStat('MEM',
                    '${_currentMetrics?.memoryUsage.toStringAsFixed(1) ?? '--'}MB'),
                const SizedBox(width: 16),
                _buildQuickStat('BUILD',
                    '${_currentMetrics?.buildTime.toStringAsFixed(1) ?? '--'}ms'),
              ],
            ),
          ),

          // Alert badge
          if (_alerts.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getHighestAlertSeverity().color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_alerts.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          const SizedBox(width: 8),

          // Controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _toggleExpanded,
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: widget.onClose,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    final status = _getPerformanceStatus();
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: status.color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: status.color.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Performance charts
          _buildPerformanceCharts(),

          const SizedBox(height: 16),

          // Alerts section
          if (_alerts.isNotEmpty) ...[
            _buildAlertsSection(),
            const SizedBox(height: 16),
          ],

          // Detailed metrics
          _buildDetailedMetrics(),

          const SizedBox(height: 16),

          // Actions
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPerformanceCharts() {
    return Container(
      height: 120,
      child: Row(
        children: [
          // FPS Chart
          Expanded(
            child: _buildMetricChart(
              'FPS History',
              MPPerformanceProfiler.instance.fpsHistory,
              Colors.green,
              60,
            ),
          ),
          const SizedBox(width: 16),

          // Memory Chart
          Expanded(
            child: _buildMetricChart(
              'Memory (MB)',
              _metricsHistory.map((m) => m.memoryUsage).toList(),
              Colors.blue,
              100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChart(
      String title, List<double> values, Color color, double maxValue) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _MetricChartPainter(
                values: values,
                color: color,
                maxValue: maxValue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Performance Alerts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _clearAlerts,
                child: const Text(
                  'Clear All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._alerts.take(5).map((alert) => _buildAlertItem(alert)),
        ],
      ),
    );
  }

  Widget _buildAlertItem(PerformanceAlert alert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: alert.severity.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            alert.severity.icon,
            color: alert.severity.color,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              alert.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            '${alert.timestamp.hour}:${alert.timestamp.minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics() {
    final allMetrics = MPPerformanceProfiler.instance.getAllMetrics();
    final warnings = MPPerformanceProfiler.instance.getWarnings();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detailed Metrics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildMetricRow('Components', '${allMetrics.length}'),
          _buildMetricRow('Total Rebuilds',
              '${allMetrics.values.fold(0, (sum, m) => sum + m.rebuildCount)}'),
          _buildMetricRow(
              'Jank Count', '${MPPerformanceProfiler.instance.jankCount}'),
          _buildMetricRow('Memory Usage',
              '${_currentMetrics?.memoryUsage.toStringAsFixed(1) ?? '--'}MB'),
          _buildMetricRow('Warnings', '${warnings.length}'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: _exportMetrics,
          icon: const Icon(Icons.download, size: 16),
          label: const Text('Export'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.2),
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            MPPerformanceProfiler.instance.clearAll();
            _clearAlerts();
          },
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Reset'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.2),
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  PerformanceStatus _getPerformanceStatus() {
    final fps = MPPerformanceProfiler.instance.currentFPS;
    final metrics = _currentMetrics!;

    if (fps < 20) {
      return PerformanceStatus.critical;
    } else if (fps < 30) {
      return PerformanceStatus.poor;
    } else if (MPPerformanceProfiler.instance.jankCount > 10 ||
        metrics.memoryUsage > 150) {
      return PerformanceStatus.warning;
    } else {
      return PerformanceStatus.good;
    }
  }

  AlertSeverity _getHighestAlertSeverity() {
    if (_alerts.isEmpty) return AlertSeverity.info;

    return _alerts
        .map((alert) => alert.severity)
        .reduce((a, b) => a.index > b.index ? a : b);
  }
}

/// Custom painter for metric charts
class _MetricChartPainter extends CustomPainter {
  final List<double> values;
  final Color color;
  final double maxValue;

  _MetricChartPainter({
    required this.values,
    required this.color,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final width = size.width;
    final height = size.height;
    final stepX = width / (values.length - 1);

    // Create path
    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = height - (values[i] / maxValue) * height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Complete fill path
    fillPath.lineTo(width, height);
    fillPath.lineTo(0, height);
    fillPath.close();

    // Draw fill
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    canvas.drawPath(path, paint);

    // Draw points
    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = height - (values[i] / maxValue) * height;

      canvas.drawCircle(Offset(x, y), 3, pointPaint);
    }
  }

  @override
  bool shouldRepaint(_MetricChartPainter oldDelegate) {
    return oldDelegate.values != values;
  }
}

/// Performance status enum
enum PerformanceStatus {
  good(Colors.green),
  warning(Colors.orange),
  poor(Colors.red),
  critical(Colors.purple);

  const PerformanceStatus(this.color);
  final Color color;
}

/// Performance alert model
class PerformanceAlert {
  final AlertType type;
  final String message;
  final AlertSeverity severity;
  final DateTime timestamp;

  PerformanceAlert({
    required this.type,
    required this.message,
    required this.severity,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'message': message,
      'severity': severity.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Alert type enum
enum AlertType {
  memory,
  fps,
  jank,
  buildTime,
  error,
}

/// Alert severity enum
enum AlertSeverity {
  info(Colors.blue, Icons.info),
  warning(Colors.orange, Icons.warning),
  error(Colors.red, Icons.error),
  critical(Colors.purple, Icons.dangerous);

  const AlertSeverity(this.color, this.icon);
  final Color color;
  final IconData icon;
}
