import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercises_providers.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla de catálogo y biblioteca de ejercicios (`/exercises`).
class ExercisesListScreen extends ConsumerWidget {
  const ExercisesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final textStyles = context.gcText;

    final filter = ref.watch(exerciseFilterProvider);
    final libraryAsync = ref.watch(exerciseLibraryProvider);
    final countAsync = ref.watch(exerciseCountProvider);

    final filterItems = [
      FilterChipItem<MuscleGroup?>(value: null, label: l10n.exercisesFilterAll),
      for (final g in MuscleGroup.values)
        FilterChipItem<MuscleGroup?>(
          value: g,
          label: MuscleTag.localizedLabel(context, g),
        ),
    ];

    return GcScaffold(
      title: l10n.navExercises,
      actions: [
        Center(
          child: countAsync.when(
            data: (count) => Text(
              l10n.exercisesCount(count),
              style: textStyles.label.copyWith(color: colors.textMuted),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ),
      ],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: GcSpacing.screenHorizontal,
                right: GcSpacing.screenHorizontal,
                top: GcSpacing.xs,
                bottom: GcSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GcSearchField(
                    hintText: l10n.exercisesSearchPlaceholder,
                    initialValue: filter.query,
                    onChanged: (val) {
                      ref.read(exerciseFilterProvider.notifier).setQuery(val);
                    },
                  ),
                  const SizedBox(height: GcSpacing.md),
                  FilterChipRow<MuscleGroup?>(
                    items: filterItems,
                    selectedValue: filter.group,
                    onSelected: (group) {
                      ref.read(exerciseFilterProvider.notifier).setGroup(group);
                    },
                  ),
                ],
              ),
            ),
          ),
          libraryAsync.when(
            data: (exercises) {
              if (exercises.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(GcSpacing.xxl),
                      child: Text(
                        l10n.exercisesEmptySearch,
                        style: textStyles.body.copyWith(
                          color: colors.textFaint,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: GcSpacing.screenHorizontal,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final exercise = exercises[index];
                    return _ExerciseListTile(
                      exercise: exercise,
                      onTap: () => context.goExercise(exercise.id),
                    );
                  }, childCount: exercises.length),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  l10n.errorUnexpectedTitle,
                  style: textStyles.body.copyWith(color: colors.danger),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 140)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'exercises_fab',
        onPressed: () => context.pushExerciseNew(),
        backgroundColor: colors.accent,
        foregroundColor: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GcRadii.md),
        ),
        child: const Icon(GcIcons.add, size: GcIcons.sizeMd),
      ),
    );
  }
}

class _ExerciseListTile extends StatelessWidget {
  const _ExerciseListTile({required this.exercise, required this.onTap});

  final Exercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;
    final l10n = context.l10n;

    return Container(
      margin: const EdgeInsets.only(bottom: GcSpacing.sm + 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GcRadii.lg),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(GcRadii.lg),
          ),
          padding: const EdgeInsets.all(GcSpacing.md + 1),
          child: Row(
            children: [
              ExerciseAvatar(
                name: exercise.name,
                muscleGroup: exercise.muscleGroup,
                size: ExerciseAvatarSize.sm,
              ),
              const SizedBox(width: GcSpacing.md + 1),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      exercise.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyles.bodyStrong.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: GcSpacing.xs + 1),
                    MuscleTag(group: exercise.muscleGroup),
                  ],
                ),
              ),
              const SizedBox(width: GcSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '—',
                    style: textStyles.label.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.exercisesMaxLabel,
                    style: textStyles.micro.copyWith(
                      color: colors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: GcSpacing.sm),
              Icon(
                GcIcons.chevronRight,
                size: GcIcons.sizeSm + 2,
                color: colors.textDisabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
