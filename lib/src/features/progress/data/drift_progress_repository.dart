import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/features/progress/data/progress_dao.dart';
import 'package:gym_claude/src/features/progress/data/progress_repository.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_progress_repository.g.dart';

class DriftProgressRepository implements ProgressRepository {
  const DriftProgressRepository(this._dao);

  final ProgressDao _dao;

  @override
  Future<bool> exerciseHasHistory(int exerciseId) =>
      _dao.hasHistory(exerciseId);

  @override
  Stream<Map<int, SetPerformance>> watchLastBest(Set<int> exerciseIds) {
    if (exerciseIds.isEmpty) return Stream.value(const {});
    return _dao
        .watchLastBest(exerciseIds.toList())
        .map(
          (rows) => {
            for (final r in rows)
              r.exerciseId: SetPerformance(
                weight: Weight.kg(r.weightKg),
                reps: r.reps,
              ),
          },
        );
  }

  @override
  Future<Weight?> maxWeightBefore(int exerciseId, int sessionId) async {
    final max = await _dao.getMaxWeightBefore(exerciseId, sessionId);
    return max == null ? null : Weight.kg(max);
  }
}

@Riverpod(keepAlive: true)
ProgressRepository progressRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftProgressRepository(db.progressDao);
}
