import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_draft.dart';

/// Interfaz del repositorio de ejercicios.
abstract interface class ExercisesRepository {
  Stream<List<Exercise>> watchLibrary({MuscleGroup? group});
  Future<Exercise?> findById(int id);
  Future<Exercise?> findByName(String name);
  Future<int> insert(ExerciseDraft draft, DateTime createdAt);
  Future<void> update(int id, ExerciseDraft draft);
  Future<void> updateUnit(int id, WeightUnit unit);
  Future<void> archive(int id, DateTime archivedAt);
  Future<void> delete(int id);
  Future<void> restore(int id, ExerciseDraft draft);
  Future<void> seedInitialExercises(DateTime createdAt);
  Future<void> deleteAll();
}
