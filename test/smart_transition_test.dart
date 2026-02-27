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
          child: child,
        ),
      ),
    );
  }

  group('SmartLayout with transitions', () {
    testWidgets('applies fade transition', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartLayout(
            transition: SmartTransition.fade,
            transitionDuration: const Duration(milliseconds: 300),
            mobile: const Text('Mobile'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.byType(FadeTransition), findsOneWidget);
    });

    testWidgets('applies fadeSlide transition', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartLayout(
            transition: SmartTransition.fadeSlide,
            mobile: const Text('Mobile'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.byType(FadeTransition), findsOneWidget);
      expect(find.byType(SlideTransition), findsOneWidget);
    });

    testWidgets('applies scale transition', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartLayout(
            transition: SmartTransition.scale,
            mobile: const Text('Mobile'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.byType(ScaleTransition), findsOneWidget);
    });

    testWidgets('no animation with SmartTransition.none', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartLayout(
            transition: SmartTransition.none,
            mobile: const Text('Mobile'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.byType(AnimatedSwitcher), findsNothing);
    });

    testWidgets('uses custom transitionBuilder', (tester) async {
      bool builderCalled = false;

      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartLayout(
            transitionBuilder: (child, animation) {
              builderCalled = true;
              return FadeTransition(opacity: animation, child: child);
            },
            mobile: const Text('Mobile'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(builderCalled, isTrue);
    });
  });

  group('SmartVisible with transitions', () {
    testWidgets('applies fade transition', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: SmartVisible(
            visibleOn: const [SmartBreakpoint.desktop],
            transition: SmartTransition.fade,
            child: const Text('Desktop Content'),
          ),
        ),
      );

      expect(find.text('Desktop Content'), findsOneWidget);
      expect(find.byType(FadeTransition), findsOneWidget);
    });

    testWidgets('no animation with SmartTransition.none', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: SmartVisible(
            visibleOn: const [SmartBreakpoint.desktop],
            transition: SmartTransition.none,
            child: const Text('Desktop Content'),
          ),
        ),
      );

      expect(find.text('Desktop Content'), findsOneWidget);
      expect(find.byType(AnimatedSwitcher), findsNothing);
    });
  });

  group('SmartTransition enum', () {
    test('has all expected values', () {
      expect(SmartTransition.values, containsAll([
        SmartTransition.none,
        SmartTransition.fade,
        SmartTransition.fadeSlide,
        SmartTransition.crossFade,
        SmartTransition.scale,
      ]));
    });
  });
}
