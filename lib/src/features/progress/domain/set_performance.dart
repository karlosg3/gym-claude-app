import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:meta/meta.dart';

/// Rendimiento de una serie (peso + repeticiones), base para comparar series y detectar récords.
@immutable
class SetPerformance {
  const SetPerformance({required this.weight, required this.reps});

  final Weight weight;
  final int reps;

  /// Mayor peso gana; a igual peso, más repeticiones.
  bool isBetterThan(SetPerformance other) {
    if (weight != other.weight) return weight > other.weight;
    return reps > other.reps;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetPerformance && weight == other.weight && reps == other.reps;

  @override
  int get hashCode => Object.hash(weight, reps);

  @override
  String toString() => 'SetPerformance(${weight.value} kg × $reps)';
}
