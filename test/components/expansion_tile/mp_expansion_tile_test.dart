import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  testWidgets('MPExpansionTile expands on tap', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MPExpansionTile(
            title: Text('Expand me'),
            children: [
              ListTile(title: Text('Child 1')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Child 1'), findsNothing);

    await tester.tap(find.text('Expand me'));
    await tester.pumpAndSettle();

    expect(find.text('Child 1'), findsOneWidget);
  });
}
