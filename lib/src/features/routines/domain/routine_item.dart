import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/features/routines/domain/exercise_ref.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:meta/meta.dart';

/// Ejercicio asignado a un día específico dentro de una rutina con su posición y esquema.
@immutable
class RoutineItem {
  const RoutineItem({
    required this.id,
    required this.routineId,
    required this.weekday,
    required this.position,
    required this.exercise,
    required this.scheme,
  });

  final int id;
  final int routineId;
  final Weekday weekday;
  final int position;
  final ExerciseRef exercise;
  final RepScheme scheme;

  RoutineItem copyWith({
    int? id,
    int? routineId,
    Weekday? weekday,
    int? position,
    ExerciseRef? exercise,
    RepScheme? scheme,
  }) {
    return RoutineItem(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      weekday: weekday ?? this.weekday,
      position: position ?? this.position,
      exercise: exercise ?? this.exercise,
      scheme: scheme ?? this.scheme,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          routineId == other.routineId &&
          weekday == other.weekday &&
          position == other.position &&
          exercise == other.exercise &&
          scheme == other.scheme;

  @override
  int get hashCode =>
      Object.hash(id, routineId, weekday, position, exercise, scheme);

  @override
  String toString() =>
      'RoutineItem(id: $id, routineId: $routineId, weekday: $weekday, position: $position, exercise: ${exercise.name}, scheme: $scheme)';
}
