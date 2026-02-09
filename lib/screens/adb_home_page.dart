import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ota_tool/state/adb_state_model.dart';

import '../models/command_spec.dart';
import '../state/adb_state.dart';
import '../widgets/command_input.dart';
import '../widgets/device_bar.dart';
import '../widgets/discovered_hosts_panel.dart';
import '../widgets/output_header.dart';
import '../widgets/output_panel.dart';
import '../widgets/suggestion_list.dart';

class AdbHomePage extends ConsumerStatefulWidget {
  const AdbHomePage({super.key});

  @override
  ConsumerState<AdbHomePage> createState() => _AdbHomePageState();
}

class _AdbHomePageState extends ConsumerState<AdbHomePage> {
  late final TextEditingController _controller;
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;
  late final FocusNode _searchFocusNode;
  late final FocusScopeNode _pageFocusNode;
  late final ScrollController _outputScroll;
  int _commandBrowseIndex = -1;
  String _commandBrowseDraft = '';
  bool _isApplyingBrowseCommand = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    _searchFocusNode = FocusNode();
    _pageFocusNode = FocusScopeNode();
    _outputScroll = ScrollController();

    _controller.addListener(_handleInputChange);
    _searchController.addListener(_handleSearchChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adbStateProvider.notifier).refreshSuggestions(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_handleInputChange);
    _searchController.removeListener(_handleSearchChange);
    _controller.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    _searchFocusNode.dispose();
    _pageFocusNode.dispose();
    _outputScroll.dispose();
    super.dispose();
  }

  void _handleInputChange() {
    if (!_isApplyingBrowseCommand) {
      _commandBrowseIndex = -1;
      _commandBrowseDraft = '';
    }
    ref.read(adbStateProvider.notifier).refreshSuggestions(_controller.text);
  }

  void _handleSearchChange() {
    final notifier = ref.read(adbStateProvider.notifier);
    notifier.setSearchQuery(_searchController.text);
    notifier.setCurrentMatchIndex(_searchController.text.isEmpty ? -1 : 0);
  }

  void _openSearch() {
    final notifier = ref.read(adbStateProvider.notifier);
    if (!ref.read(adbStateProvider).searchVisible) {
      notifier.setSearchVisible(true);
    }
    Future<void>.microtask(() => _searchFocusNode.requestFocus());
  }

  void _closeSearch() {
    ref.read(adbStateProvider.notifier).setSearchVisible(false);
    _focusNode.requestFocus();
  }

  void _updateMatchCount(int count) {
    final notifier = ref.read(adbStateProvider.notifier);
    notifier.setMatchCount(count);
    if (count == 0) {
      notifier.setCurrentMatchIndex(-1);
      return;
    }
    final current = ref.read(adbStateProvider).currentMatchIndex;
    if (current < 0 || current >= count) {
      notifier.setCurrentMatchIndex(0);
    }
  }

  void _nextMatch() {
    final state = ref.read(adbStateProvider);
    if (state.matchCount == 0) return;
    final next = (state.currentMatchIndex + 1) % state.matchCount;
    ref.read(adbStateProvider.notifier).setCurrentMatchIndex(next);
  }

  void _prevMatch() {
    final state = ref.read(adbStateProvider);
    if (state.matchCount == 0) return;
    final next =
        (state.currentMatchIndex - 1 + state.matchCount) % state.matchCount;
    ref.read(adbStateProvider.notifier).setCurrentMatchIndex(next);
  }

  void _applySuggestion(CommandSpec spec) {
    _controller.text = spec.command;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    ref.read(adbStateProvider.notifier).refreshSuggestions(_controller.text);
    _focusNode.requestFocus();
  }

  void _setCommandInputFromBrowse(String text) {
    _isApplyingBrowseCommand = true;
    _controller.text = text;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    _isApplyingBrowseCommand = false;
  }

  void _browsePreviousCommand(AppState state) {
    if (state.recentCommands.isEmpty) return;
    if (_commandBrowseIndex == -1) {
      _commandBrowseDraft = _controller.text;
    }
    final nextIndex = (_commandBrowseIndex + 1).clamp(
      0,
      state.recentCommands.length - 1,
    );
    _commandBrowseIndex = nextIndex;
    _setCommandInputFromBrowse(state.recentCommands[nextIndex]);
    _focusNode.requestFocus();
  }

  void _browseNextCommand(AppState state) {
    if (state.recentCommands.isEmpty || _commandBrowseIndex == -1) return;
    final nextIndex = _commandBrowseIndex - 1;
    if (nextIndex < 0) {
      _commandBrowseIndex = -1;
      _setCommandInputFromBrowse(_commandBrowseDraft);
      _focusNode.requestFocus();
      return;
    }
    _commandBrowseIndex = nextIndex;
    _setCommandInputFromBrowse(state.recentCommands[nextIndex]);
    _focusNode.requestFocus();
  }

  void _applySelectedSuggestion(AppState state) {
    if (state.selectedSuggestion < 0 ||
        state.selectedSuggestion >= state.suggestions.length) {
      return;
    }
    _applySuggestion(state.suggestions[state.selectedSuggestion]);
  }

  Future<void> _runCommand() async {
    final notifier = ref.read(adbStateProvider.notifier);
    await notifier.runCommand(_controller.text);
    _commandBrowseIndex = -1;
    _commandBrowseDraft = '';
    unawaited(
      Future<void>.delayed(const Duration(milliseconds: 50), () {
        if (_outputScroll.hasClients) {
          _outputScroll.animateTo(
            _outputScroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      }),
    );
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event, AppState state) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final keyboard = HardwareKeyboard.instance;
    final isBrowsePrevShortcut =
        keyboard.logicalKeysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        event.logicalKey == LogicalKeyboardKey.arrowUp;
    if (isBrowsePrevShortcut) {
      _browsePreviousCommand(state);
      return KeyEventResult.handled;
    }
    final isBrowseNextShortcut =
        keyboard.logicalKeysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        event.logicalKey == LogicalKeyboardKey.arrowDown;
    if (isBrowseNextShortcut) {
      _browseNextCommand(state);
      return KeyEventResult.handled;
    }
    final isFocusCommandInputShortcut =
        (keyboard.isMetaPressed || keyboard.isControlPressed) &&
        event.logicalKey == LogicalKeyboardKey.backquote;
    if (isFocusCommandInputShortcut) {
      _focusNode.requestFocus();
      return KeyEventResult.handled;
    }
    final isFindShortcut =
        (keyboard.isMetaPressed || keyboard.isControlPressed) &&
        event.logicalKey == LogicalKeyboardKey.keyF;
    if (isFindShortcut) {
      _openSearch();
      return KeyEventResult.handled;
    }
    if (state.suggestions.isEmpty) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      ref.read(adbStateProvider.notifier).moveSuggestion(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      ref.read(adbStateProvider.notifier).moveSuggestion(-1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.tab) {
      _applySelectedSuggestion(state);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Future<void> _copyOutput(String output) async {
    if (output.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: output));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adbStateProvider);
    final notifier = ref.read(adbStateProvider.notifier);

    String? searchError;
    if (state.searchVisible &&
        state.searchRegex &&
        state.searchQuery.isNotEmpty) {
      try {
        RegExp(state.searchQuery, caseSensitive: state.searchCaseSensitive);
      } on Exception {
        searchError = 'Invalid regex';
      }
    }

    final leftColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommandInput(
          controller: _controller,
          focusNode: _focusNode,
          isRunning: state.isRunning,
          onSubmitted: _runCommand,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: state.isRunning
              ? const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(minHeight: 3),
                )
              : const SizedBox(height: 8),
        ),
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: state.suggestions.isEmpty
              ? const SizedBox.shrink()
              : SuggestionList(
                  suggestions: state.suggestions,
                  selectedIndex: state.selectedSuggestion,
                  onTap: _applySuggestion,
                ),
        ),
      ],
    );

    final rightColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutputHeader(
          exitCode: state.exitCode,
          isRunning: state.isRunning,
          onCopy: () => _copyOutput(state.output),
          onToggleHistory: notifier.toggleHistory,
          historyVisible: state.historyVisible,
        ),
        const SizedBox(height: 8),
        if (state.searchVisible)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Search output',
                          hintStyle: .new(color: Colors.grey.shade700),
                          filled: true,
                          fillColor: const Color(0xFF141A24),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _closeSearch,
                            icon: const Icon(Icons.close),
                            tooltip: 'Close search',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () =>
                          notifier.setSearchRegex(!state.searchRegex),
                      icon: Icon(
                        Icons.data_array,
                        color: state.searchRegex
                            ? Theme.of(context).colorScheme.secondary
                            : null,
                      ),
                      tooltip: 'Regex',
                    ),
                    IconButton(
                      onPressed: () => notifier.setSearchCaseSensitive(
                        !state.searchCaseSensitive,
                      ),
                      icon: Icon(
                        Icons.text_fields,
                        color: state.searchCaseSensitive
                            ? Theme.of(context).colorScheme.secondary
                            : null,
                      ),
                      tooltip: 'Case sensitive',
                    ),
                    IconButton(
                      onPressed: _prevMatch,
                      icon: const Icon(Icons.arrow_upward),
                      tooltip: 'Previous match',
                    ),
                    IconButton(
                      onPressed: _nextMatch,
                      icon: const Icon(Icons.arrow_downward),
                      tooltip: 'Next match',
                    ),
                  ],
                ),
                if (state.matchCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${state.currentMatchIndex + 1}/${state.matchCount}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                if (searchError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      searchError,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        if (state.historyVisible)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF101723),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 140,
                child: state.history.isEmpty
                    ? const Center(
                        child: Text(
                          'No history yet',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.history.length,
                        itemBuilder: (context, index) {
                          final entry = state.history[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              entry.command,
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              entry.timestampLabel,
                              style: const TextStyle(fontSize: 11),
                            ),
                            trailing: entry.isError
                                ? const Icon(
                                    Icons.error_outline,
                                    size: 16,
                                    color: Colors.redAccent,
                                  )
                                : const Icon(
                                    Icons.check_circle_outline,
                                    size: 16,
                                    color: Colors.greenAccent,
                                  ),
                            onTap: state.isRunning
                                ? null
                                : () => notifier.applyHistoryEntry(entry),
                          );
                        },
                      ),
              ),
            ),
          ),
        OutputPanel(
          output: state.output,
          scrollController: _outputScroll,
          isError: state.outputHasError,
          searchQuery: state.searchVisible ? state.searchQuery : '',
          searchRegex: state.searchRegex,
          searchCaseSensitive: state.searchCaseSensitive,
          currentMatchIndex: state.currentMatchIndex,
          onMatchCountChanged: _updateMatchCount,
        ),
      ],
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0E12), Color(0xFF111926)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FocusScope(
          node: _pageFocusNode,
          onKeyEvent: (node, event) => _handleKey(node, event, state),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final useSplit = constraints.maxWidth >= 900;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeviceBar(
                      devices: state.devices,
                      loading: state.devicesLoading,
                      errorText: state.devicesError,
                      selectedSerial: state.selectedSerial,
                      onChanged: notifier.setSelectedSerial,
                      onRefresh: notifier.loadDevices,
                      onScan: notifier.scanLan,
                      scanning: state.isScanningLan,
                    ),
                    if (state.discoveredHosts.isNotEmpty || state.isScanningLan)
                      DiscoveredHostsPanel(
                        hosts: state.discoveredHosts,
                        scanning: state.isScanningLan,
                        errorText: state.scanError,
                        onConnect: notifier.connectDiscoveredHost,
                      ),
                    const SizedBox(height: 12),
                    if (useSplit)
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, inner) {
                            const dividerWidth = 8.0;
                            final maxWidth = inner.maxWidth;
                            final minLeft = maxWidth * 0.25;
                            final maxLeft = maxWidth * 0.75;
                            final leftWidth =
                                ((maxWidth - dividerWidth) * state.splitRatio)
                                    .clamp(minLeft, maxLeft);
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: leftWidth, child: leftColumn),
                                MouseRegion(
                                  cursor: SystemMouseCursors.resizeLeftRight,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onHorizontalDragUpdate: (details) {
                                      final nextLeft =
                                          (leftWidth + details.delta.dx).clamp(
                                            minLeft,
                                            maxLeft,
                                          );
                                      notifier.setSplitRatio(
                                        nextLeft / (maxWidth - dividerWidth),
                                      );
                                    },
                                    child: Container(
                                      width: dividerWidth,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: rightColumn),
                              ],
                            );
                          },
                        ),
                      )
                    else ...[
                      leftColumn,
                      const SizedBox(height: 16),
                      Expanded(child: rightColumn),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
