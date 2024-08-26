import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mp_button_test_scenario.dart';

void main() {
  group(
    'Button Test',
    () {
      testWidgets(
        buttonTestScenario[0].title,
        (WidgetTester tester) async {
          debugDefaultTargetPlatformOverride = TargetPlatform.android;

          await tester.pumpWidget(buttonTestScenario[0].widget);

          expect(find.text('Save'), findsOneWidget);
          debugDefaultTargetPlatformOverride = null;
        },
      );
    },
  );
}
