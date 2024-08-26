import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';
import '../../util/widget_test_scenario_model.dart';

List<WidgetTestScenarioModel> buttonTestScenario = [
  WidgetTestScenarioModel(
    title: 'has label set to Save',
    widget: MPComponentInitTest(
      child: MPButton(
        label: 'Save',
        onpressed: () async {},
      ), //TODO: add your first test case for this widget,
    ),
  ),
];
