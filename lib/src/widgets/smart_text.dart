/// Responsive text widget.
///
/// This module provides a text widget with typography tokens
/// and responsive sizing support.
library;

import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import '../core/smart_ui_config.dart';
import '../tokens/typography.dart';

/// A text widget that uses typography tokens.
///
/// Use [SmartText] for consistent typography based on your
/// design system tokens.
///
/// Example:
/// ```dart
/// SmartText(
///   'Hello World',
///   style: TypographyStyle.headlineLarge,
/// )
///
/// // Responsive text
/// SmartText.responsive(
///   'Hello World',
///   mobile: TypographyStyle.bodyMedium,
///   tablet: TypographyStyle.bodyLarge,
///   desktop: TypographyStyle.headlineSmall,
/// )
/// ```
class SmartText extends StatelessWidget {
  /// Creates a [SmartText] widget with a typography style.
  const SmartText(
    this.text, {
    super.key,
    this.style = TypographyStyle.bodyMedium,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textColor,
    this.customStyle,
  }) : _responsiveStyle = null;

  /// Creates a [SmartText] widget with responsive typography styles.
  const SmartText.responsive(
    this.text, {
    super.key,
    TypographyStyle? watch,
    TypographyStyle? mobile,
    TypographyStyle? tablet,
    TypographyStyle? desktop,
    TypographyStyle? tv,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textColor,
    this.customStyle,
  })  : style = TypographyStyle.bodyMedium,
        _responsiveStyle = (
          watch: watch,
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
          tv: tv,
        );

  /// The text to display.
  final String text;

  /// The typography style to use.
  final TypographyStyle style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The direction of the text.
  final TextDirection? textDirection;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Maximum number of lines.
  final int? maxLines;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// The color of the text.
  final Color? textColor;

  /// A custom [TextStyle] to merge with the typography style.
  final TextStyle? customStyle;

  final ({
    TypographyStyle? watch,
    TypographyStyle? mobile,
    TypographyStyle? tablet,
    TypographyStyle? desktop,
    TypographyStyle? tv,
  })? _responsiveStyle;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = _resolveStyle(context);
    final mergedStyle = resolvedStyle.merge(customStyle);
    final finalStyle = textColor != null
        ? mergedStyle.copyWith(color: textColor)
        : mergedStyle;

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  TextStyle _resolveStyle(BuildContext context) {
    if (_responsiveStyle != null) {
      final config = SmartUi.of(context);
      final width = MediaQuery.sizeOf(context).width;
      final breakpoint = config.breakpoints.breakpointForWidth(width);
      final responsiveTypographyStyle = _resolveResponsiveStyle(breakpoint);
      return SmartTypography.fromStyle(responsiveTypographyStyle);
    }
    return SmartTypography.fromStyle(style);
  }

  TypographyStyle _resolveResponsiveStyle(SmartBreakpoint breakpoint) {
    final r = _responsiveStyle!;
    final resolved = switch (breakpoint) {
      SmartBreakpoint.tv =>
        r.tv ?? r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.desktop => r.desktop ?? r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.tablet => r.tablet ?? r.mobile ?? r.watch,
      SmartBreakpoint.mobile => r.mobile ?? r.watch,
      SmartBreakpoint.watch =>
        r.watch ?? r.mobile ?? r.tablet ?? r.desktop ?? r.tv,
    };
    return resolved ?? style;
  }
}

/// A display text widget.
class DisplayText extends StatelessWidget {
  /// Creates a display text widget.
  const DisplayText(
    this.text, {
    super.key,
    this.size = DisplaySize.large,
    this.textAlign,
    this.textColor,
    this.maxLines,
    this.overflow,
  });

  /// The text to display.
  final String text;

  /// The display size.
  final DisplaySize size;

  /// How the text should be aligned.
  final TextAlign? textAlign;

  /// The color of the text.
  final Color? textColor;

  /// Maximum number of lines.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final style = switch (size) {
      DisplaySize.large => TypographyStyle.displayLarge,
      DisplaySize.medium => TypographyStyle.displayMedium,
      DisplaySize.small => TypographyStyle.displaySmall,
    };

    return SmartText(
      text,
      style: style,
      textAlign: textAlign,
      textColor: textColor,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Display text sizes.
enum DisplaySize {
  /// Large display text.
  large,

  /// Medium display text.
  medium,

  /// Small display text.
  small,
}

/// A headline text widget.
class HeadlineText extends StatelessWidget {
  /// Creates a headline text widget.
  const HeadlineText(
    this.text, {
    super.key,
    this.size = HeadlineSize.large,
    this.textAlign,
    this.textColor,
    this.maxLines,
    this.overflow,
  });

  /// The text to display.
  final String text;

  /// The headline size.
  final HeadlineSize size;

  /// How the text should be aligned.
  final TextAlign? textAlign;

  /// The color of the text.
  final Color? textColor;

  /// Maximum number of lines.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final style = switch (size) {
      HeadlineSize.large => TypographyStyle.headlineLarge,
      HeadlineSize.medium => TypographyStyle.headlineMedium,
      HeadlineSize.small => TypographyStyle.headlineSmall,
    };

    return SmartText(
      text,
      style: style,
      textAlign: textAlign,
      textColor: textColor,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Headline text sizes.
enum HeadlineSize {
  /// Large headline.
  large,

  /// Medium headline.
  medium,

  /// Small headline.
  small,
}

/// A body text widget.
class BodyText extends StatelessWidget {
  /// Creates a body text widget.
  const BodyText(
    this.text, {
    super.key,
    this.size = BodySize.medium,
    this.textAlign,
    this.textColor,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  /// The text to display.
  final String text;

  /// The body size.
  final BodySize size;

  /// How the text should be aligned.
  final TextAlign? textAlign;

  /// The color of the text.
  final Color? textColor;

  /// Maximum number of lines.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final style = switch (size) {
      BodySize.large => TypographyStyle.bodyLarge,
      BodySize.medium => TypographyStyle.bodyMedium,
      BodySize.small => TypographyStyle.bodySmall,
    };

    return SmartText(
      text,
      style: style,
      textAlign: textAlign,
      textColor: textColor,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

/// Body text sizes.
enum BodySize {
  /// Large body.
  large,

  /// Medium body.
  medium,

  /// Small body.
  small,
}

/// A label text widget.
class LabelText extends StatelessWidget {
  /// Creates a label text widget.
  const LabelText(
    this.text, {
    super.key,
    this.size = LabelSize.medium,
    this.textAlign,
    this.textColor,
    this.maxLines,
    this.overflow,
  });

  /// The text to display.
  final String text;

  /// The label size.
  final LabelSize size;

  /// How the text should be aligned.
  final TextAlign? textAlign;

  /// The color of the text.
  final Color? textColor;

  /// Maximum number of lines.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final style = switch (size) {
      LabelSize.large => TypographyStyle.labelLarge,
      LabelSize.medium => TypographyStyle.labelMedium,
      LabelSize.small => TypographyStyle.labelSmall,
    };

    return SmartText(
      text,
      style: style,
      textAlign: textAlign,
      textColor: textColor,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Label text sizes.
enum LabelSize {
  /// Large label.
  large,

  /// Medium label.
  medium,

  /// Small label.
  small,
}
