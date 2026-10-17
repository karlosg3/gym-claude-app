import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Pantalla de lista de Rutinas (Fase 0: esqueleto base).
class RoutinesListScreen extends StatelessWidget {
  const RoutinesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GcScaffold(
      title: l10n.navRoutines,
      body: EmptyState(
        icon: GcIcons.routines,
        title: l10n.navRoutines,
        description: l10n.emptyScreenPhase0Desc,
      ),
    );
  }
}
