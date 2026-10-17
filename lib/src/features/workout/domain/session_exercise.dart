import 'package:gym_claude/src/features/progress/domain/personal_record_detector.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';
import 'package:gym_claude/src/features/routines/domain/exercise_ref.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/workout/domain/set_record.dart';
import 'package:meta/meta.dart';

/// Ejercicio dentro de una sesión, con el objetivo copiado al iniciar y sus series.
@immutable
class SessionExercise {
  const SessionExercise({
    required this.id,
    required this.position,
    required this.exercise,
    required this.isBodyweight,
    this.target,
    this.note = '',
    this.sets = const [],
  });

  final int id;
  final int position;
  final ExerciseRef exercise;

  /// Snapshot de `Exercise.isBodyweight` al iniciar.
  final bool isBodyweight;

  /// Snapshot del esquema de la rutina; `null` en ejercicios añadidos sobre la marcha.
  final RepScheme? target;
  final String note;
  final List<SetRecord> sets;

  bool get hasSets => sets.isNotEmpty;

  /// Mejor serie de la sesión (mayor peso; a igual peso, más reps).
  SetPerformance? get bestSet =>
      PersonalRecordDetector.best(sets.map((s) => s.performance));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionExercise &&
          id == other.id &&
          position == other.position &&
          exercise == other.exercise &&
          isBodyweight == other.isBodyweight &&
          target == other.target &&
          note == other.note &&
          _listEquals(sets, other.sets);

  @override
  int get hashCode => Object.hash(
    id,
    position,
    exercise,
    isBodyweight,
    target,
    note,
    Object.hashAll(sets),
  );

  @override
  String toString() =>
      'SessionExercise(id: $id, ${exercise.name}, sets: ${sets.length})';
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
