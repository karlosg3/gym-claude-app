import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Pantalla de Historial mensual (Fase 0: esqueleto base).
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, this.initialMonth});

  final String? initialMonth;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GcScaffold(
      title: l10n.navHistory,
      body: EmptyState(
        icon: GcIcons.history,
        title: l10n.navHistory,
        description: l10n.emptyScreenPhase0Desc,
      ),
    );
  }
}
