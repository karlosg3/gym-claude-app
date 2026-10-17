import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';

/// Reglas puras de mejor serie y récord personal (`07 - Reglas de Negocio` §2).
abstract final class PersonalRecordDetector {
  /// Mejor serie: mayor peso y, a igual peso, más repeticiones. `null` si no hay series.
  static SetPerformance? best(Iterable<SetPerformance> sets) {
    SetPerformance? result;
    for (final set in sets) {
      if (result == null || set.isBetterThan(result)) {
        result = set;
      }
    }
    return result;
  }

  /// Una serie es récord si supera el máximo previo. Sin máximo previo (primera vez) no hay récord.
  static bool isRecord(SetPerformance set, Weight? previousMax) {
    return previousMax != null && set.weight > previousMax;
  }

  /// `true` solo en la primera serie de la sesión que supera el máximo previo,
  /// para emitir el evento de récord una vez por ejercicio y sesión.
  static bool isFirstRecordInSession({
    required SetPerformance newSet,
    required Iterable<SetPerformance> earlierSets,
    required Weight? previousMax,
  }) {
    if (!isRecord(newSet, previousMax)) return false;
    return !earlierSets.any((s) => isRecord(s, previousMax));
  }
}
