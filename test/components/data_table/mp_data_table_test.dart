import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

void main() {
  testWidgets('MPDataTable displays rows and columns', (tester) async {
    final columns = [
      MPDataColumn(label: 'Name'),
      MPDataColumn(label: 'Age'),
    ];

    final rows = [
      ['John', '30'],
      ['Jane', '25'],
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MPDataTable(
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );

    expect(find.text('Name'), findsOneWidget);
    expect(find.text('John'), findsOneWidget);
  });
}
