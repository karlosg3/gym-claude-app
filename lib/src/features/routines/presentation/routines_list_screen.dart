import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/features/routines/domain/routine.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla principal de la pestaña Rutinas.
/// Muestra las rutinas semanales configuradas con sus días activos y resumen de ejercicios.
class RoutinesListScreen extends ConsumerWidget {
  const RoutinesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final textStyles = context.gcText;
    final routinesAsync = ref.watch(routinesListProvider);

    return GcScaffold(
      title: l10n.navRoutines,
      floatingActionButton: FloatingActionButton(
        heroTag: 'routines_fab',
        onPressed: () => context.pushRoutineNew(),
        backgroundColor: colors.accent,
        foregroundColor: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GcRadii.md),
        ),
        tooltip: l10n.routinesNewButton,
        child: const Icon(GcIcons.add, size: GcIcons.sizeMd),
      ),
      body: routinesAsync.when(
        data: (routines) {
          if (routines.isEmpty) {
            return EmptyState(
              icon: GcIcons.routines,
              title: l10n.routinesEmptyTitle,
              description: l10n.routinesEmptyDesc,
              actionLabel: l10n.routinesNewButton,
              onAction: () => context.pushRoutineNew(),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              GcSpacing.screenHorizontal,
              GcSpacing.sm,
              GcSpacing.screenHorizontal,
              140,
            ),
            itemCount: routines.length,
            separatorBuilder: (context, index) => const SizedBox(height: GcSpacing.md),
            itemBuilder: (context, index) {
              final routine = routines[index];
              return _RoutineCard(
                routine: routine,
                onTap: () => context.goRoutine(routine.id),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(
            l10n.errorUnexpectedTitle,
            style: textStyles.body.copyWith(color: colors.danger),
          ),
        ),
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard({
    required this.routine,
    required this.onTap,
  });

  final Routine routine;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final text = context.gcText;
    final l10n = context.l10n;

    final accent = routine.accentGroup != null
        ? MuscleGroupColors.of(routine.accentGroup!).color
        : colors.accent;

    return GcCard(
      onTap: onTap,
      padding: const EdgeInsets.all(GcSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  routine.name,
                  style: text.bodyStrong,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (routine.accentGroup != null) ...[
                const SizedBox(width: GcSpacing.sm),
                MuscleTag(group: routine.accentGroup!),
              ],
            ],
          ),
          if (routine.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              routine.description,
              style: text.caption.copyWith(color: colors.textMuted),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: GcSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.routinesExercisesAndDays(
                    routine.totalExercisesCount,
                    routine.activeDaysCount,
                  ),
                  style: text.label.copyWith(color: colors.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: GcSpacing.sm),
              DayPills(
                activeDays: routine.activeDays,
                accentColor: accent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
