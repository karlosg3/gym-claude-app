import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_draft.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercises_providers.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Formulario para crear un nuevo ejercicio o editar uno existente.
class ExerciseFormScreen extends ConsumerStatefulWidget {
  const ExerciseFormScreen({this.exerciseId, super.key});

  final int? exerciseId;

  bool get isEditing => exerciseId != null;

  @override
  ConsumerState<ExerciseFormScreen> createState() => _ExerciseFormScreenState();
}

class _ExerciseFormScreenState extends ConsumerState<ExerciseFormScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  MuscleGroup _muscleGroup = MuscleGroup.chest;
  WeightUnit _unit = WeightUnit.kg;
  bool _isBodyweight = false;
  String? _errorMessage;
  bool _initialLoaded = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorMessage = l10n.exerciseFormErrorEmptyName;
      });
      return;
    }

    final draft = ExerciseDraft(
      name: name,
      muscleGroup: _muscleGroup,
      unit: _unit,
      isBodyweight: _isBodyweight,
      description: _descController.text.trim(),
    );

    setState(() {
      _errorMessage = null;
    });

    try {
      if (widget.isEditing) {
        final success = await ref
            .read(exerciseFormControllerProvider.notifier)
            .updateExercise(widget.exerciseId!, draft);
        if (success && mounted) {
          context.pop();
        }
      } else {
        final newId = await ref
            .read(exerciseFormControllerProvider.notifier)
            .createExercise(draft);
        if (newId != null && mounted) {
          context.goExercise(newId);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          if (e is DomainException) {
            _errorMessage = e.message;
          } else {
            _errorMessage = l10n.errorUnexpectedTitle;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final textStyles = context.gcText;

    if (!widget.isEditing && !_initialLoaded) {
      _initialLoaded = true;
    }

    if (widget.isEditing && !_initialLoaded) {
      final exerciseAsync = ref.watch(
        exerciseDetailProvider(widget.exerciseId!),
      );
      exerciseAsync.whenData((ex) {
        if (ex != null && !_initialLoaded) {
          _nameController.text = ex.name;
          _descController.text = ex.description;
          _muscleGroup = ex.muscleGroup;
          _unit = ex.unit;
          _isBodyweight = ex.isBodyweight;
          _initialLoaded = true;
        }
      });
    }

    return GcScaffold(
      title: widget.isEditing
          ? l10n.exerciseFormEditTitle
          : l10n.exerciseFormNewTitle,
      leading: IconSquareButton(
        icon: GcIcons.back,
        semanticLabel: l10n.actionBack,
        onPressed: () => context.pop(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: GcSpacing.screenHorizontal,
          vertical: GcSpacing.md,
        ),
        children: [
          // NOMBRE
          Text(
            l10n.exerciseFormNameLabel.toUpperCase(),
            style: textStyles.overline.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: GcSpacing.sm),
          TextField(
            controller: _nameController,
            style: textStyles.bodyStrong.copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: l10n.exerciseFormNamePlaceholder,
              hintStyle: textStyles.body.copyWith(color: colors.textFaint),
              filled: true,
              fillColor: colors.surface,
              contentPadding: const EdgeInsets.all(GcSpacing.md + 2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(GcRadii.md),
                borderSide: BorderSide(
                  color: _errorMessage != null ? colors.danger : colors.border,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(GcRadii.md),
                borderSide: BorderSide(
                  color: _errorMessage != null ? colors.danger : colors.border,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(GcRadii.md),
                borderSide: BorderSide(
                  color: _errorMessage != null ? colors.danger : colors.accent,
                ),
              ),
            ),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: GcSpacing.xs + 2),
            Text(
              _errorMessage!,
              style: textStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.error,
              ),
            ),
          ],
          const SizedBox(height: GcSpacing.xl),

          // GRUPO MUSCULAR
          Text(
            l10n.exerciseFormMuscleLabel.toUpperCase(),
            style: textStyles.overline.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: GcSpacing.sm + 2),
          Wrap(
            spacing: GcSpacing.sm + 1,
            runSpacing: GcSpacing.sm + 1,
            children: [
              for (final group in MuscleGroup.values)
                Builder(
                  builder: (context) {
                    final isSelected = group == _muscleGroup;
                    final pair = MuscleGroupColors.of(group);

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _muscleGroup = group;
                        });
                      },
                      borderRadius: BorderRadius.circular(GcRadii.full),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GcSpacing.lg,
                          vertical: GcSpacing.sm + 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? pair.color : colors.surface,
                          borderRadius: BorderRadius.circular(GcRadii.full),
                          border: Border.all(
                            color: isSelected ? pair.color : colors.border,
                          ),
                        ),
                        child: Text(
                          MuscleTag.localizedLabel(context, group),
                          style: textStyles.label.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? colors.background
                                : colors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: GcSpacing.xl),

          // UNIDAD DE PESO
          Text(
            l10n.exerciseFormUnitLabel.toUpperCase(),
            style: textStyles.overline.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: GcSpacing.sm + 2),
          Row(
            children: [
              for (final unit in WeightUnit.values)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: unit == WeightUnit.kg ? GcSpacing.sm : 0,
                      left: unit == WeightUnit.lb ? GcSpacing.sm : 0,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _unit = unit;
                        });
                      },
                      borderRadius: BorderRadius.circular(GcRadii.md),
                      child: Container(
                        padding: const EdgeInsets.all(GcSpacing.md),
                        decoration: BoxDecoration(
                          color: _unit == unit ? colors.accent : colors.surface,
                          borderRadius: BorderRadius.circular(GcRadii.md),
                          border: Border.all(
                            color: _unit == unit
                                ? colors.accent
                                : colors.border,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          unit.name,
                          style: textStyles.bodyStrong.copyWith(
                            color: _unit == unit
                                ? colors.background
                                : colors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: GcSpacing.xl),

          // PESO CORPORAL
          GcCard(
            padding: EdgeInsets.zero,
            child: GcSwitchRow(
              title: l10n.exerciseFormBodyweightLabel,
              subtitle: l10n.exerciseFormBodyweightSubtitle,
              value: _isBodyweight,
              showTopDivider: false,
              onChanged: (val) {
                setState(() {
                  _isBodyweight = val;
                });
              },
            ),
          ),
          const SizedBox(height: GcSpacing.xl),

          // DESCRIPCIÓN
          Row(
            children: [
              Text(
                l10n.exerciseFormDescLabel.toUpperCase(),
                style: textStyles.overline.copyWith(color: colors.textMuted),
              ),
              const SizedBox(width: GcSpacing.xs),
              Text(
                l10n.exerciseFormDescOptional,
                style: textStyles.caption.copyWith(color: colors.textFaint),
              ),
            ],
          ),
          const SizedBox(height: GcSpacing.sm),
          TextField(
            controller: _descController,
            minLines: 4,
            maxLines: 6,
            style: textStyles.body.copyWith(
              color: colors.textPrimary,
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: l10n.exerciseFormDescPlaceholder,
              hintStyle: textStyles.body.copyWith(color: colors.textFaint),
              filled: true,
              fillColor: colors.surface,
              contentPadding: const EdgeInsets.all(GcSpacing.md + 2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(GcRadii.md),
                borderSide: BorderSide(color: colors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(GcRadii.md),
                borderSide: BorderSide(color: colors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(GcRadii.md),
                borderSide: BorderSide(color: colors.accent),
              ),
            ),
          ),
          const SizedBox(height: GcSpacing.xxl),

          // BOTONES
          PrimaryButton(label: l10n.exerciseFormSave, onPressed: _submit),
          const SizedBox(height: GcSpacing.sm),
          SecondaryButton(
            label: l10n.exerciseFormCancel,
            onPressed: () => context.pop(),
          ),
          const SizedBox(height: GcSpacing.xl),
        ],
      ),
    );
  }
}
