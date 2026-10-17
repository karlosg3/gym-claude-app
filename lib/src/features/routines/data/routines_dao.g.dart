// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routines_dao.dart';

// ignore_for_file: type=lint
mixin _$RoutinesDaoMixin on DatabaseAccessor<AppDatabase> {
  Routines get routines => attachedDatabase.routines;
  Exercises get exercises => attachedDatabase.exercises;
  RoutineItems get routineItems => attachedDatabase.routineItems;
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

  RoutinesDaoManager get managers => RoutinesDaoManager(this);
}

class RoutinesDaoManager {
  final _$RoutinesDaoMixin _db;
  RoutinesDaoManager(this._db);
  $RoutinesTableManager get routines =>
      $RoutinesTableManager(_db.attachedDatabase, _db.routines);
  $ExercisesTableManager get exercises =>
      $ExercisesTableManager(_db.attachedDatabase, _db.exercises);
  $RoutineItemsTableManager get routineItems =>
      $RoutineItemsTableManager(_db.attachedDatabase, _db.routineItems);
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
