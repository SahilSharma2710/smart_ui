/// Responsive image widget.
///
/// This module provides a widget that displays different images
/// based on the current breakpoint.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';

/// A widget that displays different images based on the current breakpoint.
///
/// Use [SmartImage] when you need to serve different image assets for
/// different screen sizes (e.g., optimized images for mobile vs desktop).
///
/// Example:
/// ```dart
/// SmartImage(
///   mobile: AssetImage('assets/images/hero_mobile.png'),
///   tablet: AssetImage('assets/images/hero_tablet.png'),
///   desktop: AssetImage('assets/images/hero_desktop.png'),
///   fit: BoxFit.cover,
/// )
/// ```
///
/// With network images:
/// ```dart
/// SmartImage(
///   mobile: NetworkImage('https://example.com/small.jpg'),
///   desktop: NetworkImage('https://example.com/large.jpg'),
/// )
/// ```
///
/// Values cascade up: if a breakpoint doesn't have an image,
/// it uses the next smaller breakpoint's image.
class SmartImage extends StatelessWidget {
  /// Creates a [SmartImage] widget.
  ///
  /// At least one of [watch], [mobile], [tablet], [desktop], or [tv]
  /// must be provided.
  const SmartImage({
    super.key,
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
  }) : assert(
          watch != null ||
              mobile != null ||
              tablet != null ||
              desktop != null ||
              tv != null,
          'At least one breakpoint image must be provided',
        );

  /// Creates a [SmartImage] from asset paths.
  ///
  /// Example:
  /// ```dart
  /// SmartImage.asset(
  ///   mobile: 'assets/images/hero_mobile.png',
  ///   desktop: 'assets/images/hero_desktop.png',
  /// )
  /// ```
  SmartImage.asset({
    super.key,
    String? watch,
    String? mobile,
    String? tablet,
    String? desktop,
    String? tv,
    AssetBundle? bundle,
    String? package,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
  })  : watch = watch != null
            ? AssetImage(watch, bundle: bundle, package: package)
            : null,
        mobile = mobile != null
            ? AssetImage(mobile, bundle: bundle, package: package)
            : null,
        tablet = tablet != null
            ? AssetImage(tablet, bundle: bundle, package: package)
            : null,
        desktop = desktop != null
            ? AssetImage(desktop, bundle: bundle, package: package)
            : null,
        tv = tv != null
            ? AssetImage(tv, bundle: bundle, package: package)
            : null,
        assert(
          watch != null ||
              mobile != null ||
              tablet != null ||
              desktop != null ||
              tv != null,
          'At least one breakpoint image path must be provided',
        );

  /// Creates a [SmartImage] from network URLs.
  ///
  /// Example:
  /// ```dart
  /// SmartImage.network(
  ///   mobile: 'https://example.com/small.jpg',
  ///   desktop: 'https://example.com/large.jpg',
  /// )
  /// ```
  SmartImage.network({
    super.key,
    String? watch,
    String? mobile,
    String? tablet,
    String? desktop,
    String? tv,
    double scale = 1.0,
    Map<String, String>? headers,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
  })  : watch = watch != null
            ? NetworkImage(watch, scale: scale, headers: headers)
            : null,
        mobile = mobile != null
            ? NetworkImage(mobile, scale: scale, headers: headers)
            : null,
        tablet = tablet != null
            ? NetworkImage(tablet, scale: scale, headers: headers)
            : null,
        desktop = desktop != null
            ? NetworkImage(desktop, scale: scale, headers: headers)
            : null,
        tv = tv != null
            ? NetworkImage(tv, scale: scale, headers: headers)
            : null,
        assert(
          watch != null ||
              mobile != null ||
              tablet != null ||
              desktop != null ||
              tv != null,
          'At least one breakpoint URL must be provided',
        );

  /// Image to display on watch-sized screens.
  final ImageProvider? watch;

  /// Image to display on mobile-sized screens.
  final ImageProvider? mobile;

  /// Image to display on tablet-sized screens.
  final ImageProvider? tablet;

  /// Image to display on desktop-sized screens.
  final ImageProvider? desktop;

  /// Image to display on TV-sized screens.
  final ImageProvider? tv;

  /// How the image should be inscribed into the space.
  final BoxFit? fit;

  /// How to align the image within its bounds.
  final AlignmentGeometry alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  /// Whether to paint the image in the direction of the [TextDirection].
  final bool matchTextDirection;

  /// The target width.
  final double? width;

  /// The target height.
  final double? height;

  /// Color to blend with the image.
  final Color? color;

  /// The blend mode to use when painting the image.
  final BlendMode? colorBlendMode;

  /// The rendering quality of the image.
  final FilterQuality filterQuality;

  /// A semantic description of the image.
  final String? semanticLabel;

  /// Whether to exclude this image from semantics.
  final bool excludeFromSemantics;

  /// A builder for the frames of the image.
  final ImageFrameBuilder? frameBuilder;

  /// A builder for loading states.
  final ImageLoadingBuilder? loadingBuilder;

  /// A builder for error states.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Whether to continue showing the old image when the image provider changes.
  final bool gaplessPlayback;

  /// Whether to paint the image with anti-aliasing.
  final bool isAntiAlias;

  @override
  Widget build(BuildContext context) {
    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final image = _resolveImage(breakpoint);

    return Image(
      image: image,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      width: this.width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      filterQuality: filterQuality,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
    );
  }

  ImageProvider _resolveImage(SmartBreakpoint breakpoint) {
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch ?? mobile ?? tablet ?? desktop ?? tv,
    };

    return resolved!;
  }
}

/// A widget that displays different decoration images based on breakpoint.
///
/// Use [SmartDecorationImage] when you need responsive background images
/// in a [Container] or [DecoratedBox].
///
/// Example:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     image: SmartDecorationImage.resolve(
///       context,
///       mobile: AssetImage('assets/bg_mobile.png'),
///       desktop: AssetImage('assets/bg_desktop.png'),
///       fit: BoxFit.cover,
///     ),
///   ),
/// )
/// ```
abstract final class SmartDecorationImage {
  /// Resolves a [DecorationImage] based on the current breakpoint.
  ///
  /// Returns a [DecorationImage] using the appropriate [ImageProvider]
  /// for the current breakpoint.
  static DecorationImage resolve(
    BuildContext context, {
    ImageProvider? watch,
    ImageProvider? mobile,
    ImageProvider? tablet,
    ImageProvider? desktop,
    ImageProvider? tv,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    double scale = 1.0,
    double opacity = 1.0,
    FilterQuality filterQuality = FilterQuality.medium,
    bool invertColors = false,
    bool isAntiAlias = false,
  }) {
    assert(
      watch != null ||
          mobile != null ||
          tablet != null ||
          desktop != null ||
          tv != null,
      'At least one breakpoint image must be provided',
    );

    final config = SmartUi.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final breakpoint = config.breakpoints.breakpointForWidth(width);

    final image = switch (breakpoint) {
      SmartBreakpoint.tv => tv ?? desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.desktop => desktop ?? tablet ?? mobile ?? watch,
      SmartBreakpoint.tablet => tablet ?? mobile ?? watch,
      SmartBreakpoint.mobile => mobile ?? watch,
      SmartBreakpoint.watch => watch ?? mobile ?? tablet ?? desktop ?? tv,
    };

    return DecorationImage(
      image: image!,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      scale: scale,
      opacity: opacity,
      filterQuality: filterQuality,
      invertColors: invertColors,
      isAntiAlias: isAntiAlias,
    );
  }

  /// Resolves a [DecorationImage] from asset paths based on breakpoint.
  static DecorationImage resolveAsset(
    BuildContext context, {
    String? watch,
    String? mobile,
    String? tablet,
    String? desktop,
    String? tv,
    AssetBundle? bundle,
    String? package,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    double scale = 1.0,
    double opacity = 1.0,
    FilterQuality filterQuality = FilterQuality.medium,
    bool invertColors = false,
    bool isAntiAlias = false,
  }) {
    return resolve(
      context,
      watch: watch != null
          ? AssetImage(watch, bundle: bundle, package: package)
          : null,
      mobile: mobile != null
          ? AssetImage(mobile, bundle: bundle, package: package)
          : null,
      tablet: tablet != null
          ? AssetImage(tablet, bundle: bundle, package: package)
          : null,
      desktop: desktop != null
          ? AssetImage(desktop, bundle: bundle, package: package)
          : null,
      tv: tv != null ? AssetImage(tv, bundle: bundle, package: package) : null,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      scale: scale,
      opacity: opacity,
      filterQuality: filterQuality,
      invertColors: invertColors,
      isAntiAlias: isAntiAlias,
    );
  }
}
