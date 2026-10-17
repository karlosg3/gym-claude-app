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
    this.bottomBar,
    this.scrollable = false,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: GcSpacing.screenHorizontal,
      vertical: GcSpacing.lg,
    ),
  });

  final Widget body;
  final String? title;
  final String? overline;
  final Widget? leading;
  final List<Widget> actions;
  final Widget? floatingActionButton;
  final Widget? bottomBar;
  final bool scrollable;
  final EdgeInsetsGeometry contentPadding;

  bool get _hasHeader =>
      title != null || overline != null || leading != null || actions.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;

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
        Expanded(
          child: scrollable
              ? SingleChildScrollView(
                  padding: contentPadding,
                  child: body,
                )
              : Padding(
                  padding: contentPadding,
                  child: body,
                ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: c.background,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomBar,
      body: SafeArea(
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
