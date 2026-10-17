import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';
import 'package:gym_claude/src/design_system/widgets/gc_buttons.dart';

/// Vista de estado vacío reutilizable en todas las pantallas.
/// Recibe icono, título, descripción y una acción primaria opcional.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(GcSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: GcRadii.borderXl,
                border: Border.all(color: c.border),
              ),
              child: Icon(icon, size: 24, color: c.textSecondary),
            ),
            const SizedBox(height: GcSpacing.lg),
            Text(title, textAlign: TextAlign.center, style: t.subtitle),
            const SizedBox(height: GcSpacing.sm),
            Text(
              description,
              textAlign: TextAlign.center,
              style: t.body.copyWith(color: c.textSecondary),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: GcSpacing.xl),
              PrimaryButton(
                label: actionLabel!,
                onPressed: onAction,
                expand: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
