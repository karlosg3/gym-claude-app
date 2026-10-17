import 'package:clock/clock.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/database/transaction_runner.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/core/events/app_event.dart';
import 'package:gym_claude/src/core/events/app_event_bus.dart';
import 'package:gym_claude/src/core/time/clock_provider.dart';
import 'package:gym_claude/src/features/exercises/application/exercises_service.dart';
import 'package:gym_claude/src/features/progress/application/progress_service.dart';
import 'package:gym_claude/src/features/progress/domain/personal_record_detector.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/features/workout/data/drift_workout_repository.dart';
import 'package:gym_claude/src/features/workout/data/workout_repository.dart';
import 'package:gym_claude/src/features/workout/domain/active_workout.dart';
import 'package:gym_claude/src/features/workout/domain/finish_outcome.dart';
import 'package:gym_claude/src/features/workout/domain/session_exercise.dart';
import 'package:gym_claude/src/features/workout/domain/workout_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_service.g.dart';

/// Ciclo de vida de la sesión (`07 - Reglas de Negocio` §6). Cada acción es una escritura inmediata.
class WorkoutService {
  const WorkoutService({
    required this.repository,
    required this.transactions,
    required this.clock,
    required this.events,
    required this.routines,
    required this.exercises,
    required this.progress,
    this.streakReader,
  });

  /// Título de una sesión iniciada desde una rutina.
  static String routineTitle(String routineName) => 'Día de $routineName';

  /// Título de una sesión sin rutina.
  static const freeTitle = 'Entrenamiento libre';

  static const _maxReps = 999;
  static const _maxWeightKg = 1000.0;

  final WorkoutRepository repository;
  final TransactionRunner transactions;
  final Clock clock;
  final AppEventBus events;
  final RoutinesService routines;
  final ExercisesService exercises;
  final ProgressService progress;

  /// Racha actual para `WorkoutCompleted`. La calcula `progress` (fase 4); sin él se emite 0.
  final Future<int> Function()? streakReader;

  Stream<WorkoutSession?> watchActive() => repository.watchActive();

  Stream<WorkoutSession?> watchSession(int id) => repository.watchSession(id);

  Future<WorkoutSession?> findActive() => repository.findActive();

  /// Inicia una sesión. Con [routineId] copia los ejercicios del día [day] (hoy por defecto);
  /// sin rutina, es un entrenamiento libre vacío.
  Future<int> start({int? routineId, Weekday? day}) async {
    if (await repository.findActive() != null) {
      throw const SessionAlreadyActiveException();
    }

    final routine = routineId == null
        ? null
        : await routines.findById(routineId);
    if (routineId != null && routine == null) {
      throw const DomainException('Rutina no encontrada');
    }

    final now = clock.now();
    final date = LocalDate.of(now);
    final weekday = day ?? date.weekday;

    final id = await transactions.run(() async {
      final sessionId = await repository.insertActiveSession(
        routineId: routine?.id,
        title: routine == null ? freeTitle : routineTitle(routine.name),
        accentGroup: routine?.accentGroup,
        date: date,
        startedAt: now,
      );
      if (routine != null) {
        await repository.copyRoutineDay(sessionId, routine.id, weekday);
      }
      return sessionId;
    });

    events.emit(AppEvent.workoutStarted(id));
    return id;
  }

  /// Añade un ejercicio extra al final de la sesión activa.
  Future<int> addExercise(int sessionId, int exerciseId) async {
    final session = await _requireActive();
    if (session.id != sessionId) throw const NoActiveSessionException();
    if (session.exercises.any((e) => e.exercise.id == exerciseId)) {
      throw const DomainException('Este ejercicio ya está en la sesión');
    }
    final exercise = await exercises.findById(exerciseId);
    if (exercise == null) {
      throw const DomainException('Ejercicio no encontrado');
    }
    return repository.addExercise(
      sessionId,
      exerciseId,
      isBodyweight: exercise.isBodyweight,
    );
  }

  /// Registra una serie. El valor se teclea en la unidad del ejercicio y se guarda en kg.
  Future<int> addSet(
    int sessionExerciseId, {
    required double value,
    required WeightUnit unit,
    required int reps,
  }) async {
    _validateReps(reps);
    final weight = _toWeight(value, unit);

    final session = await _requireActive();
    final sessionExercise = _findExercise(session, sessionExerciseId);

    final id = await repository.insertSet(
      sessionExerciseId,
      weight: weight,
      reps: reps,
      createdAt: clock.now(),
    );

    final previousMax = await progress.maxWeightBefore(
      sessionExercise.exercise.id,
      session.id,
    );
    final newSet = SetPerformance(weight: weight, reps: reps);
    if (PersonalRecordDetector.isFirstRecordInSession(
      newSet: newSet,
      earlierSets: sessionExercise.sets.map((s) => s.performance),
      previousMax: previousMax,
    )) {
      events.emit(
        AppEvent.personalRecordAchieved(
          exerciseId: sessionExercise.exercise.id,
          exerciseName: sessionExercise.exercise.name,
          weightKg: weight.value,
          reps: reps,
        ),
      );
    }
    return id;
  }

  /// Edita una serie ya registrada. Si cambia el peso, [unit] indica en qué se tecleó.
  Future<void> updateSet(
    int setId, {
    double? value,
    WeightUnit unit = WeightUnit.kg,
    int? reps,
  }) {
    if (reps != null) _validateReps(reps);
    final weight = value == null ? null : _toWeight(value, unit);
    return repository.updateSet(setId, weight: weight, reps: reps);
  }

  /// Borra una serie y renumera las posteriores.
  Future<void> deleteSet(int setId) => repository.deleteSet(setId);

  Future<void> setNote(int sessionExerciseId, String note) =>
      repository.setNote(sessionExerciseId, note);

  /// Finaliza la sesión activa. Sin series se descarta.
  Future<FinishOutcome> finish({DateTime? endedAt}) async {
    final session = await _requireActive();
    if (session.totalSets == 0) {
      await repository.deleteSession(session.id);
      return const FinishDiscarded();
    }

    var end = endedAt ?? clock.now();
    if (end.isBefore(session.startedAt)) end = session.startedAt;

    final streakBefore = await streakReader?.call() ?? 0;
    await repository.complete(session.id, end);
    final streakAfter = await streakReader?.call() ?? 0;

    events.emit(
      AppEvent.workoutCompleted(
        session.id,
        streakBefore: streakBefore,
        streakAfter: streakAfter,
      ),
    );
    return FinishCompleted(session.id);
  }

  /// Finaliza una sesión olvidada con la hora de su última serie.
  Future<FinishOutcome> finishStale() async {
    final session = await _requireActive();
    return finish(endedAt: session.lastActivityAt);
  }

  /// Borra la sesión activa (la UI confirma antes si ya hay series).
  Future<void> discard() async {
    final session = await repository.findActive();
    if (session == null) return;
    await repository.deleteSession(session.id);
  }

  /// Borra cualquier sesión (usado por historial).
  Future<void> deleteSession(int sessionId) =>
      repository.deleteSession(sessionId);

  Future<WorkoutSession> _requireActive() async {
    final session = await repository.findActive();
    if (session == null) throw const NoActiveSessionException();
    return session;
  }

  SessionExercise _findExercise(WorkoutSession session, int sessionExerciseId) {
    for (final e in session.exercises) {
      if (e.id == sessionExerciseId) return e;
    }
    throw const NoActiveSessionException();
  }

  void _validateReps(int reps) {
    if (reps < 1 || reps > _maxReps) throw const InvalidRepsException();
  }

  Weight _toWeight(double value, WeightUnit unit) {
    if (value.isNaN || value < 0) throw const InvalidWeightException();
    final weight = Weight.fromInput(value, unit);
    if (weight.value >= _maxWeightKg) throw const InvalidWeightException();
    return weight;
  }
}

@Riverpod(keepAlive: true)
WorkoutService workoutService(Ref ref) {
  return WorkoutService(
    repository: ref.watch(workoutRepositoryProvider),
    transactions: ref.watch(transactionRunnerProvider),
    clock: ref.watch(clockProvider),
    events: ref.watch(appEventBusProvider),
    routines: ref.watch(routinesServiceProvider),
    exercises: ref.watch(exercisesServiceProvider),
    progress: ref.watch(progressServiceProvider),
  );
}

/// Sesión activa (o `null`). La observan Inicio, la pantalla de sesión y el router.
@Riverpod(keepAlive: true)
Stream<WorkoutSession?> activeSession(Ref ref) {
  return ref.watch(workoutServiceProvider).watchActive();
}

/// Ids de ejercicio de la sesión activa como clave estable ("3,7,12"): solo cambia
/// al añadir ejercicios, no en cada serie.
@Riverpod(keepAlive: true)
String activeSessionExerciseKey(Ref ref) {
  final ids = ref
      .watch(activeSessionProvider)
      .value
      ?.exercises
      .map((e) => e.exercise.id)
      .toList();
  return ids == null ? '' : (ids..sort()).join(',');
}

/// "Peso anterior" de los ejercicios de la sesión activa.
@Riverpod(keepAlive: true)
Stream<Map<int, SetPerformance>> activeSessionPreviousBest(Ref ref) {
  final key = ref.watch(activeSessionExerciseKeyProvider);
  final ids = key.isEmpty ? <int>{} : key.split(',').map(int.parse).toSet();
  return ref.watch(progressServiceProvider).watchLastBest(ids);
}

/// Read model de la pantalla de sesión: sesión activa + peso anterior por ejercicio.
@Riverpod(keepAlive: true)
AsyncValue<ActiveWorkout?> activeWorkout(Ref ref) {
  final sessionAsync = ref.watch(activeSessionProvider);
  final previous = ref.watch(activeSessionPreviousBestProvider).value;
  return switch (sessionAsync) {
    AsyncData(:final value) => AsyncData(
      value == null
          ? null
          : ActiveWorkout(session: value, previousBest: previous ?? const {}),
    ),
    AsyncError(:final error, :final stackTrace) => AsyncError(
      error,
      stackTrace,
    ),
    _ => const AsyncLoading(),
  };
}

/// Sesión por id (resumen, historial).
@riverpod
Stream<WorkoutSession?> workoutSession(Ref ref, int id) {
  return ref.watch(workoutServiceProvider).watchSession(id);
}

/// Ids de ejercicio de la sesión [id] cuya mejor serie es récord personal (insignia "PR").
@riverpod
Future<Set<int>> sessionRecords(Ref ref, int id) async {
  final session = await ref.watch(workoutSessionProvider(id).future);
  if (session == null) return const {};
  final progress = ref.watch(progressServiceProvider);
  final records = <int>{};
  for (final e in session.exercises) {
    final best = e.bestSet;
    if (best == null) continue;
    final previousMax = await progress.maxWeightBefore(e.exercise.id, id);
    if (PersonalRecordDetector.isRecord(best, previousMax)) {
      records.add(e.exercise.id);
    }
  }
  return records;
}
