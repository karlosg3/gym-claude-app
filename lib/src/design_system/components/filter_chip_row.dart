import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

class FilterChipItem<T> {
  const FilterChipItem({required this.value, required this.label});

  final T value;
  final String label;
}

/// Fila deslizable horizontal de chips de filtrado (píldoras con radio completo).
class FilterChipRow<T> extends StatelessWidget {
  const FilterChipRow({
    required this.items,
    required this.selectedValue,
    required this.onSelected,
    super.key,
  });

  final List<FilterChipItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: GcSpacing.sm),
            Builder(
              builder: (context) {
                final item = items[i];
                final isSelected = item.value == selectedValue;

                return InkWell(
                  onTap: () => onSelected(item.value),
                  borderRadius: BorderRadius.circular(GcRadii.full),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GcSpacing.lg - 1,
                      vertical: GcSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? colors.accent : colors.surface,
                      borderRadius: BorderRadius.circular(GcRadii.full),
                      border: Border.all(
                        color: isSelected ? colors.accent : colors.border,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.label,
                      style: textStyles.caption.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? colors.background
                            : colors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
