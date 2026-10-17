import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart'
    hide WatchActiveTreeResult, WatchSessionTreeResult;
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/routines/domain/exercise_ref.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/workout/data/workout_dao.dart';
import 'package:gym_claude/src/features/workout/data/workout_repository.dart';
import 'package:gym_claude/src/features/workout/domain/session_exercise.dart';
import 'package:gym_claude/src/features/workout/domain/session_status.dart';
import 'package:gym_claude/src/features/workout/domain/set_record.dart';
import 'package:gym_claude/src/features/workout/domain/workout_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_workout_repository.g.dart';

/// Fila común de `watchSessionTree` y `watchActiveTree`.
typedef _TreeRow = ({
  WorkoutSessionRow ws,
  SessionExerciseRow? se,
  SetRecordRow? sr,
  String? exerciseName,
  MuscleGroup? exerciseGroup,
  WeightUnit? exerciseUnit,
});

class DriftWorkoutRepository implements WorkoutRepository {
  const DriftWorkoutRepository(this._dao);

  final WorkoutDao _dao;

  @override
  Stream<WorkoutSession?> watchActive() {
    return _dao.watchActiveTreeRows().map(
      (rows) => _buildTree(rows.map(_fromActive)),
    );
  }

  @override
  Stream<WorkoutSession?> watchSession(int id) {
    return _dao
        .watchTreeRows(id)
        .map((rows) => _buildTree(rows.map(_fromSession)));
  }

  @override
  Future<WorkoutSession?> findActive() async {
    final rows = await _dao.getActiveTreeRows();
    return _buildTree(rows.map(_fromActive));
  }

  @override
  Future<WorkoutSession?> findSession(int id) async {
    final rows = await _dao.getTreeRows(id);
    return _buildTree(rows.map(_fromSession));
  }

  @override
  Future<int> insertActiveSession({
    int? routineId,
    required String title,
    MuscleGroup? accentGroup,
    required LocalDate date,
    required DateTime startedAt,
  }) {
    return _dao.insertSessionRow(
      WorkoutSessionsCompanion.insert(
        routineId: Value(routineId),
        title: title,
        accentGroup: Value(accentGroup),
        localDate: date,
        startedAt: startedAt,
        status: SessionStatus.active,
      ),
    );
  }

  @override
  Future<void> copyRoutineDay(int sessionId, int routineId, Weekday day) {
    return _dao.copyRoutineDayRows(
      sessionId: sessionId,
      routineId: routineId,
      weekday: day.isoValue,
    );
  }

  @override
  Future<int> addExercise(
    int sessionId,
    int exerciseId, {
    required bool isBodyweight,
  }) async {
    final position = await _dao.getNextExercisePosition(sessionId);
    return _dao.insertSessionExerciseRow(
      SessionExercisesCompanion.insert(
        sessionId: sessionId,
        exerciseId: exerciseId,
        position: position,
        isBodyweight: Value(isBodyweight),
      ),
    );
  }

  @override
  Future<int> insertSet(
    int sessionExerciseId, {
    required Weight weight,
    required int reps,
    required DateTime createdAt,
  }) {
    return _dao.transaction(() async {
      final number = await _dao.getNextSetNumber(sessionExerciseId);
      return _dao.insertSetRow(
        SetRecordsCompanion.insert(
          sessionExerciseId: sessionExerciseId,
          setNumber: number,
          weightKg: Value(weight.value),
          reps: reps,
          createdAt: createdAt,
        ),
      );
    });
  }

  @override
  Future<void> updateSet(int setId, {Weight? weight, int? reps}) {
    return _dao.updateSetRow(
      setId,
      SetRecordsCompanion(
        weightKg: weight == null ? const Value.absent() : Value(weight.value),
        reps: reps == null ? const Value.absent() : Value(reps),
      ),
    );
  }

  @override
  Future<void> deleteSet(int setId) {
    return _dao.transaction(() async {
      final row = await _dao.getSetRow(setId);
      if (row == null) return;
      await _dao.deleteSetRow(setId);
      await _dao.renumberSetsAfter(row.sessionExerciseId, row.setNumber);
    });
  }

  @override
  Future<void> setNote(int sessionExerciseId, String note) {
    return _dao.updateSessionExerciseRow(
      sessionExerciseId,
      SessionExercisesCompanion(note: Value(note)),
    );
  }

  @override
  Future<void> complete(int sessionId, DateTime endedAt) {
    return _dao.updateSessionRow(
      sessionId,
      WorkoutSessionsCompanion(
        endedAt: Value(endedAt),
        status: const Value(SessionStatus.completed),
      ),
    );
  }

  @override
  Future<void> deleteSession(int sessionId) {
    return _dao.deleteSessionRow(sessionId).then((_) {});
  }

  static _TreeRow _fromActive(WatchActiveTreeResult r) => (
    ws: r.ws,
    se: r.se,
    sr: r.sr,
    exerciseName: r.exerciseName,
    exerciseGroup: r.exerciseGroup,
    exerciseUnit: r.exerciseUnit,
  );

  static _TreeRow _fromSession(WatchSessionTreeResult r) => (
    ws: r.ws,
    se: r.se,
    sr: r.sr,
    exerciseName: r.exerciseName,
    exerciseGroup: r.exerciseGroup,
    exerciseUnit: r.exerciseUnit,
  );

  /// Agrupa las filas (una por serie) en el árbol sesión → ejercicios → series.
  static WorkoutSession? _buildTree(Iterable<_TreeRow> rows) {
    WorkoutSessionRow? ws;
    final exercises = <int, SessionExercise>{};
    final sets = <int, List<SetRecord>>{};

    for (final row in rows) {
      ws ??= row.ws;
      final se = row.se;
      if (se == null) continue;

      exercises.putIfAbsent(
        se.id,
        () => SessionExercise(
          id: se.id,
          position: se.position,
          exercise: ExerciseRef(
            id: se.exerciseId,
            name: row.exerciseName!,
            muscleGroup: row.exerciseGroup!,
            unit: row.exerciseUnit!,
          ),
          isBodyweight: se.isBodyweight,
          target: se.targetSets == null
              ? null
              : RepScheme(sets: se.targetSets!, reps: se.targetReps),
          note: se.note,
        ),
      );
      final list = sets.putIfAbsent(se.id, () => []);

      final sr = row.sr;
      if (sr != null) {
        list.add(
          SetRecord(
            id: sr.id,
            setNumber: sr.setNumber,
            weight: Weight.kg(sr.weightKg),
            reps: sr.reps,
            createdAt: sr.createdAt,
          ),
        );
      }
    }

    if (ws == null) return null;

    return WorkoutSession(
      id: ws.id,
      routineId: ws.routineId,
      title: ws.title,
      accentGroup: ws.accentGroup,
      date: ws.localDate,
      startedAt: ws.startedAt,
      endedAt: ws.endedAt,
      status: ws.status,
      exercises: [
        for (final e in exercises.values)
          SessionExercise(
            id: e.id,
            position: e.position,
            exercise: e.exercise,
            isBodyweight: e.isBodyweight,
            target: e.target,
            note: e.note,
            sets: List.unmodifiable(sets[e.id] ?? const []),
          ),
      ],
    );
  }
}

@Riverpod(keepAlive: true)
WorkoutRepository workoutRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftWorkoutRepository(db.workoutDao);
}
