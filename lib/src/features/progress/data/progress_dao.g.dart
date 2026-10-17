// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_dao.dart';

// ignore_for_file: type=lint
mixin _$ProgressDaoMixin on DatabaseAccessor<AppDatabase> {
  Routines get routines => attachedDatabase.routines;
  WorkoutSessions get workoutSessions => attachedDatabase.workoutSessions;
  Exercises get exercises => attachedDatabase.exercises;
  SessionExercises get sessionExercises => attachedDatabase.sessionExercises;
  SetRecords get setRecords => attachedDatabase.setRecords;
  RoutineItems get routineItems => attachedDatabase.routineItems;
  Selectable<bool> exerciseHasHistory(int exerciseId) {
    return customSelect(
      'SELECT EXISTS (SELECT 1 AS _c1 FROM session_exercises WHERE exercise_id = ?1) AS _c0',
      variables: [Variable<int>(exerciseId)],
      readsFrom: {this.sessionExercises},
    ).map((QueryRow row) => row.read<bool>('_c0'));
  }

  Selectable<LastBestPerExerciseResult> lastBestPerExercise(
    List<int> exerciseIds,
  ) {
    var $arrayStartIndex = 1;
    final expandedexerciseIds = $expandVar(
      $arrayStartIndex,
      exerciseIds.length,
    );
    $arrayStartIndex += exerciseIds.length;
    return customSelect(
      'WITH ranked AS (SELECT se.exercise_id, sr.weight_kg, sr.reps, ROW_NUMBER()OVER (PARTITION BY se.exercise_id ORDER BY ws.started_at DESC, sr.weight_kg DESC, sr.reps DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS rn FROM session_exercises AS se JOIN workout_sessions AS ws ON ws.id = se.session_id AND ws.status = \'completed\' JOIN set_records AS sr ON sr.session_exercise_id = se.id WHERE se.exercise_id IN ($expandedexerciseIds)) SELECT exercise_id, weight_kg, reps FROM ranked WHERE rn = 1',
      variables: [for (var $ in exerciseIds) Variable<int>($)],
      readsFrom: {this.sessionExercises, this.setRecords, this.workoutSessions},
    ).map(
      (QueryRow row) => LastBestPerExerciseResult(
        exerciseId: row.read<int>('exercise_id'),
        weightKg: row.read<double>('weight_kg'),
        reps: row.read<int>('reps'),
      ),
    );
  }

  Selectable<double?> maxWeightBefore(int exerciseId, int sessionId) {
    return customSelect(
      'SELECT MAX(sr.weight_kg) AS _c0 FROM set_records AS sr JOIN session_exercises AS se ON se.id = sr.session_exercise_id JOIN workout_sessions AS ws ON ws.id = se.session_id WHERE se.exercise_id = ?1 AND ws.status = \'completed\' AND ws.started_at < (SELECT started_at FROM workout_sessions WHERE id = ?2)',
      variables: [Variable<int>(exerciseId), Variable<int>(sessionId)],
      readsFrom: {this.setRecords, this.sessionExercises, this.workoutSessions},
    ).map((QueryRow row) => row.readNullable<double>('_c0'));
  }

  Selectable<WorkoutSessionRow> watchActiveSession() {
    return customSelect(
      'SELECT * FROM workout_sessions WHERE status = \'active\'',
      variables: [],
      readsFrom: {this.workoutSessions},
    ).asyncMap(this.workoutSessions.mapFromRow);
  }

  Selectable<WatchSessionTreeResult> watchSessionTree(int sessionId) {
    return customSelect(
      'SELECT"ws"."id" AS "nested_0.id", "ws"."routine_id" AS "nested_0.routine_id", "ws"."title" AS "nested_0.title", "ws"."accent_group" AS "nested_0.accent_group", "ws"."local_date" AS "nested_0.local_date", "ws"."started_at" AS "nested_0.started_at", "ws"."ended_at" AS "nested_0.ended_at", "ws"."status" AS "nested_0.status","se"."id" AS "nested_1.id", "se"."session_id" AS "nested_1.session_id", "se"."exercise_id" AS "nested_1.exercise_id", "se"."position" AS "nested_1.position", "se"."is_bodyweight" AS "nested_1.is_bodyweight", "se"."target_sets" AS "nested_1.target_sets", "se"."target_reps" AS "nested_1.target_reps", "se"."note" AS "nested_1.note","sr"."id" AS "nested_2.id", "sr"."session_exercise_id" AS "nested_2.session_exercise_id", "sr"."set_number" AS "nested_2.set_number", "sr"."weight_kg" AS "nested_2.weight_kg", "sr"."reps" AS "nested_2.reps", "sr"."created_at" AS "nested_2.created_at", e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM workout_sessions AS ws LEFT JOIN session_exercises AS se ON se.session_id = ws.id LEFT JOIN exercises AS e ON e.id = se.exercise_id LEFT JOIN set_records AS sr ON sr.session_exercise_id = se.id WHERE ws.id = ?1 ORDER BY se.position, sr.set_number',
      variables: [Variable<int>(sessionId)],
      readsFrom: {
        this.exercises,
        this.workoutSessions,
        this.sessionExercises,
        this.setRecords,
      },
    ).asyncMap(
      (QueryRow row) async => WatchSessionTreeResult(
        ws: await this.workoutSessions.mapFromRow(row, tablePrefix: 'nested_0'),
        se: await this.sessionExercises.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_1',
        ),
        sr: await this.setRecords.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_2',
        ),
        exerciseName: row.readNullable<String>('exercise_name'),
        exerciseGroup: NullAwareTypeConverter.wrapFromSql(
          Exercises.$convertermuscleGroup,
          row.readNullable<String>('exercise_group'),
        ),
        exerciseUnit: NullAwareTypeConverter.wrapFromSql(
          Exercises.$converterunit,
          row.readNullable<String>('exercise_unit'),
        ),
      ),
    );
  }

  Selectable<WatchActiveTreeResult> watchActiveTree() {
    return customSelect(
      'SELECT"ws"."id" AS "nested_0.id", "ws"."routine_id" AS "nested_0.routine_id", "ws"."title" AS "nested_0.title", "ws"."accent_group" AS "nested_0.accent_group", "ws"."local_date" AS "nested_0.local_date", "ws"."started_at" AS "nested_0.started_at", "ws"."ended_at" AS "nested_0.ended_at", "ws"."status" AS "nested_0.status","se"."id" AS "nested_1.id", "se"."session_id" AS "nested_1.session_id", "se"."exercise_id" AS "nested_1.exercise_id", "se"."position" AS "nested_1.position", "se"."is_bodyweight" AS "nested_1.is_bodyweight", "se"."target_sets" AS "nested_1.target_sets", "se"."target_reps" AS "nested_1.target_reps", "se"."note" AS "nested_1.note","sr"."id" AS "nested_2.id", "sr"."session_exercise_id" AS "nested_2.session_exercise_id", "sr"."set_number" AS "nested_2.set_number", "sr"."weight_kg" AS "nested_2.weight_kg", "sr"."reps" AS "nested_2.reps", "sr"."created_at" AS "nested_2.created_at", e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM workout_sessions AS ws LEFT JOIN session_exercises AS se ON se.session_id = ws.id LEFT JOIN exercises AS e ON e.id = se.exercise_id LEFT JOIN set_records AS sr ON sr.session_exercise_id = se.id WHERE ws.status = \'active\' ORDER BY se.position, sr.set_number',
      variables: [],
      readsFrom: {
        this.exercises,
        this.workoutSessions,
        this.sessionExercises,
        this.setRecords,
      },
    ).asyncMap(
      (QueryRow row) async => WatchActiveTreeResult(
        ws: await this.workoutSessions.mapFromRow(row, tablePrefix: 'nested_0'),
        se: await this.sessionExercises.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_1',
        ),
        sr: await this.setRecords.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_2',
        ),
        exerciseName: row.readNullable<String>('exercise_name'),
        exerciseGroup: NullAwareTypeConverter.wrapFromSql(
          Exercises.$convertermuscleGroup,
          row.readNullable<String>('exercise_group'),
        ),
        exerciseUnit: NullAwareTypeConverter.wrapFromSql(
          Exercises.$converterunit,
          row.readNullable<String>('exercise_unit'),
        ),
      ),
    );
  }

  Future<int> copyRoutineDay(int sessionId, int routineId, int weekday) {
    return customInsert(
      'INSERT INTO session_exercises (session_id, exercise_id, position, is_bodyweight, target_sets, target_reps) SELECT ?1, ri.exercise_id, ri.position, e.is_bodyweight, ri.target_sets, ri.target_reps FROM routine_items AS ri JOIN exercises AS e ON e.id = ri.exercise_id WHERE ri.routine_id = ?2 AND ri.weekday = ?3 AND e.archived_at IS NULL',
      variables: [
        Variable<int>(sessionId),
        Variable<int>(routineId),
        Variable<int>(weekday),
      ],
      updates: {this.sessionExercises},
    );
  }

  Selectable<int> nextExercisePosition(int sessionId) {
    return customSelect(
      'SELECT COALESCE(MAX(position), -1) + 1 AS _c0 FROM session_exercises WHERE session_id = ?1',
      variables: [Variable<int>(sessionId)],
      readsFrom: {this.sessionExercises},
    ).map((QueryRow row) => row.read<int>('_c0'));
  }

  Selectable<int> nextSetNumber(int sessionExerciseId) {
    return customSelect(
      'SELECT COALESCE(MAX(set_number), 0) + 1 AS _c0 FROM set_records WHERE session_exercise_id = ?1',
      variables: [Variable<int>(sessionExerciseId)],
      readsFrom: {this.setRecords},
    ).map((QueryRow row) => row.read<int>('_c0'));
  }

  Future<int> renumberAfter(int sessionExerciseId, int deletedNumber) {
    return customUpdate(
      'UPDATE set_records SET set_number = set_number - 1 WHERE session_exercise_id = ?1 AND set_number > ?2',
      variables: [
        Variable<int>(sessionExerciseId),
        Variable<int>(deletedNumber),
      ],
      updates: {this.setRecords},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<ExerciseRow> watchAllActive() {
    return customSelect(
      'SELECT * FROM exercises WHERE archived_at IS NULL ORDER BY name',
      variables: [],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<ExerciseRow> watchByGroup(MuscleGroup group) {
    return customSelect(
      'SELECT * FROM exercises WHERE archived_at IS NULL AND muscle_group = ?1 ORDER BY name',
      variables: [
        Variable<String>(Exercises.$convertermuscleGroup.toSql(group)),
      ],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<ExerciseRow> findByName(String name) {
    return customSelect(
      'SELECT * FROM exercises WHERE name = ?1',
      variables: [Variable<String>(name)],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<ExerciseRow> getById(int id) {
    return customSelect(
      'SELECT * FROM exercises WHERE id = ?1',
      variables: [Variable<int>(id)],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<WatchAllWithItemsResult> watchAllWithItems() {
    return customSelect(
      'SELECT"r"."id" AS "nested_0.id", "r"."name" AS "nested_0.name", "r"."description" AS "nested_0.description", "r"."active_days" AS "nested_0.active_days", "r"."sort_order" AS "nested_0.sort_order", "r"."created_at" AS "nested_0.created_at","ri"."id" AS "nested_1.id", "ri"."routine_id" AS "nested_1.routine_id", "ri"."weekday" AS "nested_1.weekday", "ri"."exercise_id" AS "nested_1.exercise_id", "ri"."position" AS "nested_1.position", "ri"."target_sets" AS "nested_1.target_sets", "ri"."target_reps" AS "nested_1.target_reps", e.id AS exercise_id, e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM routines AS r LEFT JOIN routine_items AS ri ON ri.routine_id = r.id LEFT JOIN exercises AS e ON e.id = ri.exercise_id ORDER BY r.sort_order, r.id, ri.weekday, ri.position',
      variables: [],
      readsFrom: {this.exercises, this.routines, this.routineItems},
    ).asyncMap(
      (QueryRow row) async => WatchAllWithItemsResult(
        r: await this.routines.mapFromRow(row, tablePrefix: 'nested_0'),
        ri: await this.routineItems.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_1',
        ),
        exerciseId: row.readNullable<int>('exercise_id'),
        exerciseName: row.readNullable<String>('exercise_name'),
        exerciseGroup: NullAwareTypeConverter.wrapFromSql(
          Exercises.$convertermuscleGroup,
          row.readNullable<String>('exercise_group'),
        ),
        exerciseUnit: NullAwareTypeConverter.wrapFromSql(
          Exercises.$converterunit,
          row.readNullable<String>('exercise_unit'),
        ),
      ),
    );
  }

  Selectable<int> watchPlannedWeekdays() {
    return customSelect(
      'SELECT DISTINCT weekday FROM routine_items',
      variables: [],
      readsFrom: {this.routineItems},
    ).map((QueryRow row) => row.read<int>('weekday'));
  }

  Selectable<DateTime?> watchPlanStart() {
    return customSelect(
      'SELECT MIN(created_at) AS _c0 FROM routines',
      variables: [],
      readsFrom: {this.routines},
    ).map((QueryRow row) => row.readNullable<DateTime>('_c0'));
  }

  Selectable<RoutineRow> watchForWeekday(int weekday) {
    return customSelect(
      'SELECT * FROM routines WHERE EXISTS (SELECT 1 AS _c0 FROM routine_items AS ri WHERE ri.routine_id = routines.id AND ri.weekday = ?1) ORDER BY sort_order, id',
      variables: [Variable<int>(weekday)],
      readsFrom: {this.routines, this.routineItems},
    ).asyncMap(this.routines.mapFromRow);
  }

  Selectable<RoutineRow> getRoutineById(int id) {
    return customSelect(
      'SELECT * FROM routines WHERE id = ?1',
      variables: [Variable<int>(id)],
      readsFrom: {this.routines},
    ).asyncMap(this.routines.mapFromRow);
  }

  Selectable<GetItemsByRoutineAndDayResult> getItemsByRoutineAndDay(
    int routineId,
    int weekday,
  ) {
    return customSelect(
      'SELECT"ri"."id" AS "nested_0.id", "ri"."routine_id" AS "nested_0.routine_id", "ri"."weekday" AS "nested_0.weekday", "ri"."exercise_id" AS "nested_0.exercise_id", "ri"."position" AS "nested_0.position", "ri"."target_sets" AS "nested_0.target_sets", "ri"."target_reps" AS "nested_0.target_reps", e.id AS exercise_id, e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM routine_items AS ri JOIN exercises AS e ON e.id = ri.exercise_id WHERE ri.routine_id = ?1 AND ri.weekday = ?2 ORDER BY ri.position',
      variables: [Variable<int>(routineId), Variable<int>(weekday)],
      readsFrom: {this.exercises, this.routineItems},
    ).asyncMap(
      (QueryRow row) async => GetItemsByRoutineAndDayResult(
        ri: await this.routineItems.mapFromRow(row, tablePrefix: 'nested_0'),
        exerciseId: row.read<int>('exercise_id'),
        exerciseName: row.read<String>('exercise_name'),
        exerciseGroup: Exercises.$convertermuscleGroup.fromSql(
          row.read<String>('exercise_group'),
        ),
        exerciseUnit: Exercises.$converterunit.fromSql(
          row.read<String>('exercise_unit'),
        ),
      ),
    );
  }

  ProgressDaoManager get managers => ProgressDaoManager(this);
}

class ProgressDaoManager {
  final _$ProgressDaoMixin _db;
  ProgressDaoManager(this._db);
  $RoutinesTableManager get routines =>
      $RoutinesTableManager(_db.attachedDatabase, _db.routines);
  $WorkoutSessionsTableManager get workoutSessions =>
      $WorkoutSessionsTableManager(_db.attachedDatabase, _db.workoutSessions);
  $ExercisesTableManager get exercises =>
      $ExercisesTableManager(_db.attachedDatabase, _db.exercises);
  $SessionExercisesTableManager get sessionExercises =>
      $SessionExercisesTableManager(_db.attachedDatabase, _db.sessionExercises);
  $SetRecordsTableManager get setRecords =>
      $SetRecordsTableManager(_db.attachedDatabase, _db.setRecords);
  $RoutineItemsTableManager get routineItems =>
      $RoutineItemsTableManager(_db.attachedDatabase, _db.routineItems);
}

class LastBestPerExerciseResult {
  final int exerciseId;
  final double weightKg;
  final int reps;
  LastBestPerExerciseResult({
    required this.exerciseId,
    required this.weightKg,
    required this.reps,
  });
}

class WatchSessionTreeResult {
  final WorkoutSessionRow ws;
  final SessionExerciseRow? se;
  final SetRecordRow? sr;
  final String? exerciseName;
  final MuscleGroup? exerciseGroup;
  final WeightUnit? exerciseUnit;
  WatchSessionTreeResult({
    required this.ws,
    this.se,
    this.sr,
    this.exerciseName,
    this.exerciseGroup,
    this.exerciseUnit,
  });
}

class WatchActiveTreeResult {
  final WorkoutSessionRow ws;
  final SessionExerciseRow? se;
  final SetRecordRow? sr;
  final String? exerciseName;
  final MuscleGroup? exerciseGroup;
  final WeightUnit? exerciseUnit;
  WatchActiveTreeResult({
    required this.ws,
    this.se,
    this.sr,
    this.exerciseName,
    this.exerciseGroup,
    this.exerciseUnit,
  });
}

class WatchAllWithItemsResult {
  final RoutineRow r;
  final RoutineItemRow? ri;
  final int? exerciseId;
  final String? exerciseName;
  final MuscleGroup? exerciseGroup;
  final WeightUnit? exerciseUnit;
  WatchAllWithItemsResult({
    required this.r,
    this.ri,
    this.exerciseId,
    this.exerciseName,
    this.exerciseGroup,
    this.exerciseUnit,
  });
}

class GetItemsByRoutineAndDayResult {
  final RoutineItemRow ri;
  final int exerciseId;
  final String exerciseName;
  final MuscleGroup exerciseGroup;
  final WeightUnit exerciseUnit;
  GetItemsByRoutineAndDayResult({
    required this.ri,
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseGroup,
    required this.exerciseUnit,
  });
}
