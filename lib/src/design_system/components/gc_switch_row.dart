import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Fila de opción con título, descripción y switch personalizado según el diseño.
class GcSwitchRow extends StatelessWidget {
  const GcSwitchRow({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.showTopDivider = true,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showTopDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;

    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        decoration: BoxDecoration(
          border: showTopDivider
              ? Border(top: BorderSide(color: colors.surfaceRaised))
              : null,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: GcSpacing.lg,
          vertical: GcSpacing.md + 1,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: GcSpacing.xs / 2),
                    Text(
                      subtitle!,
                      style: textStyles.caption.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: GcSpacing.md),
            GestureDetector(
              onTap: () => onChanged(!value),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 46,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GcRadii.full),
                  color: value ? colors.accent : colors.borderStrong,
                ),
                padding: const EdgeInsets.all(3),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x59000000),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
