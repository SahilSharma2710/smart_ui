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

  group('SmartImage', () {
    testWidgets('shows mobile image on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartImage(
            mobile: const AssetImage('assets/mobile.png'),
            tablet: const AssetImage('assets/tablet.png'),
            desktop: const AssetImage('assets/desktop.png'),
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.image, isA<AssetImage>());
      expect((image.image as AssetImage).assetName, equals('assets/mobile.png'));
    });

    testWidgets('shows tablet image on tablet', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700,
          child: SmartImage(
            mobile: const AssetImage('assets/mobile.png'),
            tablet: const AssetImage('assets/tablet.png'),
            desktop: const AssetImage('assets/desktop.png'),
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect((image.image as AssetImage).assetName, equals('assets/tablet.png'));
    });

    testWidgets('shows desktop image on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 1000,
          child: SmartImage(
            mobile: const AssetImage('assets/mobile.png'),
            tablet: const AssetImage('assets/tablet.png'),
            desktop: const AssetImage('assets/desktop.png'),
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect((image.image as AssetImage).assetName, equals('assets/desktop.png'));
    });

    testWidgets('cascades image from smaller breakpoint', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 700, // tablet
          child: SmartImage(
            mobile: const AssetImage('assets/mobile.png'),
            // No tablet specified, should use mobile
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect((image.image as AssetImage).assetName, equals('assets/mobile.png'));
    });

    testWidgets('applies fit property', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartImage(
            mobile: const AssetImage('assets/mobile.png'),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.fit, equals(BoxFit.cover));
    });

    testWidgets('applies alignment property', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartImage(
            mobile: const AssetImage('assets/mobile.png'),
            alignment: Alignment.topLeft,
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.alignment, equals(Alignment.topLeft));
    });
  });

  group('SmartImage.asset', () {
    testWidgets('creates AssetImage from string paths', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartImage.asset(
            mobile: 'assets/mobile.png',
            desktop: 'assets/desktop.png',
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.image, isA<AssetImage>());
      expect((image.image as AssetImage).assetName, equals('assets/mobile.png'));
    });
  });

  group('SmartImage.network', () {
    testWidgets('creates NetworkImage from URLs', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          width: 400,
          child: SmartImage.network(
            mobile: 'https://example.com/mobile.png',
            desktop: 'https://example.com/desktop.png',
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.image, isA<NetworkImage>());
      expect((image.image as NetworkImage).url, equals('https://example.com/mobile.png'));
    });
  });
}
