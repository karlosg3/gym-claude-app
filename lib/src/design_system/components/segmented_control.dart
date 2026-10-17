import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

class SegmentedOption<T> {
  const SegmentedOption({required this.value, required this.label});

  final T value;
  final String label;
}

/// Selector segmentado compacto con contenedor hundido y opción activa resaltada.
class SegmentedControl<T> extends StatelessWidget {
  const SegmentedControl({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.activeColor,
    this.activeTextColor,
    super.key,
  });

  final List<SegmentedOption<T>> options;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final Color? activeColor;
  final Color? activeTextColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;
    final activeBg = activeColor ?? colors.accent;
    final activeFg = activeTextColor ?? colors.background;

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
          for (final opt in options)
            Builder(
              builder: (context) {
                final isSelected = opt.value == selectedValue;
                return InkWell(
                  onTap: () => onChanged(opt.value),
                  borderRadius: BorderRadius.circular(GcRadii.sm + 1),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 46),
                    padding: const EdgeInsets.symmetric(
                      horizontal: GcSpacing.md - 2,
                      vertical: GcSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? activeBg : Colors.transparent,
                      borderRadius: BorderRadius.circular(GcRadii.sm + 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      opt.label,
                      style: textStyles.label.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isSelected ? activeFg : colors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
