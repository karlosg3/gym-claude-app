// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 String get userName; int get weeklyGoal; WeightUnit get defaultUnit; AppAccentColor get themeColor; bool get workoutReminderEnabled; int get reminderMinutes; bool get streakRiskEnabled; bool get recordsEnabled;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.userName, _this.userName) || other.userName == _this.userName)&&(identical(other.weeklyGoal, _this.weeklyGoal) || other.weeklyGoal == _this.weeklyGoal)&&(identical(other.defaultUnit, _this.defaultUnit) || other.defaultUnit == _this.defaultUnit)&&(identical(other.themeColor, _this.themeColor) || other.themeColor == _this.themeColor)&&(identical(other.workoutReminderEnabled, _this.workoutReminderEnabled) || other.workoutReminderEnabled == _this.workoutReminderEnabled)&&(identical(other.reminderMinutes, _this.reminderMinutes) || other.reminderMinutes == _this.reminderMinutes)&&(identical(other.streakRiskEnabled, _this.streakRiskEnabled) || other.streakRiskEnabled == _this.streakRiskEnabled)&&(identical(other.recordsEnabled, _this.recordsEnabled) || other.recordsEnabled == _this.recordsEnabled));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.userName,_this.weeklyGoal,_this.defaultUnit,_this.themeColor,_this.workoutReminderEnabled,_this.reminderMinutes,_this.streakRiskEnabled,_this.recordsEnabled);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(userName: ${_this.userName}, weeklyGoal: ${_this.weeklyGoal}, defaultUnit: ${_this.defaultUnit}, themeColor: ${_this.themeColor}, workoutReminderEnabled: ${_this.workoutReminderEnabled}, reminderMinutes: ${_this.reminderMinutes}, streakRiskEnabled: ${_this.streakRiskEnabled}, recordsEnabled: ${_this.recordsEnabled})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 String userName, int weeklyGoal, WeightUnit defaultUnit, AppAccentColor themeColor, bool workoutReminderEnabled, int reminderMinutes, bool streakRiskEnabled, bool recordsEnabled
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = null,Object? weeklyGoal = null,Object? defaultUnit = null,Object? themeColor = null,Object? workoutReminderEnabled = null,Object? reminderMinutes = null,Object? streakRiskEnabled = null,Object? recordsEnabled = null,}) {
  return _then(AppSettings(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,weeklyGoal: null == weeklyGoal ? _self.weeklyGoal : weeklyGoal // ignore: cast_nullable_to_non_nullable
as int,defaultUnit: null == defaultUnit ? _self.defaultUnit : defaultUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as AppAccentColor,workoutReminderEnabled: null == workoutReminderEnabled ? _self.workoutReminderEnabled : workoutReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,streakRiskEnabled: null == streakRiskEnabled ? _self.streakRiskEnabled : streakRiskEnabled // ignore: cast_nullable_to_non_nullable
as bool,recordsEnabled: null == recordsEnabled ? _self.recordsEnabled : recordsEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userName,  int weeklyGoal,  WeightUnit defaultUnit,  AppAccentColor themeColor,  bool workoutReminderEnabled,  int reminderMinutes,  bool streakRiskEnabled,  bool recordsEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.userName,_that.weeklyGoal,_that.defaultUnit,_that.themeColor,_that.workoutReminderEnabled,_that.reminderMinutes,_that.streakRiskEnabled,_that.recordsEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userName,  int weeklyGoal,  WeightUnit defaultUnit,  AppAccentColor themeColor,  bool workoutReminderEnabled,  int reminderMinutes,  bool streakRiskEnabled,  bool recordsEnabled)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.userName,_that.weeklyGoal,_that.defaultUnit,_that.themeColor,_that.workoutReminderEnabled,_that.reminderMinutes,_that.streakRiskEnabled,_that.recordsEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userName,  int weeklyGoal,  WeightUnit defaultUnit,  AppAccentColor themeColor,  bool workoutReminderEnabled,  int reminderMinutes,  bool streakRiskEnabled,  bool recordsEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.userName,_that.weeklyGoal,_that.defaultUnit,_that.themeColor,_that.workoutReminderEnabled,_that.reminderMinutes,_that.streakRiskEnabled,_that.recordsEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings extends AppSettings {
  const _AppSettings({this.userName = '', this.weeklyGoal = 3, this.defaultUnit = WeightUnit.kg, this.themeColor = AppAccentColor.orange, this.workoutReminderEnabled = true, this.reminderMinutes = 1110, this.streakRiskEnabled = true, this.recordsEnabled = false}): super._();
  

@override@JsonKey() final  String userName;
@override@JsonKey() final  int weeklyGoal;
@override@JsonKey() final  WeightUnit defaultUnit;
@override@JsonKey() final  AppAccentColor themeColor;
@override@JsonKey() final  bool workoutReminderEnabled;
@override@JsonKey() final  int reminderMinutes;
@override@JsonKey() final  bool streakRiskEnabled;
@override@JsonKey() final  bool recordsEnabled;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.weeklyGoal, weeklyGoal) || other.weeklyGoal == weeklyGoal)&&(identical(other.defaultUnit, defaultUnit) || other.defaultUnit == defaultUnit)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.workoutReminderEnabled, workoutReminderEnabled) || other.workoutReminderEnabled == workoutReminderEnabled)&&(identical(other.reminderMinutes, reminderMinutes) || other.reminderMinutes == reminderMinutes)&&(identical(other.streakRiskEnabled, streakRiskEnabled) || other.streakRiskEnabled == streakRiskEnabled)&&(identical(other.recordsEnabled, recordsEnabled) || other.recordsEnabled == recordsEnabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,userName,weeklyGoal,defaultUnit,themeColor,workoutReminderEnabled,reminderMinutes,streakRiskEnabled,recordsEnabled);
}

@override
String toString() {
    return 'AppSettings(userName: $userName, weeklyGoal: $weeklyGoal, defaultUnit: $defaultUnit, themeColor: $themeColor, workoutReminderEnabled: $workoutReminderEnabled, reminderMinutes: $reminderMinutes, streakRiskEnabled: $streakRiskEnabled, recordsEnabled: $recordsEnabled)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 String userName, int weeklyGoal, WeightUnit defaultUnit, AppAccentColor themeColor, bool workoutReminderEnabled, int reminderMinutes, bool streakRiskEnabled, bool recordsEnabled
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = null,Object? weeklyGoal = null,Object? defaultUnit = null,Object? themeColor = null,Object? workoutReminderEnabled = null,Object? reminderMinutes = null,Object? streakRiskEnabled = null,Object? recordsEnabled = null,}) {
  return _then(_AppSettings(
userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,weeklyGoal: null == weeklyGoal ? _self.weeklyGoal : weeklyGoal // ignore: cast_nullable_to_non_nullable
as int,defaultUnit: null == defaultUnit ? _self.defaultUnit : defaultUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as AppAccentColor,workoutReminderEnabled: null == workoutReminderEnabled ? _self.workoutReminderEnabled : workoutReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,streakRiskEnabled: null == streakRiskEnabled ? _self.streakRiskEnabled : streakRiskEnabled // ignore: cast_nullable_to_non_nullable
as bool,recordsEnabled: null == recordsEnabled ? _self.recordsEnabled : recordsEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
