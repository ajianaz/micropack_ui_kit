import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  testWidgets('MPComponentInit should initialize correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MPComponentInitTest(
        child: Scaffold(
          appBar: AppBar(title: Text('Test')),
          body: Center(child: const Text('Hello World')),
        ),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Hello World'), findsOneWidget);
  });
}

class MPComponentInitTest extends StatelessWidget {
  const MPComponentInitTest({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => MPComponentInit(
        builder: (_) => MaterialApp(
          title: 'Micropack UI Kit',
          theme: MPTheme.main().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              MPColorTheme.light,
            ],
          ),
          darkTheme: MPTheme.main().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              MPColorTheme.dark,
            ],
          ),
          home: child,
        ),
      );
}
