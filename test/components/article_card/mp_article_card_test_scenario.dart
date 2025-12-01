import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../util/mp_component_init_test.dart';
import '../../util/widget_test_scenario_model.dart';

List<WidgetTestScenarioModel> articleCardTestScenario = [
  WidgetTestScenarioModel(
    title: 'Article Card Test',
    widget: MPComponentInitTest(
      child: MPArticleCard(
        title: 'Getting Started with Flutter',
        description:
            'Learn the basics of Flutter development with this comprehensive guide.',
        author: 'John Doe',
        date: 'March 15, 2024',
        readTime: '5 min read',
        imageUrl: 'https://picsum.photos/400/200?random=1',
        onTap: () => print('Card tapped'),
      ),
    ),
  ),
];

void main() {
  testWidgets('Article Card Scenario Test', (WidgetTester tester) async {
    // This test is added to make the file runnable as a test
    // The actual tests are in mp_article_card_test.dart

    // Test that the scenario can be built without errors
    await tester.pumpWidget(articleCardTestScenario[0].widget);

    // Verify the card is present
    expect(find.byType(MPArticleCard), findsOneWidget);
  });
}
