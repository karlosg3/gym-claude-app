import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/exercises/data/exercises_dao.dart';
import 'package:gym_claude/src/features/exercises/data/exercises_repository.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_draft.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_exercises_repository.g.dart';

class DriftExercisesRepository implements ExercisesRepository {
  const DriftExercisesRepository(this._dao);

  final ExercisesDao _dao;

  @override
  Stream<List<Exercise>> watchLibrary({MuscleGroup? group}) {
    return _dao
        .watchLibraryRows(group: group)
        .map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<Exercise?> findById(int id) async {
    final row = await _dao.getByIdRow(id);
    return row != null ? _toDomain(row) : null;
  }

  @override
  Future<Exercise?> findByName(String name) async {
    final row = await _dao.findByNameRow(name);
    return row != null ? _toDomain(row) : null;
  }

  @override
  Future<int> insert(ExerciseDraft draft, DateTime createdAt) {
    return _dao.insertExerciseRow(
      ExercisesCompanion.insert(
        name: draft.name.trim(),
        muscleGroup: draft.muscleGroup,
        unit: draft.unit,
        isBodyweight: Value(draft.isBodyweight),
        description: Value(draft.description.trim()),
        createdAt: createdAt,
      ),
    );
  }

  @override
  Future<void> update(int id, ExerciseDraft draft) async {
    await _dao.updateExerciseRow(
      id,
      ExercisesCompanion(
        name: Value(draft.name.trim()),
        muscleGroup: Value(draft.muscleGroup),
        unit: Value(draft.unit),
        isBodyweight: Value(draft.isBodyweight),
        description: Value(draft.description.trim()),
      ),
    );
  }

  @override
  Future<void> updateUnit(int id, WeightUnit unit) async {
    await _dao.updateExerciseRow(
      id,
      ExercisesCompanion(unit: Value(unit)),
    );
  }

  @override
  Future<void> archive(int id, DateTime archivedAt) async {
    await _dao.archiveExerciseRow(id, archivedAt);
  }

  @override
  Future<void> delete(int id) async {
    await _dao.deleteExerciseRow(id);
  }

  @override
  Future<void> restore(int id, ExerciseDraft draft) async {
    await _dao.updateExerciseRow(
      id,
      ExercisesCompanion(
        name: Value(draft.name.trim()),
        muscleGroup: Value(draft.muscleGroup),
        unit: Value(draft.unit),
        isBodyweight: Value(draft.isBodyweight),
        description: Value(draft.description.trim()),
        archivedAt: const Value(null),
      ),
    );
  }

  @override
  Future<void> seedInitialExercises(DateTime createdAt) {
    return _dao.seedDefaultExercises(createdAt);
  }

  @override
  Future<void> deleteAll() async {
    await _dao.deleteAllExercises();
  }

  Exercise _toDomain(ExerciseRow row) {
    return Exercise(
      id: row.id,
      name: row.name,
      muscleGroup: row.muscleGroup,
      unit: row.unit,
      isBodyweight: row.isBodyweight,
      description: row.description,
      archivedAt: row.archivedAt,
      createdAt: row.createdAt,
    );
  }
}

@Riverpod(keepAlive: true)
ExercisesDao exercisesDao(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExercisesDao(db);
}

@Riverpod(keepAlive: true)
ExercisesRepository exercisesRepository(Ref ref) {
  final dao = ref.watch(exercisesDaoProvider);
  return DriftExercisesRepository(dao);
}
