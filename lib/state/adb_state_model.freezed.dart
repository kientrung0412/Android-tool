// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adb_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 List<CommandSpec> get suggestions; int get selectedSuggestion; String get output; bool get isRunning; int? get exitCode; bool get outputHasError; bool get devicesLoading; String? get devicesError; List<DeviceInfo> get devices; String? get selectedSerial; bool get isScanningLan; String? get scanError; List<String> get discoveredHosts; List<CommandSpec> get commandSpecs; List<String> get recentCommands; List<String> get savedConnectIps; bool get searchVisible; String get searchQuery; bool get searchRegex; bool get searchCaseSensitive; int get matchCount; int get currentMatchIndex; double get splitRatio; bool get historyVisible; List<CommandHistoryEntry> get history;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.selectedSuggestion, selectedSuggestion) || other.selectedSuggestion == selectedSuggestion)&&(identical(other.output, output) || other.output == output)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.exitCode, exitCode) || other.exitCode == exitCode)&&(identical(other.outputHasError, outputHasError) || other.outputHasError == outputHasError)&&(identical(other.devicesLoading, devicesLoading) || other.devicesLoading == devicesLoading)&&(identical(other.devicesError, devicesError) || other.devicesError == devicesError)&&const DeepCollectionEquality().equals(other.devices, devices)&&(identical(other.selectedSerial, selectedSerial) || other.selectedSerial == selectedSerial)&&(identical(other.isScanningLan, isScanningLan) || other.isScanningLan == isScanningLan)&&(identical(other.scanError, scanError) || other.scanError == scanError)&&const DeepCollectionEquality().equals(other.discoveredHosts, discoveredHosts)&&const DeepCollectionEquality().equals(other.commandSpecs, commandSpecs)&&const DeepCollectionEquality().equals(other.recentCommands, recentCommands)&&const DeepCollectionEquality().equals(other.savedConnectIps, savedConnectIps)&&(identical(other.searchVisible, searchVisible) || other.searchVisible == searchVisible)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.searchRegex, searchRegex) || other.searchRegex == searchRegex)&&(identical(other.searchCaseSensitive, searchCaseSensitive) || other.searchCaseSensitive == searchCaseSensitive)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount)&&(identical(other.currentMatchIndex, currentMatchIndex) || other.currentMatchIndex == currentMatchIndex)&&(identical(other.splitRatio, splitRatio) || other.splitRatio == splitRatio)&&(identical(other.historyVisible, historyVisible) || other.historyVisible == historyVisible)&&const DeepCollectionEquality().equals(other.history, history));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(suggestions),selectedSuggestion,output,isRunning,exitCode,outputHasError,devicesLoading,devicesError,const DeepCollectionEquality().hash(devices),selectedSerial,isScanningLan,scanError,const DeepCollectionEquality().hash(discoveredHosts),const DeepCollectionEquality().hash(commandSpecs),const DeepCollectionEquality().hash(recentCommands),const DeepCollectionEquality().hash(savedConnectIps),searchVisible,searchQuery,searchRegex,searchCaseSensitive,matchCount,currentMatchIndex,splitRatio,historyVisible,const DeepCollectionEquality().hash(history)]);

@override
String toString() {
  return 'AppState(suggestions: $suggestions, selectedSuggestion: $selectedSuggestion, output: $output, isRunning: $isRunning, exitCode: $exitCode, outputHasError: $outputHasError, devicesLoading: $devicesLoading, devicesError: $devicesError, devices: $devices, selectedSerial: $selectedSerial, isScanningLan: $isScanningLan, scanError: $scanError, discoveredHosts: $discoveredHosts, commandSpecs: $commandSpecs, recentCommands: $recentCommands, savedConnectIps: $savedConnectIps, searchVisible: $searchVisible, searchQuery: $searchQuery, searchRegex: $searchRegex, searchCaseSensitive: $searchCaseSensitive, matchCount: $matchCount, currentMatchIndex: $currentMatchIndex, splitRatio: $splitRatio, historyVisible: $historyVisible, history: $history)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 List<CommandSpec> suggestions, int selectedSuggestion, String output, bool isRunning, int? exitCode, bool outputHasError, bool devicesLoading, String? devicesError, List<DeviceInfo> devices, String? selectedSerial, bool isScanningLan, String? scanError, List<String> discoveredHosts, List<CommandSpec> commandSpecs, List<String> recentCommands, List<String> savedConnectIps, bool searchVisible, String searchQuery, bool searchRegex, bool searchCaseSensitive, int matchCount, int currentMatchIndex, double splitRatio, bool historyVisible, List<CommandHistoryEntry> history
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestions = null,Object? selectedSuggestion = null,Object? output = null,Object? isRunning = null,Object? exitCode = freezed,Object? outputHasError = null,Object? devicesLoading = null,Object? devicesError = freezed,Object? devices = null,Object? selectedSerial = freezed,Object? isScanningLan = null,Object? scanError = freezed,Object? discoveredHosts = null,Object? commandSpecs = null,Object? recentCommands = null,Object? savedConnectIps = null,Object? searchVisible = null,Object? searchQuery = null,Object? searchRegex = null,Object? searchCaseSensitive = null,Object? matchCount = null,Object? currentMatchIndex = null,Object? splitRatio = null,Object? historyVisible = null,Object? history = null,}) {
  return _then(_self.copyWith(
suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<CommandSpec>,selectedSuggestion: null == selectedSuggestion ? _self.selectedSuggestion : selectedSuggestion // ignore: cast_nullable_to_non_nullable
as int,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,exitCode: freezed == exitCode ? _self.exitCode : exitCode // ignore: cast_nullable_to_non_nullable
as int?,outputHasError: null == outputHasError ? _self.outputHasError : outputHasError // ignore: cast_nullable_to_non_nullable
as bool,devicesLoading: null == devicesLoading ? _self.devicesLoading : devicesLoading // ignore: cast_nullable_to_non_nullable
as bool,devicesError: freezed == devicesError ? _self.devicesError : devicesError // ignore: cast_nullable_to_non_nullable
as String?,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as List<DeviceInfo>,selectedSerial: freezed == selectedSerial ? _self.selectedSerial : selectedSerial // ignore: cast_nullable_to_non_nullable
as String?,isScanningLan: null == isScanningLan ? _self.isScanningLan : isScanningLan // ignore: cast_nullable_to_non_nullable
as bool,scanError: freezed == scanError ? _self.scanError : scanError // ignore: cast_nullable_to_non_nullable
as String?,discoveredHosts: null == discoveredHosts ? _self.discoveredHosts : discoveredHosts // ignore: cast_nullable_to_non_nullable
as List<String>,commandSpecs: null == commandSpecs ? _self.commandSpecs : commandSpecs // ignore: cast_nullable_to_non_nullable
as List<CommandSpec>,recentCommands: null == recentCommands ? _self.recentCommands : recentCommands // ignore: cast_nullable_to_non_nullable
as List<String>,savedConnectIps: null == savedConnectIps ? _self.savedConnectIps : savedConnectIps // ignore: cast_nullable_to_non_nullable
as List<String>,searchVisible: null == searchVisible ? _self.searchVisible : searchVisible // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,searchRegex: null == searchRegex ? _self.searchRegex : searchRegex // ignore: cast_nullable_to_non_nullable
as bool,searchCaseSensitive: null == searchCaseSensitive ? _self.searchCaseSensitive : searchCaseSensitive // ignore: cast_nullable_to_non_nullable
as bool,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,currentMatchIndex: null == currentMatchIndex ? _self.currentMatchIndex : currentMatchIndex // ignore: cast_nullable_to_non_nullable
as int,splitRatio: null == splitRatio ? _self.splitRatio : splitRatio // ignore: cast_nullable_to_non_nullable
as double,historyVisible: null == historyVisible ? _self.historyVisible : historyVisible // ignore: cast_nullable_to_non_nullable
as bool,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<CommandHistoryEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommandSpec> suggestions,  int selectedSuggestion,  String output,  bool isRunning,  int? exitCode,  bool outputHasError,  bool devicesLoading,  String? devicesError,  List<DeviceInfo> devices,  String? selectedSerial,  bool isScanningLan,  String? scanError,  List<String> discoveredHosts,  List<CommandSpec> commandSpecs,  List<String> recentCommands,  List<String> savedConnectIps,  bool searchVisible,  String searchQuery,  bool searchRegex,  bool searchCaseSensitive,  int matchCount,  int currentMatchIndex,  double splitRatio,  bool historyVisible,  List<CommandHistoryEntry> history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.suggestions,_that.selectedSuggestion,_that.output,_that.isRunning,_that.exitCode,_that.outputHasError,_that.devicesLoading,_that.devicesError,_that.devices,_that.selectedSerial,_that.isScanningLan,_that.scanError,_that.discoveredHosts,_that.commandSpecs,_that.recentCommands,_that.savedConnectIps,_that.searchVisible,_that.searchQuery,_that.searchRegex,_that.searchCaseSensitive,_that.matchCount,_that.currentMatchIndex,_that.splitRatio,_that.historyVisible,_that.history);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommandSpec> suggestions,  int selectedSuggestion,  String output,  bool isRunning,  int? exitCode,  bool outputHasError,  bool devicesLoading,  String? devicesError,  List<DeviceInfo> devices,  String? selectedSerial,  bool isScanningLan,  String? scanError,  List<String> discoveredHosts,  List<CommandSpec> commandSpecs,  List<String> recentCommands,  List<String> savedConnectIps,  bool searchVisible,  String searchQuery,  bool searchRegex,  bool searchCaseSensitive,  int matchCount,  int currentMatchIndex,  double splitRatio,  bool historyVisible,  List<CommandHistoryEntry> history)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.suggestions,_that.selectedSuggestion,_that.output,_that.isRunning,_that.exitCode,_that.outputHasError,_that.devicesLoading,_that.devicesError,_that.devices,_that.selectedSerial,_that.isScanningLan,_that.scanError,_that.discoveredHosts,_that.commandSpecs,_that.recentCommands,_that.savedConnectIps,_that.searchVisible,_that.searchQuery,_that.searchRegex,_that.searchCaseSensitive,_that.matchCount,_that.currentMatchIndex,_that.splitRatio,_that.historyVisible,_that.history);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommandSpec> suggestions,  int selectedSuggestion,  String output,  bool isRunning,  int? exitCode,  bool outputHasError,  bool devicesLoading,  String? devicesError,  List<DeviceInfo> devices,  String? selectedSerial,  bool isScanningLan,  String? scanError,  List<String> discoveredHosts,  List<CommandSpec> commandSpecs,  List<String> recentCommands,  List<String> savedConnectIps,  bool searchVisible,  String searchQuery,  bool searchRegex,  bool searchCaseSensitive,  int matchCount,  int currentMatchIndex,  double splitRatio,  bool historyVisible,  List<CommandHistoryEntry> history)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.suggestions,_that.selectedSuggestion,_that.output,_that.isRunning,_that.exitCode,_that.outputHasError,_that.devicesLoading,_that.devicesError,_that.devices,_that.selectedSerial,_that.isScanningLan,_that.scanError,_that.discoveredHosts,_that.commandSpecs,_that.recentCommands,_that.savedConnectIps,_that.searchVisible,_that.searchQuery,_that.searchRegex,_that.searchCaseSensitive,_that.matchCount,_that.currentMatchIndex,_that.splitRatio,_that.historyVisible,_that.history);case _:
  return null;

}
}

}

/// @nodoc


class _AppState implements AppState {
  const _AppState({final  List<CommandSpec> suggestions = const [], this.selectedSuggestion = -1, this.output = 'Ready.', this.isRunning = false, this.exitCode, this.outputHasError = false, this.devicesLoading = false, this.devicesError, final  List<DeviceInfo> devices = const [], this.selectedSerial, this.isScanningLan = false, this.scanError, final  List<String> discoveredHosts = const [], final  List<CommandSpec> commandSpecs = kDefaultCommands, final  List<String> recentCommands = const [], final  List<String> savedConnectIps = const [], this.searchVisible = false, this.searchQuery = '', this.searchRegex = false, this.searchCaseSensitive = false, this.matchCount = 0, this.currentMatchIndex = -1, this.splitRatio = 0.48, this.historyVisible = false, final  List<CommandHistoryEntry> history = const []}): _suggestions = suggestions,_devices = devices,_discoveredHosts = discoveredHosts,_commandSpecs = commandSpecs,_recentCommands = recentCommands,_savedConnectIps = savedConnectIps,_history = history;
  

 final  List<CommandSpec> _suggestions;
@override@JsonKey() List<CommandSpec> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override@JsonKey() final  int selectedSuggestion;
@override@JsonKey() final  String output;
@override@JsonKey() final  bool isRunning;
@override final  int? exitCode;
@override@JsonKey() final  bool outputHasError;
@override@JsonKey() final  bool devicesLoading;
@override final  String? devicesError;
 final  List<DeviceInfo> _devices;
@override@JsonKey() List<DeviceInfo> get devices {
  if (_devices is EqualUnmodifiableListView) return _devices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_devices);
}

@override final  String? selectedSerial;
@override@JsonKey() final  bool isScanningLan;
@override final  String? scanError;
 final  List<String> _discoveredHosts;
@override@JsonKey() List<String> get discoveredHosts {
  if (_discoveredHosts is EqualUnmodifiableListView) return _discoveredHosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveredHosts);
}

 final  List<CommandSpec> _commandSpecs;
@override@JsonKey() List<CommandSpec> get commandSpecs {
  if (_commandSpecs is EqualUnmodifiableListView) return _commandSpecs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_commandSpecs);
}

 final  List<String> _recentCommands;
@override@JsonKey() List<String> get recentCommands {
  if (_recentCommands is EqualUnmodifiableListView) return _recentCommands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentCommands);
}

 final  List<String> _savedConnectIps;
@override@JsonKey() List<String> get savedConnectIps {
  if (_savedConnectIps is EqualUnmodifiableListView) return _savedConnectIps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_savedConnectIps);
}

@override@JsonKey() final  bool searchVisible;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  bool searchRegex;
@override@JsonKey() final  bool searchCaseSensitive;
@override@JsonKey() final  int matchCount;
@override@JsonKey() final  int currentMatchIndex;
@override@JsonKey() final  double splitRatio;
@override@JsonKey() final  bool historyVisible;
 final  List<CommandHistoryEntry> _history;
@override@JsonKey() List<CommandHistoryEntry> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.selectedSuggestion, selectedSuggestion) || other.selectedSuggestion == selectedSuggestion)&&(identical(other.output, output) || other.output == output)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.exitCode, exitCode) || other.exitCode == exitCode)&&(identical(other.outputHasError, outputHasError) || other.outputHasError == outputHasError)&&(identical(other.devicesLoading, devicesLoading) || other.devicesLoading == devicesLoading)&&(identical(other.devicesError, devicesError) || other.devicesError == devicesError)&&const DeepCollectionEquality().equals(other._devices, _devices)&&(identical(other.selectedSerial, selectedSerial) || other.selectedSerial == selectedSerial)&&(identical(other.isScanningLan, isScanningLan) || other.isScanningLan == isScanningLan)&&(identical(other.scanError, scanError) || other.scanError == scanError)&&const DeepCollectionEquality().equals(other._discoveredHosts, _discoveredHosts)&&const DeepCollectionEquality().equals(other._commandSpecs, _commandSpecs)&&const DeepCollectionEquality().equals(other._recentCommands, _recentCommands)&&const DeepCollectionEquality().equals(other._savedConnectIps, _savedConnectIps)&&(identical(other.searchVisible, searchVisible) || other.searchVisible == searchVisible)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.searchRegex, searchRegex) || other.searchRegex == searchRegex)&&(identical(other.searchCaseSensitive, searchCaseSensitive) || other.searchCaseSensitive == searchCaseSensitive)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount)&&(identical(other.currentMatchIndex, currentMatchIndex) || other.currentMatchIndex == currentMatchIndex)&&(identical(other.splitRatio, splitRatio) || other.splitRatio == splitRatio)&&(identical(other.historyVisible, historyVisible) || other.historyVisible == historyVisible)&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_suggestions),selectedSuggestion,output,isRunning,exitCode,outputHasError,devicesLoading,devicesError,const DeepCollectionEquality().hash(_devices),selectedSerial,isScanningLan,scanError,const DeepCollectionEquality().hash(_discoveredHosts),const DeepCollectionEquality().hash(_commandSpecs),const DeepCollectionEquality().hash(_recentCommands),const DeepCollectionEquality().hash(_savedConnectIps),searchVisible,searchQuery,searchRegex,searchCaseSensitive,matchCount,currentMatchIndex,splitRatio,historyVisible,const DeepCollectionEquality().hash(_history)]);

@override
String toString() {
  return 'AppState(suggestions: $suggestions, selectedSuggestion: $selectedSuggestion, output: $output, isRunning: $isRunning, exitCode: $exitCode, outputHasError: $outputHasError, devicesLoading: $devicesLoading, devicesError: $devicesError, devices: $devices, selectedSerial: $selectedSerial, isScanningLan: $isScanningLan, scanError: $scanError, discoveredHosts: $discoveredHosts, commandSpecs: $commandSpecs, recentCommands: $recentCommands, savedConnectIps: $savedConnectIps, searchVisible: $searchVisible, searchQuery: $searchQuery, searchRegex: $searchRegex, searchCaseSensitive: $searchCaseSensitive, matchCount: $matchCount, currentMatchIndex: $currentMatchIndex, splitRatio: $splitRatio, historyVisible: $historyVisible, history: $history)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 List<CommandSpec> suggestions, int selectedSuggestion, String output, bool isRunning, int? exitCode, bool outputHasError, bool devicesLoading, String? devicesError, List<DeviceInfo> devices, String? selectedSerial, bool isScanningLan, String? scanError, List<String> discoveredHosts, List<CommandSpec> commandSpecs, List<String> recentCommands, List<String> savedConnectIps, bool searchVisible, String searchQuery, bool searchRegex, bool searchCaseSensitive, int matchCount, int currentMatchIndex, double splitRatio, bool historyVisible, List<CommandHistoryEntry> history
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestions = null,Object? selectedSuggestion = null,Object? output = null,Object? isRunning = null,Object? exitCode = freezed,Object? outputHasError = null,Object? devicesLoading = null,Object? devicesError = freezed,Object? devices = null,Object? selectedSerial = freezed,Object? isScanningLan = null,Object? scanError = freezed,Object? discoveredHosts = null,Object? commandSpecs = null,Object? recentCommands = null,Object? savedConnectIps = null,Object? searchVisible = null,Object? searchQuery = null,Object? searchRegex = null,Object? searchCaseSensitive = null,Object? matchCount = null,Object? currentMatchIndex = null,Object? splitRatio = null,Object? historyVisible = null,Object? history = null,}) {
  return _then(_AppState(
suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<CommandSpec>,selectedSuggestion: null == selectedSuggestion ? _self.selectedSuggestion : selectedSuggestion // ignore: cast_nullable_to_non_nullable
as int,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,exitCode: freezed == exitCode ? _self.exitCode : exitCode // ignore: cast_nullable_to_non_nullable
as int?,outputHasError: null == outputHasError ? _self.outputHasError : outputHasError // ignore: cast_nullable_to_non_nullable
as bool,devicesLoading: null == devicesLoading ? _self.devicesLoading : devicesLoading // ignore: cast_nullable_to_non_nullable
as bool,devicesError: freezed == devicesError ? _self.devicesError : devicesError // ignore: cast_nullable_to_non_nullable
as String?,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as List<DeviceInfo>,selectedSerial: freezed == selectedSerial ? _self.selectedSerial : selectedSerial // ignore: cast_nullable_to_non_nullable
as String?,isScanningLan: null == isScanningLan ? _self.isScanningLan : isScanningLan // ignore: cast_nullable_to_non_nullable
as bool,scanError: freezed == scanError ? _self.scanError : scanError // ignore: cast_nullable_to_non_nullable
as String?,discoveredHosts: null == discoveredHosts ? _self._discoveredHosts : discoveredHosts // ignore: cast_nullable_to_non_nullable
as List<String>,commandSpecs: null == commandSpecs ? _self._commandSpecs : commandSpecs // ignore: cast_nullable_to_non_nullable
as List<CommandSpec>,recentCommands: null == recentCommands ? _self._recentCommands : recentCommands // ignore: cast_nullable_to_non_nullable
as List<String>,savedConnectIps: null == savedConnectIps ? _self._savedConnectIps : savedConnectIps // ignore: cast_nullable_to_non_nullable
as List<String>,searchVisible: null == searchVisible ? _self.searchVisible : searchVisible // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,searchRegex: null == searchRegex ? _self.searchRegex : searchRegex // ignore: cast_nullable_to_non_nullable
as bool,searchCaseSensitive: null == searchCaseSensitive ? _self.searchCaseSensitive : searchCaseSensitive // ignore: cast_nullable_to_non_nullable
as bool,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,currentMatchIndex: null == currentMatchIndex ? _self.currentMatchIndex : currentMatchIndex // ignore: cast_nullable_to_non_nullable
as int,splitRatio: null == splitRatio ? _self.splitRatio : splitRatio // ignore: cast_nullable_to_non_nullable
as double,historyVisible: null == historyVisible ? _self.historyVisible : historyVisible // ignore: cast_nullable_to_non_nullable
as bool,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<CommandHistoryEntry>,
  ));
}


}

// dart format on
