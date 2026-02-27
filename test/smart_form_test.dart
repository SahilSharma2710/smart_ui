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

  group('SmartForm', () {
    testWidgets('renders form fields', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartForm(
            children: [
              SmartFormField(child: TextField(key: const Key('field1'))),
              SmartFormField(child: TextField(key: const Key('field2'))),
            ],
          ),
        ),
      );

      expect(find.byKey(const Key('field1')), findsOneWidget);
      expect(find.byKey(const Key('field2')), findsOneWidget);
    });

    testWidgets('uses 1 column on mobile by default', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartForm(
            children: [
              SmartFormField(child: Container(key: const Key('field1'))),
              SmartFormField(child: Container(key: const Key('field2'))),
            ],
          ),
        ),
      );

      // On mobile (1 column), fields should be stacked vertically
      final field1 = tester.getRect(find.byKey(const Key('field1')));
      final field2 = tester.getRect(find.byKey(const Key('field2')));

      // field2 should be below field1
      expect(field2.top, greaterThan(field1.top));
    });

    testWidgets('respects custom column counts', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartForm(
            mobileColumns: 2,
            children: [
              SmartFormField(child: Container(key: const Key('field1'), height: 50)),
              SmartFormField(child: Container(key: const Key('field2'), height: 50)),
            ],
          ),
        ),
      );

      final field1 = tester.getRect(find.byKey(const Key('field1')));
      final field2 = tester.getRect(find.byKey(const Key('field2')));

      // With 2 columns, fields should be on the same row
      expect(field2.top, equals(field1.top));
      expect(field2.left, greaterThan(field1.left));
    });

    testWidgets('respects field span', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: SmartForm(
            desktopColumns: 3,
            children: [
              SmartFormField(
                span: 2,
                child: Container(key: const Key('wide'), height: 50),
              ),
              SmartFormField(
                child: Container(key: const Key('narrow'), height: 50),
              ),
            ],
          ),
        ),
      );

      final wide = tester.getRect(find.byKey(const Key('wide')));
      final narrow = tester.getRect(find.byKey(const Key('narrow')));

      // Wide field should be roughly 2x the width of narrow
      expect(wide.width, greaterThan(narrow.width * 1.5));
    });
  });

  group('SmartFormSection', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartFormSection(
            title: 'Section Title',
            children: [
              SmartFormField(child: TextField()),
            ],
          ),
        ),
      );

      expect(find.text('Section Title'), findsOneWidget);
    });

    testWidgets('renders description', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartFormSection(
            title: 'Title',
            description: 'Section description',
            children: [
              SmartFormField(child: TextField()),
            ],
          ),
        ),
      );

      expect(find.text('Section description'), findsOneWidget);
    });
  });

  group('SmartFormRow', () {
    testWidgets('renders children in a row', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartFormRow(
            children: [
              Expanded(child: Container(key: const Key('child1'))),
              Expanded(child: Container(key: const Key('child2'))),
            ],
          ),
        ),
      );

      final child1 = tester.getRect(find.byKey(const Key('child1')));
      final child2 = tester.getRect(find.byKey(const Key('child2')));

      expect(child1.top, equals(child2.top));
      expect(child2.left, greaterThan(child1.left));
    });
  });
}
