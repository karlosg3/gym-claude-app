import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';
import 'package:gym_claude/src/design_system/tokens/gc_typography.dart';

/// Control incremental (− / +) para valores enteros con contenedor hundido.
class GcStepper extends StatelessWidget {
  const GcStepper({
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 7,
    super.key,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;
    final canDec = value > min;
    final canInc = value < max;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceSunken,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(GcRadii.md),
      ),
      padding: const EdgeInsets.all(GcSpacing.xs - 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            iconText: '−',
            enabled: canDec,
            onPressed: canDec ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 32,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: textStyles.bodyStrong.copyWith(
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
              ),
            ),
          ),
          _StepButton(
            iconText: '+',
            enabled: canInc,
            onPressed: canInc ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.iconText,
    required this.enabled,
    required this.onPressed,
  });

  final String iconText;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(GcRadii.sm + 1),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(GcRadii.sm + 1),
        ),
        alignment: Alignment.center,
        child: Text(
          iconText,
          style: TextStyle(
            fontFamily: GcTextStyles.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: enabled ? colors.textPrimary : colors.textDisabled,
            height: 1,
          ),
        ),
      ),
    );
  }
}
