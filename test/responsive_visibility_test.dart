import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_ui/smart_ui.dart';

void main() {
  Widget createTestWidget({
    required double width,
    required Widget child,
  }) {
    return MaterialApp(
      home: SmartUi(
        child: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: child,
        ),
      ),
    );
  }

  group('SmartVisible', () {
    testWidgets('shows widget when visible on current breakpoint',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: SmartVisible(
            visibleOn: const [SmartBreakpoint.tablet, SmartBreakpoint.desktop],
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('hides widget when not visible on current breakpoint',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: SmartVisible(
            visibleOn: const [SmartBreakpoint.tablet, SmartBreakpoint.desktop],
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsNothing);
    });

    testWidgets('shows replacement when hidden', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: SmartVisible(
            visibleOn: const [SmartBreakpoint.desktop],
            replacement: const Text('Replacement'),
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsNothing);
      expect(find.text('Replacement'), findsOneWidget);
    });

    testWidgets('hiddenOn hides on specified breakpoints', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: SmartVisible(
            hiddenOn: const [SmartBreakpoint.mobile],
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsNothing);
    });

    testWidgets('hiddenOn shows on other breakpoints', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: SmartVisible(
            hiddenOn: const [SmartBreakpoint.mobile],
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('SmartVisible.on', () {
    testWidgets('works correctly', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: SmartVisible.on(
            breakpoints: const [SmartBreakpoint.tablet],
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('SmartVisible.except', () {
    testWidgets('works correctly', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: SmartVisible.except(
            breakpoints: const [SmartBreakpoint.mobile],
            child: const Text('Content'),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('MobileOnly', () {
    testWidgets('shows on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: const MobileOnly(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('hides on tablet', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: const MobileOnly(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsNothing);
    });
  });

  group('TabletOnly', () {
    testWidgets('shows on tablet', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: const TabletOnly(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('hides on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: const TabletOnly(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsNothing);
    });
  });

  group('DesktopOnly', () {
    testWidgets('shows on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: const DesktopOnly(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('hides on tablet', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: const DesktopOnly(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsNothing);
    });
  });

  group('HideOnMobile', () {
    testWidgets('hides on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: const HideOnMobile(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsNothing);
    });

    testWidgets('shows on tablet', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: const HideOnMobile(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('HideOnDesktop', () {
    testWidgets('hides on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: const HideOnDesktop(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsNothing);
    });

    testWidgets('shows on tablet', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: const HideOnDesktop(child: Text('Content')),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });
  });
}
