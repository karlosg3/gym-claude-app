import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Tarjeta base del Design System: superficie + borde de 1 px + radio redondeado.
/// Sin elevación Material (según `10 - Design System.md`).
class GcCard extends StatelessWidget {
  const GcCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(GcSpacing.lg),
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = GcRadii.borderXl,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final bg = backgroundColor ?? c.surface;
    final border = borderColor ?? c.border;

    final content = Padding(
      padding: padding,
      child: child,
    );

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: border),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: content,
            )
          : content,
    );
  }
}
