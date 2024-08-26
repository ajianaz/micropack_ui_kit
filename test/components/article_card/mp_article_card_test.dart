import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mp_article_card_test_scenario.dart';

void main() {
  group(
    'Article Card Test',
    () {
       testWidgets(
         articleCardTestScenario[0].title,
        (WidgetTester tester) async {
          debugDefaultTargetPlatformOverride = TargetPlatform.android;

          await tester.pumpWidget(articleCardTestScenario[0].widget);

          // expect(find.text('Title'), findsOneWidget);
          debugDefaultTargetPlatformOverride = null;
        },
      );
    },
  );
}
