import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/time/clock_provider.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/workout/application/workout_service.dart';
import 'package:gym_claude/src/features/workout/domain/finish_outcome.dart';
import 'package:gym_claude/src/features/workout/domain/workout_session.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla principal de Inicio. Hasta la fase 4 solo ofrece reanudar la sesión activa
/// y resolver una sesión olvidada.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  /// Sesiones olvidadas por las que ya se preguntó en esta ejecución.
  final _askedStale = <int>{};

  @override
  void initState() {
    super.initState();
    ref.listenManual(activeSessionProvider, (_, next) {
      final session = next.value;
      if (session == null || _askedStale.contains(session.id)) return;
      if (session.isStaleAt(ref.read(clockProvider).now())) {
        _askedStale.add(session.id);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _resolveStale(session),
        );
      }
    }, fireImmediately: true);
  }

  /// "Tienes una sesión sin terminar del lunes" → Finalizar (hora de la última serie) o Descartar.
  Future<void> _resolveStale(WorkoutSession session) async {
    if (!mounted) return;
    final l10n = context.l10n;
    final today = ref.read(todayProvider);
    final finish = await showConfirmDialog(
      context,
      title: l10n.workoutStaleTitle,
      message: session.date == today
          ? l10n.workoutStaleMessageToday
          : l10n.workoutStaleMessageDay(
              DateLabels.weekdayLong(session.date.weekday).toLowerCase(),
            ),
      confirmLabel: l10n.workoutStaleFinish,
      cancelLabel: l10n.workoutDiscardConfirm,
    );
    final service = ref.read(workoutServiceProvider);
    if (finish) {
      final outcome = await service.finishStale();
      if (mounted && outcome is FinishCompleted) {
        context.goWorkoutSummary(outcome.sessionId);
      }
    } else {
      await service.discard();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final active = ref.watch(activeSessionProvider).value;

    return GcScaffold(
      title: l10n.navHome,
      actions: [
        IconSquareButton(
          icon: GcIcons.settings,
          semanticLabel: l10n.navSettings,
          onPressed: () => context.pushSettings(),
        ),
      ],
      body: active == null
          ? EmptyState(
              icon: GcIcons.home,
              title: l10n.navHome,
              description: l10n.emptyScreenPhase0Desc,
            )
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: GcSpacing.screenHorizontal,
                vertical: GcSpacing.lg,
              ),
              children: [_ResumeCard(session: active)],
            ),
    );
  }
}

class _ResumeCard extends ConsumerWidget {
  const _ResumeCard({required this.session});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;
    final now =
        ref.watch(tickerProvider).value ?? ref.read(clockProvider).now();

    return GcCard(
      padding: const EdgeInsets.all(GcSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.workoutResumeTitle.toUpperCase(),
                      style: t.overline.copyWith(color: c.textMuted),
                    ),
                    const SizedBox(height: GcSpacing.xs),
                    Text(session.title, style: t.headline),
                  ],
                ),
              ),
              GcTimerPill(elapsed: session.durationAt(now)),
            ],
          ),
          const SizedBox(height: GcSpacing.lg),
          PrimaryButton(
            key: const Key('home-resume'),
            icon: GcIcons.play,
            label: l10n.workoutResumeButton,
            onPressed: context.goWorkout,
          ),
        ],
      ),
    );
  }
}
