import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla principal de Inicio (Fase 0: esqueleto con acceso a Ajustes).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GcScaffold(
      title: l10n.navHome,
      actions: [
        IconSquareButton(
          icon: GcIcons.settings,
          semanticLabel: l10n.navSettings,
          onPressed: () => context.pushSettings(),
        ),
      ],
      body: EmptyState(
        icon: GcIcons.home,
        title: l10n.navHome,
        description: l10n.emptyScreenPhase0Desc,
      ),
    );
  }
}
