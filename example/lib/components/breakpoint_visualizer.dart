import 'package:flutter/material.dart';
import '../theme/playground_theme.dart';

/// The interactive breakpoint visualizer hero component
class BreakpointVisualizer extends StatefulWidget {
  const BreakpointVisualizer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<BreakpointVisualizer> createState() => _BreakpointVisualizerState();
}

class _BreakpointVisualizerState extends State<BreakpointVisualizer>
    with SingleTickerProviderStateMixin {
  double _width = 800.0;
  bool _isDragging = false;
  late AnimationController _glowController;

  static const double minWidth = 280.0;
  static const double maxWidth = 1400.0;

  String get _currentBreakpoint {
    if (_width < 300) return 'watch';
    if (_width < 600) return 'mobile';
    if (_width < 900) return 'tablet';
    if (_width < 1200) return 'desktop';
    return 'tv';
  }

  Color get _breakpointColor => PlaygroundTheme.colorForBreakpoint(_currentBreakpoint);
  IconData get _breakpointIcon => PlaygroundTheme.iconForBreakpoint(_currentBreakpoint);

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Width slider with labels
        _buildSliderSection(),
        const SizedBox(height: PlaygroundTheme.spaceLg),
        // Preview area with device frame
        Expanded(
          child: Center(
            child: _buildPreviewArea(),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderSection() {
    return Container(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          // Breakpoint labels
          Row(
            children: [
              _BreakpointLabel(
                label: 'Watch',
                minWidth: 0,
                icon: Icons.watch_outlined,
                color: PlaygroundTheme.watchColor,
                isActive: _currentBreakpoint == 'watch',
              ),
              _BreakpointLabel(
                label: 'Mobile',
                minWidth: 300,
                icon: Icons.phone_android_outlined,
                color: PlaygroundTheme.mobileColor,
                isActive: _currentBreakpoint == 'mobile',
              ),
              _BreakpointLabel(
                label: 'Tablet',
                minWidth: 600,
                icon: Icons.tablet_android_outlined,
                color: PlaygroundTheme.tabletColor,
                isActive: _currentBreakpoint == 'tablet',
              ),
              _BreakpointLabel(
                label: 'Desktop',
                minWidth: 900,
                icon: Icons.desktop_windows_outlined,
                color: PlaygroundTheme.desktopColor,
                isActive: _currentBreakpoint == 'desktop',
              ),
              _BreakpointLabel(
                label: 'TV',
                minWidth: 1200,
                icon: Icons.tv_outlined,
                color: PlaygroundTheme.tvColor,
                isActive: _currentBreakpoint == 'tv',
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceMd),
          // Slider
          Row(
            children: [
              Text(
                '${minWidth.toInt()}px',
                style: TextStyle(
                  fontSize: 12,
                  color: context.textMutedColor,
                  fontFamily: 'monospace',
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: _breakpointColor,
                    inactiveTrackColor: context.borderColor.withValues(alpha: 0.3),
                    thumbColor: _breakpointColor,
                    overlayColor: _breakpointColor.withValues(alpha: 0.1),
                    trackHeight: 6,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                  ),
                  child: Slider(
                    value: _width,
                    min: minWidth,
                    max: maxWidth,
                    onChanged: (value) {
                      setState(() => _width = value);
                    },
                    onChangeStart: (_) {
                      setState(() => _isDragging = true);
                    },
                    onChangeEnd: (_) {
                      setState(() => _isDragging = false);
                    },
                  ),
                ),
              ),
              Text(
                '${maxWidth.toInt()}px',
                style: TextStyle(
                  fontSize: 12,
                  color: context.textMutedColor,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: PlaygroundTheme.spaceSm),
          // Current width badge
          AnimatedContainer(
            duration: PlaygroundTheme.durationFast,
            padding: const EdgeInsets.symmetric(
              horizontal: PlaygroundTheme.spaceMd,
              vertical: PlaygroundTheme.spaceSm,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _breakpointColor.withValues(alpha: 0.2),
                  _breakpointColor.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusFull),
              border: Border.all(
                color: _breakpointColor.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _breakpointIcon,
                  size: 18,
                  color: _breakpointColor,
                ),
                const SizedBox(width: 8),
                Text(
                  _currentBreakpoint.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _breakpointColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 16,
                  color: _breakpointColor.withValues(alpha: 0.3),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_width.toInt()}px',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewArea() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final glowOpacity = 0.3 + (_glowController.value * 0.3);
        return Container(
          constraints: BoxConstraints(
            maxWidth: _width,
            maxHeight: 600,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusXl),
            boxShadow: _isDragging
                ? [
                    BoxShadow(
                      color: _breakpointColor.withValues(alpha: glowOpacity),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
          ),
          child: _DeviceFrame(
            breakpoint: _currentBreakpoint,
            color: _breakpointColor,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _BreakpointLabel extends StatelessWidget {
  const _BreakpointLabel({
    required this.label,
    required this.minWidth,
    required this.icon,
    required this.color,
    required this.isActive,
  });

  final String label;
  final double minWidth;
  final IconData icon;
  final Color color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: PlaygroundTheme.durationFast,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? color.withValues(alpha: 0.1) : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isActive ? color : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? color : context.textMutedColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? color : context.textMutedColor,
              ),
            ),
            Text(
              '${minWidth.toInt()}px',
              style: TextStyle(
                fontSize: 10,
                color: isActive
                    ? color.withValues(alpha: 0.7)
                    : context.textMutedColor.withValues(alpha: 0.5),
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceFrame extends StatelessWidget {
  const _DeviceFrame({
    required this.breakpoint,
    required this.color,
    required this.child,
  });

  final String breakpoint;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        border: Border.all(
          color: context.borderColor,
          width: _getBorderWidth(),
        ),
      ),
      child: Column(
        children: [
          // Device frame header (notch/status bar)
          _buildDeviceHeader(),
          // Content
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(_getBorderRadius() - 2),
                bottomRight: Radius.circular(_getBorderRadius() - 2),
              ),
              child: Container(
                color: context.backgroundColor,
                child: child,
              ),
            ),
          ),
          // Device frame footer (home bar)
          if (_showHomeBar()) _buildHomeBar(),
        ],
      ),
    );
  }

  double _getBorderRadius() {
    switch (breakpoint) {
      case 'watch':
        return 24;
      case 'mobile':
        return 32;
      case 'tablet':
        return 20;
      default:
        return 12;
    }
  }

  double _getBorderWidth() {
    switch (breakpoint) {
      case 'watch':
        return 8;
      case 'mobile':
        return 10;
      case 'tablet':
        return 8;
      default:
        return 2;
    }
  }

  bool _showHomeBar() {
    return breakpoint == 'mobile' || breakpoint == 'tablet';
  }

  Widget _buildDeviceHeader() {
    switch (breakpoint) {
      case 'watch':
        return const SizedBox(height: 8);
      case 'mobile':
        return _MobileNotch(color: color);
      case 'tablet':
        return _TabletCamera(color: color);
      default:
        return _DesktopTitleBar(color: color);
    }
  }

  Widget _buildHomeBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 120,
        height: 5,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

class _MobileNotch extends StatelessWidget {
  const _MobileNotch({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          width: 120,
          height: 28,
          decoration: BoxDecoration(
            color: context.borderColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  color: context.surfaceElevatedColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabletCamera extends StatelessWidget {
  const _TabletCamera({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _DesktopTitleBar extends StatelessWidget {
  const _DesktopTitleBar({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor.withValues(alpha: 0.5),
        border: Border(
          bottom: BorderSide(
            color: context.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          _WindowDot(color: const Color(0xFFFF5F56)),
          const SizedBox(width: 6),
          _WindowDot(color: const Color(0xFFFFBD2E)),
          const SizedBox(width: 6),
          _WindowDot(color: const Color(0xFF27C93F)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 12,
                  color: PlaygroundTheme.success,
                ),
                const SizedBox(width: 6),
                Text(
                  'adaptive_kit.dev',
                  style: TextStyle(
                    fontSize: 11,
                    color: context.textMutedColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(width: 60),
        ],
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
