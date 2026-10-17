import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Contenedor shell de las 4 pestañas principales con barra inferior.
///
/// Tocar la pestaña ya activa restablece la pila de esa rama a su ubicación inicial.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onTapDestination(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final text = context.gcText;

    final items = <_NavDestinationItem>[
      _NavDestinationItem(icon: GcIcons.home, label: l10n.navHome),
      _NavDestinationItem(icon: GcIcons.routines, label: l10n.navRoutines),
      _NavDestinationItem(icon: GcIcons.exercises, label: l10n.navExercises),
      _NavDestinationItem(icon: GcIcons.history, label: l10n.navHistory),
    ];

    return Scaffold(
      backgroundColor: colors.background,
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceSunken,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: GcSpacing.sm,
              vertical: GcSpacing.sm,
            ),
            child: Row(
              children: [
                for (var i = 0; i < items.length; i++)
                  Expanded(
                    child: _NavTabButton(
                      item: items[i],
                      selected: i == navigationShell.currentIndex,
                      activeColor: colors.accent,
                      inactiveColor: colors.textFaint,
                      labelStyle: text.micro,
                      onTap: () => _onTapDestination(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavDestinationItem {
  const _NavDestinationItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class _NavTabButton extends StatelessWidget {
  const _NavTabButton({
    required this.item,
    required this.selected,
    required this.activeColor,
    required this.inactiveColor,
    required this.labelStyle,
    required this.onTap,
  });

  final _NavDestinationItem item;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle labelStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? activeColor : inactiveColor;

    return Semantics(
      selected: selected,
      button: true,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GcRadii.sm),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: GcSpacing.minTouchTarget,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: GcSpacing.xs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: GcIcons.sizeMd, color: color),
                const SizedBox(height: GcSpacing.xs),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle.copyWith(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
