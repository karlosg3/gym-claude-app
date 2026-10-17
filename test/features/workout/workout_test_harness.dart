import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/database/transaction_runner.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/events/app_event.dart';
import 'package:gym_claude/src/core/events/app_event_bus.dart';
import 'package:gym_claude/src/features/exercises/application/exercises_service.dart';
import 'package:gym_claude/src/features/exercises/data/drift_exercises_repository.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/progress/application/progress_service.dart';
import 'package:gym_claude/src/features/progress/data/drift_progress_repository.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/features/routines/data/drift_routines_repository.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/routines/domain/routine_draft.dart';
import 'package:gym_claude/src/features/workout/application/workout_service.dart';
import 'package:gym_claude/src/features/workout/data/drift_workout_repository.dart';

/// Servicios reales sobre Drift en memoria con un reloj controlable.
/// Fecha de demostración: lunes 22-jun-2026 (`12 - Testing y Calidad`).
class WorkoutTestHarness {
  WorkoutTestHarness._(this.db);

  final AppDatabase db;
  DateTime now = DateTime(2026, 6, 22, 18);
  final events = <AppEvent>[];

  late final AppEventBus bus;
  late final ProgressService progress;
  late final ExercisesService exercises;
  late final RoutinesService routines;
  late final WorkoutService workout;
  late final List<Exercise> library;

  static Future<WorkoutTestHarness> create() async {
    final h = WorkoutTestHarness._(AppDatabase(NativeDatabase.memory()));
    final clock = Clock(() => h.now);
    h.bus = AppEventBus()..stream.listen(h.events.add);
    h.progress = ProgressService(DriftProgressRepository(h.db.progressDao));
    h.exercises = ExercisesService(
      repository: DriftExercisesRepository(h.db.exercisesDao),
      clock: clock,
      hasHistoryChecker: h.progress.exerciseHasHistory,
    );
    h.routines = RoutinesService(DriftRoutinesRepository(h.db.routinesDao));
    h.workout = WorkoutService(
      repository: DriftWorkoutRepository(h.db.workoutDao),
      transactions: DriftTransactionRunner(h.db),
      clock: clock,
      events: h.bus,
      routines: h.routines,
      exercises: h.exercises,
      progress: h.progress,
    );
    h.library = await h.exercises.watchLibrary().first;
    return h;
  }

  Exercise exercise(String name) => library.firstWhere((e) => e.name == name);

  /// Rutina "Empuje" con Press de banca 4×8 y Fondos 3×máx el lunes.
  Future<int> createPushRoutine() async {
    final id = await routines.create(
      const RoutineDraft(name: 'Empuje', activeDays: {Weekday.monday}),
    );
    await routines.addExercise(
      id,
      Weekday.monday,
      exercise('Press de banca').id,
      const RepScheme(sets: 4, reps: 8),
    );
    await routines.addExercise(
      id,
      Weekday.monday,
      exercise('Fondos en paralelas').id,
      const RepScheme(sets: 3),
    );
    return id;
  }

  /// Deja que el bus entregue los eventos emitidos.
  Future<void> flush() => Future<void>.delayed(Duration.zero);

  Future<void> dispose() async {
    bus.dispose();
    await db.close();
  }
}
