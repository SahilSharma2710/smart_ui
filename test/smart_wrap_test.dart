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

  group('SmartWrap', () {
    testWidgets('renders children', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartWrap(
            children: [
              Container(key: const Key('item1'), width: 100, height: 50),
              Container(key: const Key('item2'), width: 100, height: 50),
              Container(key: const Key('item3'), width: 100, height: 50),
            ],
          ),
        ),
      );

      expect(find.byKey(const Key('item1')), findsOneWidget);
      expect(find.byKey(const Key('item2')), findsOneWidget);
      expect(find.byKey(const Key('item3')), findsOneWidget);
    });

    testWidgets('applies spacing', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartWrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              Container(key: const Key('item1'), width: 100, height: 50),
              Container(key: const Key('item2'), width: 100, height: 50),
            ],
          ),
        ),
      );

      final item1 = tester.getRect(find.byKey(const Key('item1')));
      final item2 = tester.getRect(find.byKey(const Key('item2')));

      // Items should be spaced apart
      expect(item2.left - item1.right, equals(16));
    });

    testWidgets('fillRow expands items to fill available width', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartWrap(
            mobileItemsPerRow: 2,
            fillRow: true,
            spacing: 16,
            children: [
              Container(key: const Key('item1'), height: 50),
              Container(key: const Key('item2'), height: 50),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();

      final item1 = tester.getRect(find.byKey(const Key('item1')));
      final item2 = tester.getRect(find.byKey(const Key('item2')));

      // Items should have equal width and fill the row
      expect(item1.width, closeTo(item2.width, 1.0));
      expect(item1.top, equals(item2.top));
    });
  });

  group('SmartWrap.spaced', () {
    testWidgets('uses token-based spacing', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartWrap.spaced(
            spacingSize: SpacingSize.md,
            runSpacingSize: SpacingSize.sm,
            children: [
              Container(key: const Key('item1'), width: 100, height: 50),
              Container(key: const Key('item2'), width: 100, height: 50),
            ],
          ),
        ),
      );

      final item1 = tester.getRect(find.byKey(const Key('item1')));
      final item2 = tester.getRect(find.byKey(const Key('item2')));

      // Items should be spaced by md (16px)
      expect(item2.left - item1.right, equals(16));
    });
  });

  group('SmartChipWrap', () {
    testWidgets('renders chips from labels', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartChipWrap(
            labels: const ['Tag1', 'Tag2', 'Tag3'],
          ),
        ),
      );

      expect(find.text('Tag1'), findsOneWidget);
      expect(find.text('Tag2'), findsOneWidget);
      expect(find.text('Tag3'), findsOneWidget);
    });

    testWidgets('calls onSelected when chip tapped', (tester) async {
      String? selectedLabel;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartChipWrap(
            labels: const ['Tag1', 'Tag2'],
            onSelected: (label) => selectedLabel = label,
          ),
        ),
      );

      await tester.tap(find.text('Tag1'));
      expect(selectedLabel, equals('Tag1'));
    });

    testWidgets('shows selected state', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartChipWrap(
            labels: const ['Tag1', 'Tag2'],
            selectedLabels: const {'Tag1'},
          ),
        ),
      );

      // Both tags should be visible
      expect(find.text('Tag1'), findsOneWidget);
      expect(find.text('Tag2'), findsOneWidget);
    });

    testWidgets('uses custom chip builder', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartChipWrap(
            labels: const ['Tag1'],
            chipBuilder: (context, label, isSelected) => Container(
              key: Key('custom-$label'),
              child: Text('Custom: $label'),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('custom-Tag1')), findsOneWidget);
      expect(find.text('Custom: Tag1'), findsOneWidget);
    });
  });
}
