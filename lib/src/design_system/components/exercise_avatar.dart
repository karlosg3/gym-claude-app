import 'package:flutter/material.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_colors.dart';
import 'package:gym_claude/src/design_system/tokens/gc_typography.dart';

enum ExerciseAvatarSize {
  sm(42.0, 13.0, 17.0),
  lg(56.0, 17.0, 23.0);

  const ExerciseAvatarSize(this.dimension, this.borderRadius, this.fontSize);

  final double dimension;
  final double borderRadius;
  final double fontSize;
}

/// Avatar de ejercicio con inicial del nombre y fondo con el color del grupo muscular.
class ExerciseAvatar extends StatelessWidget {
  const ExerciseAvatar({
    required this.name,
    required this.muscleGroup,
    this.size = ExerciseAvatarSize.sm,
    super.key,
  });

  final String name;
  final MuscleGroup muscleGroup;
  final ExerciseAvatarSize size;

  String get _initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final pair = MuscleGroupColors.of(muscleGroup);
    final colors = context.gcColors;

    return Container(
      width: size.dimension,
      height: size.dimension,
      decoration: BoxDecoration(
        color: pair.color,
        borderRadius: BorderRadius.circular(size.borderRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        _initial,
        style: TextStyle(
          fontFamily: GcTextStyles.fontFamily,
          fontWeight: FontWeight.w800,
          color: colors.background,
        ).copyWith(fontSize: size.fontSize),
      ),
    );
  }
}
