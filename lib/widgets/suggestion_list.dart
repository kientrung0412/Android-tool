import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ota_tool/models/command_spec.dart';

class SuggestionList extends HookConsumerWidget {
  const SuggestionList({
    super.key,
    required this.suggestions,
    required this.onTap,
    required this.selectedIndex,
  });

  static const itemExtent = 44.0;

  final List<CommandSpec> suggestions;
  final ValueChanged<CommandSpec> onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final itemKeys = useMemoized(
      () => List<GlobalKey>.generate(suggestions.length, (_) => GlobalKey()),
      [suggestions.length],
    );

    useEffect(() {
      if (selectedIndex < 0 || selectedIndex >= itemKeys.length) {
        return null;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final itemContext = itemKeys[selectedIndex].currentContext;
        if (itemContext == null) return;
        Scrollable.ensureVisible(
          itemContext,
          alignment: 0.1,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
        );
      });
      return null;
    }, [selectedIndex, itemKeys]);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 220),
      child: Container(
        key: const ValueKey('suggestions'),
        decoration: BoxDecoration(
          color: const Color(0xFF111826),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount: suggestions.length,
            itemExtent: itemExtent,
            itemBuilder: (context, index) {
              final spec = suggestions[index];
              final isSelected = index == selectedIndex;
              return InkWell(
                key: itemKeys[index],
                onTap: () => onTap(spec),
                child: Container(
                  color: isSelected
                      ? Colors.white.withOpacity(0.08)
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bolt,
                        size: 16,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          spec.command,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            color: Color(0xFF8FD3FF),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        spec.suggestionLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
