import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/features/workout/application/workout_service.dart';
import 'package:gym_claude/src/features/workout/domain/finish_outcome.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_workout_controller.g.dart';

/// Acciones de la sesión activa. Valida la forma de la entrada y delega en [WorkoutService];
/// los errores quedan en `state` como `AsyncError`.
@riverpod
class ActiveWorkoutController extends _$ActiveWorkoutController {
  @override
  FutureOr<void> build() {}

  WorkoutService get _service => ref.read(workoutServiceProvider);

  /// Inicia una sesión. `false` si falla (p. ej. ya hay una activa: ver `state.error`).
  Future<bool> start({int? routineId, Weekday? day}) async =>
      await _run(() => _service.start(routineId: routineId, day: day)) != null;

  /// Registra una serie a partir del texto de los campos. Peso vacío = 0.
  Future<bool> addSet(
    int sessionExerciseId, {
    required String weightText,
    required String repsText,
    required WeightUnit unit,
  }) async {
    final id = await _run(() {
      final weight = parseWeight(weightText);
      final reps = parseReps(repsText);
      return _service.addSet(
        sessionExerciseId,
        value: weight,
        unit: unit,
        reps: reps,
      );
    });
    return id != null;
  }

  Future<bool> updateSet(
    int setId, {
    required String weightText,
    required String repsText,
    required WeightUnit unit,
  }) async {
    final done = await _run(() async {
      await _service.updateSet(
        setId,
        value: parseWeight(weightText),
        unit: unit,
        reps: parseReps(repsText),
      );
      return true;
    });
    return done ?? false;
  }

  Future<void> deleteSet(int setId) => _run(() => _service.deleteSet(setId));

  Future<void> setNote(int sessionExerciseId, String note) =>
      _run(() => _service.setNote(sessionExerciseId, note));

  Future<bool> addExercise(int sessionId, int exerciseId) async =>
      await _run(() => _service.addExercise(sessionId, exerciseId)) != null;

  Future<FinishOutcome?> finish() => _run(_service.finish);

  Future<FinishOutcome?> finishStale() => _run(_service.finishStale);

  Future<void> discard() => _run(_service.discard);

  /// Acepta coma o punto decimal. Vacío = 0 (peso corporal o barra sin discos).
  static double parseWeight(String text) {
    final normalized = text.trim().replaceAll(',', '.');
    if (normalized.isEmpty) return 0;
    final value = double.tryParse(normalized);
    if (value == null) throw const InvalidWeightException();
    return value;
  }

  static int parseReps(String text) {
    final value = int.tryParse(text.trim());
    if (value == null) throw const InvalidRepsException();
    return value;
  }

  Future<T?> _run<T>(Future<T> Function() action) async {
    state = const AsyncLoading();
    T? result;
    final next = await AsyncValue.guard(() async {
      result = await action();
    });
    if (ref.mounted) state = next;
    return next.hasError ? null : result;
  }
}

/// Índice del ejercicio visible (estado de UI). `null` = colocarse en el primero sin series.
@riverpod
class CurrentExerciseIndex extends _$CurrentExerciseIndex {
  @override
  int? build() => null;

  void set(int index) => state = index;
}
