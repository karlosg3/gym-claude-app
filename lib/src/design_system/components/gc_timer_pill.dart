import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/formatters/duration_formatter.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_icons.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Pastilla de cronómetro (`mm:ss`, `h:mm:ss` desde 1 h).
class GcTimerPill extends StatelessWidget {
  const GcTimerPill({required this.elapsed, super.key});

  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GcSpacing.md + 2,
        vertical: GcSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: c.accentSoft,
        borderRadius: GcRadii.borderLg,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(GcIcons.clock, size: GcIcons.sizeMd, color: c.accent),
          const SizedBox(width: GcSpacing.sm),
          Text(
            DurationFormatter.stopwatch(elapsed),
            style: t.headline.copyWith(
              color: c.accent,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
