import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';


void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Debug MPTheme.main', (WidgetTester tester) async {
    try {
      // Create theme without dependencies
      final theme = MPTheme.main(isDarkMode: true);
      print('Theme created successfully: ${theme.brightness}');

      await tester.pumpWidget(
        MaterialApp(
          title: 'Debug Theme Test',
          theme: theme.copyWith(
            extensions: [MPColorTheme.dark],
          ),
          home: Builder(
            builder: (context) {
              // Test theme access
              final primaryColor = context.mp.primary;
              final textColor = context.mp.textColor;
              print('Primary color: $primaryColor');
              print('Text color: $textColor');
              
              return Container(
                color: context.mp.adaptiveBackgroundColor,
                child: Center(
                  child: Text(
                    'Debug Theme Test',
                    style: TextStyle(color: textColor),
                  ),
                ),
              );
            },
          ),
        ),
      );

      print('Test completed successfully');
      
      // Verify widget exists
      expect(find.text('Debug Theme Test'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      
    } catch (e, stackTrace) {
      print('Error creating theme: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  });
}
