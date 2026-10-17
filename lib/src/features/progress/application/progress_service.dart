import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/features/progress/data/drift_progress_repository.dart';
import 'package:gym_claude/src/features/progress/data/progress_repository.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress_service.g.dart';

/// Vía de lectura entre features para estadísticas derivadas (nada se guarda).
class ProgressService {
  const ProgressService(this._repository);

  final ProgressRepository _repository;

  Future<bool> exerciseHasHistory(int exerciseId) =>
      _repository.exerciseHasHistory(exerciseId);

  /// "Peso anterior" por ejercicio: mejor serie de su sesión completada más reciente.
  Stream<Map<int, SetPerformance>> watchLastBest(Set<int> exerciseIds) =>
      _repository.watchLastBest(exerciseIds);

  Future<Weight?> maxWeightBefore(int exerciseId, int sessionId) =>
      _repository.maxWeightBefore(exerciseId, sessionId);
}

@Riverpod(keepAlive: true)
ProgressService progressService(Ref ref) {
  return ProgressService(ref.watch(progressRepositoryProvider));
}
