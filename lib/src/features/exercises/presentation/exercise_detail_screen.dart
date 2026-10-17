import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/exercises/domain/delete_outcome.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercises_providers.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla de detalle de ejercicio (`/exercises/:exerciseId`).
class ExerciseDetailScreen extends ConsumerWidget {
  const ExerciseDetailScreen({required this.exerciseId, super.key});

  final int exerciseId;

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Exercise exercise,
  ) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: context.gcColors.surface,
          title: Text(l10n.exerciseDeleteTitle),
          content: Text(
            l10n.exerciseDeleteMessage,
            style: context.gcText.body.copyWith(
              color: context.gcColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                l10n.settingsWipeCancelAction,
                style: TextStyle(color: context.gcColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                l10n.exerciseDeleteAction,
                style: TextStyle(color: context.gcColors.danger),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      final outcome = await ref
          .read(exerciseDetailControllerProvider.notifier)
          .deleteExercise(exercise.id);

      if (context.mounted && outcome != null) {
        context.pop();
        if (outcome == DeleteOutcome.archived) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.exerciseArchiveMessage)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final textStyles = context.gcText;

    final exerciseAsync = ref.watch(exerciseDetailProvider(exerciseId));

    return exerciseAsync.when(
      data: (exercise) {
        if (exercise == null) {
          return GcScaffold(
            title: l10n.navExercises,
            leading: IconSquareButton(
              icon: GcIcons.back,
              semanticLabel: l10n.actionBack,
              onPressed: () => context.pop(),
            ),
            body: Center(
              child: Text(
                l10n.exerciseNotFound,
                style: textStyles.body.copyWith(color: colors.textSecondary),
              ),
            ),
          );
        }

        return GcScaffold(
          title: '',
          leading: IconSquareButton(
            icon: GcIcons.back,
            semanticLabel: l10n.actionBack,
            onPressed: () => context.pop(),
          ),
          actions: [
            IconSquareButton(
              icon: GcIcons.export,
              semanticLabel: l10n.navExport,
              onPressed: () =>
                  context.pushExport(scope: 'exercises', ids: [exercise.id]),
            ),
            const SizedBox(width: GcSpacing.sm),
            IconSquareButton(
              icon: GcIcons.edit,
              semanticLabel: l10n.exerciseFormEditTitle,
              onPressed: () => context.pushExerciseEdit(exercise.id),
            ),
            const SizedBox(width: GcSpacing.sm),
            IconSquareButton(
              icon: GcIcons.delete,
              semanticLabel: l10n.exerciseDeleteAction,
              color: colors.danger,
              onPressed: () => _confirmDelete(context, ref, exercise),
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: GcSpacing.screenHorizontal,
              vertical: GcSpacing.sm,
            ),
            children: [
              // CABECERA DEL EJERCICIO
              Row(
                children: [
                  ExerciseAvatar(
                    name: exercise.name,
                    muscleGroup: exercise.muscleGroup,
                    size: ExerciseAvatarSize.lg,
                  ),
                  const SizedBox(width: GcSpacing.md + 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: textStyles.headline.copyWith(
                            fontSize: 22,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: GcSpacing.xs + 2),
                        MuscleTag(group: exercise.muscleGroup),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: GcSpacing.xl),

              // UNIDAD DE PESO
              GcCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: GcSpacing.lg,
                  vertical: GcSpacing.sm + 2,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.exerciseDetailUnitTitle,
                            style: textStyles.bodyStrong.copyWith(
                              fontSize: 13,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.exerciseDetailUnitSubtitle,
                            style: textStyles.caption.copyWith(
                              fontSize: 11,
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SegmentedControl<WeightUnit>(
                      options: const [
                        SegmentedOption(value: WeightUnit.kg, label: 'kg'),
                        SegmentedOption(value: WeightUnit.lb, label: 'lb'),
                      ],
                      selectedValue: exercise.unit,
                      onChanged: (unit) {
                        ref
                            .read(exerciseDetailControllerProvider.notifier)
                            .changeUnit(exercise.id, unit);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: GcSpacing.md),

              // TRES ESTADÍSTICAS (Máximo, Última, Sesiones)
              Row(
                children: [
                  Expanded(
                    child: _DetailStatCard(
                      value: '—',
                      label: l10n.exercisesMaxLabel,
                    ),
                  ),
                  const SizedBox(width: GcSpacing.md),
                  Expanded(
                    child: _DetailStatCard(
                      value: '—',
                      label: l10n.exercisesLastLabel,
                    ),
                  ),
                  const SizedBox(width: GcSpacing.md),
                  Expanded(
                    child: _DetailStatCard(
                      value: '0',
                      label: l10n.exercisesSessionsLabel,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: GcSpacing.lg),

              // PROGRESO / ESTADO SIN SESIONES
              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border.all(
                    color: colors.borderStrong,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(GcRadii.lg),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: GcSpacing.lg,
                  vertical: GcSpacing.xl + 4,
                ),
                child: Column(
                  children: [
                    Text(
                      l10n.exerciseDetailNoDataTitle,
                      textAlign: TextAlign.center,
                      style: textStyles.bodyStrong.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: GcSpacing.xs + 2),
                    Text(
                      l10n.exerciseDetailNoDataSubtitle,
                      textAlign: TextAlign.center,
                      style: textStyles.caption.copyWith(
                        color: colors.textFaint,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: GcSpacing.lg),

              // DESCRIPCIÓN
              GcCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.exerciseDetailDescTitle,
                      style: textStyles.bodyStrong.copyWith(
                        fontSize: 13,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: GcSpacing.sm),
                    Text(
                      exercise.description.isNotEmpty
                          ? exercise.description
                          : l10n.exerciseDetailNoDesc,
                      style: textStyles.body.copyWith(
                        fontSize: 13,
                        color: colors.textSecondary,
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: GcSpacing.xxl),
            ],
          ),
        );
      },
      loading: () =>
          const GcScaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, _) => GcScaffold(
        body: Center(
          child: Text(
            l10n.errorUnexpectedTitle,
            style: textStyles.body.copyWith(color: colors.danger),
          ),
        ),
      ),
    );
  }
}

class _DetailStatCard extends StatelessWidget {
  const _DetailStatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(GcRadii.lg),
      ),
      padding: const EdgeInsets.all(GcSpacing.md + 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: textStyles.headline.copyWith(
              fontSize: 18,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: GcSpacing.xs),
          Text(
            label,
            style: textStyles.micro.copyWith(
              color: colors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
