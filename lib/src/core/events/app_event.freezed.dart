// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppEvent()';
}


}

/// @nodoc
class $AppEventCopyWith<$Res>  {
$AppEventCopyWith(AppEvent _, $Res Function(AppEvent) __);
}


/// Adds pattern-matching-related methods to [AppEvent].
extension AppEventPatterns on AppEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WorkoutStarted value)?  workoutStarted,TResult Function( WorkoutCompleted value)?  workoutCompleted,TResult Function( PersonalRecordAchieved value)?  personalRecordAchieved,TResult Function( DataWiped value)?  dataWiped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WorkoutStarted() when workoutStarted != null:
return workoutStarted(_that);case WorkoutCompleted() when workoutCompleted != null:
return workoutCompleted(_that);case PersonalRecordAchieved() when personalRecordAchieved != null:
return personalRecordAchieved(_that);case DataWiped() when dataWiped != null:
return dataWiped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WorkoutStarted value)  workoutStarted,required TResult Function( WorkoutCompleted value)  workoutCompleted,required TResult Function( PersonalRecordAchieved value)  personalRecordAchieved,required TResult Function( DataWiped value)  dataWiped,}){
final _that = this;
switch (_that) {
case WorkoutStarted():
return workoutStarted(_that);case WorkoutCompleted():
return workoutCompleted(_that);case PersonalRecordAchieved():
return personalRecordAchieved(_that);case DataWiped():
return dataWiped(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WorkoutStarted value)?  workoutStarted,TResult? Function( WorkoutCompleted value)?  workoutCompleted,TResult? Function( PersonalRecordAchieved value)?  personalRecordAchieved,TResult? Function( DataWiped value)?  dataWiped,}){
final _that = this;
switch (_that) {
case WorkoutStarted() when workoutStarted != null:
return workoutStarted(_that);case WorkoutCompleted() when workoutCompleted != null:
return workoutCompleted(_that);case PersonalRecordAchieved() when personalRecordAchieved != null:
return personalRecordAchieved(_that);case DataWiped() when dataWiped != null:
return dataWiped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int sessionId)?  workoutStarted,TResult Function( int sessionId,  int streakBefore,  int streakAfter)?  workoutCompleted,TResult Function( int exerciseId,  String exerciseName,  double weightKg,  int reps)?  personalRecordAchieved,TResult Function()?  dataWiped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WorkoutStarted() when workoutStarted != null:
return workoutStarted(_that.sessionId);case WorkoutCompleted() when workoutCompleted != null:
return workoutCompleted(_that.sessionId,_that.streakBefore,_that.streakAfter);case PersonalRecordAchieved() when personalRecordAchieved != null:
return personalRecordAchieved(_that.exerciseId,_that.exerciseName,_that.weightKg,_that.reps);case DataWiped() when dataWiped != null:
return dataWiped();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int sessionId)  workoutStarted,required TResult Function( int sessionId,  int streakBefore,  int streakAfter)  workoutCompleted,required TResult Function( int exerciseId,  String exerciseName,  double weightKg,  int reps)  personalRecordAchieved,required TResult Function()  dataWiped,}) {final _that = this;
switch (_that) {
case WorkoutStarted():
return workoutStarted(_that.sessionId);case WorkoutCompleted():
return workoutCompleted(_that.sessionId,_that.streakBefore,_that.streakAfter);case PersonalRecordAchieved():
return personalRecordAchieved(_that.exerciseId,_that.exerciseName,_that.weightKg,_that.reps);case DataWiped():
return dataWiped();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int sessionId)?  workoutStarted,TResult? Function( int sessionId,  int streakBefore,  int streakAfter)?  workoutCompleted,TResult? Function( int exerciseId,  String exerciseName,  double weightKg,  int reps)?  personalRecordAchieved,TResult? Function()?  dataWiped,}) {final _that = this;
switch (_that) {
case WorkoutStarted() when workoutStarted != null:
return workoutStarted(_that.sessionId);case WorkoutCompleted() when workoutCompleted != null:
return workoutCompleted(_that.sessionId,_that.streakBefore,_that.streakAfter);case PersonalRecordAchieved() when personalRecordAchieved != null:
return personalRecordAchieved(_that.exerciseId,_that.exerciseName,_that.weightKg,_that.reps);case DataWiped() when dataWiped != null:
return dataWiped();case _:
  return null;

}
}

}

/// @nodoc


class WorkoutStarted implements AppEvent {
  const WorkoutStarted(this.sessionId);
  

 final  int sessionId;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutStartedCopyWith<WorkoutStarted> get copyWith => _$WorkoutStartedCopyWithImpl<WorkoutStarted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutStarted&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sessionId);
}

@override
String toString() {
    return 'AppEvent.workoutStarted(sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $WorkoutStartedCopyWith<$Res> implements $AppEventCopyWith<$Res> {
  factory $WorkoutStartedCopyWith(WorkoutStarted value, $Res Function(WorkoutStarted) _then) = _$WorkoutStartedCopyWithImpl;
@useResult
$Res call({
 int sessionId
});




}
/// @nodoc
class _$WorkoutStartedCopyWithImpl<$Res>
    implements $WorkoutStartedCopyWith<$Res> {
  _$WorkoutStartedCopyWithImpl(this._self, this._then);

  final WorkoutStarted _self;
  final $Res Function(WorkoutStarted) _then;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,}) {
  return _then(WorkoutStarted(
null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class WorkoutCompleted implements AppEvent {
  const WorkoutCompleted(this.sessionId, {required this.streakBefore, required this.streakAfter});
  

 final  int sessionId;
 final  int streakBefore;
 final  int streakAfter;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutCompletedCopyWith<WorkoutCompleted> get copyWith => _$WorkoutCompletedCopyWithImpl<WorkoutCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutCompleted&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.streakBefore, streakBefore) || other.streakBefore == streakBefore)&&(identical(other.streakAfter, streakAfter) || other.streakAfter == streakAfter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,streakBefore,streakAfter);
}

@override
String toString() {
    return 'AppEvent.workoutCompleted(sessionId: $sessionId, streakBefore: $streakBefore, streakAfter: $streakAfter)';
}


}

/// @nodoc
abstract mixin class $WorkoutCompletedCopyWith<$Res> implements $AppEventCopyWith<$Res> {
  factory $WorkoutCompletedCopyWith(WorkoutCompleted value, $Res Function(WorkoutCompleted) _then) = _$WorkoutCompletedCopyWithImpl;
@useResult
$Res call({
 int sessionId, int streakBefore, int streakAfter
});




}
/// @nodoc
class _$WorkoutCompletedCopyWithImpl<$Res>
    implements $WorkoutCompletedCopyWith<$Res> {
  _$WorkoutCompletedCopyWithImpl(this._self, this._then);

  final WorkoutCompleted _self;
  final $Res Function(WorkoutCompleted) _then;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? streakBefore = null,Object? streakAfter = null,}) {
  return _then(WorkoutCompleted(
null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,streakBefore: null == streakBefore ? _self.streakBefore : streakBefore // ignore: cast_nullable_to_non_nullable
as int,streakAfter: null == streakAfter ? _self.streakAfter : streakAfter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PersonalRecordAchieved implements AppEvent {
  const PersonalRecordAchieved({required this.exerciseId, required this.exerciseName, required this.weightKg, required this.reps});
  

 final  int exerciseId;
 final  String exerciseName;
 final  double weightKg;
 final  int reps;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalRecordAchievedCopyWith<PersonalRecordAchieved> get copyWith => _$PersonalRecordAchievedCopyWithImpl<PersonalRecordAchieved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalRecordAchieved&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.reps, reps) || other.reps == reps));
}


@override
int get hashCode {
    return Object.hash(runtimeType,exerciseId,exerciseName,weightKg,reps);
}

@override
String toString() {
    return 'AppEvent.personalRecordAchieved(exerciseId: $exerciseId, exerciseName: $exerciseName, weightKg: $weightKg, reps: $reps)';
}


}

/// @nodoc
abstract mixin class $PersonalRecordAchievedCopyWith<$Res> implements $AppEventCopyWith<$Res> {
  factory $PersonalRecordAchievedCopyWith(PersonalRecordAchieved value, $Res Function(PersonalRecordAchieved) _then) = _$PersonalRecordAchievedCopyWithImpl;
@useResult
$Res call({
 int exerciseId, String exerciseName, double weightKg, int reps
});




}
/// @nodoc
class _$PersonalRecordAchievedCopyWithImpl<$Res>
    implements $PersonalRecordAchievedCopyWith<$Res> {
  _$PersonalRecordAchievedCopyWithImpl(this._self, this._then);

  final PersonalRecordAchieved _self;
  final $Res Function(PersonalRecordAchieved) _then;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseId = null,Object? exerciseName = null,Object? weightKg = null,Object? reps = null,}) {
  return _then(PersonalRecordAchieved(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as int,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class DataWiped implements AppEvent {
  const DataWiped();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DataWiped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppEvent.dataWiped()';
}


}




// dart format on
