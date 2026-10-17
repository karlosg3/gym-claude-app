import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Contenedor shell de las 4 pestañas principales con barra de navegación flotante
/// tipo isla centrada con efecto estético inspirado en 'liquid glass'.
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          navigationShell,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  GcSpacing.screenHorizontal,
                  0,
                  GcSpacing.screenHorizontal,
                  GcSpacing.sm,
                ),
                child: Center(
                  heightFactor: 1.0,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 340,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                            spreadRadius: -2,
                          ),
                          BoxShadow(
                            color: colors.accent.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF2E2822).withValues(alpha: 0.15),
                                  const Color(0xFF161310).withValues(alpha: 0.25),
                                ],
                              ),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.18),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                for (var i = 0; i < items.length; i++)
                                  Expanded(
                                    child: _NavTabButton(
                                      item: items[i],
                                      selected: i == navigationShell.currentIndex,
                                      activeColor: colors.accent,
                                      inactiveColor: colors.textMuted,
                                      labelStyle: text.micro,
                                      onTap: () => _onTapDestination(i),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selected
                  ? activeColor.withValues(alpha: 0.16)
                  : Colors.transparent,
              border: Border.all(
                color: selected
                    ? activeColor.withValues(alpha: 0.28)
                    : Colors.transparent,
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  size: GcIcons.sizeMd,
                  color: color,
                ),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
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
