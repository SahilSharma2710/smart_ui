import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_kit/adaptive_kit.dart';

void main() {
  group('SmartApp', () {
    testWidgets('provides SmartUi configuration', (tester) async {
      SmartUiData? capturedConfig;

      await tester.pumpWidget(
        SmartApp(
          home: Builder(
            builder: (context) {
              capturedConfig = SmartUi.of(context);
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedConfig, isNotNull);
      expect(capturedConfig!.breakpoints, equals(SmartBreakpoints.defaults));
    });

    testWidgets('accepts custom breakpoints', (tester) async {
      SmartUiData? capturedConfig;
      const customBreakpoints = SmartBreakpoints(
        mobile: 400,
        tablet: 800,
        desktop: 1100,
      );

      await tester.pumpWidget(
        SmartApp(
          breakpoints: customBreakpoints,
          home: Builder(
            builder: (context) {
              capturedConfig = SmartUi.of(context);
              return const Text('Test');
            },
          ),
        ),
      );

      expect(capturedConfig!.breakpoints, equals(customBreakpoints));
    });

    testWidgets('passes theme to MaterialApp', (tester) async {
      await tester.pumpWidget(
        SmartApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const Text('Test'),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('passes title to MaterialApp', (tester) async {
      await tester.pumpWidget(
        const SmartApp(
          title: 'Test App',
          home: Text('Test'),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });
  });

  group('SmartApp.router', () {
    testWidgets('creates router-based app with SmartUi', (tester) async {
      SmartUiData? capturedConfig;

      await tester.pumpWidget(
        SmartApp.router(
          routerConfig: RouterConfig(
            routerDelegate: _TestRouterDelegate(
              builder: (context) {
                capturedConfig = SmartUi.of(context);
                return const Text('Router Test');
              },
            ),
            routeInformationParser: _TestRouteInformationParser(),
            routeInformationProvider: PlatformRouteInformationProvider(
              initialRouteInformation: RouteInformation(uri: Uri.parse('/')),
            ),
          ),
        ),
      );

      expect(find.text('Router Test'), findsOneWidget);
      expect(capturedConfig, isNotNull);
    });
  });
}

class _TestRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  _TestRouterDelegate({required this.builder});

  final Widget Function(BuildContext) builder;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        onPopPage: (route, result) => route.didPop(result),
        pages: [
          MaterialPage<void>(
            child: Builder(builder: builder),
          ),
        ],
      );

  @override
  Future<void> setNewRoutePath(Object configuration) async {}
}

class _TestRouteInformationParser extends RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(RouteInformation routeInformation) async {
    return Object();
  }
}
