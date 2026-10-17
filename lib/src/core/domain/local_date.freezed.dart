// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_date.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalDate {

 int get year; int get month; int get day;
/// Create a copy of LocalDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalDateCopyWith<LocalDate> get copyWith => _$LocalDateCopyWithImpl<LocalDate>(this as LocalDate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocalDate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalDate&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day));
}


@override
int get hashCode {
  final _this = this as LocalDate;
  return Object.hash(runtimeType,_this.year,_this.month,_this.day);
}

@override
String toString() {
  final _this = this as LocalDate;
  return 'LocalDate(year: ${_this.year}, month: ${_this.month}, day: ${_this.day})';
}


}

/// @nodoc
abstract mixin class $LocalDateCopyWith<$Res>  {
  factory $LocalDateCopyWith(LocalDate value, $Res Function(LocalDate) _then) = _$LocalDateCopyWithImpl;
@useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class _$LocalDateCopyWithImpl<$Res>
    implements $LocalDateCopyWith<$Res> {
  _$LocalDateCopyWithImpl(this._self, this._then);

  final LocalDate _self;
  final $Res Function(LocalDate) _then;

/// Create a copy of LocalDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(LocalDate(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalDate].
extension LocalDatePatterns on LocalDate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalDate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalDate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalDate value)  $default,){
final _that = this;
switch (_that) {
case _LocalDate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalDate value)?  $default,){
final _that = this;
switch (_that) {
case _LocalDate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  int day)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalDate() when $default != null:
return $default(_that.year,_that.month,_that.day);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  int day)  $default,) {final _that = this;
switch (_that) {
case _LocalDate():
return $default(_that.year,_that.month,_that.day);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  int day)?  $default,) {final _that = this;
switch (_that) {
case _LocalDate() when $default != null:
return $default(_that.year,_that.month,_that.day);case _:
  return null;

}
}

}

/// @nodoc


class _LocalDate extends LocalDate {
  const _LocalDate({required this.year, required this.month, required this.day}): super._();
  

@override final  int year;
@override final  int month;
@override final  int day;

/// Create a copy of LocalDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalDateCopyWith<_LocalDate> get copyWith => __$LocalDateCopyWithImpl<_LocalDate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalDate&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode {
    return Object.hash(runtimeType,year,month,day);
}

@override
String toString() {
    return 'LocalDate(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class _$LocalDateCopyWith<$Res> implements $LocalDateCopyWith<$Res> {
  factory _$LocalDateCopyWith(_LocalDate value, $Res Function(_LocalDate) _then) = __$LocalDateCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class __$LocalDateCopyWithImpl<$Res>
    implements _$LocalDateCopyWith<$Res> {
  __$LocalDateCopyWithImpl(this._self, this._then);

  final _LocalDate _self;
  final $Res Function(_LocalDate) _then;

/// Create a copy of LocalDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_LocalDate(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
