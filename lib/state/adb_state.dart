import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/command_history_entry.dart';
import '../models/command_spec.dart';
import '../models/device_info.dart';
import 'adb_history_repository.dart';
import 'adb_network.dart';
import 'adb_state_model.dart';
import 'adb_utils.dart';

part 'adb_state.g.dart';

@riverpod
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepository();
}

@riverpod
class AdbState extends _$AdbState {
  Timer? _deviceWatcherTimer;
  bool _isPollingDevices = false;

  @override
  AppState build() {
    _startDeviceWatcher();
    ref.onDispose(() {
      _deviceWatcherTimer?.cancel();
      _deviceWatcherTimer = null;
    });

    Future<void>.microtask(() async {
      refreshSuggestions('');
      await loadDevices();
      await loadSavedConnectIps();
      await loadCommands();
      await loadHistory();
    });

    return const AppState();
  }

  void _startDeviceWatcher() {
    _deviceWatcherTimer?.cancel();
    _deviceWatcherTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (_isPollingDevices || state.isRunning) return;
      _isPollingDevices = true;
      unawaited(
        loadDevices(showLoading: false, reportError: false).whenComplete(() {
          _isPollingDevices = false;
        }),
      );
    });
  }

  void refreshSuggestions(String input) {
    final normalized = input.trimLeft().replaceAll(RegExp(r'\s+'), ' ');
    final isAdb = normalized.startsWith('adb');
    final isFastboot = normalized.startsWith('fastboot');
    List<CommandSpec> matches;
    if (normalized.isEmpty) {
      matches = state.recentCommands
          .map((cmd) => CommandSpec(cmd, 'Recent command'))
          .toList();
      if (matches.isEmpty) {
        matches = const [
          CommandSpec('adb', 'Start an adb command'),
          CommandSpec('fastboot', 'Start a fastboot command'),
        ];
      }
    } else if (!isAdb && !isFastboot) {
      matches = const [
        CommandSpec('adb', 'Start an adb command'),
        CommandSpec('fastboot', 'Start a fastboot command'),
      ];
    } else {
      matches = state.commandSpecs
          .where((spec) => spec.command.startsWith(normalized))
          .toList();
      if (matches.isEmpty && normalized == 'adb') {
        matches = state.commandSpecs
            .where((spec) => spec.command.startsWith('adb'))
            .toList();
      } else if (matches.isEmpty && normalized == 'fastboot') {
        matches = state.commandSpecs
            .where((spec) => spec.command.startsWith('fastboot'))
            .toList();
      }
      matches = sortByRecent(matches, state.recentCommands);
    }

    int nextSelected = state.selectedSuggestion;
    if (matches.isEmpty) {
      nextSelected = -1;
    } else if (nextSelected >= matches.length || nextSelected == -1) {
      nextSelected = 0;
    }

    state = state.copyWith(
      suggestions: matches,
      selectedSuggestion: nextSelected,
    );
  }

  void moveSuggestion(int delta) {
    if (state.suggestions.isEmpty) return;
    final next = (state.selectedSuggestion + delta).clamp(
      0,
      state.suggestions.length - 1,
    );
    state = state.copyWith(selectedSuggestion: next);
  }

  void selectSuggestion(int index) {
    state = state.copyWith(selectedSuggestion: index);
  }

  void setSelectedSerial(String? serial) {
    state = state.copyWith(selectedSerial: serial);
  }

  void setSearchVisible(bool visible) {
    state = state.copyWith(searchVisible: visible);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSearchRegex(bool enabled) {
    state = state.copyWith(searchRegex: enabled);
  }

  void setSearchCaseSensitive(bool enabled) {
    state = state.copyWith(searchCaseSensitive: enabled);
  }

  void setMatchCount(int count) {
    state = state.copyWith(matchCount: count);
  }

  void setCurrentMatchIndex(int index) {
    state = state.copyWith(currentMatchIndex: index);
  }

  void setSplitRatio(double ratio) {
    state = state.copyWith(splitRatio: ratio);
  }

  void toggleHistory() {
    state = state.copyWith(historyVisible: !state.historyVisible);
  }

  void applyHistoryEntry(CommandHistoryEntry entry) {
    state = state.copyWith(
      output: entry.output,
      exitCode: entry.exitCode,
      outputHasError: entry.isError,
    );
  }

  Future<void> loadHistory() async {
    final repo = ref.read(historyRepositoryProvider);
    final entries = await repo.load();
    final successful = <String>[];
    final seenSuccessful = <String>{};
    final savedIps = List<String>.from(state.savedConnectIps);
    final savedIpSet = savedIps.toSet();
    final nextSpecs = List<CommandSpec>.from(state.commandSpecs);
    final knownCommands = nextSpecs.map((spec) => spec.command).toSet();

    for (final entry in entries) {
      if (entry.isError) continue;
      final normalized = _normalizeCommand(entry.command);
      if (normalized.isEmpty) continue;
      if (seenSuccessful.add(normalized)) {
        successful.add(normalized);
      }
      if (!knownCommands.contains(normalized) &&
          _isSupportedCommandPrefix(normalized)) {
        nextSpecs.add(CommandSpec(normalized, 'Successful command'));
        knownCommands.add(normalized);
      }
      final connectTarget = _extractConnectTargetFromRawCommand(normalized);
      if (connectTarget != null && savedIpSet.add(connectTarget)) {
        savedIps.add(connectTarget);
      }
    }

    state = state.copyWith(
      history: entries,
      recentCommands: successful.take(8).toList(),
      commandSpecs: nextSpecs,
      savedConnectIps: savedIps.take(20).toList(),
    );
    if (savedIps.isNotEmpty) {
      unawaited(saveConnectIps(state.savedConnectIps));
    }
  }

  Future<void> saveHistory(List<CommandHistoryEntry> entries) async {
    final repo = ref.read(historyRepositoryProvider);
    await repo.save(entries);
  }

  Future<void> loadSavedConnectIps() async {
    final repo = ref.read(historyRepositoryProvider);
    final ips = await repo.loadConnectIps();
    if (ips.isEmpty) return;
    final cleaned = <String>[];
    final seen = <String>{};
    for (final raw in ips) {
      final value = raw.trim();
      if (value.isEmpty) continue;
      if (seen.add(value)) {
        cleaned.add(value);
      }
      if (cleaned.length >= 20) break;
    }
    state = state.copyWith(savedConnectIps: cleaned);
  }

  Future<void> saveConnectIps(List<String> ips) async {
    final repo = ref.read(historyRepositoryProvider);
    await repo.saveConnectIps(ips);
  }

  void recordRecentCommand(String raw) {
    final next = List<String>.from(state.recentCommands);
    next.remove(raw);
    next.insert(0, raw);
    if (next.length > 8) {
      next.removeRange(8, next.length);
    }
    state = state.copyWith(recentCommands: next);
  }

  void _recordSuccessfulCommand(String raw) {
    final normalized = _normalizeCommand(raw);
    if (normalized.isEmpty) return;
    recordRecentCommand(normalized);
    if (!state.commandSpecs.any((spec) => spec.command == normalized)) {
      final nextSpecs = List<CommandSpec>.from(state.commandSpecs)
        ..add(CommandSpec(normalized, 'Successful command'));
      state = state.copyWith(commandSpecs: nextSpecs);
    }
  }

  Future<void> loadDevices({
    bool showLoading = true,
    bool reportError = true,
  }) async {
    if (showLoading) {
      state = state.copyWith(devicesLoading: true, devicesError: null);
    }
    try {
      final result = await Process.run('adb', const ['devices']);
      final lines = (result.stdout as String).split('\n');
      final devicePattern = RegExp(
        r'^(\S+)\s+(device|offline|unauthorized|recovery|sideload|bootloader|host|rescue)\b',
        caseSensitive: false,
      );
      final foundBySerial = <String, DeviceInfo>{};
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.isEmpty) continue;
        final match = devicePattern.firstMatch(trimmed);
        if (match == null) continue;
        final serial = match.group(1);
        final deviceState = match.group(2);
        if (serial == null || deviceState == null) continue;
        if (serial.startsWith('*')) continue;
        foundBySerial[serial] = DeviceInfo(serial, deviceState);
      }
      final found = foundBySerial.values.toList();
      String? selectedSerial = state.selectedSerial;
      if (selectedSerial != null &&
          !found.any((d) => d.serial == selectedSerial)) {
        selectedSerial = null;
      }
      if (selectedSerial == null && found.length == 1) {
        selectedSerial = found.first.serial;
      }
      state = state.copyWith(
        devices: found,
        devicesLoading: showLoading ? false : state.devicesLoading,
        selectedSerial: selectedSerial,
        devicesError: showLoading ? null : state.devicesError,
      );
    } on Exception catch (e) {
      if (reportError) {
        state = state.copyWith(
          devicesError: 'Failed to load devices: $e',
          devicesLoading: false,
        );
      } else if (showLoading) {
        state = state.copyWith(devicesLoading: false);
      }
    }
  }

  Future<void> loadCommands() async {
    final jsonText = await rootBundle.loadString('assets/adb_commands.json');
    final dynamic raw = jsonDecode(jsonText);
    if (raw is! List) {
      return;
    }
    final cmds = <CommandSpec>[];
    for (final entry in raw) {
      if (entry is Map<String, dynamic>) {
        final cmd = entry['command'];
        final desc = entry['description'];
        final params = entry['params'];
        if (cmd is String && desc is String) {
          cmds.add(CommandSpec(cmd, desc, params is String ? params : null));
        }
      }
    }
    final next = <CommandSpec>[
      ...state.savedConnectIps.map(
        (ip) => CommandSpec('adb connect $ip', 'Reconnect saved device'),
      ),
      ...cmds,
    ];
    state = state.copyWith(commandSpecs: next);
    refreshSuggestions('');
  }

  Future<void> runCommand(String raw) async {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      state = state.copyWith(
        output: 'Enter a command.',
        exitCode: null,
        outputHasError: true,
      );
      return;
    }
    if (!_isSupportedCommandPrefix(trimmed)) {
      state = state.copyWith(
        output: 'Command must start with "adb" or "fastboot".',
        exitCode: null,
        outputHasError: true,
      );
      return;
    }

    final rawArgs = parseArgs(trimmed);
    if (rawArgs.isEmpty) {
      state = state.copyWith(
        output: 'Unable to parse command.',
        exitCode: null,
        outputHasError: true,
      );
      return;
    }

    final args = List<String>.from(rawArgs);
    if (state.selectedSerial != null &&
        args.first == 'adb' &&
        !args.contains('-s') &&
        _adbCommandSupportsSerial(args)) {
      args.insertAll(1, ['-s', state.selectedSerial!]);
    }

    state = state.copyWith(
      isRunning: true,
      output: 'Running...',
      exitCode: null,
      outputHasError: false,
    );

    bool ranProcess = false;
    try {
      ranProcess = true;
      final result = await Process.run(args.first, args.sublist(1));
      final stdoutText = result.stdout is String ? result.stdout as String : '';
      final stderrText = result.stderr is String ? result.stderr as String : '';
      final nextOutput = [
        if (stdoutText.isNotEmpty) stdoutText,
        if (stderrText.isNotEmpty) stderrText,
      ].join('\n').trim();
      final hasError = result.exitCode != 0 || stderrText.trim().isNotEmpty;
      state = state.copyWith(
        output: nextOutput,
        exitCode: result.exitCode,
        outputHasError: hasError,
        isRunning: false,
      );
      if (!hasError) {
        _recordSuccessfulCommand(trimmed);
        final connectTarget = _extractConnectTarget(rawArgs);
        if (connectTarget != null) {
          _saveConnectTarget(connectTarget);
        }
      }
    } on ProcessException catch (e) {
      ranProcess = true;
      state = state.copyWith(
        output: 'Failed to run ${args.first}: ${e.message}',
        exitCode: null,
        outputHasError: true,
        isRunning: false,
      );
    } on Exception catch (e) {
      ranProcess = true;
      state = state.copyWith(
        output: 'Error: $e',
        exitCode: null,
        outputHasError: true,
        isRunning: false,
      );
    }

    if (ranProcess) {
      final next = List<CommandHistoryEntry>.from(state.history);
      next.insert(
        0,
        CommandHistoryEntry(
          command: trimmed,
          output: state.output,
          exitCode: state.exitCode,
          isError: state.outputHasError,
          timestamp: DateTime.now(),
        ),
      );
      if (next.length > 50) {
        next.removeRange(50, next.length);
      }
      state = state.copyWith(history: next);
      unawaited(saveHistory(next));
    }
  }

  Future<void> scanLan() async {
    state = state.copyWith(
      isScanningLan: true,
      scanError: null,
      discoveredHosts: const [],
    );

    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );
      final prefixes = <String>{};
      for (final iface in interfaces) {
        for (final addr in iface.addresses) {
          final ip = addr.address;
          if (ip.startsWith('169.254.') || ip.startsWith('127.')) {
            continue;
          }
          final parts = ip.split('.');
          if (parts.length == 4) {
            prefixes.add('${parts[0]}.${parts[1]}.${parts[2]}');
          }
        }
      }

      final found = <String>{};
      for (final prefix in prefixes) {
        final hosts = await scanSubnet(prefix);
        found.addAll(hosts);
      }
      state = state.copyWith(
        discoveredHosts: found.toList()..sort(),
        isScanningLan: false,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        scanError: 'LAN scan failed: $e',
        isScanningLan: false,
      );
    }
  }

  Future<void> connectDiscoveredHost(String host) async {
    state = state.copyWith(
      output: 'Connecting to $host:5555 ...',
      exitCode: null,
    );
    try {
      final result = await Process.run('adb', ['connect', '$host:5555']);
      final stdoutText = result.stdout is String ? result.stdout as String : '';
      final stderrText = result.stderr is String ? result.stderr as String : '';
      final nextOutput = [
        if (stdoutText.isNotEmpty) stdoutText,
        if (stderrText.isNotEmpty) stderrText,
      ].join('\n').trim();
      final hasError = result.exitCode != 0 || stderrText.trim().isNotEmpty;
      state = state.copyWith(
        output: nextOutput,
        exitCode: result.exitCode,
        outputHasError: hasError,
      );
      if (!hasError) {
        _recordSuccessfulCommand('adb connect $host:5555');
        _saveConnectTarget('$host:5555');
      }
      unawaited(loadDevices());
    } on Exception catch (e) {
      state = state.copyWith(
        output: 'Connect failed: $e',
        exitCode: null,
        outputHasError: true,
      );
    }
  }

  bool _isSupportedCommandPrefix(String command) {
    return command.startsWith('adb') || command.startsWith('fastboot');
  }

  String _normalizeCommand(String command) {
    return command.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  bool _adbCommandSupportsSerial(List<String> args) {
    if (args.length < 2) return false;
    const unsupportedSubCommands = <String>{
      'connect',
      'disconnect',
      'kill-server',
      'start-server',
      'version',
      'help',
    };
    return !unsupportedSubCommands.contains(args[1]);
  }

  String? _extractConnectTarget(List<String> args) {
    if (args.length < 3) return null;
    if (args.first != 'adb' || args[1] != 'connect') return null;
    return args[2].trim();
  }

  String? _extractConnectTargetFromRawCommand(String command) {
    final args = parseArgs(command);
    return _extractConnectTarget(args);
  }

  void _saveConnectTarget(String rawTarget) {
    final target = rawTarget.trim();
    if (target.isEmpty) return;
    final nextIps = List<String>.from(state.savedConnectIps);
    nextIps.remove(target);
    nextIps.insert(0, target);
    if (nextIps.length > 20) {
      nextIps.removeRange(20, nextIps.length);
    }

    final connectCommand = 'adb connect $target';
    final nextSpecs = List<CommandSpec>.from(state.commandSpecs);
    if (!nextSpecs.any((spec) => spec.command == connectCommand)) {
      nextSpecs.insert(
        0,
        CommandSpec(connectCommand, 'Reconnect saved device'),
      );
    }
    state = state.copyWith(savedConnectIps: nextIps, commandSpecs: nextSpecs);
    unawaited(saveConnectIps(nextIps));
  }
}
