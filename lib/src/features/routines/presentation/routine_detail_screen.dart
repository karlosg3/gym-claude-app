import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/features/routines/domain/routine.dart';
import 'package:gym_claude/src/features/routines/domain/routine_item.dart';
import 'package:gym_claude/src/features/routines/presentation/widgets/rep_scheme_bottom_sheet.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla de detalle de una rutina con navegación por pestañas de día,
/// reordenación de ejercicios, edición de series/reps y eliminación.
class RoutineDetailScreen extends ConsumerStatefulWidget {
  const RoutineDetailScreen({
    super.key,
    required this.routineId,
    this.initialDay,
  });

  final int routineId;
  final int? initialDay;

  @override
  ConsumerState<RoutineDetailScreen> createState() =>
      _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends ConsumerState<RoutineDetailScreen> {
  Weekday? _selectedDay;

  Weekday _resolveInitialDay(Routine routine) {
    if (widget.initialDay != null) {
      final requested = Weekday.fromIso(widget.initialDay!);
      if (routine.activeDays.contains(requested)) {
        return requested;
      }
    }
    final today = Weekday.fromDateTime(DateTime.now());
    if (routine.activeDays.contains(today)) {
      return today;
    }
    if (routine.activeDays.isNotEmpty) {
      final sorted = routine.activeDays.toList()
        ..sort((a, b) => a.isoValue.compareTo(b.isoValue));
      return sorted.first;
    }
    return Weekday.monday;
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = context.l10n;
    final colors = context.gcColors;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: colors.surfaceSunken,
        title: Text(l10n.routineDeleteTitle),
        content: Text(l10n.routineDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.danger),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(routinesServiceProvider).delete(widget.routineId);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _editScheme(BuildContext context, RoutineItem item) async {
    final newScheme = await RepSchemeBottomSheet.show(
      context: context,
      initialScheme: item.scheme,
      exerciseName: item.exercise.name,
    );

    if (newScheme != null && mounted) {
      await ref.read(routinesServiceProvider).setScheme(item.id, newScheme);
    }
  }

  Future<void> _removeItem(BuildContext context, RoutineItem item) async {
    await ref.read(routinesServiceProvider).removeItem(item.id);
    if (context.mounted) {
      showGcSnackBar(
        context,
        context.l10n.routineExerciseRemoved,
        aboveNavBar: true,
      );
    }
  }

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
    final routineAsync = ref.watch(routineDetailProvider(widget.routineId));

    return routineAsync.when(
      data: (routine) {
        if (routine == null) {
          return GcScaffold(
            leading: IconSquareButton(
              icon: GcIcons.chevronLeft,
              semanticLabel: l10n.actionBack,
              onPressed: () => Navigator.of(context).pop(),
            ),
            body: Center(
              child: Text(
                l10n.routineNotFound,
                style: textStyles.body.copyWith(color: colors.textMuted),
              ),
            ),
          );
        }

        final activeDay = _selectedDay ?? _resolveInitialDay(routine);
        final dayItems = routine.itemsFor(activeDay);

        return GcScaffold(
          leading: IconSquareButton(
            icon: GcIcons.chevronLeft,
            semanticLabel: l10n.actionBack,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: routine.name,
          actions: [
            IconSquareButton(
              icon: GcIcons.edit,
              semanticLabel: l10n.commonEdit,
              onPressed: () => context.pushRoutineEdit(routine.id),
            ),
            const SizedBox(width: GcSpacing.xs),
            IconSquareButton(
              icon: GcIcons.delete,
              semanticLabel: l10n.commonDelete,
              onPressed: () => _confirmDelete(context),
            ),
          ],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Selector de día en pestañas horizontales
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: GcSpacing.screenHorizontal,
                  vertical: GcSpacing.sm,
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: colors.border)),
                ),
                child: Center(
                  child: DayPills(
                    activeDays: routine.activeDays,
                    selectedDay: activeDay,
                    size: 38.0,
                    onDaySelected: (day) {
                      setState(() => _selectedDay = day);
                    },
                    accentColor: routine.accentGroup != null
                        ? MuscleGroupColors.of(routine.accentGroup!).color
                        : colors.accent,
                  ),
                ),
              ),

              // Cabecera del día
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  GcSpacing.screenHorizontal,
                  GcSpacing.md,
                  GcSpacing.screenHorizontal,
                  GcSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _weekdayNames[activeDay] ?? activeDay.name,
                      style: textStyles.headline,
                    ),
                    Text(
                      '${dayItems.length} ${dayItems.length == 1 ? "ejercicio" : "ejercicios"}',
                      style: textStyles.label.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
              ),

              // Lista de ejercicios del día
              Expanded(
                child: dayItems.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(GcSpacing.xl),
                          child: Text(
                            l10n.routineEmptyDay,
                            textAlign: TextAlign.center,
                            style: textStyles.body.copyWith(
                              color: colors.textFaint,
                            ),
                          ),
                        ),
                      )
                    : ReorderableListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GcSpacing.screenHorizontal,
                          vertical: GcSpacing.xs,
                        ),
                        itemCount: dayItems.length,
                        // ignore: deprecated_member_use
                        onReorder: (oldIndex, newIndex) {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          ref
                              .read(routinesServiceProvider)
                              .reorder(
                                routine.id,
                                activeDay,
                                oldIndex,
                                newIndex,
                              );
                        },
                        itemBuilder: (context, index) {
                          final item = dayItems[index];
                          return _RoutineExerciseTile(
                            key: ValueKey(item.id),
                            item: item,
                            index: index,
                            onSchemeTap: () => _editScheme(context, item),
                            onDeleteTap: () => _removeItem(context, item),
                          );
                        },
                      ),
              ),

              // Botones inferiores de acción
              Padding(
                padding: EdgeInsets.fromLTRB(
                  GcSpacing.screenHorizontal,
                  GcSpacing.sm,
                  GcSpacing.screenHorizontal,
                  MediaQuery.paddingOf(context).bottom +
                      GcSpacing.navBarClearance,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SecondaryButton(
                      icon: GcIcons.add,
                      label: l10n.routineAddExerciseButton,
                      onPressed: () {
                        context.pushRoutineDayAddExercise(
                          routineId: routine.id,
                          weekday: activeDay.isoValue,
                        );
                      },
                    ),
                    const SizedBox(height: GcSpacing.sm),
                    PrimaryButton(
                      icon: GcIcons.play,
                      label: l10n.routineStartDayButton,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Sesiones de entrenamiento disponibles en la Fase 3',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
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

class _RoutineExerciseTile extends StatelessWidget {
  const _RoutineExerciseTile({
    super.key,
    required this.item,
    required this.index,
    required this.onSchemeTap,
    required this.onDeleteTap,
  });

  final RoutineItem item;
  final int index;
  final VoidCallback onSchemeTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final text = context.gcText;

    return Container(
      margin: const EdgeInsets.only(bottom: GcSpacing.sm),
      decoration: BoxDecoration(
        color: colors.surfaceSunken,
        borderRadius: BorderRadius.circular(GcRadii.md),
        border: Border.all(color: colors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: GcSpacing.md,
          vertical: 2,
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReorderableDragStartListener(
              index: index,
              child: Icon(
                GcIcons.dragHandle,
                color: colors.textFaint,
                size: 20,
              ),
            ),
            const SizedBox(width: GcSpacing.xs),
            ExerciseAvatar(
              name: item.exercise.name,
              muscleGroup: item.exercise.muscleGroup,
              size: ExerciseAvatarSize.sm,
            ),
          ],
        ),
        title: Text(
          item.exercise.name,
          style: text.bodyStrong,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          item.exercise.muscleGroup.name.toUpperCase(),
          style: text.micro.copyWith(
            color: MuscleGroupColors.of(item.exercise.muscleGroup).color,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pastilla para ver / editar esquema
            InkWell(
              onTap: onSchemeTap,
              borderRadius: BorderRadius.circular(GcRadii.sm),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: GcSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceRaised,
                  borderRadius: BorderRadius.circular(GcRadii.sm),
                  border: Border.all(color: colors.borderStrong),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.scheme.label,
                      style: text.label.copyWith(
                        color: colors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(GcIcons.edit, size: 12, color: colors.textMuted),
                  ],
                ),
              ),
            ),
            const SizedBox(width: GcSpacing.xs),
            IconButton(
              icon: Icon(
                GcIcons.delete,
                size: GcIcons.sizeSm,
                color: colors.danger,
              ),
              onPressed: onDeleteTap,
            ),
          ],
        ),
      ),
    );
  }
}
