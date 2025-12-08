import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme.dart';


void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Debug MPTheme.main', (WidgetTester tester) async {
    try {
      // Create theme without ScreenUtil
      final theme = MPTheme.main(isDarkMode: true);
      print('Theme created successfully: ${theme.brightness}');

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Builder(
            builder: (context) {
              // Just return a container since we're just testing theme creation
              return Container();
            },
          ),
        ),
      );

      print('Test completed successfully');
    } catch (e, s) {
      print('Error creating theme: $e');
      print('Stack trace: $s');
      rethrow;
    }
  });
}
