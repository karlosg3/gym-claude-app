import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Altura estándar de los botones de acción principales según `10 - Design System.md`.
const double _kButtonHeight = 52.0;

/// Dimensión visual del botón cuadrado de cabecera (`40 × 40 dp`) dentro de área táctil ≥ `48 × 48 dp`.
const double _kIconSquareSize = 40.0;

/// Botón de acción principal con fondo de acento y sombra suave.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;
    final enabled = onPressed != null && !isLoading;

    final button = Container(
      height: _kButtonHeight,
      decoration: BoxDecoration(
        color: enabled ? c.accent : c.surfaceRaised,
        borderRadius: GcRadii.borderLg,
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: c.accentShadow,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: GcRadii.borderLg,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GcSpacing.xl),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation<Color>(c.background),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            size: 18,
                            color: enabled ? c.background : c.textDisabled,
                          ),
                          const SizedBox(width: GcSpacing.sm),
                        ],
                        Flexible(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: t.bodyStrong.copyWith(
                              color: enabled ? c.background : c.textDisabled,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Botón secundario con superficie hundida y borde sutil.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;
    final enabled = onPressed != null;

    final button = SizedBox(
      height: _kButtonHeight,
      child: Material(
        color: c.surfaceSunken,
        shape: RoundedRectangleBorder(
          borderRadius: GcRadii.borderLg,
          side: BorderSide(color: c.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          borderRadius: GcRadii.borderLg,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GcSpacing.xl),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 18,
                      color: enabled ? c.textPrimary : c.textDisabled,
                    ),
                    const SizedBox(width: GcSpacing.sm),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: t.label.copyWith(
                        color: enabled ? c.textPrimary : c.textDisabled,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Botón para acciones destructivas (borrar, descartar).
class DangerButton extends StatelessWidget {
  const DangerButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;
    final enabled = onPressed != null;

    final button = SizedBox(
      height: _kButtonHeight,
      child: Material(
        color: c.surfaceSunken,
        shape: RoundedRectangleBorder(
          borderRadius: GcRadii.borderLg,
          side: BorderSide(
            color: enabled ? c.danger.withValues(alpha: 0.4) : c.border,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          borderRadius: GcRadii.borderLg,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GcSpacing.xl),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 18,
                      color: enabled ? c.danger : c.textDisabled,
                    ),
                    const SizedBox(width: GcSpacing.sm),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: t.label.copyWith(
                        color: enabled ? c.danger : c.textDisabled,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Botón cuadrado de `40 × 40 dp` visuales con área táctil mínima de `48 × 48 dp`
/// utilizado en las cabeceras (volver atrás, editar, exportar).
class IconSquareButton extends StatelessWidget {
  const IconSquareButton({
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    super.key,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Tooltip(
        message: semanticLabel,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: GcSpacing.minTouchTarget,
              minHeight: GcSpacing.minTouchTarget,
            ),
            child: Center(
              child: Container(
                width: _kIconSquareSize,
                height: _kIconSquareSize,
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: GcRadii.borderMd,
                  border: Border.all(color: c.border),
                ),
                child: Icon(icon, size: 18, color: color ?? c.textPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
