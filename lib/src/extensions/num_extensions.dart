/// Number extensions for responsive sizing.
///
/// This module provides extensions on [num] for responsive
/// sizing calculations based on screen dimensions.
library;

import 'package:flutter/widgets.dart';

/// A utility class for responsive number calculations.
///
/// Provides methods to calculate sizes relative to the screen
/// dimensions or a reference design size.
abstract final class SmartSize {
  static double? _screenWidth;
  static double? _screenHeight;
  static Size? _designSize;

  /// Initializes the sizing system with screen dimensions.
  ///
  /// Call this in your widget tree using a [LayoutBuilder] or
  /// in your app initialization.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   return LayoutBuilder(
  ///     builder: (context, constraints) {
  ///       SmartSize.init(
  ///         screenWidth: constraints.maxWidth,
  ///         screenHeight: constraints.maxHeight,
  ///         designSize: Size(375, 812), // iPhone X design size
  ///       );
  ///       return MyApp();
  ///     },
  ///   );
  /// }
  /// ```
  static void init({
    required double screenWidth,
    required double screenHeight,
    Size? designSize,
  }) {
    _screenWidth = screenWidth;
    _screenHeight = screenHeight;
    _designSize = designSize;
  }

  /// Initializes from a [BuildContext].
  static void initFromContext(BuildContext context, {Size? designSize}) {
    final size = MediaQuery.sizeOf(context);
    init(
      screenWidth: size.width,
      screenHeight: size.height,
      designSize: designSize,
    );
  }

  /// The current screen width.
  static double get screenWidth => _screenWidth ?? 375;

  /// The current screen height.
  static double get screenHeight => _screenHeight ?? 812;

  /// The design reference size.
  static Size get designSize => _designSize ?? const Size(375, 812);

  /// The scale factor for width-based calculations.
  static double get scaleWidth => screenWidth / designSize.width;

  /// The scale factor for height-based calculations.
  static double get scaleHeight => screenHeight / designSize.height;

  /// The scale factor for text (uses the smaller of width/height).
  static double get scaleText {
    final scaleW = screenWidth / designSize.width;
    final scaleH = screenHeight / designSize.height;
    return scaleW < scaleH ? scaleW : scaleH;
  }

  /// Converts a value to a width-scaled value.
  static double setWidth(num width) => width * scaleWidth;

  /// Converts a value to a height-scaled value.
  static double setHeight(num height) => height * scaleHeight;

  /// Converts a value to a text-scaled value (sp).
  static double setSp(num fontSize) => fontSize * scaleText;

  /// Converts a percentage to actual screen width.
  static double percentWidth(num percent) => screenWidth * (percent / 100);

  /// Converts a percentage to actual screen height.
  static double percentHeight(num percent) => screenHeight * (percent / 100);
}

/// Extension on [num] for responsive sizing.
///
/// Provides convenient properties for scaling values relative
/// to screen dimensions.
///
/// Example:
/// ```dart
/// // Scale based on design width
/// Container(width: 100.w)
///
/// // Scale based on design height
/// Container(height: 50.h)
///
/// // Scale text size
/// Text('Hello', style: TextStyle(fontSize: 16.sp))
///
/// // Percentage of screen
/// Container(width: 50.sw) // 50% of screen width
/// Container(height: 25.sh) // 25% of screen height
/// ```
extension SmartNumExtension on num {
  /// Scales this value based on the design width.
  ///
  /// Example:
  /// ```dart
  /// Container(width: 100.w) // Scaled width
  /// ```
  double get w => SmartSize.setWidth(this);

  /// Scales this value based on the design height.
  ///
  /// Example:
  /// ```dart
  /// Container(height: 50.h) // Scaled height
  /// ```
  double get h => SmartSize.setHeight(this);

  /// Scales this value for text (scaled points).
  ///
  /// Uses the smaller of width/height scale to prevent
  /// text from becoming too large on wide screens.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello', style: TextStyle(fontSize: 16.sp))
  /// ```
  double get sp => SmartSize.setSp(this);

  /// Converts this percentage value to screen width.
  ///
  /// Example:
  /// ```dart
  /// Container(width: 50.sw) // 50% of screen width
  /// ```
  double get sw => SmartSize.percentWidth(this);

  /// Converts this percentage value to screen height.
  ///
  /// Example:
  /// ```dart
  /// Container(height: 25.sh) // 25% of screen height
  /// ```
  double get sh => SmartSize.percentHeight(this);

  /// Returns this value as a [SizedBox] with this width.
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  /// Returns this value as a [SizedBox] with this height.
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// Returns this value as scaled [SizedBox] width.
  SizedBox get horizontalSpaceScaled => SizedBox(width: w);

  /// Returns this value as scaled [SizedBox] height.
  SizedBox get verticalSpaceScaled => SizedBox(height: h);

  /// Returns [EdgeInsets] with this value on all sides.
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  /// Returns [EdgeInsets] with this value horizontally.
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Returns [EdgeInsets] with this value vertically.
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Returns [EdgeInsets] with this value on the left.
  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());

  /// Returns [EdgeInsets] with this value on the right.
  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());

  /// Returns [EdgeInsets] with this value on the top.
  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());

  /// Returns [EdgeInsets] with this value on the bottom.
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());

  /// Returns a [BorderRadius] with this value.
  BorderRadius get borderRadius =>
      BorderRadius.all(Radius.circular(toDouble()));

  /// Returns a circular [Radius] with this value.
  Radius get radius => Radius.circular(toDouble());

  /// Returns a [Duration] with this value in milliseconds.
  Duration get ms => Duration(milliseconds: toInt());

  /// Returns a [Duration] with this value in seconds.
  Duration get seconds => Duration(seconds: toInt());

  /// Returns a [Duration] with this value in minutes.
  Duration get minutes => Duration(minutes: toInt());
}

/// A widget that initializes [SmartSize] for its descendants.
///
/// Wrap your app with this widget to enable the `.w`, `.h`, and `.sp`
/// extensions.
///
/// Example:
/// ```dart
/// SmartSizeInit(
///   designSize: Size(375, 812), // iPhone X design size
///   child: MaterialApp(...),
/// )
/// ```
class SmartSizeInit extends StatelessWidget {
  /// Creates a [SmartSizeInit] widget.
  const SmartSizeInit({
    required this.child,
    super.key,
    this.designSize = const Size(375, 812),
  });

  /// The reference design size for scaling calculations.
  final Size designSize;

  /// The child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          SmartSize.init(
            screenWidth: constraints.maxWidth,
            screenHeight: constraints.maxHeight,
            designSize: designSize,
          );
          return child;
        },
      );
}
