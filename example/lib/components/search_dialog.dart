import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/playground_theme.dart';

/// Search item model
class SearchItem {
  const SearchItem({
    required this.title,
    required this.route,
    this.category,
    this.description,
    this.icon,
    this.keywords = const [],
  });

  final String title;
  final String route;
  final String? category;
  final String? description;
  final IconData? icon;
  final List<String> keywords;

  bool matches(String query) {
    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
        (description?.toLowerCase().contains(lowerQuery) ?? false) ||
        (category?.toLowerCase().contains(lowerQuery) ?? false) ||
        keywords.any((k) => k.toLowerCase().contains(lowerQuery));
  }
}

/// Global search dialog
class SearchDialog extends StatefulWidget {
  const SearchDialog({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  final List<SearchItem> items;
  final void Function(SearchItem item) onItemSelected;

  static Future<void> show(
    BuildContext context, {
    required List<SearchItem> items,
    required void Function(SearchItem item) onItemSelected,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => SearchDialog(
        items: items,
        onItemSelected: onItemSelected,
      ),
    );
  }

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  List<SearchItem> _filteredItems = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items.where((item) => item.matches(query)).toList();
      }
      _selectedIndex = 0;
    });
  }

  void _selectItem(SearchItem item) {
    Navigator.of(context).pop();
    widget.onItemSelected(item);
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _selectedIndex = (_selectedIndex + 1) % _filteredItems.length;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _selectedIndex =
            (_selectedIndex - 1 + _filteredItems.length) % _filteredItems.length;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (_filteredItems.isNotEmpty) {
        _selectItem(_filteredItems[_selectedIndex]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: _handleKeyEvent,
      child: Center(
        child: Container(
          width: 560,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          margin: const EdgeInsets.all(PlaygroundTheme.spaceLg),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusLg),
            border: Border.all(
              color: context.borderColor.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search input
                Container(
                  padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: context.borderColor.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: context.textMutedColor,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          onChanged: _onSearch,
                          style: TextStyle(
                            fontSize: 16,
                            color: context.textPrimaryColor,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search widgets, tokens, utilities...',
                            hintStyle: TextStyle(
                              color: context.textMutedColor,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: context.surfaceElevatedColor,
                          borderRadius: BorderRadius.circular(
                            PlaygroundTheme.radiusSm,
                          ),
                          border: Border.all(
                            color: context.borderColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          'ESC',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: context.textMutedColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Results
                Flexible(
                  child: _filteredItems.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                            vertical: PlaygroundTheme.spaceSm,
                          ),
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            final isSelected = index == _selectedIndex;
                            return _SearchResultItem(
                              item: item,
                              isSelected: isSelected,
                              onTap: () => _selectItem(item),
                              onHover: () {
                                setState(() => _selectedIndex = index);
                              },
                            );
                          },
                        ),
                ),
                // Footer
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PlaygroundTheme.spaceMd,
                    vertical: PlaygroundTheme.spaceSm,
                  ),
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(PlaygroundTheme.radiusLg),
                      bottomRight: Radius.circular(PlaygroundTheme.radiusLg),
                    ),
                  ),
                  child: Row(
                    children: [
                      _KeyboardHint(keys: ['↑', '↓'], label: 'Navigate'),
                      const SizedBox(width: 16),
                      _KeyboardHint(keys: ['↵'], label: 'Select'),
                      const Spacer(),
                      Text(
                        '${_filteredItems.length} results',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(PlaygroundTheme.spaceXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: context.textMutedColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'No results found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try a different search term',
            style: TextStyle(
              fontSize: 14,
              color: context.textMutedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultItem extends StatefulWidget {
  const _SearchResultItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.onHover,
  });

  final SearchItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onHover;

  @override
  State<_SearchResultItem> createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<_SearchResultItem> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHover(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PlaygroundTheme.durationFast,
          margin: const EdgeInsets.symmetric(
            horizontal: PlaygroundTheme.spaceSm,
            vertical: 2,
          ),
          padding: const EdgeInsets.all(PlaygroundTheme.spaceMd),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? PlaygroundTheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(PlaygroundTheme.radiusMd),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? PlaygroundTheme.primary.withValues(alpha: 0.15)
                      : context.surfaceElevatedColor,
                  borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                ),
                child: Icon(
                  widget.item.icon ?? Icons.widgets_outlined,
                  size: 18,
                  color: widget.isSelected
                      ? PlaygroundTheme.primary
                      : context.textMutedColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.item.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        if (widget.item.category != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.surfaceElevatedColor,
                              borderRadius: BorderRadius.circular(
                                PlaygroundTheme.radiusSm,
                              ),
                            ),
                            child: Text(
                              widget.item.category!,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: context.textMutedColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (widget.item.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.item.description!,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textMutedColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.isSelected)
                Icon(
                  Icons.keyboard_return,
                  size: 16,
                  color: context.textMutedColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyboardHint extends StatelessWidget {
  const _KeyboardHint({
    required this.keys,
    required this.label,
  });

  final List<String> keys;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...keys.map((key) => Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: context.surfaceElevatedColor,
                borderRadius: BorderRadius.circular(PlaygroundTheme.radiusSm),
                border: Border.all(
                  color: context.borderColor.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                key,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: context.textMutedColor,
                ),
              ),
            )),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: context.textMutedColor,
          ),
        ),
      ],
    );
  }
}

/// A keyboard shortcut listener for Cmd+K / Ctrl+K
class SearchShortcutListener extends StatelessWidget {
  const SearchShortcutListener({
    super.key,
    required this.child,
    required this.onSearchRequested,
  });

  final Widget child;
  final VoidCallback onSearchRequested;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(
          LogicalKeyboardKey.meta,
          LogicalKeyboardKey.keyK,
        ): const _SearchIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.keyK,
        ): const _SearchIntent(),
      },
      child: Actions(
        actions: {
          _SearchIntent: CallbackAction<_SearchIntent>(
            onInvoke: (_) {
              onSearchRequested();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}

class _SearchIntent extends Intent {
  const _SearchIntent();
}
