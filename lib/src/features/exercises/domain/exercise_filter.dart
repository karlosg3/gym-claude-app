import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';

part 'exercise_filter.freezed.dart';

/// Filtro de búsqueda y grupo muscular para la biblioteca de ejercicios.
@freezed
abstract class ExerciseFilter with _$ExerciseFilter {
  const factory ExerciseFilter({
    MuscleGroup? group,
    @Default('') String query,
  }) = _ExerciseFilter;
}
