import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/features/routines/domain/routine.dart';
import 'package:gym_claude/src/features/routines/domain/routine_draft.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Formulario para crear o editar una rutina semanal.
class RoutineFormScreen extends ConsumerStatefulWidget {
  const RoutineFormScreen({super.key, this.routineId});

  final int? routineId;

  @override
  ConsumerState<RoutineFormScreen> createState() => _RoutineFormScreenState();
}

class _RoutineFormScreenState extends ConsumerState<RoutineFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Set<Weekday> _activeDays = {
    Weekday.monday,
    Weekday.wednesday,
    Weekday.friday,
  };
  bool _initialized = false;
  Routine? _existingRoutine;
  String? _errorMessage;
  String? _nameError;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initFromRoutine(Routine routine) {
    if (_initialized) return;
    _initialized = true;
    _existingRoutine = routine;
    _nameController.text = routine.name;
    _descriptionController.text = routine.description;
    _activeDays = Set.of(routine.activeDays);
  }

  void _toggleDay(Weekday day) {
    setState(() {
      if (_activeDays.contains(day)) {
        if (_activeDays.length > 1) {
          _activeDays.remove(day);
        }
      } else {
        _activeDays.add(day);
      }
    });
  }

  Future<void> _save() async {
    setState(() {
      _errorMessage = null;
      _nameError = null;
    });

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = 'El nombre no puede estar vacío');
      return;
    }
    if (name.length > 60) {
      setState(
        () => _nameError = 'El nombre no puede superar los 60 caracteres',
      );
      return;
    }
    if (_activeDays.isEmpty) {
      setState(() => _errorMessage = 'Selecciona al menos un día');
      return;
    }

    final draft = RoutineDraft(
      name: name,
      description: _descriptionController.text.trim(),
      activeDays: _activeDays,
    );

    try {
      if (widget.routineId != null) {
        await ref
            .read(routinesServiceProvider)
            .update(widget.routineId!, draft);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        final newId = await ref.read(routinesServiceProvider).create(draft);
        if (mounted) {
          // Navegar a la rutina recién creada
          Navigator.of(context).pop();
          context.goRoutine(newId);
        }
      }
    } on DomainException catch (e) {
      if (mounted) {
        setState(() => _errorMessage = e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final textStyles = context.gcText;

    if (widget.routineId != null && !_initialized) {
      final routineAsync = ref.watch(routineDetailProvider(widget.routineId!));
      return routineAsync.when(
        data: (routine) {
          if (routine != null) {
            _initFromRoutine(routine);
          }
          return _buildForm(context, l10n, colors, textStyles);
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

    return _buildForm(context, l10n, colors, textStyles);
  }

  Widget _buildForm(
    BuildContext context,
    AppLocalizations l10n,
    dynamic colors,
    dynamic textStyles,
  ) {
    final isEditing = widget.routineId != null;
    final title = isEditing ? l10n.routineEditTitle : l10n.routineNewTitle;

    // Calcular si hay ejercicios que se perderán al desactivar días
    final removedExercisesCount =
        _existingRoutine?.items
            .where((item) => !_activeDays.contains(item.weekday))
            .length ??
        0;

    return GcScaffold(
      leading: IconSquareButton(
        icon: GcIcons.chevronLeft,
        semanticLabel: l10n.actionBack,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: title,
      scrollable: true,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(GcSpacing.md),
                decoration: BoxDecoration(
                  color: colors.danger.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(GcRadii.md),
                  border: Border.all(
                    color: colors.danger.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  _errorMessage!,
                  style: textStyles.body.copyWith(color: colors.danger),
                ),
              ),
              const SizedBox(height: GcSpacing.lg),
            ],

            // Nombre
            GcTextField(
              controller: _nameController,
              label: l10n.routineNameLabel,
              hintText: l10n.routineNamePlaceholder,
              errorText: _nameError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: GcSpacing.xl),

            // Selector de Días activos
            Text(
              l10n.routineActiveDaysLabel,
              style: textStyles.label.copyWith(color: colors.textMuted),
            ),
            const SizedBox(height: GcSpacing.xs),
            Text(
              'Selecciona los días de la semana en los que entrenarás',
              style: textStyles.caption.copyWith(color: colors.textFaint),
            ),
            const SizedBox(height: GcSpacing.md),
            Center(
              child: DayPills(
                activeDays: _activeDays,
                size: 42.0,
                onDayToggled: _toggleDay,
              ),
            ),
            if (removedExercisesCount > 0) ...[
              const SizedBox(height: GcSpacing.md),
              Container(
                padding: const EdgeInsets.all(GcSpacing.md),
                decoration: BoxDecoration(
                  color: colors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(GcRadii.md),
                  border: Border.all(
                    color: colors.error.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(GcIcons.alert, color: colors.error, size: 20),
                    const SizedBox(width: GcSpacing.sm),
                    Expanded(
                      child: Text(
                        'Se quitarán $removedExercisesCount ${removedExercisesCount == 1 ? "ejercicio" : "ejercicios"} de los días desactivados.',
                        style: textStyles.caption.copyWith(color: colors.error),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: GcSpacing.xl),

            // Descripción (opcional)
            GcTextField(
              controller: _descriptionController,
              label: l10n.routineDescriptionLabel,
              hintText: l10n.routineDescriptionPlaceholder,
              maxLines: 3,
            ),
            const SizedBox(height: GcSpacing.xxl),

            // Botón Guardar
            PrimaryButton(label: l10n.routineSaveButton, onPressed: _save),
          ],
        ),
      ),
    );
  }
}
