import 'package:flutter/material.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_colors.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Etiqueta semántica de grupo muscular con paleta propia según el diseño.
class MuscleTag extends StatelessWidget {
  const MuscleTag({
    required this.group,
    this.labelOverride,
    super.key,
  });

  final MuscleGroup group;
  final String? labelOverride;

  static String localizedLabel(BuildContext context, MuscleGroup group) {
    final l10n = context.l10n;
    return switch (group) {
      MuscleGroup.chest => l10n.muscleGroupChest,
      MuscleGroup.back => l10n.muscleGroupBack,
      MuscleGroup.legs => l10n.muscleGroupLegs,
      MuscleGroup.shoulders => l10n.muscleGroupShoulders,
      MuscleGroup.arms => l10n.muscleGroupArms,
      MuscleGroup.core => l10n.muscleGroupCore,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = MuscleGroupColors.of(group);
    final textStyles = context.gcText;
    final text = labelOverride ?? localizedLabel(context, group);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GcSpacing.sm + 1,
        vertical: GcSpacing.xs - 1,
      ),
      decoration: BoxDecoration(
        color: colors.soft,
        borderRadius: BorderRadius.circular(GcRadii.sm - 1),
      ),
      child: Text(
        text,
        style: textStyles.overline.copyWith(
          color: colors.color,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
