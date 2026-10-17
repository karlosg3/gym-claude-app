import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/exercises/application/exercises_service.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Selector de un ejercicio extra para la sesión. Devuelve el id elegido.
class ExercisePickerSheet extends ConsumerWidget {
  const ExercisePickerSheet({required this.excludedIds, super.key});

  final Set<int> excludedIds;

  static Future<int?> show(BuildContext context, Set<int> excludedIds) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ExercisePickerSheet(excludedIds: excludedIds),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;
    final library = ref.watch(allExercisesProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              GcSpacing.screenHorizontal,
              0,
              GcSpacing.screenHorizontal,
              GcSpacing.md,
            ),
            child: Text(l10n.workoutAddExercise, style: t.headline),
          ),
          Flexible(
            child: AsyncValueView(
              value: library,
              data: (all) {
                final options = all
                    .where((e) => !excludedIds.contains(e.id))
                    .toList();
                if (options.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(GcSpacing.xxl),
                    child: Text(
                      l10n.workoutPickExerciseEmpty,
                      textAlign: TextAlign.center,
                      style: t.body.copyWith(color: c.textFaint),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom + GcSpacing.lg,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, i) {
                    final exercise = options[i];
                    return ListTile(
                      onTap: () => Navigator.of(context).pop(exercise.id),
                      leading: ExerciseAvatar(
                        name: exercise.name,
                        muscleGroup: exercise.muscleGroup,
                      ),
                      title: Text(exercise.name, style: t.bodyStrong),
                      subtitle: Text(
                        MuscleTag.localizedLabel(context, exercise.muscleGroup),
                        style: t.label.copyWith(color: c.textMuted),
                      ),
                      trailing: Icon(GcIcons.add, color: c.accent),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
