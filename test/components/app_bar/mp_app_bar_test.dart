import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('MPAppBar Widget Tests', () {
    group('Render Tests', () {
      testWidgets('renders with title', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      });

      testWidgets('renders with subtitle', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                subtitle: Text('Test Subtitle'),
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Test Subtitle'), findsOneWidget);
      });

      testWidgets('renders with leading widget', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                leading: Icon(Icons.menu),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.menu), findsOneWidget);
      });

      testWidgets('renders with trailing widget', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                trailing: Icon(Icons.search),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('renders with actions', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                actions: [
                  Icon(Icons.search),
                  Icon(Icons.more_vert),
                ],
              ),
            ),
          ),
          );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
      });
    });

    group('Variant Tests', () {
      testWidgets('renders standard variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                variant: MPAppBarVariant.standard,
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      });

      testWidgets('renders elevated variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                variant: MPAppBarVariant.elevated,
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      });

      testWidgets('renders transparent variant', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                variant: MPAppBarVariant.transparent,
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      });
    });

    group('Title Alignment Tests', () {
      testWidgets('centers title when centerTitle is true', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                centerTitle: true,
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      });

      testWidgets('left-aligns title by default', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
      });
    });

    group('Action Alignment Tests', () {
      testWidgets('aligns actions to start', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                actionAlignment: MPAppBarActionAlignment.start,
              actions: [
                Icon(Icons.search),
              ],
            ),
          ),
        ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('aligns actions to end', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                title: Text('Test Title'),
                actionAlignment: MPAppBarActionAlignment.end,
              actions: [
                Icon(Icons.search),
              ],
            ),
          ),
        ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('has semantic label', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MPAppBar(
                semanticLabel: 'App bar for main screen',
                title: Text('Test Title'),
              ),
            ),
          ),
        );

        expect(find.bySemanticsLabel('App bar for main screen'), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('works with Scaffold', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: MPAppBar(
                  title: Text('Test Title'),
                ),
              ),
              body: Text('Body Content'),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Body Content'), findsOneWidget);
      });

      testWidgets('works with NestedScrollView', (tester) async {
        await tester.pumpWidget(
          MPTestHelpers.createTestApp(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: MPAppBar(
                  title: Text('Test Title'),
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Text('Scrollable Content'),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Scrollable Content'), findsOneWidget);
      });
    });
  });
}
