import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/features/exercises/data/seed/seed_exercises.dart';

part 'exercises_dao.g.dart';

@DriftAccessor(include: {'exercises.drift'})
class ExercisesDao extends DatabaseAccessor<AppDatabase>
    with _$ExercisesDaoMixin {
  ExercisesDao(super.db);

  Stream<List<ExerciseRow>> watchLibraryRows({MuscleGroup? group}) {
    if (group != null) {
      return watchByGroup(group).watch();
    }
    return watchAllActive().watch();
  }

  Future<ExerciseRow?> findByNameRow(String name) {
    return findByName(name).getSingleOrNull();
  }

  Future<ExerciseRow?> getByIdRow(int id) {
    return getById(id).getSingleOrNull();
  }

  Future<int> insertExerciseRow(ExercisesCompanion companion) {
    return into(exercises).insert(companion);
  }

  Future<bool> updateExerciseRow(int id, ExercisesCompanion companion) {
    return (update(
      exercises,
    )..where((tbl) => tbl.id.equals(id))).write(companion).then((c) => c > 0);
  }

  Future<bool> archiveExerciseRow(int id, DateTime archivedAt) {
    return (update(exercises)..where((tbl) => tbl.id.equals(id)))
        .write(ExercisesCompanion(archivedAt: Value(archivedAt)))
        .then((c) => c > 0);
  }

  Future<int> deleteExerciseRow(int id) {
    return (delete(exercises)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteAllExercises() {
    return delete(exercises).go();
  }

  Future<void> seedDefaultExercises(DateTime createdAt) async {
    await batch((b) {
      b.insertAll(
        exercises,
        initialExercises.map(
          (seed) => ExercisesCompanion.insert(
            name: seed.name,
            muscleGroup: seed.muscleGroup,
            unit: seed.unit,
            isBodyweight: Value(seed.isBodyweight),
            description: Value(seed.description),
            createdAt: createdAt,
          ),
        ),
      );
    });
  }
}
