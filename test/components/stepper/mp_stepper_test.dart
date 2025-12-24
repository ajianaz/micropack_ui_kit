import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/error/mp_error_handler.dart';

void main() {
  testWidgets('MPStepper displays all steps', (tester) async {
    // Initialize MPErrorHandler first
    await MPErrorHandler.initialize();

    final steps = [
      MPStep(title: Text('Step 1'), content: Text('Content 1')),
      MPStep(title: Text('Step 2'), content: Text('Content 2')),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MPStepper(
            steps: steps,
            currentStep: 0,
          ),
        ),
      ),
    );

    expect(find.text('Step 1'), findsOneWidget);
    expect(find.text('Step 2'), findsOneWidget);
  });
}
