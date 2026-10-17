import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/features/workout/domain/workout_session.dart';

/// Contrato de persistencia de sesiones, ejercicios de sesión y series.
abstract interface class WorkoutRepository {
  /// Observa la sesión activa completa (o `null` si no hay).
  Stream<WorkoutSession?> watchActive();

  /// Observa una sesión completa por id.
  Stream<WorkoutSession?> watchSession(int id);

  Future<WorkoutSession?> findActive();

  Future<WorkoutSession?> findSession(int id);

  /// Inserta una sesión activa vacía y devuelve su id.
  Future<int> insertActiveSession({
    int? routineId,
    required String title,
    MuscleGroup? accentGroup,
    required LocalDate date,
    required DateTime startedAt,
  });

  /// Copia los items de un día de la rutina como ejercicios de la sesión.
  Future<void> copyRoutineDay(int sessionId, int routineId, Weekday day);

  /// Añade un ejercicio al final de la sesión y devuelve el id del ejercicio de sesión.
  Future<int> addExercise(
    int sessionId,
    int exerciseId, {
    required bool isBodyweight,
  });

  /// Inserta una serie con el siguiente número correlativo.
  Future<int> insertSet(
    int sessionExerciseId, {
    required Weight weight,
    required int reps,
    required DateTime createdAt,
  });

  Future<void> updateSet(int setId, {Weight? weight, int? reps});

  /// Borra una serie y renumera las posteriores en la misma transacción.
  Future<void> deleteSet(int setId);

  Future<void> setNote(int sessionExerciseId, String note);

  /// Marca la sesión como completada en [endedAt].
  Future<void> complete(int sessionId, DateTime endedAt);

  Future<void> deleteSession(int sessionId);
}
