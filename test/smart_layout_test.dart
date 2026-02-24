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

  group('SmartLayout', () {
    testWidgets('shows mobile widget on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartLayout(
            mobile: const Text('Mobile'),
            tablet: const Text('Tablet'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.text('Tablet'), findsNothing);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('shows tablet widget on tablet', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: SmartLayout(
            mobile: const Text('Mobile'),
            tablet: const Text('Tablet'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Tablet'), findsOneWidget);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('shows desktop widget on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: SmartLayout(
            mobile: const Text('Mobile'),
            tablet: const Text('Tablet'),
            desktop: const Text('Desktop'),
          ),
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Tablet'), findsNothing);
      expect(find.text('Desktop'), findsOneWidget);
    });

    testWidgets('cascades widget from smaller breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: SmartLayout(
            mobile: const Text('Mobile'),
            // No tablet specified, should use mobile
          ),
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
    });

    testWidgets('builder receives breakpoint info', (tester) async {
      late SmartBreakpoint receivedBreakpoint;

      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: SmartLayout(
            mobile: const Text('Content'),
            builder: (context, breakpoint, child) {
              receivedBreakpoint = breakpoint;
              return child;
            },
          ),
        ),
      );

      expect(receivedBreakpoint, equals(SmartBreakpoint.tablet));
    });
  });

  group('BreakpointBuilder', () {
    testWidgets('provides current breakpoint to builder', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: BreakpointBuilder(
            builder: (context, breakpoint) {
              return Text('Breakpoint: ${breakpoint.name}');
            },
          ),
        ),
      );

      expect(find.text('Breakpoint: tablet'), findsOneWidget);
    });

    testWidgets('updates when breakpoint changes', (tester) async {
      Widget buildWidget(double width) {
        return MaterialApp(
          home: SmartUi(
            child: MediaQuery(
              data: MediaQueryData(size: Size(width, 800)),
              child: BreakpointBuilder(
                builder: (context, breakpoint) {
                  return Text('Breakpoint: ${breakpoint.name}');
                },
              ),
            ),
          ),
        );
      }

      await tester.pumpWidget(buildWidget(400));
      expect(find.text('Breakpoint: mobile'), findsOneWidget);

      await tester.pumpWidget(buildWidget(700));
      expect(find.text('Breakpoint: tablet'), findsOneWidget);
    });
  });
}
