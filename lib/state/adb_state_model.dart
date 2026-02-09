import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/command_history_entry.dart';
import '../models/command_spec.dart';
import '../models/device_info.dart';

part 'adb_state_model.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default([]) List<CommandSpec> suggestions,
    @Default(-1) int selectedSuggestion,
    @Default('Ready.') String output,
    @Default(false) bool isRunning,
    int? exitCode,
    @Default(false) bool outputHasError,
    @Default(false) bool devicesLoading,
    String? devicesError,
    @Default([]) List<DeviceInfo> devices,
    String? selectedSerial,
    @Default(false) bool isScanningLan,
    String? scanError,
    @Default([]) List<String> discoveredHosts,
    @Default(kDefaultCommands) List<CommandSpec> commandSpecs,
    @Default([]) List<String> recentCommands,
    @Default([]) List<String> savedConnectIps,
    @Default(false) bool searchVisible,
    @Default('') String searchQuery,
    @Default(false) bool searchRegex,
    @Default(false) bool searchCaseSensitive,
    @Default(0) int matchCount,
    @Default(-1) int currentMatchIndex,
    @Default(0.48) double splitRatio,
    @Default(false) bool historyVisible,
    @Default([]) List<CommandHistoryEntry> history,
  }) = _AppState;
}
