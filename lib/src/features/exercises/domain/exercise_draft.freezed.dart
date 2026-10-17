// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseDraft {

 String get name; MuscleGroup get muscleGroup; WeightUnit get unit; bool get isBodyweight; String get description;
/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseDraftCopyWith<ExerciseDraft> get copyWith => _$ExerciseDraftCopyWithImpl<ExerciseDraft>(this as ExerciseDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExerciseDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseDraft&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.muscleGroup, _this.muscleGroup) || other.muscleGroup == _this.muscleGroup)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.isBodyweight, _this.isBodyweight) || other.isBodyweight == _this.isBodyweight)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as ExerciseDraft;
  return Object.hash(runtimeType,_this.name,_this.muscleGroup,_this.unit,_this.isBodyweight,_this.description);
}

@override
String toString() {
  final _this = this as ExerciseDraft;
  return 'ExerciseDraft(name: ${_this.name}, muscleGroup: ${_this.muscleGroup}, unit: ${_this.unit}, isBodyweight: ${_this.isBodyweight}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $ExerciseDraftCopyWith<$Res>  {
  factory $ExerciseDraftCopyWith(ExerciseDraft value, $Res Function(ExerciseDraft) _then) = _$ExerciseDraftCopyWithImpl;
@useResult
$Res call({
 String name, MuscleGroup muscleGroup, WeightUnit unit, bool isBodyweight, String description
});




}
/// @nodoc
class _$ExerciseDraftCopyWithImpl<$Res>
    implements $ExerciseDraftCopyWith<$Res> {
  _$ExerciseDraftCopyWithImpl(this._self, this._then);

  final ExerciseDraft _self;
  final $Res Function(ExerciseDraft) _then;

/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? muscleGroup = null,Object? unit = null,Object? isBodyweight = null,Object? description = null,}) {
  return _then(ExerciseDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as MuscleGroup,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as WeightUnit,isBodyweight: null == isBodyweight ? _self.isBodyweight : isBodyweight // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseDraft].
extension ExerciseDraftPatterns on ExerciseDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseDraft value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseDraft value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  MuscleGroup muscleGroup,  WeightUnit unit,  bool isBodyweight,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
return $default(_that.name,_that.muscleGroup,_that.unit,_that.isBodyweight,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  MuscleGroup muscleGroup,  WeightUnit unit,  bool isBodyweight,  String description)  $default,) {final _that = this;
switch (_that) {
case _ExerciseDraft():
return $default(_that.name,_that.muscleGroup,_that.unit,_that.isBodyweight,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  MuscleGroup muscleGroup,  WeightUnit unit,  bool isBodyweight,  String description)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
return $default(_that.name,_that.muscleGroup,_that.unit,_that.isBodyweight,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseDraft implements ExerciseDraft {
  const _ExerciseDraft({required this.name, required this.muscleGroup, required this.unit, this.isBodyweight = false, this.description = ''});
  

@override final  String name;
@override final  MuscleGroup muscleGroup;
@override final  WeightUnit unit;
@override@JsonKey() final  bool isBodyweight;
@override@JsonKey() final  String description;

/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseDraftCopyWith<_ExerciseDraft> get copyWith => __$ExerciseDraftCopyWithImpl<_ExerciseDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseDraft&&(identical(other.name, name) || other.name == name)&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.isBodyweight, isBodyweight) || other.isBodyweight == isBodyweight)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,muscleGroup,unit,isBodyweight,description);
}

@override
String toString() {
    return 'ExerciseDraft(name: $name, muscleGroup: $muscleGroup, unit: $unit, isBodyweight: $isBodyweight, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ExerciseDraftCopyWith<$Res> implements $ExerciseDraftCopyWith<$Res> {
  factory _$ExerciseDraftCopyWith(_ExerciseDraft value, $Res Function(_ExerciseDraft) _then) = __$ExerciseDraftCopyWithImpl;
@override @useResult
$Res call({
 String name, MuscleGroup muscleGroup, WeightUnit unit, bool isBodyweight, String description
});




}
/// @nodoc
class __$ExerciseDraftCopyWithImpl<$Res>
    implements _$ExerciseDraftCopyWith<$Res> {
  __$ExerciseDraftCopyWithImpl(this._self, this._then);

  final _ExerciseDraft _self;
  final $Res Function(_ExerciseDraft) _then;

/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? muscleGroup = null,Object? unit = null,Object? isBodyweight = null,Object? description = null,}) {
  return _then(_ExerciseDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as MuscleGroup,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as WeightUnit,isBodyweight: null == isBodyweight ? _self.isBodyweight : isBodyweight // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
