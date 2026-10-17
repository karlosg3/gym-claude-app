import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';
import 'package:meta/meta.dart';

/// Serie registrada de un ejercicio dentro de una sesión.
@immutable
class SetRecord {
  const SetRecord({
    required this.id,
    required this.setNumber,
    required this.weight,
    required this.reps,
    required this.createdAt,
  });

  final int id;

  /// Número de serie 1-based; se renumera al borrar.
  final int setNumber;
  final Weight weight;
  final int reps;
  final DateTime createdAt;

  SetPerformance get performance => SetPerformance(weight: weight, reps: reps);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetRecord &&
          id == other.id &&
          setNumber == other.setNumber &&
          weight == other.weight &&
          reps == other.reps &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, setNumber, weight, reps, createdAt);

  @override
  String toString() =>
      'SetRecord(id: $id, #$setNumber, ${weight.value} kg × $reps)';
}
