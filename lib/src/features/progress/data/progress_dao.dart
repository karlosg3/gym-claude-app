import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

part 'progress_dao.g.dart';

/// Consultas agregadas de solo lectura sobre tablas de otros features. No escribe.
@DriftAccessor(include: {'progress_queries.drift'})
class ProgressDao extends DatabaseAccessor<AppDatabase>
    with _$ProgressDaoMixin {
  ProgressDao(super.db);

  Future<bool> hasHistory(int exerciseId) {
    return exerciseHasHistory(exerciseId).getSingle();
  }

  Stream<List<LastBestPerExerciseResult>> watchLastBest(List<int> exerciseIds) {
    return lastBestPerExercise(exerciseIds).watch();
  }

  Future<double?> getMaxWeightBefore(int exerciseId, int sessionId) {
    return maxWeightBefore(exerciseId, sessionId).getSingle();
  }
}
