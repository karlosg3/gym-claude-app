import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:meta/meta.dart';

/// Referencia inmutable ligera a un ejercicio embebido en un [RoutineItem].
@immutable
class ExerciseRef {
  const ExerciseRef({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.unit,
  });

  final int id;
  final String name;
  final MuscleGroup muscleGroup;
  final WeightUnit unit;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseRef &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          muscleGroup == other.muscleGroup &&
          unit == other.unit;

  @override
  int get hashCode => Object.hash(id, name, muscleGroup, unit);

  @override
  String toString() =>
      'ExerciseRef(id: $id, name: $name, muscleGroup: $muscleGroup, unit: $unit)';
}
