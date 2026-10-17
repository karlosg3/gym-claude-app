import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/exercises/application/exercises_service.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla para buscar y asignar un ejercicio de la biblioteca a un día concreto de una rutina.
class RoutineAddExerciseScreen extends ConsumerStatefulWidget {
  const RoutineAddExerciseScreen({
    super.key,
    required this.routineId,
    required this.weekday,
  });

  final int routineId;
  final Weekday weekday;

  @override
  ConsumerState<RoutineAddExerciseScreen> createState() =>
      _RoutineAddExerciseScreenState();
}

class _RoutineAddExerciseScreenState
    extends ConsumerState<RoutineAddExerciseScreen> {
  String _query = '';
  MuscleGroup? _group;

  static const _weekdayNames = {
    Weekday.monday: 'Lunes',
    Weekday.tuesday: 'Martes',
    Weekday.wednesday: 'Miércoles',
    Weekday.thursday: 'Jueves',
    Weekday.friday: 'Viernes',
    Weekday.saturday: 'Sábado',
    Weekday.sunday: 'Domingo',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final textStyles = context.gcText;

    final libraryAsync = ref.watch(allExercisesProvider);
    final routineAsync = ref.watch(routineDetailProvider(widget.routineId));

    final filterItems = [
      FilterChipItem<MuscleGroup?>(value: null, label: l10n.exercisesFilterAll),
      for (final g in MuscleGroup.values)
        FilterChipItem<MuscleGroup?>(
          value: g,
          label: MuscleTag.localizedLabel(context, g),
        ),
    ];

    final dayName = _weekdayNames[widget.weekday] ?? widget.weekday.name;

    return GcScaffold(
      leading: IconSquareButton(
        icon: GcIcons.chevronLeft,
        semanticLabel: l10n.actionBack,
        onPressed: () => Navigator.of(context).pop(),
      ),
      overline: dayName,
      title: l10n.routineAddExerciseButton,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GcSpacing.screenHorizontal,
                vertical: GcSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GcSearchField(
                    hintText: l10n.exercisesSearchPlaceholder,
                    initialValue: _query,
                    onChanged: (val) => setState(() => _query = val),
                  ),
                  const SizedBox(height: GcSpacing.md),
                  FilterChipRow<MuscleGroup?>(
                    items: filterItems,
                    selectedValue: _group,
                    onSelected: (group) => setState(() => _group = group),
                  ),
                ],
              ),
            ),
          ),
          libraryAsync.when(
            data: (allExercises) {
              final assignedExerciseIds = routineAsync.maybeWhen(
                data: (routine) =>
                    routine
                        ?.itemsFor(widget.weekday)
                        .map((it) => it.exercise.id)
                        .toSet() ??
                    const <int>{},
                orElse: () => const <int>{},
              );

              final filtered = allExercises.where((exercise) {
                if (assignedExerciseIds.contains(exercise.id)) {
                  return false;
                }
                if (_group != null && exercise.muscleGroup != _group) {
                  return false;
                }
                if (_query.trim().isNotEmpty) {
                  final q = _query.trim().toLowerCase();
                  if (!exercise.name.toLowerCase().contains(q)) {
                    return false;
                  }
                }
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(GcSpacing.xxl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.exercisesEmptySearch,
                            style: textStyles.body.copyWith(
                              color: colors.textFaint,
                            ),
                          ),
                          const SizedBox(height: GcSpacing.md),
                          SecondaryButton(
                            icon: GcIcons.add,
                            label: l10n.exercisesNewButton,
                            onPressed: () => context.pushExerciseNew(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: GcSpacing.screenHorizontal,
                  vertical: GcSpacing.xs,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final exercise = filtered[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: GcSpacing.sm),
                      decoration: BoxDecoration(
                        color: colors.surfaceSunken,
                        borderRadius: BorderRadius.circular(GcRadii.md),
                        border: Border.all(color: colors.border),
                      ),
                      child: ListTile(
                        onTap: () async {
                          try {
                            await ref
                                .read(routinesServiceProvider)
                                .addExercise(
                                  widget.routineId,
                                  widget.weekday,
                                  exercise.id,
                                );
                            if (context.mounted) {
                              showGcSnackBar(
                                context,
                                l10n.routineExerciseAdded,
                                aboveNavBar: true,
                              );
                              Navigator.of(context).pop();
                            }
                          } on DomainException catch (e) {
                            if (context.mounted) {
                              showGcSnackBar(
                                context,
                                e.message,
                                aboveNavBar: true,
                              );
                            }
                          }
                        },
                        leading: ExerciseAvatar(
                          name: exercise.name,
                          muscleGroup: exercise.muscleGroup,
                        ),
                        title: Text(
                          exercise.name,
                          style: textStyles.bodyStrong,
                        ),
                        subtitle: Text(
                          MuscleTag.localizedLabel(
                            context,
                            exercise.muscleGroup,
                          ),
                          style: textStyles.label.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                        trailing: Icon(
                          GcIcons.add,
                          color: colors.accent,
                          size: GcIcons.sizeMd,
                        ),
                      ),
                    );
                  }, childCount: filtered.length),
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
          SliverToBoxAdapter(
            child: SizedBox(
              height:
                  MediaQuery.paddingOf(context).bottom +
                  GcSpacing.navBarClearance,
            ),
          ),
        ],
      ),
    );
  }
}
