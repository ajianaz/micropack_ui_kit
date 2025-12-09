import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Demo page showcasing error handling capabilities
class MPErrorHandlingPage extends StatefulWidget {
  const MPErrorHandlingPage({Key? key}) : super(key: key);

  @override
  State<MPErrorHandlingPage> createState() => _MPErrorHandlingPageState();
}

class _MPErrorHandlingPageState extends State<MPErrorHandlingPage> {
  final List<String> _errorLogs = [];

  void _logError(String message) {
    setState(() {
      _errorLogs
          .add('${DateTime.now().toString().substring(11, 19)}: $message');
    });
  }

  Future<void> _testThemeError() async {
    try {
      _logError('Testing theme initialization error...');

      // Simulate theme error by trying to access invalid theme data
      if (MPThemeManager.instance.isInitialized) {
        // Try to get theme data with invalid context
        MPThemeManager.instance.getCurrentThemeData(context);
      }

      _logError('Theme error test completed');
    } catch (e) {
      _logError('Theme error caught: ${e.toString()}');

      // Try to recover using error recovery system
      final error = MPError(
        category: MPErrorCategory.theme,
        severity: MPErrorSeverity.medium,
        code: 'THEME_INIT_FAILED',
        message: 'Failed to initialize theme',
        technicalDetails: e.toString(),
      );

      await MPErrorRecovery.recoverFromError(
        error: error,
        operation: () async => MPThemeManager.instance.setSystemTheme(),
      );

      _logError('Theme recovery attempted');
    }
  }

  Future<void> _testFontError() async {
    try {
      _logError('Testing font loading error...');

      // Simulate font error by trying to load invalid font
      MpUiKit.fontName = 'InvalidFontName';

      _logError('Font error test completed');
    } catch (e) {
      _logError('Font error caught: ${e.toString()}');

      // Try to recover using error recovery system
      final error = MPError(
        category: MPErrorCategory.font,
        severity: MPErrorSeverity.medium,
        code: 'FONT_LOAD_FAILED',
        message: 'Failed to load font',
        technicalDetails: e.toString(),
      );

      await MPErrorRecovery.recoverFromError(
        error: error,
        operation: () async {
          MpUiKit.fontName = 'Poppins';
          return true;
        },
      );

      _logError('Font recovery attempted');
    }
  }

  Future<void> _testComponentError() async {
    try {
      _logError('Testing component initialization error...');

      // Simulate component error with invalid parameters
      MPButton(
        text: 'Test Button',
        onPressed: () {},
      );

      _logError('Component error test completed');
    } catch (e) {
      _logError('Component error caught: ${e.toString()}');

      // Try to recover using error recovery system
      final error = MPError(
        category: MPErrorCategory.component,
        severity: MPErrorSeverity.low,
        code: 'COMPONENT_INIT_FAILED',
        message: 'Failed to initialize component',
        technicalDetails: e.toString(),
      );

      await MPErrorRecovery.recoverFromError(
        error: error,
        operation: () async {
          // Return a fallback component
          return Container();
        },
      );

      _logError('Component recovery attempted');
    }
  }

  Future<void> _testValidationError() async {
    try {
      _logError('Testing validation error...');

      // Simulate validation error
      throw ArgumentError('Invalid parameter value');
    } catch (e) {
      _logError('Validation error caught: ${e.toString()}');

      // Try to recover using error recovery system
      final error = MPError(
        category: MPErrorCategory.validation,
        severity: MPErrorSeverity.low,
        code: 'VALIDATION_FAILED',
        message: 'Parameter validation failed',
        technicalDetails: e.toString(),
      );

      await MPErrorRecovery.recoverFromError(
        error: error,
        operation: () async {
          // Apply default value
          return 'default_value';
        },
      );

      _logError('Validation recovery attempted');
    }
  }

  Future<void> _testNetworkError() async {
    try {
      _logError('Testing network error...');

      // Simulate network error
      throw Exception('Network connection failed');
    } catch (e) {
      _logError('Network error caught: ${e.toString()}');

      // Try to recover using error recovery system
      final error = MPError(
        category: MPErrorCategory.network,
        severity: MPErrorSeverity.high,
        code: 'NETWORK_UNAVAILABLE',
        message: 'Network connection unavailable',
        technicalDetails: e.toString(),
      );

      await MPErrorRecovery.recoverFromError(
        error: error,
        operation: () async {
          // Enable offline mode
          return true;
        },
      );

      _logError('Network recovery attempted');
    }
  }

  Future<void> _testSystemError() async {
    try {
      _logError('Testing system error...');

      // Simulate system error
      throw Exception('System resource unavailable');
    } catch (e) {
      _logError('System error caught: ${e.toString()}');

      // Try to recover using error recovery system
      final error = MPError(
        category: MPErrorCategory.system,
        severity: MPErrorSeverity.critical,
        code: 'SYSTEM_RESOURCE_UNAVAILABLE',
        message: 'System resource unavailable',
        technicalDetails: e.toString(),
      );

      await MPErrorRecovery.recoverFromError(
        error: error,
        operation: () async {
          // Reset system state
          return true;
        },
      );

      _logError('System recovery attempted');
    }
  }

  Future<void> _testUnknownError() async {
    try {
      _logError('Testing unknown error...');

      // Simulate unknown error
      throw Exception('Unknown error occurred');
    } catch (e) {
      _logError('Unknown error caught: ${e.toString()}');

      // Try to recover using error recovery system
      final error = MPError(
        category: MPErrorCategory.unknown,
        severity: MPErrorSeverity.medium,
        code: 'UNKNOWN_ERROR',
        message: 'Unknown error occurred',
        technicalDetails: e.toString(),
      );

      await MPErrorRecovery.recoverFromError(
        error: error,
        operation: () async {
          // Apply generic recovery
          return true;
        },
      );

      _logError('Unknown recovery attempted');
    }
  }

  void _clearLogs() {
    setState(() {
      _errorLogs.clear();
    });
  }

  void _showErrorStats() {
    final stats = MPErrorRecovery.getRetryStats();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.mp.cardColor,
        title: MPText.head('Error Recovery Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText('Max Retries: ${stats['config']['maxRetries']}'),
            MPText('Retry Delay: ${stats['config']['retryDelay']}ms'),
            MPText(
                'Exponential Backoff: ${stats['config']['useExponentialBackoff']}'),
            const SizedBox(height: 16),
            MPText.subhead('Retry Counters:'),
            ...(stats['retryCounters'] as Map).entries.map(
                (entry) => MPText('${entry.key}: ${entry.value} attempts')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.mp.adaptiveBackgroundColor,
        title: MPText.head('Error Handling Demo'),
        actions: [
          IconButton(
            onPressed: _showErrorStats,
            icon: const Icon(Icons.analytics),
            tooltip: 'Show Error Statistics',
          ),
          IconButton(
            onPressed: _clearLogs,
            icon: const Icon(Icons.clear),
            tooltip: 'Clear Logs',
          ),
        ],
      ),
      body: MPErrorBoundary(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MPText.head(
                'Test Error Scenarios',
              ),
              const SizedBox(height: 16),

              // Error test buttons
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  MPButton(
                    text: 'Theme Error',
                    onPressed: _testThemeError,
                  ),
                  MPButton(
                    text: 'Font Error',
                    onPressed: _testFontError,
                  ),
                  MPButton(
                    text: 'Component Error',
                    onPressed: _testComponentError,
                  ),
                  MPButton(
                    text: 'Validation Error',
                    onPressed: _testValidationError,
                  ),
                  MPButton(
                    text: 'Network Error',
                    onPressed: _testNetworkError,
                  ),
                  MPButton(
                    text: 'System Error',
                    onPressed: _testSystemError,
                  ),
                  MPButton(
                    text: 'Unknown Error',
                    onPressed: _testUnknownError,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Error logs
              MPText.subhead(
                'Error Logs:',
              ),
              const SizedBox(height: 8),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.mp.cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.mp.adaptiveBorderColor),
                  ),
                  child: _errorLogs.isEmpty
                      ? Center(
                          child: MPText(
                            'No errors logged yet. Tap buttons above to test error scenarios.',
                            textAlign: TextAlign.center,
                            color: context.mp.subtitleColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: _errorLogs.length,
                          itemBuilder: (context, index) {
                            final log = _errorLogs[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 16,
                                    color: context.mp.errorColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: MPText(
                                      log,
                                      style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12,
                                        color: context.mp.textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Error recovery configuration
              MPButton(
                text: 'Configure Error Recovery',
                onPressed: () {
                  MPErrorRecovery.configure(
                    const MPErrorRecoveryConfig(
                      maxRetries: 5,
                      retryDelay: Duration(seconds: 2),
                      useExponentialBackoff: true,
                      fallbackValues: {
                        'DEFAULT_TEXT': 'Fallback text',
                        'DEFAULT_COLOR': Colors.blue,
                      },
                    ),
                  );
                  _logError('Error recovery configuration updated');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
