import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_kit/adaptive_kit.dart';
import '../theme/playground_theme.dart';

/// A code preview component with syntax highlighting and copy functionality
class CodePreview extends StatefulWidget {
  const CodePreview({
    super.key,
    required this.code,
    this.language = 'dart',
    this.showLineNumbers = true,
    this.maxHeight,
    this.title,
  });

  final String code;
  final String language;
  final bool showLineNumbers;
  final double? maxHeight;
  final String? title;

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  bool _copied = false;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: PlaygroundTheme.success,
              size: 18,
            ),
            const SizedBox(width: 8),
            const Text('Copied to clipboard'),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _copied = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.code.trim().split('\n');

    return Container(
      decoration: BoxDecoration(
        color: context.codeBgColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PlaygroundTheme.spaceMd,
              vertical: PlaygroundTheme.spaceSm,
            ),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(PlaygroundTheme.radiusLg),
                topRight: Radius.circular(PlaygroundTheme.radiusLg),
              ),
              border: Border(
                bottom: BorderSide(
                  color: context.borderColor.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                // Window dots
                Row(
                  children: [
                    _WindowDot(color: const Color(0xFFFF5F56)),
                    const SizedBox(width: 6),
                    _WindowDot(color: const Color(0xFFFFBD2E)),
                    const SizedBox(width: 6),
                    _WindowDot(color: const Color(0xFF27C93F)),
                  ],
                ),
                const SizedBox(width: 16),
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: TextStyle(
                      color: context.textMutedColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                const Spacer(),
                // Copy button
                _CopyButton(
                  onPressed: _copyToClipboard,
                  copied: _copied,
                ),
              ],
            ),
          ),
          // Code content
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: widget.maxHeight ?? double.infinity,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.showLineNumbers) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          lines.length,
                          (index) => SizedBox(
                            height: 20,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                                color: context.textMutedColor.withValues(alpha: 0.5),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 1,
                        height: lines.length * 20.0,
                        color: context.borderColor.withValues(alpha: 0.3),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: lines.map((line) {
                        return SizedBox(
                          height: 20,
                          child: _SyntaxHighlightedText(
                            text: line,
                            isDark: context.isDarkMode,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
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

class _CopyButton extends StatefulWidget {
  const _CopyButton({
    required this.onPressed,
    required this.copied,
  });

  final VoidCallback onPressed;
  final bool copied;

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: PlaygroundTheme.durationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: _hovered
                ? context.surfaceElevatedColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.copied ? Icons.check : Icons.copy_outlined,
                size: 14,
                color: widget.copied
                    ? PlaygroundTheme.success
                    : context.textMutedColor,
              ),
              const SizedBox(width: 4),
              Text(
                widget.copied ? 'Copied!' : 'Copy',
                style: TextStyle(
                  fontSize: 12,
                  color: widget.copied
                      ? PlaygroundTheme.success
                      : context.textMutedColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple syntax highlighting for Dart code
class _SyntaxHighlightedText extends StatelessWidget {
  const _SyntaxHighlightedText({
    required this.text,
    required this.isDark,
  });

  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final spans = _parseCode(text);
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          height: 1.5,
          color: isDark
              ? PlaygroundTheme.codePunctuation
              : const Color(0xFF383A42),
        ),
        children: spans,
      ),
    );
  }

  List<TextSpan> _parseCode(String code) {
    final List<TextSpan> spans = [];
    final RegExp tokenPattern = RegExp(
      r'(//.*$)|'                                    // Comments
      r'("(?:[^"\\]|\\.)*"|' "'(?:[^'\\\\]|\\\\.)*'" r')|'   // Strings
      r'(\b(?:class|extends|implements|with|abstract|final|const|var|void|dynamic|static|import|export|library|part|show|hide|as|if|else|for|while|do|switch|case|default|break|continue|return|try|catch|finally|throw|rethrow|assert|new|is|this|super|enum|mixin|extension|typedef|required|late|get|set|async|await|yield|sync|factory|operator|covariant|true|false|null)\b)|'  // Keywords
      r'(\b[A-Z][a-zA-Z0-9_]*\b)|'                   // Classes/Types
      r'(\b\d+\.?\d*\b)|'                            // Numbers
      r'(@\w+)|'                                      // Annotations
      r'(\w+(?=\s*\())|'                              // Function calls
      r'(\.\w+)|'                                     // Properties
      r'([^\w\s]+)|'                                  // Punctuation
      r'(\s+)|'                                       // Whitespace
      r'(\w+)',                                       // Other identifiers
      multiLine: true,
    );

    for (final match in tokenPattern.allMatches(code)) {
      final matchedText = match.group(0)!;
      Color color;

      if (match.group(1) != null) {
        // Comment
        color = PlaygroundTheme.codeComment;
      } else if (match.group(2) != null) {
        // String
        color = PlaygroundTheme.codeString;
      } else if (match.group(3) != null) {
        // Keyword
        color = PlaygroundTheme.codeKeyword;
      } else if (match.group(4) != null) {
        // Class/Type
        color = PlaygroundTheme.codeClass;
      } else if (match.group(5) != null) {
        // Number
        color = PlaygroundTheme.codeNumber;
      } else if (match.group(6) != null) {
        // Annotation
        color = PlaygroundTheme.codeKeyword;
      } else if (match.group(7) != null) {
        // Function call
        color = PlaygroundTheme.codeFunction;
      } else if (match.group(8) != null) {
        // Property
        color = PlaygroundTheme.codeProperty;
      } else {
        // Punctuation, whitespace, or other
        color = isDark
            ? PlaygroundTheme.codePunctuation
            : const Color(0xFF383A42);
      }

      spans.add(TextSpan(text: matchedText, style: TextStyle(color: color)));
    }

    return spans;
  }
}

/// A split view showing both code and preview
class CodePreviewSplit extends StatefulWidget {
  const CodePreviewSplit({
    super.key,
    required this.code,
    required this.preview,
    this.codeTitle,
    this.previewTitle = 'Preview',
    this.initialTab = 0,
  });

  final String code;
  final Widget preview;
  final String? codeTitle;
  final String previewTitle;
  final int initialTab;

  @override
  State<CodePreviewSplit> createState() => _CodePreviewSplitState();
}

class _CodePreviewSplitState extends State<CodePreviewSplit>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartLayout(
      mobile: _buildMobileView(),
      tablet: _buildTabletView(),
      desktop: _buildDesktopView(),
    );
  }

  Widget _buildMobileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tab bar
        Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            border: Border.all(
              color: context.borderColor.withValues(alpha: 0.5),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: PlaygroundTheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
            ),
            dividerColor: Colors.transparent,
            labelColor: PlaygroundTheme.primary,
            unselectedLabelColor: context.textMutedColor,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.visibility_outlined, size: 16),
                    const SizedBox(width: 6),
                    Text(widget.previewTitle),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.code, size: 16),
                    const SizedBox(width: 6),
                    const Text('Code'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _PreviewContainer(child: widget.preview),
              CodePreview(
                code: widget.code,
                title: widget.codeTitle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabletView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _PreviewContainer(child: widget.preview),
        ),
        const SizedBox(height: PlaygroundTheme.spaceMd),
        CodePreview(
          code: widget.code,
          title: widget.codeTitle,
          maxHeight: 300,
        ),
      ],
    );
  }

  Widget _buildDesktopView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _PreviewContainer(child: widget.preview),
        ),
        const SizedBox(width: PlaygroundTheme.spaceMd),
        Expanded(
          child: CodePreview(
            code: widget.code,
            title: widget.codeTitle,
          ),
        ),
      ],
    );
  }
}

class _PreviewContainer extends StatelessWidget {
  const _PreviewContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        border: Border.all(
          color: context.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
        child: child,
      ),
    );
  }
}
