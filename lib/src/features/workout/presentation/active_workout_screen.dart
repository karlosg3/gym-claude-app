import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/core/events/app_event.dart';
import 'package:gym_claude/src/core/events/app_event_bus.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/workout/application/workout_service.dart';
import 'package:gym_claude/src/features/workout/domain/active_workout.dart';
import 'package:gym_claude/src/features/workout/domain/finish_outcome.dart';
import 'package:gym_claude/src/features/workout/domain/session_exercise.dart';
import 'package:gym_claude/src/features/workout/domain/set_record.dart';
import 'package:gym_claude/src/features/workout/presentation/controllers/active_workout_controller.dart';
import 'package:gym_claude/src/features/workout/presentation/widgets/exercise_picker_sheet.dart';
import 'package:gym_claude/src/features/workout/presentation/widgets/set_input_row.dart';
import 'package:gym_claude/src/features/workout/presentation/widgets/workout_timer.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Registro de la sesión activa serie a serie. Pantalla completa, sin barra inferior.
class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  ConsumerState<ActiveWorkoutScreen> createState() =>
      _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  static const _noteDebounce = Duration(milliseconds: 400);

  final _note = TextEditingController();
  int? _noteExerciseId;
  Timer? _noteTimer;

  String? _inputError;
  final _recordExerciseIds = <int>{};
  StreamSubscription<PersonalRecordAchieved>? _records;

  /// Evita volver a Inicio dos veces cuando la propia pantalla cierra la sesión.
  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable().ignore();
    _records = ref
        .read(appEventBusProvider)
        .on<PersonalRecordAchieved>()
        .listen(_onRecord);
    // `/workout` sin sesión activa (deep link u otra pantalla la cerró) ⇒ Inicio.
    ref.listenManual(activeWorkoutProvider, (_, next) {
      if (next is AsyncData<ActiveWorkout?> && next.value == null) {
        _leaveTo(() => context.goHome());
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _flushNote();
    _records?.cancel();
    _note.dispose();
    WakelockPlus.disable().ignore();
    super.dispose();
  }

  void _leaveTo(VoidCallback navigate) {
    if (_leaving) return;
    _leaving = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) navigate();
    });
  }

  void _onRecord(PersonalRecordAchieved event) {
    if (!mounted) return;
    setState(() => _recordExerciseIds.add(event.exerciseId));
    showGcSnackBar(context, context.l10n.workoutNewRecord(event.exerciseName));
  }

  ActiveWorkoutController get _controller =>
      ref.read(activeWorkoutControllerProvider.notifier);

  // --- Nota con debounce -------------------------------------------------

  void _syncNote(SessionExercise exercise) {
    if (_noteExerciseId == exercise.id) return;
    _flushNote();
    _noteExerciseId = exercise.id;
    _note.text = exercise.note;
  }

  void _onNoteChanged(String _) {
    _noteTimer?.cancel();
    _noteTimer = Timer(_noteDebounce, _flushNote);
  }

  void _flushNote() {
    final pending = _noteTimer?.isActive ?? false;
    _noteTimer?.cancel();
    final id = _noteExerciseId;
    if (pending && id != null) {
      _controller.setNote(id, _note.text);
    }
  }

  // --- Navegación entre ejercicios --------------------------------------

  void _goTo(int index) {
    _flushNote();
    setState(() => _inputError = null);
    ref.read(currentExerciseIndexProvider.notifier).set(index);
  }

  // --- Acciones -----------------------------------------------------------

  Future<bool> _addSet(
    SessionExercise exercise,
    String weight,
    String reps,
  ) async {
    final ok = await _controller.addSet(
      exercise.id,
      weightText: weight,
      repsText: reps,
      unit: exercise.exercise.unit,
    );
    if (!mounted) return ok;
    setState(() => _inputError = ok ? null : _errorMessage());
    return ok;
  }

  String _errorMessage() {
    final error = ref.read(activeWorkoutControllerProvider).error;
    return error is DomainException
        ? error.message
        : context.l10n.errorUnexpectedTitle;
  }

  Future<void> _finish() async {
    _flushNote();
    _leaving = true;
    final outcome = await _controller.finish();
    if (!mounted) return;
    switch (outcome) {
      case FinishCompleted(:final sessionId):
        context.goWorkoutSummary(sessionId);
      case FinishDiscarded():
        showGcSnackBar(
          context,
          context.l10n.workoutDiscardedNoSets,
          aboveNavBar: true,
        );
        context.goHome();
      case null:
        _leaving = false;
        showGcSnackBar(context, _errorMessage());
    }
  }

  Future<void> _cancel(ActiveWorkout workout) async {
    final l10n = context.l10n;
    final sets = workout.session.totalSets;
    if (sets > 0) {
      final confirmed = await showConfirmDialog(
        context,
        title: l10n.workoutDiscardTitle,
        message: l10n.workoutDiscardMessage(sets),
        confirmLabel: l10n.workoutDiscardConfirm,
        cancelLabel: l10n.commonCancel,
        destructive: true,
      );
      if (!confirmed || !mounted) return;
    }
    _leaving = true;
    _noteTimer?.cancel();
    await _controller.discard();
    if (mounted) context.goHome();
  }

  Future<void> _addExercise(ActiveWorkout workout) async {
    final session = workout.session;
    final exerciseId = await ExercisePickerSheet.show(
      context,
      session.exercises.map((e) => e.exercise.id).toSet(),
    );
    if (exerciseId == null || !mounted) return;
    final ok = await _controller.addExercise(session.id, exerciseId);
    if (!mounted) return;
    if (ok) {
      _goTo(session.exercises.length);
    } else {
      showGcSnackBar(context, _errorMessage());
    }
  }

  Future<void> _editSet(SessionExercise exercise, SetRecord set) async {
    final l10n = context.l10n;
    final unit = exercise.exercise.unit;
    final weight = TextEditingController(
      text: WeightFormatter.formatNumber(set.weight.displayValue(unit)),
    );
    final reps = TextEditingController(text: '${set.reps}');
    String? error;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          backgroundColor: context.gcColors.surfaceSunken,
          title: Text(l10n.workoutEditSetTitle(set.setNumber)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GcTextField(
                label: l10n.workoutWeightHint(unit.name),
                controller: weight,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: GcSpacing.md),
              GcTextField(
                label: l10n.workoutRepsHint,
                controller: reps,
                keyboardType: TextInputType.number,
                errorText: error,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _controller.deleteSet(set.id);
              },
              style: TextButton.styleFrom(
                foregroundColor: context.gcColors.danger,
              ),
              child: Text(l10n.commonDelete),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () async {
                final ok = await _controller.updateSet(
                  set.id,
                  weightText: weight.text,
                  repsText: reps.text,
                  unit: unit,
                );
                if (!dialogContext.mounted) return;
                if (ok) {
                  Navigator.of(dialogContext).pop();
                } else {
                  setDialogState(() => error = _errorMessage());
                }
              },
              child: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
    weight.dispose();
    reps.dispose();
  }

  // --- UI -----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Mantiene vivo el controller mientras la pantalla está visible.
    ref.watch(activeWorkoutControllerProvider);
    final workoutAsync = ref.watch(activeWorkoutProvider);
    final l10n = context.l10n;

    return PopScope(
      canPop: false,
      // Atrás nunca descarta: vuelve a Inicio con la sesión activa.
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.goHome();
      },
      child: AsyncValueView(
        value: workoutAsync,
        data: (workout) {
          if (workout == null) {
            return GcScaffold(
              body: EmptyState(
                icon: GcIcons.clock,
                title: l10n.workoutNotActive,
                description: '',
              ),
            );
          }
          return _buildWorkout(context, workout);
        },
      ),
    );
  }

  Widget _buildWorkout(BuildContext context, ActiveWorkout workout) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;
    final session = workout.session;
    final exercises = session.exercises;

    final requested = ref.watch(currentExerciseIndexProvider);
    final index = exercises.isEmpty
        ? 0
        : (requested ?? session.resumeIndex).clamp(0, exercises.length - 1);
    if (requested == null && exercises.isNotEmpty) {
      // Al reanudar se coloca en el primer ejercicio sin series y se fija ahí: añadir
      // una serie no debe saltar solo al siguiente.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && ref.read(currentExerciseIndexProvider) == null) {
          ref.read(currentExerciseIndexProvider.notifier).set(index);
        }
      });
    }
    final current = exercises.isEmpty ? null : exercises[index];
    if (current != null) _syncNote(current);
    final isLast = exercises.isEmpty || index == exercises.length - 1;

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
                _Header(
                  workout: workout,
                  onCancel: () => _cancel(workout),
                  onAddExercise: () => _addExercise(workout),
                  onFinish: _finish,
                ),
                if (exercises.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GcSpacing.screenHorizontal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProgressSegments(
                          segments: [
                            for (var i = 0; i < exercises.length; i++)
                              exercises[i].hasSets
                                  ? SegmentState.done
                                  : i == index
                                  ? SegmentState.current
                                  : SegmentState.pending,
                          ],
                        ),
                        const SizedBox(height: GcSpacing.sm + 2),
                        Text(
                          l10n.workoutExerciseProgress(
                            index + 1,
                            exercises.length,
                          ),
                          style: t.label.copyWith(color: c.textMuted),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: current == null
                      ? EmptyState(
                          icon: GcIcons.exercises,
                          title: l10n.workoutEmptyTitle,
                          description: l10n.workoutEmptyDesc,
                          actionLabel: l10n.workoutAddExercise,
                          onAction: () => _addExercise(workout),
                        )
                      : _buildExercise(context, workout, current),
                ),
                _Footer(
                  canGoBack: index > 0,
                  isLast: isLast,
                  onBack: () => _goTo(index - 1),
                  onNext: () => _goTo(index + 1),
                  onFinish: _finish,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExercise(
    BuildContext context,
    ActiveWorkout workout,
    SessionExercise exercise,
  ) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;
    final unit = exercise.exercise.unit;
    final previous = workout.previousFor(exercise.exercise.id);
    final lastSet = exercise.sets.isEmpty ? null : exercise.sets.last;

    String setValue(SetRecord set) => l10n.workoutSetValue(
      WeightFormatter.format(
        set.weight,
        unit,
        isBodyweight: exercise.isBodyweight,
        short: true,
      ),
      set.reps,
    );

    final best = exercise.bestSet;
    final recordSetId = _recordExerciseIds.contains(exercise.exercise.id)
        ? exercise.sets
              .where((s) => s.performance == best)
              .map((s) => s.id)
              .firstOrNull
        : null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        GcSpacing.screenHorizontal,
        GcSpacing.lg,
        GcSpacing.screenHorizontal,
        GcSpacing.xl,
      ),
      children: [
        GcCard(
          padding: const EdgeInsets.all(GcSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exercise.exercise.name, style: t.display),
              const SizedBox(height: GcSpacing.sm),
              Wrap(
                spacing: GcSpacing.md,
                runSpacing: GcSpacing.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MuscleTag(group: exercise.exercise.muscleGroup),
                  if (exercise.target != null)
                    Text(
                      l10n.workoutTarget(exercise.target!.label),
                      style: t.body.copyWith(color: c.textMuted),
                    ),
                ],
              ),
              if (previous != null) ...[
                const SizedBox(height: GcSpacing.sm),
                Text(
                  l10n.workoutPrevious(
                    '${WeightFormatter.format(previous.weight, unit, isBodyweight: exercise.isBodyweight, short: true)} × ${previous.reps}',
                  ),
                  style: t.label.copyWith(color: c.textFaint),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: GcSpacing.xl),
        if (exercise.sets.isEmpty)
          Text(l10n.workoutNoSets, style: t.body.copyWith(color: c.textFaint))
        else ...[
          Text(
            l10n.workoutSetsTitle.toUpperCase(),
            style: t.overline.copyWith(color: c.textMuted),
          ),
          const SizedBox(height: GcSpacing.md),
          for (final set in exercise.sets) ...[
            SetRow(
              key: ValueKey('set-${set.id}'),
              label: l10n.workoutSetLabel(set.setNumber),
              value: setValue(set),
              badge: set.id == recordSetId ? l10n.workoutRecordBadge : null,
              onTap: () => _editSet(exercise, set),
              onDelete: () => _controller.deleteSet(set.id),
              deleteLabel: l10n.workoutDeleteSet,
            ),
            const SizedBox(height: GcSpacing.md),
          ],
        ],
        const SizedBox(height: GcSpacing.md),
        SetInputRow(
          key: ValueKey('input-${exercise.id}'),
          unitLabel: unit.name,
          initialWeight: lastSet == null
              ? ''
              : WeightFormatter.formatNumber(lastSet.weight.displayValue(unit)),
          initialReps: lastSet == null ? '' : '${lastSet.reps}',
          errorText: _inputError,
          onSubmit: (weight, reps) => _addSet(exercise, weight, reps),
        ),
        const SizedBox(height: GcSpacing.lg),
        GcTextField(
          key: const Key('workout-note'),
          controller: _note,
          hintText: l10n.workoutNoteHint,
          maxLines: 3,
          onChanged: _onNoteChanged,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.workout,
    required this.onCancel,
    required this.onAddExercise,
    required this.onFinish,
  });

  final ActiveWorkout workout;
  final VoidCallback onCancel;
  final VoidCallback onAddExercise;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        GcSpacing.screenHorizontal,
        GcSpacing.md,
        GcSpacing.xs,
        GcSpacing.lg,
      ),
      child: Row(
        children: [
          WorkoutTimer(startedAt: workout.session.startedAt),
          const SizedBox(width: GcSpacing.md),
          Expanded(
            child: Text(
              workout.session.title,
              style: t.label.copyWith(color: c.textMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(foregroundColor: c.accent),
            child: Text(l10n.commonCancel, style: t.bodyStrong),
          ),
          PopupMenuButton<VoidCallback>(
            tooltip: l10n.workoutMoreOptions,
            color: c.surfaceRaised,
            icon: Icon(GcIcons.more, color: c.textMuted),
            onSelected: (action) => action(),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: onAddExercise,
                child: Text(l10n.workoutAddExercise),
              ),
              PopupMenuItem(value: onFinish, child: Text(l10n.workoutFinish)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.canGoBack,
    required this.isLast,
    required this.onBack,
    required this.onNext,
    required this.onFinish,
  });

  final bool canGoBack;
  final bool isLast;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        GcSpacing.screenHorizontal,
        GcSpacing.sm,
        GcSpacing.screenHorizontal,
        GcSpacing.lg,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: IconSquareButton(
              icon: GcIcons.chevronLeft,
              semanticLabel: l10n.workoutPreviousExercise,
              onPressed: canGoBack ? onBack : null,
              color: canGoBack ? null : context.gcColors.textDisabled,
            ),
          ),
          const SizedBox(width: GcSpacing.md),
          Expanded(
            child: isLast
                ? PrimaryButton(
                    key: const Key('workout-finish'),
                    label: l10n.workoutFinish,
                    icon: GcIcons.check,
                    onPressed: onFinish,
                  )
                : PrimaryButton(
                    key: const Key('workout-next'),
                    label: l10n.workoutNext,
                    icon: GcIcons.chevronRight,
                    onPressed: onNext,
                  ),
          ),
        ],
      ),
    );
  }
}
