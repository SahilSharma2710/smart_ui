import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  Widget createTestWidget({
    required double width,
    required Widget child,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return MaterialApp(
      home: SmartUi(
        child: MediaQuery(
          data: MediaQueryData(
            size: Size(width, 800),
            padding: padding,
          ),
          child: Scaffold(body: child),
        ),
      ),
    );
  }

  group('SmartSafeArea', () {
    testWidgets('applies safe area by default', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          padding: const EdgeInsets.only(top: 44, bottom: 34),
          child: SmartSafeArea(
            child: Container(
              key: const Key('content'),
              color: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('content')), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('respects minimum padding', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartSafeArea(
            minimum: const EdgeInsets.all(16),
            child: Container(
              key: const Key('content'),
              color: Colors.blue,
            ),
          ),
        ),
      );

      final SafeArea safeArea = tester.widget(find.byType(SafeArea));
      expect(safeArea.minimum, equals(const EdgeInsets.all(16)));
    });

    testWidgets('allows disabling specific edges', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartSafeArea(
            top: false,
            bottom: true,
            left: true,
            right: true,
            child: Container(
              key: const Key('content'),
              color: Colors.blue,
            ),
          ),
        ),
      );

      final SafeArea safeArea = tester.widget(find.byType(SafeArea));
      expect(safeArea.top, isFalse);
      expect(safeArea.bottom, isTrue);
    });

    testWidgets('responsive overrides work on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: SmartSafeArea(
            top: true,
            mobileTop: false, // override for mobile
            child: Container(
              key: const Key('content'),
              color: Colors.blue,
            ),
          ),
        ),
      );

      final SafeArea safeArea = tester.widget(find.byType(SafeArea));
      expect(safeArea.top, isFalse);
    });

    testWidgets('responsive overrides work on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: SmartSafeArea(
            top: true,
            desktopTop: false, // override for desktop
            child: Container(
              key: const Key('content'),
              color: Colors.blue,
            ),
          ),
        ),
      );

      final SafeArea safeArea = tester.widget(find.byType(SafeArea));
      expect(safeArea.top, isFalse);
    });
  });

  group('SmartSafeArea.mobileOnly', () {
    testWidgets('applies safe area on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400, // mobile
          child: SmartSafeArea.mobileOnly(
            child: Container(
              key: const Key('content'),
              color: Colors.blue,
            ),
          ),
        ),
      );

      final SafeArea safeArea = tester.widget(find.byType(SafeArea));
      expect(safeArea.top, isTrue);
      expect(safeArea.bottom, isTrue);
    });

    testWidgets('does not apply safe area on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000, // desktop
          child: SmartSafeArea.mobileOnly(
            child: Container(
              key: const Key('content'),
              color: Colors.blue,
            ),
          ),
        ),
      );

      final SafeArea safeArea = tester.widget(find.byType(SafeArea));
      expect(safeArea.top, isFalse);
      expect(safeArea.bottom, isFalse);
    });
  });

  group('SmartSafeAreaExtension', () {
    testWidgets('safeAreaPadding returns padding', (tester) async {
      EdgeInsets? capturedPadding;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          padding: const EdgeInsets.only(top: 44, bottom: 34),
          child: Builder(
            builder: (context) {
              capturedPadding = context.safeAreaPadding;
              return Container();
            },
          ),
        ),
      );

      expect(capturedPadding!.top, equals(44));
      expect(capturedPadding!.bottom, equals(34));
    });

    testWidgets('safeAreaTop returns top padding', (tester) async {
      double? capturedTop;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          padding: const EdgeInsets.only(top: 44),
          child: Builder(
            builder: (context) {
              capturedTop = context.safeAreaTop;
              return Container();
            },
          ),
        ),
      );

      expect(capturedTop, equals(44));
    });

    testWidgets('hasTopSafeArea returns true when has padding', (tester) async {
      bool? hasTop;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          padding: const EdgeInsets.only(top: 44),
          child: Builder(
            builder: (context) {
              hasTop = context.hasTopSafeArea;
              return Container();
            },
          ),
        ),
      );

      expect(hasTop, isTrue);
    });

    testWidgets('hasSafeAreaPadding returns false when no padding', (tester) async {
      bool? hasPadding;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          padding: EdgeInsets.zero,
          child: Builder(
            builder: (context) {
              hasPadding = context.hasSafeAreaPadding;
              return Container();
            },
          ),
        ),
      );

      expect(hasPadding, isFalse);
    });
  });

  group('SliverSmartSafeArea', () {
    testWidgets('applies safe area to sliver', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: CustomScrollView(
            slivers: [
              SliverSmartSafeArea(
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
      expect(find.byType(SliverSafeArea), findsOneWidget);
    });
  });
}
