import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartui/smartui.dart';

void main() {
  group('SmartRadius', () {
    test('constants have correct values', () {
      expect(SmartRadius.none, equals(BorderRadius.zero));
      expect(
          SmartRadius.xs, equals(const BorderRadius.all(Radius.circular(2))));
      expect(
          SmartRadius.sm, equals(const BorderRadius.all(Radius.circular(4))));
      expect(
          SmartRadius.md, equals(const BorderRadius.all(Radius.circular(8))));
      expect(
          SmartRadius.lg, equals(const BorderRadius.all(Radius.circular(12))));
      expect(
          SmartRadius.xl, equals(const BorderRadius.all(Radius.circular(16))));
      expect(
          SmartRadius.xxl, equals(const BorderRadius.all(Radius.circular(24))));
      expect(SmartRadius.full,
          equals(const BorderRadius.all(Radius.circular(9999))));
    });

    test('value constants are correct', () {
      expect(SmartRadius.xsValue, equals(2));
      expect(SmartRadius.smValue, equals(4));
      expect(SmartRadius.mdValue, equals(8));
      expect(SmartRadius.lgValue, equals(12));
      expect(SmartRadius.xlValue, equals(16));
      expect(SmartRadius.xxlValue, equals(24));
    });

    test('fromSize returns correct BorderRadius', () {
      expect(SmartRadius.fromSize(RadiusSize.none), equals(SmartRadius.none));
      expect(SmartRadius.fromSize(RadiusSize.xs), equals(SmartRadius.xs));
      expect(SmartRadius.fromSize(RadiusSize.sm), equals(SmartRadius.sm));
      expect(SmartRadius.fromSize(RadiusSize.md), equals(SmartRadius.md));
      expect(SmartRadius.fromSize(RadiusSize.lg), equals(SmartRadius.lg));
      expect(SmartRadius.fromSize(RadiusSize.xl), equals(SmartRadius.xl));
      expect(SmartRadius.fromSize(RadiusSize.xxl), equals(SmartRadius.xxl));
      expect(SmartRadius.fromSize(RadiusSize.full), equals(SmartRadius.full));
    });

    test('valueFromSize returns correct values', () {
      expect(SmartRadius.valueFromSize(RadiusSize.none), equals(0));
      expect(SmartRadius.valueFromSize(RadiusSize.xs), equals(2));
      expect(SmartRadius.valueFromSize(RadiusSize.sm), equals(4));
      expect(SmartRadius.valueFromSize(RadiusSize.md), equals(8));
      expect(SmartRadius.valueFromSize(RadiusSize.lg), equals(12));
      expect(SmartRadius.valueFromSize(RadiusSize.xl), equals(16));
      expect(SmartRadius.valueFromSize(RadiusSize.xxl), equals(24));
      expect(SmartRadius.valueFromSize(RadiusSize.full), equals(9999));
    });

    test('all creates correct BorderRadius', () {
      expect(
        SmartRadius.all(10),
        equals(const BorderRadius.all(Radius.circular(10))),
      );
    });

    test('top creates correct BorderRadius', () {
      expect(
        SmartRadius.top(10),
        equals(const BorderRadius.vertical(top: Radius.circular(10))),
      );
    });

    test('bottom creates correct BorderRadius', () {
      expect(
        SmartRadius.bottom(10),
        equals(const BorderRadius.vertical(bottom: Radius.circular(10))),
      );
    });

    test('left creates correct BorderRadius', () {
      expect(
        SmartRadius.left(10),
        equals(const BorderRadius.horizontal(left: Radius.circular(10))),
      );
    });

    test('right creates correct BorderRadius', () {
      expect(
        SmartRadius.right(10),
        equals(const BorderRadius.horizontal(right: Radius.circular(10))),
      );
    });

    test('only creates correct BorderRadius', () {
      expect(
        SmartRadius.only(
            topLeft: 5, topRight: 10, bottomLeft: 15, bottomRight: 20),
        equals(const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(20),
        )),
      );
    });
  });

  group('RadiusSize', () {
    test('borderRadius getter returns correct BorderRadius', () {
      expect(RadiusSize.none.borderRadius, equals(SmartRadius.none));
      expect(RadiusSize.md.borderRadius, equals(SmartRadius.md));
      expect(RadiusSize.full.borderRadius, equals(SmartRadius.full));
    });

    test('value getter returns correct values', () {
      expect(RadiusSize.none.value, equals(0));
      expect(RadiusSize.md.value, equals(8));
      expect(RadiusSize.full.value, equals(9999));
    });
  });
}
