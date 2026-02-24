import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/premium_theme.dart';

/// Animated counter that counts up from 0 to the target value
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    required this.suffix,
    this.duration = const Duration(milliseconds: 1500),
    this.style,
    this.curve = Curves.easeOutCubic,
  });

  final int value;
  final String suffix;
  final Duration duration;
  final TextStyle? style;
  final Curve curve;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final current = (_animation.value * widget.value).round();
        return Text(
          '$current${widget.suffix}',
          style: widget.style ?? PremiumTypography.headlineLarge,
        );
      },
    );
  }
}

/// Staggered fade in animation wrapper
class StaggeredFadeIn extends StatefulWidget {
  const StaggeredFadeIn({
    super.key,
    required this.child,
    required this.index,
    this.baseDelay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 400),
    this.offset = const Offset(0, 20),
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;
  final int index;
  final Duration baseDelay;
  final Duration duration;
  final Offset offset;
  final Curve curve;

  @override
  State<StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<StaggeredFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    Future.delayed(
      Duration(milliseconds: widget.baseDelay.inMilliseconds * widget.index),
      () {
        if (mounted) {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// Glass morphism card with blur effect
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.blur = 10,
    this.opacity = 0.1,
    this.borderColor,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double blur;
  final double opacity;
  final Color? borderColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(16);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient ??
                LinearGradient(
                  colors: [
                    Colors.white.withOpacity(opacity),
                    Colors.white.withOpacity(opacity * 0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
            borderRadius: radius,
            border: Border.all(
              color: borderColor ?? Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          padding: padding ?? const EdgeInsets.all(SmartSpacing.md),
          child: child,
        ),
      ),
    );
  }
}

/// Premium card with gradient border option
class PremiumCard extends StatefulWidget {
  const PremiumCard({
    super.key,
    required this.child,
    this.padding,
    this.gradientBorder = false,
    this.onTap,
    this.showHoverEffect = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool gradientBorder;
  final VoidCallback? onTap;
  final bool showHoverEffect;

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      transform: Matrix4.identity()
        ..scale(_isHovered && widget.showHoverEffect ? 1.02 : 1.0),
      decoration: BoxDecoration(
        color: PremiumColors.cardBackground,
        borderRadius: borderRadius,
        border: widget.gradientBorder
            ? null
            : Border.all(
                color: _isHovered
                    ? PremiumColors.primary.withOpacity(0.5)
                    : PremiumColors.cardBorder,
                width: 1,
              ),
        boxShadow: _isHovered && widget.showHoverEffect
            ? [
                BoxShadow(
                  color: PremiumColors.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      padding: widget.padding ?? const EdgeInsets.all(SmartSpacing.md),
      child: widget.child,
    );

    if (widget.gradientBorder) {
      card = Container(
        decoration: BoxDecoration(
          gradient: PremiumGradients.primary,
          borderRadius: borderRadius,
        ),
        padding: const EdgeInsets.all(1),
        child: Container(
          decoration: BoxDecoration(
            color: PremiumColors.cardBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: widget.padding ?? const EdgeInsets.all(SmartSpacing.md),
          child: widget.child,
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor:
          widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: card,
      ),
    );
  }
}

/// Gradient text widget
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.gradient = PremiumGradients.primary,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style ?? PremiumTypography.headlineLarge,
      ),
    );
  }
}

/// Gradient icon widget
class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icon, {
    super.key,
    this.size = 24,
    this.gradient = PremiumGradients.primary,
  });

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}

/// Premium stat card with animated counter
class PremiumStatCard extends StatelessWidget {
  const PremiumStatCard({
    super.key,
    required this.value,
    required this.suffix,
    required this.label,
    required this.icon,
    this.color,
    this.useGradient = false,
  });

  final int value;
  final String suffix;
  final String label;
  final IconData icon;
  final Color? color;
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? PremiumColors.primary;

    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: effectiveColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: useGradient
                    ? GradientIcon(icon, size: 22)
                    : Icon(icon, color: effectiveColor, size: 22),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SmartSpacing.sm,
                  vertical: SmartSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: effectiveColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 12,
                      color: effectiveColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${(value * 0.12).round()}%',
                      style: PremiumTypography.labelSmall.copyWith(
                        color: effectiveColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VGap.lg(),
          AnimatedCounter(
            value: value,
            suffix: suffix,
            style: useGradient
                ? null
                : PremiumTypography.headlineLarge.copyWith(
                    color: effectiveColor,
                  ),
          ),
          const VGap.xs(),
          Text(
            label,
            style: PremiumTypography.labelMedium,
          ),
        ],
      ),
    );
  }
}

/// Premium section header with gradient accent
class PremiumSectionHeader extends StatelessWidget {
  const PremiumSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.showGradientLine = true,
  });

  final String title;
  final String? subtitle;
  final Widget? action;
  final bool showGradientLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (showGradientLine) ...[
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  gradient: PremiumGradients.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const HGap.md(),
            ],
            Expanded(
              child: Text(
                title,
                style: PremiumTypography.titleLarge,
              ),
            ),
            if (action != null) action!,
          ],
        ),
        if (subtitle != null) ...[
          const VGap.sm(),
          Padding(
            padding: EdgeInsets.only(left: showGradientLine ? 20 : 0),
            child: Text(
              subtitle!,
              style: PremiumTypography.bodyMedium.copyWith(
                color: PremiumColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Premium page header with gradient background
class PremiumPageHeader extends StatelessWidget {
  const PremiumPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsive(
        mobile: SmartSpacing.md,
        tablet: SmartSpacing.lg,
        desktop: SmartSpacing.xl,
      )),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            PremiumColors.primary.withOpacity(0.15),
            PremiumColors.gradientEnd.withOpacity(0.05),
            Colors.transparent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: PremiumColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: PremiumGradients.primary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: PremiumColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const HGap.lg(),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PremiumTypography.headlineMedium,
                ),
                const VGap.xs(),
                Text(
                  subtitle,
                  style: PremiumTypography.bodyMedium.copyWith(
                    color: PremiumColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Code block with syntax highlighting feel
class PremiumCodeBlock extends StatelessWidget {
  const PremiumCodeBlock({
    super.key,
    required this.code,
    this.language = 'dart',
  });

  final String code;
  final String language;

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: PremiumColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SmartSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PremiumColors.cardBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: PremiumColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  language,
                  style: PremiumTypography.labelSmall.copyWith(
                    color: PremiumColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _copyToClipboard(context),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.copy,
                    size: 16,
                    color: PremiumColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const VGap.md(),
          Text(
            code,
            style: PremiumTypography.code,
          ),
        ],
      ),
    );
  }
}

/// Premium chip/badge
class PremiumChip extends StatelessWidget {
  const PremiumChip({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.gradient,
    this.outlined = false,
  });

  final String label;
  final IconData? icon;
  final Color? color;
  final Gradient? gradient;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? PremiumColors.primary;

    if (gradient != null) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SmartSpacing.md,
          vertical: SmartSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: PremiumTypography.labelMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SmartSpacing.md,
        vertical: SmartSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : effectiveColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: effectiveColor.withOpacity(outlined ? 0.5 : 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: effectiveColor),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: PremiumTypography.labelMedium.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer effect widget for loading states
class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  final Widget child;
  final Duration duration;

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Colors.transparent,
                Colors.white24,
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(
                slidePercent: _controller.value,
              ),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
        bounds.width * (slidePercent * 2 - 1), 0, 0);
  }
}

/// Animated gradient border
class AnimatedGradientBorder extends StatefulWidget {
  const AnimatedGradientBorder({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.strokeWidth = 2,
    this.duration = const Duration(seconds: 3),
  });

  final Widget child;
  final double borderRadius;
  final double strokeWidth;
  final Duration duration;

  @override
  State<AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _GradientBorderPainter(
            progress: _controller.value,
            borderRadius: widget.borderRadius,
            strokeWidth: widget.strokeWidth,
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.strokeWidth),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  _GradientBorderPainter({
    required this.progress,
    required this.borderRadius,
    required this.strokeWidth,
  });

  final double progress;
  final double borderRadius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    final paint = Paint()
      ..shader = SweepGradient(
        colors: const [
          PremiumColors.gradientStart,
          PremiumColors.gradientMiddle,
          PremiumColors.gradientEnd,
          PremiumColors.gradientStart,
        ],
        stops: const [0.0, 0.33, 0.66, 1.0],
        transform: GradientRotation(progress * 2 * math.pi),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_GradientBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Breakpoint indicator chip
class BreakpointIndicator extends StatelessWidget {
  const BreakpointIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        final color = _getBreakpointColor(info.breakpoint);
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SmartSpacing.md,
            vertical: SmartSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                info.breakpoint.name.toUpperCase(),
                style: PremiumTypography.labelSmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${info.screenWidth.toInt()}px',
                style: PremiumTypography.labelSmall.copyWith(
                  color: color.withOpacity(0.7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getBreakpointColor(SmartBreakpoint breakpoint) {
    return switch (breakpoint) {
      SmartBreakpoint.watch => PremiumColors.watchColor,
      SmartBreakpoint.mobile => PremiumColors.mobileColor,
      SmartBreakpoint.tablet => PremiumColors.tabletColor,
      SmartBreakpoint.desktop => PremiumColors.desktopColor,
      SmartBreakpoint.tv => PremiumColors.tvColor,
    };
  }
}

/// Platform badge
class PlatformBadge extends StatelessWidget {
  const PlatformBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = context.platform;
    final icon = context.usesMaterial ? Icons.android : Icons.apple;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SmartSpacing.sm,
        vertical: SmartSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: PremiumColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: PremiumColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            platform.name,
            style: PremiumTypography.labelSmall,
          ),
        ],
      ),
    );
  }
}
