// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseFilter {

 MuscleGroup? get group; String get query;
/// Create a copy of ExerciseFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseFilterCopyWith<ExerciseFilter> get copyWith => _$ExerciseFilterCopyWithImpl<ExerciseFilter>(this as ExerciseFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExerciseFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseFilter&&(identical(other.group, _this.group) || other.group == _this.group)&&(identical(other.query, _this.query) || other.query == _this.query));
}


@override
int get hashCode {
  final _this = this as ExerciseFilter;
  return Object.hash(runtimeType,_this.group,_this.query);
}

@override
String toString() {
  final _this = this as ExerciseFilter;
  return 'ExerciseFilter(group: ${_this.group}, query: ${_this.query})';
}


}

/// @nodoc
abstract mixin class $ExerciseFilterCopyWith<$Res>  {
  factory $ExerciseFilterCopyWith(ExerciseFilter value, $Res Function(ExerciseFilter) _then) = _$ExerciseFilterCopyWithImpl;
@useResult
$Res call({
 MuscleGroup? group, String query
});




}
/// @nodoc
class _$ExerciseFilterCopyWithImpl<$Res>
    implements $ExerciseFilterCopyWith<$Res> {
  _$ExerciseFilterCopyWithImpl(this._self, this._then);

  final ExerciseFilter _self;
  final $Res Function(ExerciseFilter) _then;

/// Create a copy of ExerciseFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? group = freezed,Object? query = null,}) {
  return _then(ExerciseFilter(
group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as MuscleGroup?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseFilter].
extension ExerciseFilterPatterns on ExerciseFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseFilter value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseFilter value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MuscleGroup? group,  String query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseFilter() when $default != null:
return $default(_that.group,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MuscleGroup? group,  String query)  $default,) {final _that = this;
switch (_that) {
case _ExerciseFilter():
return $default(_that.group,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MuscleGroup? group,  String query)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseFilter() when $default != null:
return $default(_that.group,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseFilter implements ExerciseFilter {
  const _ExerciseFilter({this.group, this.query = ''});
  

@override final  MuscleGroup? group;
@override@JsonKey() final  String query;

/// Create a copy of ExerciseFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseFilterCopyWith<_ExerciseFilter> get copyWith => __$ExerciseFilterCopyWithImpl<_ExerciseFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseFilter&&(identical(other.group, group) || other.group == group)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,group,query);
}

@override
String toString() {
    return 'ExerciseFilter(group: $group, query: $query)';
}


}

/// @nodoc
abstract mixin class _$ExerciseFilterCopyWith<$Res> implements $ExerciseFilterCopyWith<$Res> {
  factory _$ExerciseFilterCopyWith(_ExerciseFilter value, $Res Function(_ExerciseFilter) _then) = __$ExerciseFilterCopyWithImpl;
@override @useResult
$Res call({
 MuscleGroup? group, String query
});




}
/// @nodoc
class __$ExerciseFilterCopyWithImpl<$Res>
    implements _$ExerciseFilterCopyWith<$Res> {
  __$ExerciseFilterCopyWithImpl(this._self, this._then);

  final _ExerciseFilter _self;
  final $Res Function(_ExerciseFilter) _then;

/// Create a copy of ExerciseFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? group = freezed,Object? query = null,}) {
  return _then(_ExerciseFilter(
group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as MuscleGroup?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
