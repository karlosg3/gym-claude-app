import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';

/// Lecturas agregadas de progreso sobre las sesiones completadas.
abstract interface class ProgressRepository {
  /// `true` si el ejercicio aparece en alguna sesión (impide borrarlo físicamente).
  Future<bool> exerciseHasHistory(int exerciseId);

  /// Mejor serie de la sesión completada más reciente de cada ejercicio.
  Stream<Map<int, SetPerformance>> watchLastBest(Set<int> exerciseIds);

  /// Máximo peso del ejercicio en sesiones completadas anteriores a [sessionId].
  Future<Weight?> maxWeightBefore(int exerciseId, int sessionId);
}
