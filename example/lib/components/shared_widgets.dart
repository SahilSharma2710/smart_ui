import 'package:flutter/material.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/playground_theme.dart';

/// Animated counter for stats display
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 1500),
    this.style,
    this.prefix = '',
    this.suffix = '',
  });

  final int value;
  final Duration duration;
  final TextStyle? style;
  final String prefix;
  final String suffix;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = IntTween(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
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
        return Text(
          '${widget.prefix}${_animation.value}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}

/// Staggered fade-in animation wrapper
class StaggeredFadeIn extends StatefulWidget {
  const StaggeredFadeIn({
    super.key,
    required this.child,
    required this.index,
    this.duration = const Duration(milliseconds: 500),
    this.delayPerItem = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.slideOffset = 20.0,
  });

  final Widget child;
  final int index;
  final Duration duration;
  final Duration delayPerItem;
  final Curve curve;
  final double slideOffset;

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
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    Future.delayed(widget.delayPerItem * widget.index, () {
      if (mounted) {
        _controller.forward();
      }
    });
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
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// A page wrapper with consistent styling
class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SmartLayout(
      mobile: _buildMobile(context),
      desktop: _buildDesktop(context),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: PlaygroundTheme.spaceLg),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceLg),
      child: SmartContainer.lg(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: PlaygroundTheme.spaceXl),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            if (actions != null) ...actions!,
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: PlaygroundTheme.spaceSm),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.textSecondaryColor,
                ),
          ),
        ],
      ],
    );
  }
}

/// Section header with optional action
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PlaygroundTheme.spaceMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: context.textSecondaryColor,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// A card with hover effect
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.borderRadius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PlaygroundTheme.durationFast,
          curve: PlaygroundTheme.curveSnappy,
          padding: widget.padding ?? const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: _isHovered
                ? context.surfaceElevatedColor
                : context.surfaceColor,
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(
              color: _isHovered
                  ? PlaygroundTheme.primary.withValues(alpha: 0.3)
                  : context.borderColor.withValues(alpha: 0.5),
            ),
            boxShadow: _isHovered ? context.cardShadow : null,
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -2.0))
              : Matrix4.identity(),
          child: widget.child,
        ),
      ),
    );
  }
}

/// A stat card for displaying metrics
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.color,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final accentColor = color ?? PlaygroundTheme.primary;
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: accentColor,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A feature card for showcasing features
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final accentColor = color ?? PlaygroundTheme.primary;
    return HoverCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha: 0.2),
                  accentColor.withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            child: Icon(
              icon,
              size: 22,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
              height: 1.5,
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Learn more',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: accentColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: accentColor,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// A gradient text widget
class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.gradient,
    this.style,
  });

  final String text;
  final Gradient gradient;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}

/// A badge component for tags and labels
class PlaygroundBadge extends StatelessWidget {
  const PlaygroundBadge({
    super.key,
    required this.label,
    this.color,
    this.icon,
  });

  final String label;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? PlaygroundTheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 12,
              color: badgeColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// A comparison component showing before/after code
class CodeComparison extends StatefulWidget {
  const CodeComparison({
    super.key,
    required this.beforeCode,
    required this.afterCode,
    this.beforeLabel = 'Without adaptive_kit',
    this.afterLabel = 'With adaptive_kit',
  });

  final String beforeCode;
  final String afterCode;
  final String beforeLabel;
  final String afterLabel;

  @override
  State<CodeComparison> createState() => _CodeComparisonState();
}

class _CodeComparisonState extends State<CodeComparison> {
  bool _showAfter = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Toggle
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.surfaceElevatedColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
          ),
          child: Row(
            children: [
              Expanded(
                child: _ToggleButton(
                  label: widget.beforeLabel,
                  icon: Icons.code_off,
                  isSelected: !_showAfter,
                  color: PlaygroundTheme.error,
                  onTap: () => setState(() => _showAfter = false),
                ),
              ),
              Expanded(
                child: _ToggleButton(
                  label: widget.afterLabel,
                  icon: Icons.code,
                  isSelected: _showAfter,
                  color: PlaygroundTheme.success,
                  onTap: () => setState(() => _showAfter = true),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        // Code
        AnimatedSwitcher(
          duration: PlaygroundTheme.durationNormal,
          child: Container(
            key: ValueKey(_showAfter),
            padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
            decoration: BoxDecoration(
              color: context.codeBgColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
              border: Border.all(
                color: (_showAfter ? PlaygroundTheme.success : PlaygroundTheme.error)
                    .withValues(alpha: 0.3),
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
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (_showAfter
                                ? PlaygroundTheme.success
                                : PlaygroundTheme.error)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          PlaygroundTheme.radiusSm,
                        ),
                      ),
                      child: Text(
                        '${_countLines(_showAfter ? widget.afterCode : widget.beforeCode)} lines',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _showAfter
                              ? PlaygroundTheme.success
                              : PlaygroundTheme.error,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _showAfter ? 'Clean & Simple' : 'Verbose & Complex',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PlaygroundTheme.spaceMd),
                Text(
                  _showAfter ? widget.afterCode : widget.beforeCode,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    height: 1.5,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int _countLines(String code) {
    return code.trim().split('\n').length;
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: PlaygroundTheme.durationFast,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? color : context.textMutedColor,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? color : context.textMutedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// An example preview container
class ExamplePreview extends StatelessWidget {
  const ExamplePreview({
    super.key,
    required this.child,
    this.height,
    this.backgroundColor,
  });

  final Widget child;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: child,
    );
  }
}
