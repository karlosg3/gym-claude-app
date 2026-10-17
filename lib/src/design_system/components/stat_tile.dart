import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/widgets/gc_card.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Tarjeta de estadística: valor grande (con sufijo atenuado opcional, p. ej. "/5") y etiqueta.
class StatTile extends StatelessWidget {
  const StatTile({
    required this.value,
    required this.label,
    super.key,
    this.suffix,
  });

  final String value;
  final String? suffix;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;

    return GcCard(
      padding: const EdgeInsets.symmetric(
        horizontal: GcSpacing.sm,
        vertical: GcSpacing.lg,
      ),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text.rich(
              TextSpan(
                text: value,
                style: t.title.copyWith(color: c.textPrimary),
                children: [
                  if (suffix != null)
                    TextSpan(
                      text: suffix,
                      style: t.subtitle.copyWith(color: c.textFaint),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: GcSpacing.xs),
          Text(label, style: t.label.copyWith(color: c.textMuted)),
        ],
      ),
    );
  }
}
