import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Modal bottom sheet para configurar el esquema de series y repeticiones de un ejercicio.
class RepSchemeBottomSheet extends StatefulWidget {
  const RepSchemeBottomSheet({
    super.key,
    required this.initialScheme,
    required this.exerciseName,
  });

  final RepScheme initialScheme;
  final String exerciseName;

  static Future<RepScheme?> show({
    required BuildContext context,
    required RepScheme initialScheme,
    required String exerciseName,
  }) {
    return showModalBottomSheet<RepScheme>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RepSchemeBottomSheet(
        initialScheme: initialScheme,
        exerciseName: exerciseName,
      ),
    );
  }

  @override
  State<RepSchemeBottomSheet> createState() => _RepSchemeBottomSheetState();
}

class _RepSchemeBottomSheetState extends State<RepSchemeBottomSheet> {
  late int _sets;
  late int _reps;
  late bool _isMax;

  @override
  void initState() {
    super.initState();
    _sets = widget.initialScheme.sets;
    _reps = widget.initialScheme.reps ?? 10;
    _isMax = widget.initialScheme.isMax;
  }

  void _onSave() {
    final scheme = RepScheme(sets: _sets, reps: _isMax ? null : _reps);
    Navigator.of(context).pop(scheme);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final text = context.gcText;
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceSunken,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(GcRadii.xxl),
        ),
        border: Border(top: BorderSide(color: colors.border)),
      ),
      padding: EdgeInsets.fromLTRB(
        GcSpacing.screenHorizontal,
        GcSpacing.lg,
        GcSpacing.screenHorizontal,
        MediaQuery.paddingOf(context).bottom + GcSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.borderStrong,
                borderRadius: BorderRadius.circular(GcRadii.full),
              ),
            ),
          ),
          const SizedBox(height: GcSpacing.lg),
          Text(
            widget.exerciseName,
            style: text.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            l10n.routineEditSchemeTitle,
            style: text.caption.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: GcSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.routineSetsLabel, style: text.bodyStrong),
              GcStepper(
                value: _sets,
                min: 1,
                max: 10,
                onChanged: (val) => setState(() => _sets = val),
              ),
            ],
          ),
          const SizedBox(height: GcSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.routineRepsLabel,
                style: text.bodyStrong.copyWith(
                  color: _isMax ? colors.textFaint : colors.textPrimary,
                ),
              ),
              GcStepper(
                value: _reps,
                min: 1,
                max: 50,
                enabled: !_isMax,
                onChanged: (val) => setState(() => _reps = val),
              ),
            ],
          ),
          const SizedBox(height: GcSpacing.md),
          GcSwitchRow(
            title: l10n.routineRepsToFailure,
            subtitle: 'Series hasta no poder completar otra repetición',
            value: _isMax,
            onChanged: (val) => setState(() => _isMax = val),
          ),
          const SizedBox(height: GcSpacing.xl),
          PrimaryButton(label: l10n.commonSave, onPressed: _onSave),
        ],
      ),
    );
  }
}
