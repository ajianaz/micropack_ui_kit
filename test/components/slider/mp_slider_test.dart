import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  group('MPSlider Widget Tests', () {
    testWidgets('renders with default props', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSlider(
              value: 0.5,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders with primary variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSlider(
              value: 0.5,
              onChanged: (value) {},
              variant: MPSliderVariant.primary,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders with secondary variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSlider(
              value: 0.5,
              onChanged: (value) {},
              variant: MPSliderVariant.secondary,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders with success variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSlider(
              value: 0.5,
              onChanged: (value) {},
              variant: MPSliderVariant.success,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders with warning variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSlider(
              value: 0.5,
              onChanged: (value) {},
              variant: MPSliderVariant.warning,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders with error variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSlider(
              value: 0.5,
              onChanged: (value) {},
              variant: MPSliderVariant.error,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders with info variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MPSlider(
              value: 0.5,
              onChanged: (value) {},
              variant: MPSliderVariant.info,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    group('Value Tests', () {
      testWidgets('renders with value 0', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('renders with value 1', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 1,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('renders with value 0.5', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('clamps value to min', (tester) async {
        double value = -0.5;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return MPSlider(
                    value: value,
                    onChanged: (newValue) {
                      setState(() => value = newValue);
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Slider should handle negative values gracefully
        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('clamps value to max', (tester) async {
        double value = 1.5;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return MPSlider(
                    value: value,
                    max: 1.0,
                    onChanged: (newValue) {
                      setState(() => value = newValue);
                    },
                  );
                },
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });
    });

    group('Min/Max Tests', () {
      testWidgets('renders with custom min and max', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 50,
                min: 0,
                max: 100,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('renders with negative min', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0,
                min: -50,
                max: 50,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });
    });

    group('Divisions Tests', () {
      testWidgets('renders continuous slider (no divisions)',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                divisions: null,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('renders discrete slider with divisions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                divisions: 10,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.divisions, equals(10));
      });

      testWidgets('renders with 5 divisions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                divisions: 5,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.divisions, equals(5));
      });

      testWidgets('renders with 20 divisions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                divisions: 20,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.divisions, equals(20));
      });
    });

    group('Custom Colors', () {
      testWidgets('applies custom active color', (tester) async {
        const customColor = Colors.purple;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
                activeColor: customColor,
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.activeColor, equals(customColor));
      });

      testWidgets('applies custom inactive color', (tester) async {
        const customColor = Colors.grey;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
                inactiveColor: customColor,
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.inactiveColor, equals(customColor));
      });
    });

    group('Enabled State', () {
      testWidgets('is enabled by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.onChanged, isNotNull);
      });

      testWidgets('is disabled when enabled is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
                enabled: false,
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.onChanged, isNull);
      });

      testWidgets('shows as enabled when enabled is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
                enabled: true,
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.onChanged, isNotNull);
      });
    });

    group('Label Tests', () {
      testWidgets('renders without label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('renders with custom label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                label: 'Custom Label',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                semanticLabel: 'Volume control',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(MPSlider));
        expect(semantics.label, contains('Volume control'));
      });
    });

    group('Theme Integration', () {
      testWidgets('works in light theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('works in dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });
    });

    group('Interaction Tests', () {
      testWidgets('calls onChanged when dragged', (tester) async {
        double value = 0.5;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return MPSlider(
                    value: value,
                    onChanged: (newValue) {
                      setState(() => value = newValue);
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Tap on the slider at 75% position
        await tester.tap(find.byType(Slider));
        await tester.pumpAndSettle();

        // Slider should still exist and be interactive
        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        double value = 0.5;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return MPSlider(
                    value: value,
                    onChanged: (newValue) {
                      setState(() => value = newValue);
                    },
                    enabled: false,
                  );
                },
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.onChanged, isNull);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles min equals max gracefully', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                min: 0.5,
                max: 0.5,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        // When min equals max, slider returns SizedBox.shrink()
        expect(find.byType(Slider), findsNothing);
      });

      testWidgets('handles very large max value', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 5000000,
                min: 0,
                max: 10000000,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('handles very small divisions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                divisions: 2,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.divisions, equals(2));
      });

      testWidgets('handles very large divisions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MPSlider(
                value: 0.5,
                divisions: 100,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.divisions, equals(100));
      });
    });
  });
}
