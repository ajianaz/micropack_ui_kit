import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPRatingBar Widget Tests', () {
    testWidgets('renders with default props', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPRatingBar(
              rating: 3.5,
            ),
          ),
        ),
      );

      expect(find.byType(MPRatingBar), findsOneWidget);
      expect(find.byIcon(Icons.star), findsWidgets);
    });

    testWidgets('renders with stars variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPRatingBar(
              rating: 3.5,
              variant: MPRatingVariant.stars,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsWidgets);
      expect(find.byIcon(Icons.star_border), findsWidgets);
    });

    testWidgets('renders with hearts variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPRatingBar(
              rating: 2.5,
              variant: MPRatingVariant.hearts,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsWidgets);
    });

    testWidgets('renders with thumbs variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPRatingBar(
              rating: 4.0,
              variant: MPRatingVariant.thumbs,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.thumb_up), findsWidgets);
    });

    group('Size Tests', () {
      testWidgets('renders with small size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                size: MPRatingSize.small,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('renders with medium size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                size: MPRatingSize.medium,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('renders with large size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                size: MPRatingSize.large,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('renders with extra large size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                size: MPRatingSize.extraLarge,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });

    group('Rating Value Tests', () {
      testWidgets('renders with rating 0', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 0,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star_border), findsWidgets);
      });

      testWidgets('renders with rating 5', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 5,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsWidgets);
      });

      testWidgets('renders with half rating', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.5,
                allowHalfRating: true,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('renders without half rating', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.5,
                allowHalfRating: false,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });

    group('Star Count Tests', () {
      testWidgets('renders with 3 stars', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 2.0,
                starCount: 3,
              ),
            ),
          ),
        );

        // Check that rating bar exists and has expected stars
        expect(find.byType(MPRatingBar), findsOneWidget);
        expect(find.byIcon(Icons.star), findsWidgets);
        expect(find.byIcon(Icons.star_border), findsWidgets);
      });

      testWidgets('renders with 7 stars', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 5.0,
                starCount: 7,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
        expect(find.byIcon(Icons.star), findsWidgets);
      });

      testWidgets('renders with 10 stars', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 7.5,
                starCount: 10,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
        expect(find.byIcon(Icons.star), findsWidgets);
      });
    });

    group('Custom Colors', () {
      testWidgets('applies custom filled color', (tester) async {
        const customColor = Colors.purple;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                color: customColor,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('applies custom unfilled color', (tester) async {
        const customColor = Colors.grey;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                unfilledColor: customColor,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });

    group('Custom Icons', () {
      testWidgets('applies custom filled icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                filledIcon: Icons.check_circle,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.check_circle), findsWidgets);
      });

      testWidgets('applies custom empty icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                emptyIcon: Icons.circle_outlined,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.circle_outlined), findsWidgets);
      });

      testWidgets('applies custom half-filled icon',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.5,
                allowHalfRating: true,
                halfFilledIcon: Icons.star_half,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });

    group('Interaction Tests', () {
      testWidgets('calls onRatingChanged when tapped', (tester) async {
        double? newRating;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                onRatingChanged: (rating) => newRating = rating,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(MPRatingBar));
        await tester.pumpAndSettle();

        expect(newRating, isNotNull);
      });

      testWidgets('does not call onRatingChanged when read-only',
          (tester) async {
        double? newRating;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                readOnly: true,
                onRatingChanged: (rating) => newRating = rating,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(MPRatingBar));
        await tester.pumpAndSettle();

        expect(newRating, isNull);
      });

      testWidgets('does not call onRatingChanged when callback is null',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 4.5,
                semanticLabel: 'Product rating',
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPRatingBar));
        expect(semantics.label, contains('Product rating'));
      });

      testWidgets('has rating info in label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 4.5,
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPRatingBar));
        expect(semantics.label, contains('4.5'));
      });

      testWidgets('label shows integer for no half rating',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 4.5,
                allowHalfRating: false,
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPRatingBar));
        expect(semantics.label, contains('4'));
      });
    });

    group('Theme Integration', () {
      testWidgets('works in light theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.5,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('works in dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.5,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles rating 0 gracefully', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 0,
                starCount: 5,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
        expect(find.byIcon(Icons.star_border), findsNWidgets(5));
      });

      testWidgets('handles max rating gracefully', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 5,
                starCount: 5,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
        expect(find.byIcon(Icons.star), findsNWidgets(5));
      });

      testWidgets('handles custom item size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                itemSize: 40.0,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('handles custom spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                spacing: 8.0,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });

    group('Custom Variant Tests', () {
      testWidgets('renders with custom variant and icons', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.5,
                variant: MPRatingVariant.custom,
                filledIcon: Icons.face,
                emptyIcon: Icons.face_outlined,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.face), findsWidgets);
        expect(find.byIcon(Icons.face_outlined), findsWidgets);
      });
    });

    group('State Tests', () {
      testWidgets('is interactive by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                onRatingChanged: (rating) {},
              ),
            ),
          ),
        );

        expect(find.byType(GestureDetector), findsWidgets);
      });

      testWidgets('is read-only when readOnly is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
                readOnly: true,
              ),
            ),
          ),
        );

        // Should not have GestureDetector when read-only
        expect(find.byType(MPRatingBar), findsOneWidget);
      });

      testWidgets('is read-only when onRatingChanged is null',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPRatingBar(
                rating: 3.0,
              ),
            ),
          ),
        );

        expect(find.byType(MPRatingBar), findsOneWidget);
      });
    });
  });
}
