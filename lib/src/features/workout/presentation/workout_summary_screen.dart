import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/workout/application/workout_service.dart';
import 'package:gym_claude/src/features/workout/domain/session_exercise.dart';
import 'package:gym_claude/src/features/workout/domain/workout_session.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Resumen tras finalizar: llama que se enciende, estadísticas y mejor serie por ejercicio.
/// El contador de racha llega en la fase 4 (`progress`).
class WorkoutSummaryScreen extends ConsumerWidget {
  const WorkoutSummaryScreen({required this.sessionId, super.key});

  final int sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final sessionAsync = ref.watch(workoutSessionProvider(sessionId));

    return PopScope(
      canPop: false,
      // Desde el resumen no se vuelve a la sesión.
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.goHome();
      },
      child: AsyncValueView(
        value: sessionAsync,
        data: (session) {
          if (session == null) {
            return GcScaffold(
              body: EmptyState(
                icon: GcIcons.alert,
                title: l10n.summaryNotFound,
                description: '',
                actionLabel: l10n.summaryDone,
                onAction: context.goHome,
              ),
            );
          }
          return _Summary(session: session);
        },
      ),
    );
  }
}

class _Summary extends ConsumerWidget {
  const _Summary({required this.session});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;
    final records =
        ref.watch(sessionRecordsProvider(session.id)).value ?? const <int>{};
    final hasSets = session.totalSets > 0;
    final duration = session.durationAt(session.endedAt ?? session.startedAt);

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: GcSpacing.maxContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      GcSpacing.screenHorizontal,
                      GcSpacing.xl,
                      GcSpacing.screenHorizontal,
                      GcSpacing.lg,
                    ),
                    children: [
                      Center(
                        child: StreakFlame(
                          mode: hasSets ? FlameMode.ignite : FlameMode.off,
                          size: 180,
                        ),
                      ),
                      const SizedBox(height: GcSpacing.md),
                      Text(
                        l10n.summaryTitle,
                        textAlign: TextAlign.center,
                        style: t.display,
                      ),
                      const SizedBox(height: GcSpacing.xs),
                      Text(
                        l10n.summarySubtitle(
                          session.title,
                          DateLabels.longDate(session.date),
                        ),
                        textAlign: TextAlign.center,
                        style: t.body.copyWith(color: c.textMuted),
                      ),
                      const SizedBox(height: GcSpacing.xxl),
                      Row(
                        children: [
                          Expanded(
                            child: StatTile(
                              value: DurationFormatter.minutesLabel(duration),
                              label: l10n.summaryDuration,
                            ),
                          ),
                          const SizedBox(width: GcSpacing.md),
                          Expanded(
                            child: StatTile(
                              value: '${session.totalSets}',
                              label: l10n.summarySets,
                            ),
                          ),
                          const SizedBox(width: GcSpacing.md),
                          Expanded(
                            child: StatTile(
                              value: '${session.exercisesDone}',
                              suffix: '/${session.exercises.length}',
                              label: l10n.summaryExercises,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: GcSpacing.xxl),
                      Text(
                        l10n.summaryByExercise.toUpperCase(),
                        style: t.overline.copyWith(color: c.textMuted),
                      ),
                      const SizedBox(height: GcSpacing.md),
                      for (final exercise in session.exercises) ...[
                        _ExerciseSummaryRow(
                          exercise: exercise,
                          isRecord: records.contains(exercise.exercise.id),
                        ),
                        const SizedBox(height: GcSpacing.md),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    GcSpacing.screenHorizontal,
                    GcSpacing.sm,
                    GcSpacing.screenHorizontal,
                    GcSpacing.lg,
                  ),
                  child: PrimaryButton(
                    key: const Key('summary-done'),
                    label: l10n.summaryDone,
                    onPressed: context.goHome,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseSummaryRow extends StatelessWidget {
  const _ExerciseSummaryRow({required this.exercise, required this.isRecord});

  final SessionExercise exercise;
  final bool isRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;
    final done = exercise.hasSets;
    final best = exercise.bestSet;
    final bestLabel = best == null
        ? WeightFormatter.noData
        : '${WeightFormatter.format(best.weight, exercise.exercise.unit, isBodyweight: exercise.isBodyweight, short: true)} × ${best.reps}';

    return GcCard(
      padding: const EdgeInsets.symmetric(
        horizontal: GcSpacing.lg + 2,
        vertical: GcSpacing.md + 2,
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done
                  ? MuscleGroupColors.of(exercise.exercise.muscleGroup).color
                  : c.surfaceRaised,
            ),
          ),
          const SizedBox(width: GcSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.exercise.name,
                  style: t.bodyStrong.copyWith(
                    color: done ? c.textPrimary : c.textFaint,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  l10n.summarySetsCount(exercise.sets.length),
                  style: t.label.copyWith(
                    color: done ? c.textMuted : c.textFaint,
                  ),
                ),
              ],
            ),
          ),
          if (isRecord) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: GcSpacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: c.accentSoft,
                borderRadius: GcRadii.borderPill,
              ),
              child: Text(
                l10n.workoutRecordBadge,
                style: t.micro.copyWith(
                  color: c.accent,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: GcSpacing.sm),
          ],
          Text(
            bestLabel,
            style: t.bodyStrong.copyWith(
              color: done ? c.textPrimary : c.textFaint,
            ),
          ),
        ],
      ),
    );
  }
}
