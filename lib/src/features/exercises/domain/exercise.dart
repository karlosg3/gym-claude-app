import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

part 'exercise.freezed.dart';

/// Entidad pura de Ejercicio de la biblioteca según `05 - Modelo de Dominio.md`.
@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required int id,
    required String name,
    required MuscleGroup muscleGroup,
    required WeightUnit unit,
    @Default(false) bool isBodyweight,
    @Default('') String description,
    DateTime? archivedAt,
    required DateTime createdAt,
  }) = _Exercise;

  const Exercise._();

  bool get isArchived => archivedAt != null;

  String get initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }
}
