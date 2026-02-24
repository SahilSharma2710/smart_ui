import 'package:flutter_test/flutter_test.dart';
import 'package:smartui/smartui.dart';

void main() {
  group('SmartBreakpoint', () {
    test('enum values are ordered correctly', () {
      expect(
          SmartBreakpoint.watch.index, lessThan(SmartBreakpoint.mobile.index));
      expect(
          SmartBreakpoint.mobile.index, lessThan(SmartBreakpoint.tablet.index));
      expect(SmartBreakpoint.tablet.index,
          lessThan(SmartBreakpoint.desktop.index));
      expect(SmartBreakpoint.desktop.index, lessThan(SmartBreakpoint.tv.index));
    });

    test('comparison operators work correctly', () {
      expect(SmartBreakpoint.mobile < SmartBreakpoint.tablet, isTrue);
      expect(SmartBreakpoint.mobile <= SmartBreakpoint.mobile, isTrue);
      expect(SmartBreakpoint.desktop > SmartBreakpoint.tablet, isTrue);
      expect(SmartBreakpoint.desktop >= SmartBreakpoint.desktop, isTrue);
    });

    test('compareTo works correctly', () {
      expect(SmartBreakpoint.mobile.compareTo(SmartBreakpoint.tablet),
          lessThan(0));
      expect(
          SmartBreakpoint.tablet.compareTo(SmartBreakpoint.tablet), equals(0));
      expect(SmartBreakpoint.desktop.compareTo(SmartBreakpoint.mobile),
          greaterThan(0));
    });
  });

  group('SmartBreakpoints', () {
    test('default values are correct', () {
      const breakpoints = SmartBreakpoints.defaults;
      expect(breakpoints.watch, equals(0));
      expect(breakpoints.mobile, equals(300));
      expect(breakpoints.tablet, equals(600));
      expect(breakpoints.desktop, equals(900));
      expect(breakpoints.tv, equals(1200));
    });

    test('custom values work correctly', () {
      const breakpoints = SmartBreakpoints.custom(
        mobile: 320,
        tablet: 768,
        desktop: 1024,
        tv: 1440,
      );
      expect(breakpoints.mobile, equals(320));
      expect(breakpoints.tablet, equals(768));
      expect(breakpoints.desktop, equals(1024));
      expect(breakpoints.tv, equals(1440));
    });

    test('breakpointForWidth returns correct breakpoint', () {
      const breakpoints = SmartBreakpoints.defaults;

      expect(breakpoints.breakpointForWidth(0), equals(SmartBreakpoint.watch));
      expect(
          breakpoints.breakpointForWidth(299), equals(SmartBreakpoint.watch));
      expect(
          breakpoints.breakpointForWidth(300), equals(SmartBreakpoint.mobile));
      expect(
          breakpoints.breakpointForWidth(599), equals(SmartBreakpoint.mobile));
      expect(
          breakpoints.breakpointForWidth(600), equals(SmartBreakpoint.tablet));
      expect(
          breakpoints.breakpointForWidth(899), equals(SmartBreakpoint.tablet));
      expect(
          breakpoints.breakpointForWidth(900), equals(SmartBreakpoint.desktop));
      expect(breakpoints.breakpointForWidth(1199),
          equals(SmartBreakpoint.desktop));
      expect(breakpoints.breakpointForWidth(1200), equals(SmartBreakpoint.tv));
      expect(breakpoints.breakpointForWidth(2000), equals(SmartBreakpoint.tv));
    });

    test('minWidthFor returns correct values', () {
      const breakpoints = SmartBreakpoints.defaults;

      expect(breakpoints.minWidthFor(SmartBreakpoint.watch), equals(0));
      expect(breakpoints.minWidthFor(SmartBreakpoint.mobile), equals(300));
      expect(breakpoints.minWidthFor(SmartBreakpoint.tablet), equals(600));
      expect(breakpoints.minWidthFor(SmartBreakpoint.desktop), equals(900));
      expect(breakpoints.minWidthFor(SmartBreakpoint.tv), equals(1200));
    });

    test('maxWidthFor returns correct values', () {
      const breakpoints = SmartBreakpoints.defaults;

      expect(breakpoints.maxWidthFor(SmartBreakpoint.watch), equals(299));
      expect(breakpoints.maxWidthFor(SmartBreakpoint.mobile), equals(599));
      expect(breakpoints.maxWidthFor(SmartBreakpoint.tablet), equals(899));
      expect(breakpoints.maxWidthFor(SmartBreakpoint.desktop), equals(1199));
      expect(
          breakpoints.maxWidthFor(SmartBreakpoint.tv), equals(double.infinity));
    });

    test('copyWith works correctly', () {
      const original = SmartBreakpoints.defaults;
      final copied = original.copyWith(mobile: 350, desktop: 1000);

      expect(copied.watch, equals(0));
      expect(copied.mobile, equals(350));
      expect(copied.tablet, equals(600));
      expect(copied.desktop, equals(1000));
      expect(copied.tv, equals(1200));
    });

    test('equality works correctly', () {
      const a = SmartBreakpoints.defaults;
      const b = SmartBreakpoints();
      const c = SmartBreakpoints(mobile: 350);

      expect(a == b, isTrue);
      expect(a == c, isFalse);
      expect(a.hashCode == b.hashCode, isTrue);
    });
  });
}
