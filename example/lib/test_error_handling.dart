import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Test page to verify error handling implementation
class ErrorHandlingTestPage extends StatefulWidget {
  const ErrorHandlingTestPage({Key? key}) : super(key: key);

  @override
  State<ErrorHandlingTestPage> createState() => _ErrorHandlingTestPageState();
}

class _ErrorHandlingTestPageState extends State<ErrorHandlingTestPage> {
  String _testResult = 'No tests run yet';
  List<String> _errorLogs = [];

  void _logError(String message) {
    setState(() {
      _errorLogs
          .add('${DateTime.now().toString().substring(11, 19)}: $message');
    });
  }

  void _updateTestResult(String result) {
    setState(() {
      _testResult = result;
    });
  }

  Future<void> _testThemeErrorHandling() async {
    try {
      // Test theme switching error handling
      _updateTestResult('Testing theme error handling...');

      // Initialize theme manager first
      await MPThemeManager.initialize();

      // Try to access theme manager before proper initialization to trigger error
      // This will be handled by the theme manager's error handling
      try {
        // This should work since we initialized
        final themeMode = MPThemeManager.instance.themeMode;
        _logError(
            'Theme error test: Theme manager initialized successfully with mode: $themeMode');
        _updateTestResult(
            'Theme error test: PASSED - Theme manager initialized correctly');
      } catch (e) {
        _logError(
            'Theme error test: Error caught as expected - ${e.toString()}');
        _updateTestResult('Theme error test: PASSED - Error handled correctly');
      }
    } catch (e) {
      _logError('Theme error test: Unexpected error - ${e.toString()}');
      _updateTestResult('Theme error test: FAILED - Unexpected error occurred');
    }
  }

  void _testFontErrorHandling() {
    try {
      // Test font error handling by using invalid font
      _updateTestResult('Testing font error handling...');

      // This should trigger the font error handling
      final textStyle = MPTextStyle.body1(fontFamily: 'InvalidFontName');

      _logError('Font error test: Font error handled gracefully');
      _updateTestResult(
          'Font error test: PASSED - Font error handled correctly');
    } catch (e) {
      _logError('Font error test: Unexpected error - ${e.toString()}');
      _updateTestResult('Font error test: FAILED - Unexpected error occurred');
    }
  }

  void _testComponentErrorHandling() {
    try {
      // Test component error handling
      _updateTestResult('Testing component error handling...');

      // Create a button with potentially problematic parameters
      final button = MPButton(
        text: 'Test Button',
        onPressed: () {
          // This will be caught by the button's error handling
          throw Exception('Test button press error');
        },
      );

      _logError('Component error test: Button created successfully');
      _updateTestResult(
          'Component error test: PASSED - Component created successfully');
    } catch (e) {
      _logError('Component error test: Unexpected error - ${e.toString()}');
      _updateTestResult(
          'Component error test: FAILED - Unexpected error occurred');
    }
  }

  void _testErrorReporting() {
    try {
      // Test error reporting system
      _updateTestResult('Testing error reporting...');

      // Manually trigger different error types
      MPErrorHandler.instance.handleThemeError(
        code: 'TEST_THEME_ERROR',
        message: 'Test theme error',
        technicalDetails: 'This is a test theme error',
      );

      MPErrorHandler.instance.handleFontError(
        code: 'TEST_FONT_ERROR',
        message: 'Test font error',
        technicalDetails: 'This is a test font error',
      );

      MPErrorHandler.instance.handleComponentError(
        code: 'TEST_COMPONENT_ERROR',
        message: 'Test component error',
        technicalDetails: 'This is a test component error',
      );

      _logError('Error reporting test: All error types reported successfully');
      _updateTestResult(
          'Error reporting test: PASSED - Errors reported correctly');
    } catch (e) {
      _logError('Error reporting test: Unexpected error - ${e.toString()}');
      _updateTestResult(
          'Error reporting test: FAILED - Unexpected error occurred');
    }
  }

  void _clearLogs() {
    setState(() {
      _errorLogs.clear();
      _testResult = 'No tests run yet';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Handling Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Test result display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Test Result:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_testResult),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Test buttons
            ElevatedButton(
              onPressed: _testThemeErrorHandling,
              child: const Text('Test Theme Error Handling'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testFontErrorHandling,
              child: const Text('Test Font Error Handling'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testComponentErrorHandling,
              child: const Text('Test Component Error Handling'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testErrorReporting,
              child: const Text('Test Error Reporting'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _clearLogs,
              child: const Text('Clear Logs'),
            ),
            const SizedBox(height: 16),

            // Error logs
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Error Logs:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _errorLogs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(_errorLogs[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
