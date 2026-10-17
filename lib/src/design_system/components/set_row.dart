import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_icons.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Fila de serie registrada: "Serie 1 · 72 kg × 8 reps" con insignia opcional y borrar.
class SetRow extends StatelessWidget {
  const SetRow({
    required this.label,
    required this.value,
    super.key,
    this.badge,
    this.onTap,
    this.onDelete,
    this.deleteLabel,
  });

  final String label;
  final String value;

  /// Texto de insignia (p. ej. "PR").
  final String? badge;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final String? deleteLabel;

  static const double _labelWidth = 64;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;

    return Material(
      color: c.surface,
      shape: RoundedRectangleBorder(
        borderRadius: GcRadii.borderXl,
        side: BorderSide(color: c.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            left: GcSpacing.lg + 2,
            right: GcSpacing.xs,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 56),
            child: Row(
              children: [
                SizedBox(
                  width: _labelWidth,
                  child: Text(
                    label,
                    style: t.bodyStrong.copyWith(color: c.accent),
                  ),
                ),
                Expanded(
                  child: Text(
                    value,
                    style: t.subtitle.copyWith(color: c.textPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GcSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: c.accentSoft,
                      borderRadius: GcRadii.borderPill,
                    ),
                    child: Text(
                      badge!,
                      style: t.micro.copyWith(
                        color: c.accent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                if (onDelete != null)
                  IconButton(
                    onPressed: onDelete,
                    tooltip: deleteLabel,
                    icon: Icon(
                      GcIcons.close,
                      size: GcIcons.sizeMd,
                      color: c.textMuted,
                    ),
                  )
                else
                  const SizedBox(width: GcSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
