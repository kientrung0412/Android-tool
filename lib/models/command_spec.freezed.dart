// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'command_spec.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommandSpec {

 String get command; String get description; String? get params;
/// Create a copy of CommandSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommandSpecCopyWith<CommandSpec> get copyWith => _$CommandSpecCopyWithImpl<CommandSpec>(this as CommandSpec, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommandSpec&&(identical(other.command, command) || other.command == command)&&(identical(other.description, description) || other.description == description)&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,command,description,params);

@override
String toString() {
  return 'CommandSpec(command: $command, description: $description, params: $params)';
}


}

/// @nodoc
abstract mixin class $CommandSpecCopyWith<$Res>  {
  factory $CommandSpecCopyWith(CommandSpec value, $Res Function(CommandSpec) _then) = _$CommandSpecCopyWithImpl;
@useResult
$Res call({
 String command, String description, String? params
});




}
/// @nodoc
class _$CommandSpecCopyWithImpl<$Res>
    implements $CommandSpecCopyWith<$Res> {
  _$CommandSpecCopyWithImpl(this._self, this._then);

  final CommandSpec _self;
  final $Res Function(CommandSpec) _then;

/// Create a copy of CommandSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? command = null,Object? description = null,Object? params = freezed,}) {
  return _then(_self.copyWith(
command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommandSpec].
extension CommandSpecPatterns on CommandSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommandSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommandSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommandSpec value)  $default,){
final _that = this;
switch (_that) {
case _CommandSpec():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommandSpec value)?  $default,){
final _that = this;
switch (_that) {
case _CommandSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String command,  String description,  String? params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommandSpec() when $default != null:
return $default(_that.command,_that.description,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String command,  String description,  String? params)  $default,) {final _that = this;
switch (_that) {
case _CommandSpec():
return $default(_that.command,_that.description,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String command,  String description,  String? params)?  $default,) {final _that = this;
switch (_that) {
case _CommandSpec() when $default != null:
return $default(_that.command,_that.description,_that.params);case _:
  return null;

}
}

}

/// @nodoc


class _CommandSpec extends CommandSpec {
  const _CommandSpec(this.command, this.description, [this.params]): super._();
  

@override final  String command;
@override final  String description;
@override final  String? params;

/// Create a copy of CommandSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommandSpecCopyWith<_CommandSpec> get copyWith => __$CommandSpecCopyWithImpl<_CommandSpec>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommandSpec&&(identical(other.command, command) || other.command == command)&&(identical(other.description, description) || other.description == description)&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,command,description,params);

@override
String toString() {
  return 'CommandSpec(command: $command, description: $description, params: $params)';
}


}

/// @nodoc
abstract mixin class _$CommandSpecCopyWith<$Res> implements $CommandSpecCopyWith<$Res> {
  factory _$CommandSpecCopyWith(_CommandSpec value, $Res Function(_CommandSpec) _then) = __$CommandSpecCopyWithImpl;
@override @useResult
$Res call({
 String command, String description, String? params
});




}
/// @nodoc
class __$CommandSpecCopyWithImpl<$Res>
    implements _$CommandSpecCopyWith<$Res> {
  __$CommandSpecCopyWithImpl(this._self, this._then);

  final _CommandSpec _self;
  final $Res Function(_CommandSpec) _then;

/// Create a copy of CommandSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? command = null,Object? description = null,Object? params = freezed,}) {
  return _then(_CommandSpec(
null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
