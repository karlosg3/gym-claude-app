import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/exercises/application/exercises_service.dart';
import 'package:gym_claude/src/features/exercises/domain/delete_outcome.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_draft.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_providers.g.dart';

@riverpod
class ExerciseFilterNotifier extends _$ExerciseFilterNotifier {
  @override
  ExerciseFilter build() {
    return const ExerciseFilter();
  }

  void setGroup(MuscleGroup? group) {
    state = state.copyWith(group: group);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void reset() {
    state = const ExerciseFilter();
  }
}

@riverpod
Stream<List<Exercise>> exerciseLibrary(Ref ref) {
  final service = ref.watch(exercisesServiceProvider);
  final filter = ref.watch(exerciseFilterProvider);
  return service.watchLibrary(filter);
}

@riverpod
Stream<Exercise?> exerciseDetail(Ref ref, int id) {
  final service = ref.watch(exercisesServiceProvider);
  return service.watchById(id);
}

@riverpod
Stream<int> exerciseCount(Ref ref) {
  final service = ref.watch(exercisesServiceProvider);
  return service.watchLibrary().map((list) => list.length);
}

@riverpod
class ExerciseFormController extends _$ExerciseFormController {
  @override
  FutureOr<int?> build() => null;

  Future<int?> createExercise(ExerciseDraft draft) async {
    state = const AsyncLoading();
    int? createdId;
    final res = await AsyncValue.guard(() async {
      createdId = await ref.read(exercisesServiceProvider).create(draft);
      return createdId;
    });
    if (!ref.mounted) return createdId;
    state = res;
    return createdId;
  }

  Future<bool> updateExercise(int id, ExerciseDraft draft) async {
    state = const AsyncLoading();
    var success = false;
    final res = await AsyncValue.guard(() async {
      await ref.read(exercisesServiceProvider).update(id, draft);
      success = true;
      return id;
    });
    if (!ref.mounted) return success;
    state = res;
    return success;
  }
}

@riverpod
class ExerciseDetailController extends _$ExerciseDetailController {
  @override
  FutureOr<void> build() {}

  Future<void> changeUnit(int exerciseId, WeightUnit unit) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(exercisesServiceProvider).setUnit(exerciseId, unit),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<DeleteOutcome?> deleteExercise(int exerciseId) async {
    state = const AsyncLoading();
    DeleteOutcome? outcome;
    final res = await AsyncValue.guard(() async {
      outcome = await ref.read(exercisesServiceProvider).delete(exerciseId);
    });
    if (!ref.mounted) return outcome;
    state = res;
    return outcome;
  }
}
