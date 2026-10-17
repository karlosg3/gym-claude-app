import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Estructura base de pantalla de GymClaude:
/// - Fondo `#161310`
/// - `SafeArea`
/// - Centrado adaptable con ancho máximo de `480 dp` en pantallas anchas
/// - Cabecera opcional con título, subtítulo superior (`overline`), botón izquierdo (`leading`) y acciones (`actions`)
class GcScaffold extends StatelessWidget {
  const GcScaffold({
    required this.body,
    super.key,
    this.title,
    this.overline,
    this.leading,
    this.actions = const [],
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomBar,
    this.scrollable = false,
    this.contentPadding,
    this.safeAreaBottom = false,
  });

  final Widget body;
  final String? title;
  final String? overline;
  final Widget? leading;
  final List<Widget> actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomBar;
  final bool scrollable;
  final EdgeInsetsGeometry? contentPadding;
  final bool safeAreaBottom;

  bool get _hasHeader =>
      title != null || overline != null || leading != null || actions.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;

    final effectivePadding = contentPadding ??
        (scrollable
            ? const EdgeInsets.symmetric(
                horizontal: GcSpacing.screenHorizontal,
                vertical: GcSpacing.lg,
              )
            : EdgeInsets.zero);

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_hasHeader)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              GcSpacing.screenHorizontal,
              GcSpacing.md,
              GcSpacing.screenHorizontal,
              GcSpacing.sm,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: GcSpacing.minTouchTarget,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: GcSpacing.md),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (overline != null) ...[
                          Text(
                            overline!.toUpperCase(),
                            style: t.overline,
                          ),
                          const SizedBox(height: 2),
                        ],
                        if (title != null)
                          Text(
                            title!,
                            style: t.title,
                          ),
                      ],
                    ),
                  ),
                  if (actions.isNotEmpty)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions,
                    ),
                ],
              ),
            ),
          ),
        Expanded(
          child: scrollable
              ? SingleChildScrollView(
                  padding: effectivePadding,
                  child: body,
                )
              : (effectivePadding == EdgeInsets.zero
                  ? body
                  : Padding(
                      padding: effectivePadding,
                      child: body,
                    )),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: c.background,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          (floatingActionButton != null
              ? const GcAboveNavFabLocation()
              : null),
      bottomNavigationBar: bottomBar,
      body: SafeArea(
        bottom: safeAreaBottom,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: GcSpacing.maxContentWidth,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}

/// Ubicación de FAB flotante que se alinea a la derecha con margen estándar de pantalla
/// (`GcSpacing.screenHorizontal`) y despeje vertical para flotar por encima de la isla de navegación.
class GcAboveNavFabLocation extends StandardFabLocation with FabEndOffsetX {
  const GcAboveNavFabLocation({this.navBarClearance = 88.0});

  /// Despeje vertical adicional respecto a la parte inferior (altura de isla + margen).
  final double navBarClearance;

  @override
  double getOffsetX(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) {
    return scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        GcSpacing.screenHorizontal;
  }

  @override
  double getOffsetY(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) {
    final double systemInset = scaffoldGeometry.minViewPadding.bottom;
    final double keyboardInset = scaffoldGeometry.minInsets.bottom;
    final double effectiveBottom = math.max(systemInset, keyboardInset);
    return scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        effectiveBottom -
        navBarClearance;
  }
}
