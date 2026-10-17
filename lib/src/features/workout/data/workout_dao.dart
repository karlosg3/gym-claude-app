import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

part 'workout_dao.g.dart';

@DriftAccessor(include: {'workout.drift'})
class WorkoutDao extends DatabaseAccessor<AppDatabase> with _$WorkoutDaoMixin {
  WorkoutDao(super.db);

  Future<WorkoutSessionRow?> getActiveRow() {
    return watchActiveSession().getSingleOrNull();
  }

  Stream<List<WatchActiveTreeResult>> watchActiveTreeRows() {
    return watchActiveTree().watch();
  }

  Future<List<WatchActiveTreeResult>> getActiveTreeRows() {
    return watchActiveTree().get();
  }

  Stream<List<WatchSessionTreeResult>> watchTreeRows(int sessionId) {
    return watchSessionTree(sessionId).watch();
  }

  Future<List<WatchSessionTreeResult>> getTreeRows(int sessionId) {
    return watchSessionTree(sessionId).get();
  }

  Future<int> insertSessionRow(WorkoutSessionsCompanion companion) {
    return into(workoutSessions).insert(companion);
  }

  Future<void> updateSessionRow(int id, WorkoutSessionsCompanion companion) {
    return (update(
      workoutSessions,
    )..where((tbl) => tbl.id.equals(id))).write(companion).then((_) {});
  }

  Future<int> deleteSessionRow(int id) {
    return (delete(workoutSessions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> copyRoutineDayRows({
    required int sessionId,
    required int routineId,
    required int weekday,
  }) {
    return copyRoutineDay(sessionId, routineId, weekday);
  }

  Future<int> insertSessionExerciseRow(SessionExercisesCompanion companion) {
    return into(sessionExercises).insert(companion);
  }

  Future<void> updateSessionExerciseRow(
    int id,
    SessionExercisesCompanion companion,
  ) {
    return (update(
      sessionExercises,
    )..where((tbl) => tbl.id.equals(id))).write(companion).then((_) {});
  }

  Future<int> getNextExercisePosition(int sessionId) {
    return nextExercisePosition(sessionId).getSingle();
  }

  Future<int> getNextSetNumber(int sessionExerciseId) {
    return nextSetNumber(sessionExerciseId).getSingle();
  }

  Future<SetRecordRow?> getSetRow(int id) {
    return (select(
      setRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertSetRow(SetRecordsCompanion companion) {
    return into(setRecords).insert(companion);
  }

  Future<void> updateSetRow(int id, SetRecordsCompanion companion) {
    return (update(
      setRecords,
    )..where((tbl) => tbl.id.equals(id))).write(companion).then((_) {});
  }

  Future<int> deleteSetRow(int id) {
    return (delete(setRecords)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> renumberSetsAfter(int sessionExerciseId, int deletedNumber) {
    return renumberAfter(sessionExerciseId, deletedNumber);
  }
}
