import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  Widget createTestWidget({
    required double width,
    required Widget child,
  }) {
    return MaterialApp(
      home: SmartUi(
        child: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: Scaffold(body: child),
        ),
      ),
    );
  }

  group('SmartSliverGrid', () {
    testWidgets('renders children in grid', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: CustomScrollView(
            slivers: [
              SmartSliverGrid(
                mobileColumns: 2,
                children: [
                  Container(key: const Key('item1'), color: Colors.red),
                  Container(key: const Key('item2'), color: Colors.blue),
                  Container(key: const Key('item3'), color: Colors.green),
                  Container(key: const Key('item4'), color: Colors.yellow),
                ],
              ),
            ],
          ),
        ),
      );

      expect(find.byKey(const Key('item1')), findsOneWidget);
      expect(find.byKey(const Key('item2')), findsOneWidget);
      expect(find.byKey(const Key('item3')), findsOneWidget);
      expect(find.byKey(const Key('item4')), findsOneWidget);
    });

    testWidgets('uses correct column count on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: CustomScrollView(
            slivers: [
              SmartSliverGrid(
                mobileColumns: 2,
                tabletColumns: 3,
                desktopColumns: 4,
                children: [
                  Container(key: const Key('item1'), height: 100, color: Colors.red),
                  Container(key: const Key('item2'), height: 100, color: Colors.blue),
                ],
              ),
            ],
          ),
        ),
      );

      final item1 = tester.getRect(find.byKey(const Key('item1')));
      final item2 = tester.getRect(find.byKey(const Key('item2')));

      // With 2 columns on mobile, items should be side by side
      expect(item1.top, equals(item2.top));
    });

    testWidgets('uses correct column count on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: CustomScrollView(
            slivers: [
              SmartSliverGrid(
                mobileColumns: 2,
                desktopColumns: 4,
                children: List.generate(
                  4,
                  (i) => Container(key: Key('item$i'), height: 100),
                ),
              ),
            ],
          ),
        ),
      );

      // All 4 items should be on the same row with 4 columns
      final items = List.generate(4, (i) => tester.getRect(find.byKey(Key('item$i'))));

      for (var i = 1; i < items.length; i++) {
        expect(items[i].top, equals(items[0].top));
      }
    });
  });

  group('SmartSliverGrid.builder', () {
    testWidgets('builds items with builder', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: CustomScrollView(
            slivers: [
              SmartSliverGrid.builder(
                itemCount: 4,
                mobileColumns: 2,
                itemBuilder: (context, index) => Container(
                  key: Key('item$index'),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byKey(const Key('item0')), findsOneWidget);
      expect(find.byKey(const Key('item1')), findsOneWidget);
    });
  });

  group('SliverSmartPadding', () {
    testWidgets('applies responsive padding', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: CustomScrollView(
            slivers: [
              SliverSmartPadding(
                mobile: const EdgeInsets.all(8),
                desktop: const EdgeInsets.all(24),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    key: const Key('content'),
                    height: 100,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byKey(const Key('content')), findsOneWidget);
    });
  });

  group('SliverSmartVisible', () {
    testWidgets('shows sliver when visible on breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: CustomScrollView(
            slivers: [
              SliverSmartVisible(
                visibleOn: const [SmartBreakpoint.desktop, SmartBreakpoint.tv],
                sliver: SliverToBoxAdapter(
                  child: Container(
                    key: const Key('desktop-only'),
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('desktop-only')), findsOneWidget);
    });

    testWidgets('hides sliver when not visible on breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: CustomScrollView(
            slivers: [
              SliverSmartVisible(
                visibleOn: const [SmartBreakpoint.desktop, SmartBreakpoint.tv],
                sliver: SliverToBoxAdapter(
                  child: Container(
                    key: const Key('desktop-only'),
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('desktop-only')), findsNothing);
    });

    testWidgets('shows sliver with hiddenOn when not hidden', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: CustomScrollView(
            slivers: [
              SliverSmartVisible.except(
                breakpoints: const [SmartBreakpoint.mobile, SmartBreakpoint.watch],
                sliver: SliverToBoxAdapter(
                  child: Container(
                    key: const Key('hide-mobile'),
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('hide-mobile')), findsOneWidget);
    });
  });

  group('SliverSmartList', () {
    testWidgets('uses correct builder for breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: CustomScrollView(
            slivers: [
              SliverSmartList(
                itemCount: 2,
                mobile: (context, index) => Container(
                  key: Key('mobile$index'),
                  child: const Text('Mobile'),
                ),
                desktop: (context, index) => Container(
                  key: Key('desktop$index'),
                  child: const Text('Desktop'),
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byKey(const Key('mobile0')), findsOneWidget);
      expect(find.text('Mobile'), findsWidgets);
      expect(find.byKey(const Key('desktop0')), findsNothing);
    });
  });
}
