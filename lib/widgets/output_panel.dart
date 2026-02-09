import 'package:flutter/material.dart';

class OutputPanel extends StatefulWidget {
  const OutputPanel({
    super.key,
    required this.output,
    required this.scrollController,
    required this.isError,
    required this.searchQuery,
    required this.searchRegex,
    required this.searchCaseSensitive,
    required this.currentMatchIndex,
    required this.onMatchCountChanged,
  });

  final String output;
  final ScrollController scrollController;
  final bool isError;
  final String searchQuery;
  final bool searchRegex;
  final bool searchCaseSensitive;
  final int currentMatchIndex;
  final ValueChanged<int> onMatchCountChanged;

  @override
  State<OutputPanel> createState() => _OutputPanelState();
}

class _OutputPanelState extends State<OutputPanel> {
  int? _lastMatchCount;
  String? _lastScrollKey;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final baseStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      color: widget.isError ? Colors.redAccent : colorScheme.onSurface,
    );
    final content = widget.output.isEmpty ? '(no output)' : widget.output;

    RegExp? buildPattern() {
      if (widget.searchQuery.isEmpty) return null;
      try {
        return widget.searchRegex
            ? RegExp(
                widget.searchQuery,
                caseSensitive: widget.searchCaseSensitive,
              )
            : RegExp(
                RegExp.escape(widget.searchQuery),
                caseSensitive: widget.searchCaseSensitive,
              );
      } on Exception {
        return null;
      }
    }

    TextSpan buildSearchSpan(List<RegExpMatch> matches) {
      if (matches.isEmpty) return TextSpan(text: content);

      final currentIndex = widget.currentMatchIndex;
      final spans = <TextSpan>[];
      int lastIndex = 0;
      int indexOfMatch = 0;
      for (final match in matches) {
        if (match.start > lastIndex) {
          spans.add(
            TextSpan(text: content.substring(lastIndex, match.start)),
          );
        }
        final isCurrent = indexOfMatch == currentIndex;
        spans.add(
          TextSpan(
            text: content.substring(match.start, match.end),
            style: TextStyle(
              backgroundColor:
                  isCurrent ? const Color(0xFF1E3752) : const Color(0xFF3A2F12),
              color:
                  isCurrent ? const Color(0xFF9FD4FF) : const Color(0xFFFFD479),
              fontWeight: FontWeight.w700,
            ),
          ),
        );
        lastIndex = match.end;
        indexOfMatch++;
      }
      if (lastIndex < content.length) {
        spans.add(TextSpan(text: content.substring(lastIndex)));
      }
      return TextSpan(children: spans);
    }

    final pattern = buildPattern();
    final matches = pattern?.allMatches(content).toList() ?? <RegExpMatch>[];

    if (_lastMatchCount != matches.length) {
      _lastMatchCount = matches.length;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onMatchCountChanged(matches.length);
      });
    }

    return Expanded(
      child: Container(
        width: .infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0F141D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.primary.withOpacity(0.2),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Scrollbar(
          thumbVisibility: true,
          controller: widget.scrollController,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (widget.currentMatchIndex >= 0 &&
                  widget.currentMatchIndex < matches.length) {
                final match = matches[widget.currentMatchIndex];
                final scrollKey =
                    '${widget.searchQuery}:${widget.currentMatchIndex}:${content.length}:${constraints.maxWidth}';
                if (_lastScrollKey != scrollKey) {
                  _lastScrollKey = scrollKey;
                  final painter = TextPainter(
                    text: TextSpan(style: baseStyle, text: content),
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);
                  final caretOffset = painter.getOffsetForCaret(
                    TextPosition(offset: match.start),
                    Rect.zero,
                  );
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!widget.scrollController.hasClients) return;
                    final target = (caretOffset.dy - 24)
                        .clamp(0.0, widget.scrollController.position.maxScrollExtent);
                    widget.scrollController.animateTo(
                      target,
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                    );
                  });
                }
              }
              return SingleChildScrollView(
                controller: widget.scrollController,
                child: SelectableText.rich(
                  buildSearchSpan(matches),
                  style: baseStyle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
