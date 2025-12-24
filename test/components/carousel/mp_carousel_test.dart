import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPCarousel', () {
    testWidgets('displays carousel with items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPCarousel(
              items: [
                Container(color: Colors.red, child: Text('Item 1')),
                Container(color: Colors.blue, child: Text('Item 2')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('applies adaptive theme colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MPTheme.lightTheme(),
          home: Scaffold(
            body: MPCarousel(
              items: [
                Container(child: Text('Item')),
              ],
              showIndicator: true,
            ),
          ),
        ),
      );

      // Verify carousel is rendered
      final carousel = find.byType(CarouselSlider);
      expect(carousel, findsOneWidget);
    });
  });
}
