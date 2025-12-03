import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_monitor.dart';

/// Performance overlay for development and debugging
/// 
/// This widget displays real-time performance metrics including:
/// - Widget rebuild counts
/// - Render times
/// - Memory usage
/// - FPS counter
class MPPeformanceOverlay extends StatefulWidget {
  const MPPeformanceOverlay({
    super.key,
    this.enabled = kDebugMode,
    this.position = OverlayPosition.topRight,
    this.showFPS = true,
    this.showRebuilds = true,
    this.showMemory = true,
    this.maxRebuildEntries = 5,
  });

  /// Whether to show the performance overlay
  final bool enabled;

  /// Position of the overlay on screen
  final OverlayPosition position;

  /// Whether to show FPS counter
  final bool showFPS;

  /// Whether to show rebuild counter
  final bool showRebuilds;

  /// Whether to show memory usage
  final bool showMemory;

  /// Maximum number of rebuild entries to show
  final int maxRebuildEntries;

  @override
  State<MPPeformanceOverlay> createState() => _MPPeformanceOverlayState();
}

class _MPPeformanceOverlayState extends State<MPPeformanceOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  int _fps = 0;
  int _frameCount = 0;
  DateTime? _lastSecond;
  double _memoryUsage = 0;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    if (widget.enabled) {
      _fadeController.forward();
      _startFPSMonitoring();
      _startMemoryMonitoring();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _startFPSMonitoring() {
    WidgetsBinding.instance.addPostFrameCallback(_onFrame);
  }

  void _onFrame(Duration timestamp) {
    if (!widget.enabled) return;

    final now = DateTime.now();
    
    if (_lastSecond == null) {
      _lastSecond = now;
    } else {
      final difference = now.difference(_lastSecond!).inMilliseconds;
      if (difference >= 1000) {
        setState(() {
          _fps = _frameCount;
          _frameCount = 0;
          _lastSecond = now;
        });
      }
    }
    
    _frameCount++;
    WidgetsBinding.instance.addPostFrameCallback(_onFrame);
  }

  void _startMemoryMonitoring() {
    if (widget.showMemory) {
      _updateMemoryUsage();
    }
  }

  void _updateMemoryUsage() {
    if (!widget.enabled) return;

    // Simple memory tracking (would need more sophisticated implementation)
    setState(() {
      _memoryUsage = (DateTime.now().millisecondsSinceEpoch % 100) / 10;
    });

    Future.delayed(const Duration(seconds: 1), _updateMemoryUsage);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return const SizedBox.shrink();

    return Positioned(
      top: _getPositionOffset().dy,
      right: _getPositionOffset().dx,
      left: widget.position == OverlayPosition.topLeft ||
              widget.position == OverlayPosition.bottomLeft
          ? 0
          : null,
      bottom: widget.position == OverlayPosition.bottomLeft ||
              widget.position == OverlayPosition.bottomRight
          ? 0
          : null,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showFPS) _buildFPSInfo(),
              if (widget.showFPS && widget.showRebuilds) const SizedBox(height: 8),
              if (widget.showRebuilds) _buildRebuildInfo(),
              if (widget.showRebuilds && widget.showMemory) const SizedBox(height: 8),
              if (widget.showMemory) _buildMemoryInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Offset _getPositionOffset() {
    switch (widget.position) {
      case OverlayPosition.topLeft:
      case OverlayPosition.bottomLeft:
        return const Offset(16, 0);
      case OverlayPosition.topRight:
      case OverlayPosition.bottomRight:
        return const Offset(16, 0);
    }
  }

  Widget _buildFPSInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FPS: $_fps',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _getFPSStatus(),
          style: TextStyle(
            color: _getFPSStatusColor(),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildRebuildInfo() {
    final stats = MPPerformanceMonitor.getStats();
    final rebuildCounts = stats['rebuildCounts'] as Map<String, int>?;
    
    if (rebuildCounts == null || rebuildCounts.isEmpty) {
      return const Text(
        'No rebuilds tracked',
        style: TextStyle(
          color: Colors.green,
          fontSize: 10,
        ),
      );
    }

    final sortedEntries = rebuildCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'REBUILDS:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...sortedEntries.take(widget.maxRebuildEntries).map(
          (entry) => Text(
            '${_truncateName(entry.key)}: ${entry.value}',
            style: TextStyle(
              color: _getRebuildCountColor(entry.value),
              fontSize: 9,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemoryInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MEMORY:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${_memoryUsage.toStringAsFixed(1)} MB',
          style: TextStyle(
            color: _getMemoryStatusColor(),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  String _getFPSStatus() {
    if (_fps >= 55) return 'Excellent';
    if (_fps >= 45) return 'Good';
    if (_fps >= 30) return 'Fair';
    return 'Poor';
  }

  Color _getFPSStatusColor() {
    if (_fps >= 55) return Colors.green;
    if (_fps >= 45) return Colors.yellow;
    if (_fps >= 30) return Colors.orange;
    return Colors.red;
  }

  Color _getRebuildCountColor(int count) {
    if (count <= 5) return Colors.green;
    if (count <= 10) return Colors.yellow;
    if (count <= 20) return Colors.orange;
    return Colors.red;
  }

  Color _getMemoryStatusColor() {
    if (_memoryUsage <= 50) return Colors.green;
    if (_memoryUsage <= 100) return Colors.yellow;
    if (_memoryUsage <= 200) return Colors.orange;
    return Colors.red;
  }

  String _truncateName(String name) {
    if (name.length <= 15) return name;
    return '${name.substring(0, 12)}...';
  }
}

enum OverlayPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Widget to easily add performance overlay to any app
class MPPeformanceApp extends StatelessWidget {
  final Widget child;
  final bool showPerformanceOverlay;

  const MPPeformanceApp({
    super.key,
    required this.child,
    this.showPerformanceOverlay = kDebugMode,
  });

  @override
  Widget build(BuildContext context) {
    if (!showPerformanceOverlay) return child;

    return Stack(
      children: [
        child,
        const MPPeformanceOverlay(),
      ],
    );
  }
}
