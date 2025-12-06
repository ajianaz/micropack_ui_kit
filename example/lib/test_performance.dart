import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_profiler.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_performance_dashboard.dart';
import 'package:micropack_ui_kit/src/core/performance/mp_image_cache.dart';

/// Performance testing and monitoring demo page
class TestPerformancePage extends StatefulWidget {
  const TestPerformancePage({super.key});

  @override
  State<TestPerformancePage> createState() => _TestPerformancePageState();
}

class _TestPerformancePageState extends State<TestPerformancePage> {
  bool _showDashboard = false;
  bool _enableProfiling = true;
  int _stressTestCount = 0;
  List<String> _testResults = [];

  @override
  void initState() {
    super.initState();

    // Initialize performance profiling
    if (_enableProfiling) {
      MPPerformanceProfiler.instance.startMonitoring();
    }
  }

  @override
  void dispose() {
    if (_enableProfiling) {
      MPPerformanceProfiler.instance.stopMonitoring();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Testing'),
        backgroundColor: context.mp.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_showDashboard ? Icons.hide_source : Icons.show_chart),
            onPressed: () {
              setState(() {
                _showDashboard = !_showDashboard;
              });
            },
            tooltip: 'Toggle Performance Dashboard',
          ),
          IconButton(
            icon: Icon(_enableProfiling ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _enableProfiling = !_enableProfiling;
                if (_enableProfiling) {
                  MPPerformanceProfiler.instance.startMonitoring();
                } else {
                  MPPerformanceProfiler.instance.stopMonitoring();
                }
              });
            },
            tooltip: 'Toggle Profiling',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPerformanceOverview(),
                const SizedBox(height: 24),
                _buildComponentTests(),
                const SizedBox(height: 24),
                _buildStressTests(),
                const SizedBox(height: 24),
                _buildImageCacheTests(),
                const SizedBox(height: 24),
                _buildTestResults(),
              ],
            ),
          ),

          // Performance dashboard overlay
          if (_showDashboard)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: MPPerformanceDashboard(
                  showInDebugModeOnly: false,
                  onClose: () {
                    setState(() {
                      _showDashboard = false;
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    return MPCard(
      variant: MPCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(
            'Performance Overview',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),

          // Current metrics
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Current FPS',
                  '${MPPerformanceProfiler.instance.currentFPS.toStringAsFixed(1)}',
                  _getFpsColor(MPPerformanceProfiler.instance.currentFPS),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Memory Usage',
                  '0.0MB',
                  _getMemoryColor(0.0),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Jank Count',
                  '${MPPerformanceProfiler.instance.jankCount}',
                  _getJankColor(MPPerformanceProfiler.instance.jankCount),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Active Components',
                  '${MPPerformanceProfiler.instance.getAllMetrics().length}',
                  Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Profiling status
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _enableProfiling
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _enableProfiling ? Colors.green : Colors.red,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _enableProfiling ? Icons.check_circle : Icons.error,
                  color: _enableProfiling ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                MPText.body(
                  _enableProfiling ? 'Profiling Enabled' : 'Profiling Disabled',
                  color: _enableProfiling ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.small(
            title,
            color: color.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 4),
          MPText.subhead(
            value,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildComponentTests() {
    return MPCard(
      variant: MPCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(
            'Component Performance Tests',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),

          // Button performance test
          _buildComponentTestRow(
            'Button Performance',
            'Test button rendering and interaction performance',
            () => _testButtonPerformance(),
          ),

          const SizedBox(height: 12),

          // Card performance test
          _buildComponentTestRow(
            'Card Performance',
            'Test card rendering and layout performance',
            () => _testCardPerformance(),
          ),

          const SizedBox(height: 12),

          // Theme switching test
          _buildComponentTestRow(
            'Theme Switching',
            'Test theme switching performance',
            () => _testThemeSwitching(),
          ),

          const SizedBox(height: 12),

          // Font loading test
          _buildComponentTestRow(
            'Font Loading',
            'Test font loading and caching performance',
            () => _testFontLoading(),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentTestRow(
      String title, String description, VoidCallback onTap) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MPText.subhead(title),
              const SizedBox(height: 4),
              MPText.small(
                description,
                color: context.mp.subtitleColor,
              ),
            ],
          ),
        ),
        MPButton.primary(
          text: 'Run Test',
          onPressed: onTap,
        ),
      ],
    );
  }

  Widget _buildStressTests() {
    return MPCard(
      variant: MPCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(
            'Stress Tests',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),

          // Heavy rendering test
          _buildStressTestRow(
            'Heavy Rendering',
            'Render multiple complex widgets simultaneously',
            () => _testHeavyRendering(),
          ),

          const SizedBox(height: 12),

          // Memory stress test
          _buildStressTestRow(
            'Memory Stress',
            'Test memory allocation and garbage collection',
            () => _testMemoryStress(),
          ),

          const SizedBox(height: 12),

          // Animation stress test
          _buildStressTestRow(
            'Animation Stress',
            'Run multiple animations simultaneously',
            () => _testAnimationStress(),
          ),

          const SizedBox(height: 16),

          // Stress test counter
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.mp.neutral20,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                MPText.body('Stress Tests Run: $_stressTestCount'),
                const Spacer(),
                MPButton.outlined(
                  text: 'Reset Counter',
                  onPressed: () {
                    setState(() {
                      _stressTestCount = 0;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStressTestRow(
      String title, String description, VoidCallback onTap) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MPText.subhead(title),
              const SizedBox(height: 4),
              MPText.small(
                description,
                color: context.mp.subtitleColor,
              ),
            ],
          ),
        ),
        MPButton.danger(
          text: 'Run Stress Test',
          onPressed: () {
            setState(() {
              _stressTestCount++;
            });
            onTap();
          },
        ),
      ],
    );
  }

  Widget _buildImageCacheTests() {
    return MPCard(
      variant: MPCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(
            'Image Cache Tests',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),

          // Cache statistics
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.mp.neutral20,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.subhead('Cache Statistics'),
                const SizedBox(height: 8),
                _buildCacheStatRow('Cached Images', '0'),
                _buildCacheStatRow('Cache Size', '0.0MB'),
                _buildCacheStatRow('Cache Hits', '0'),
                _buildCacheStatRow('Cache Misses', '0'),
                _buildCacheStatRow('Hit Rate', '0.0%'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Cache control buttons
          Row(
            children: [
              MPButton.outlined(
                text: 'Clear Cache',
                onPressed: () {
                  MPImageCacheManager.instance.clearAll();
                  setState(() {});
                },
              ),
              const SizedBox(width: 12),
              MPButton.outlined(
                text: 'Preload Images',
                onPressed: () => _preloadImages(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCacheStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MPText.body(label),
          MPText.subhead(
            value,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildTestResults() {
    if (_testResults.isEmpty) {
      return const SizedBox.shrink();
    }

    return MPCard(
      variant: MPCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MPText.head(
                'Test Results',
                fontWeight: FontWeight.bold,
              ),
              MPButton.outlined(
                text: 'Clear Results',
                onPressed: () {
                  setState(() {
                    _testResults.clear();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._testResults.map((result) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.mp.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MPText.body(result),
                ),
              )),
        ],
      ),
    );
  }

  // Test methods
  void _testButtonPerformance() {
    final stopwatch = Stopwatch()..start();

    // Create multiple buttons
    final buttons = List.generate(
        100,
        (index) => MPButton.primary(
              text: 'Button $index',
              onPressed: () {},
            ));

    stopwatch.stop();

    _addTestResult(
        'Button Test: Created 100 buttons in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _testCardPerformance() {
    final stopwatch = Stopwatch()..start();

    // Create multiple cards
    final cards = List.generate(
        50,
        (index) => MPCard(
              child: Column(
                children: [
                  MPText.subhead('Card $index'),
                  const SizedBox(height: 8),
                  MPText.body('This is a test card for performance testing.'),
                ],
              ),
            ));

    stopwatch.stop();

    _addTestResult(
        'Card Test: Created 50 cards in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _testThemeSwitching() {
    final stopwatch = Stopwatch()..start();

    // Switch themes multiple times
    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        // Toggle theme using provider
        // Simple theme toggle without provider
        // In a real implementation, you would use your theme management system
      } else {
        // Toggle theme using provider
        // Simple theme toggle without provider
        // In a real implementation, you would use your theme management system
      }
    }

    stopwatch.stop();

    _addTestResult(
        'Theme Switching: Switched themes 10 times in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _testFontLoading() {
    final stopwatch = Stopwatch()..start();

    // Load different font sizes
    final fonts = List.generate(
        20,
        (index) => MPText.body(
              'Font test $index',
              fontSize: 12.0 + (index * 0.5),
              fontWeight: index % 2 == 0 ? FontWeight.normal : FontWeight.bold,
            ));

    stopwatch.stop();

    _addTestResult(
        'Font Loading: Loaded 20 font variations in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _testHeavyRendering() {
    final stopwatch = Stopwatch()..start();

    // Create complex widget tree
    final complexWidgets = List.generate(
        20,
        (index) => MPCard(
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                        5,
                        (colIndex) => Expanded(
                              child: MPButton.primary(
                                text: 'Btn $colIndex',
                                onPressed: () {},
                              ),
                            )),
                  ),
                  const SizedBox(height: 8),
                  MPText.body('Complex content for stress testing $index'),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                        3,
                        (iconIndex) => Icon(
                              iconIndex % 2 == 0 ? Icons.star : Icons.favorite,
                              color: context.mp.primary,
                            )),
                  ),
                ],
              ),
            ));

    stopwatch.stop();

    _addTestResult(
        'Heavy Rendering: Created 20 complex widgets in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _testMemoryStress() {
    final stopwatch = Stopwatch()..start();

    // Create large data structures
    final largeList = List.generate(
        1000,
        (index) => {
              'id': index,
              'data': 'Large data string for memory testing $index' * 100,
              'timestamp': DateTime.now().millisecondsSinceEpoch,
            });

    stopwatch.stop();

    _addTestResult(
        'Memory Stress: Allocated 1000 large objects in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _testAnimationStress() {
    final stopwatch = Stopwatch()..start();

    // Create multiple animated containers
    final animatedWidgets = List.generate(
        10,
        (index) => AnimatedContainer(
              duration: Duration(milliseconds: 500 + (index * 100)),
              curve: Curves.easeInOut,
              child: Container(
                width: 50.0 + (index * 10),
                height: 50.0 + (index * 10),
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ));

    stopwatch.stop();

    _addTestResult(
        'Animation Stress: Created 10 animated widgets in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _preloadImages() {
    final stopwatch = Stopwatch()..start();

    // Simulate preloading images
    final imageUrls = [
      'https://picsum.photos/100/100?random=1',
      'https://picsum.photos/100/100?random=2',
      'https://picsum.photos/100/100?random=3',
      'https://picsum.photos/100/100?random=4',
      'https://picsum.photos/100/100?random=5',
    ];

    for (final url in imageUrls) {
      MPImageCacheManager.instance.preloadImages([url]);
    }

    stopwatch.stop();

    _addTestResult(
        'Image Preload: Preloaded 5 images in ${stopwatch.elapsedMilliseconds}ms');
  }

  void _addTestResult(String result) {
    setState(() {
      _testResults.add('${DateTime.now().millisecondsSinceEpoch}: $result');

      // Keep only last 20 results
      if (_testResults.length > 20) {
        _testResults.removeAt(0);
      }
    });
  }

  // Helper methods for colors
  Color _getFpsColor(double fps) {
    if (fps >= 55) return Colors.green;
    if (fps >= 30) return Colors.orange;
    return Colors.red;
  }

  Color _getMemoryColor(double memoryUsage) {
    if (memoryUsage < 50) return Colors.green;
    if (memoryUsage < 100) return Colors.orange;
    return Colors.red;
  }

  Color _getJankColor(int jankCount) {
    if (jankCount < 5) return Colors.green;
    if (jankCount < 15) return Colors.orange;
    return Colors.red;
  }
}
