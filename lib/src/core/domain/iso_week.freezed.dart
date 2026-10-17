// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iso_week.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IsoWeek {

 int get weekYear; int get weekNumber;
/// Create a copy of IsoWeek
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IsoWeekCopyWith<IsoWeek> get copyWith => _$IsoWeekCopyWithImpl<IsoWeek>(this as IsoWeek, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as IsoWeek;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IsoWeek&&(identical(other.weekYear, _this.weekYear) || other.weekYear == _this.weekYear)&&(identical(other.weekNumber, _this.weekNumber) || other.weekNumber == _this.weekNumber));
}


@override
int get hashCode {
  final _this = this as IsoWeek;
  return Object.hash(runtimeType,_this.weekYear,_this.weekNumber);
}

@override
String toString() {
  final _this = this as IsoWeek;
  return 'IsoWeek(weekYear: ${_this.weekYear}, weekNumber: ${_this.weekNumber})';
}


}

/// @nodoc
abstract mixin class $IsoWeekCopyWith<$Res>  {
  factory $IsoWeekCopyWith(IsoWeek value, $Res Function(IsoWeek) _then) = _$IsoWeekCopyWithImpl;
@useResult
$Res call({
 int weekYear, int weekNumber
});




}
/// @nodoc
class _$IsoWeekCopyWithImpl<$Res>
    implements $IsoWeekCopyWith<$Res> {
  _$IsoWeekCopyWithImpl(this._self, this._then);

  final IsoWeek _self;
  final $Res Function(IsoWeek) _then;

/// Create a copy of IsoWeek
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekYear = null,Object? weekNumber = null,}) {
  return _then(IsoWeek(
weekYear: null == weekYear ? _self.weekYear : weekYear // ignore: cast_nullable_to_non_nullable
as int,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [IsoWeek].
extension IsoWeekPatterns on IsoWeek {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IsoWeek value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IsoWeek() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IsoWeek value)  $default,){
final _that = this;
switch (_that) {
case _IsoWeek():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IsoWeek value)?  $default,){
final _that = this;
switch (_that) {
case _IsoWeek() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekYear,  int weekNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IsoWeek() when $default != null:
return $default(_that.weekYear,_that.weekNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekYear,  int weekNumber)  $default,) {final _that = this;
switch (_that) {
case _IsoWeek():
return $default(_that.weekYear,_that.weekNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekYear,  int weekNumber)?  $default,) {final _that = this;
switch (_that) {
case _IsoWeek() when $default != null:
return $default(_that.weekYear,_that.weekNumber);case _:
  return null;

}
}

}

/// @nodoc


class _IsoWeek extends IsoWeek {
  const _IsoWeek({required this.weekYear, required this.weekNumber}): super._();
  

@override final  int weekYear;
@override final  int weekNumber;

/// Create a copy of IsoWeek
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IsoWeekCopyWith<_IsoWeek> get copyWith => __$IsoWeekCopyWithImpl<_IsoWeek>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IsoWeek&&(identical(other.weekYear, weekYear) || other.weekYear == weekYear)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber));
}


@override
int get hashCode {
    return Object.hash(runtimeType,weekYear,weekNumber);
}

@override
String toString() {
    return 'IsoWeek(weekYear: $weekYear, weekNumber: $weekNumber)';
}


}

/// @nodoc
abstract mixin class _$IsoWeekCopyWith<$Res> implements $IsoWeekCopyWith<$Res> {
  factory _$IsoWeekCopyWith(_IsoWeek value, $Res Function(_IsoWeek) _then) = __$IsoWeekCopyWithImpl;
@override @useResult
$Res call({
 int weekYear, int weekNumber
});




}
/// @nodoc
class __$IsoWeekCopyWithImpl<$Res>
    implements _$IsoWeekCopyWith<$Res> {
  __$IsoWeekCopyWithImpl(this._self, this._then);

  final _IsoWeek _self;
  final $Res Function(_IsoWeek) _then;

/// Create a copy of IsoWeek
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekYear = null,Object? weekNumber = null,}) {
  return _then(_IsoWeek(
weekYear: null == weekYear ? _self.weekYear : weekYear // ignore: cast_nullable_to_non_nullable
as int,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
