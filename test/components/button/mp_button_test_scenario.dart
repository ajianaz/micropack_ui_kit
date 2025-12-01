import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';
import '../../util/widget_test_scenario_model.dart';

List<WidgetTestScenarioModel> buttonTestScenario = [
  WidgetTestScenarioModel(
    title: 'has label set to Save',
    widget: MPComponentInitTest(
      child: MPButton(
        text: 'Save',
        onPressed: () async {},
      ), //TODO: add your first test case for this widget,
    ),
  ),
];

void main() {
  testWidgets('Button Scenario Test', (WidgetTester tester) async {
    // This test is added to make the file runnable as a test
    // The actual tests are in mp_button_test.dart

    // Test that the scenario can be built without errors
    await tester.pumpWidget(buttonTestScenario[0].widget);

    // Verify the button is present
    expect(find.byType(MPButton), findsOneWidget);
  });
}
