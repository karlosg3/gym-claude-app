import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

part 'exercise_draft.freezed.dart';

/// Borrador de datos ingresados en el formulario de creación o edición de ejercicio.
@freezed
abstract class ExerciseDraft with _$ExerciseDraft {
  const factory ExerciseDraft({
    required String name,
    required MuscleGroup muscleGroup,
    required WeightUnit unit,
    @Default(false) bool isBodyweight,
    @Default('') String description,
  }) = _ExerciseDraft;
}
