import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.freezed.dart';

/// Eventos de dominio emitidos para notificar momentos puntuales (no para transportar estado permanente).
@freezed
sealed class AppEvent with _$AppEvent {
  const factory AppEvent.workoutStarted(int sessionId) = WorkoutStarted;

  const factory AppEvent.workoutCompleted(
    int sessionId, {
    required int streakBefore,
    required int streakAfter,
  }) = WorkoutCompleted;

  const factory AppEvent.personalRecordAchieved({
    required int exerciseId,
    required String exerciseName,
    required double weightKg,
    required int reps,
  }) = PersonalRecordAchieved;

  const factory AppEvent.dataWiped() = DataWiped;
}
