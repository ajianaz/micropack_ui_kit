import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  testWidgets('MPSlidable renders child and actions', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MPSlidable(
            child: ListTile(title: Text('Swipe me')),
            startActions: [
              MPSlidableAction(
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (_) {},
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Swipe me'), findsOneWidget);
  });
}
