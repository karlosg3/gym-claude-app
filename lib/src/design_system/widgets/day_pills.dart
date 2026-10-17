import 'package:flutter/material.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_colors.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';

/// Fila de 7 pastillas L M X J V S D para visualizar y/o seleccionar días activos de una rutina.
class DayPills extends StatelessWidget {
  const DayPills({
    super.key,
    required this.activeDays,
    this.onDayToggled,
    this.selectedDay,
    this.onDaySelected,
    this.accentColor,
    this.size = 28.0,
  });

  /// Conjunto de días activos configurados.
  final Set<Weekday> activeDays;

  /// Callback para alternar un día (modo formulario multi-selección).
  final ValueChanged<Weekday>? onDayToggled;

  /// Día actualmente seleccionado en pestañas de detalle (modo pestaña activa).
  final Weekday? selectedDay;

  /// Callback al pulsar un día activo en modo pestañas.
  final ValueChanged<Weekday>? onDaySelected;

  /// Color de acento opcional (por defecto usa el color de acento del tema).
  final Color? accentColor;

  /// Tamaño cuadrado de cada pastilla en dp.
  final double size;

  static const _dayLetters = {
    Weekday.monday: 'L',
    Weekday.tuesday: 'M',
    Weekday.wednesday: 'X',
    Weekday.thursday: 'J',
    Weekday.friday: 'V',
    Weekday.saturday: 'S',
    Weekday.sunday: 'D',
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final text = context.gcText;
    final active = accentColor ?? colors.accent;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final day in Weekday.values)
          _buildPill(
            context: context,
            day: day,
            letter: _dayLetters[day]!,
            isActive: activeDays.contains(day),
            isSelected: selectedDay == day,
            activeColor: active,
            colors: colors,
            textStyle: text.micro,
          ),
      ],
    );
  }

  Widget _buildPill({
    required BuildContext context,
    required Weekday day,
    required String letter,
    required bool isActive,
    required bool isSelected,
    required Color activeColor,
    required GcColors colors,
    required TextStyle textStyle,
  }) {
    final isInteractive = onDayToggled != null || onDaySelected != null;
    final isClickable =
        onDayToggled != null || (onDaySelected != null && isActive);

    Color bg;
    Color fg;
    Border? border;

    if (isSelected) {
      bg = activeColor;
      fg = colors.background;
    } else if (isActive) {
      bg = activeColor.withValues(alpha: 0.16);
      fg = activeColor;
      border = Border.all(
        color: activeColor.withValues(alpha: 0.35),
        width: 1.0,
      );
    } else {
      bg = colors.surfaceSunken;
      fg = colors.textFaint;
    }

    Widget pill = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(GcRadii.sm),
        border: border,
      ),
      child: Text(
        letter,
        style: textStyle.copyWith(
          color: fg,
          fontWeight: (isActive || isSelected)
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
    );

    if (isInteractive && isClickable) {
      pill = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onDayToggled != null) {
              onDayToggled!(day);
            } else if (onDaySelected != null) {
              onDaySelected!(day);
            }
          },
          borderRadius: BorderRadius.circular(GcRadii.sm),
          child: pill,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Semantics(
        label: 'Día ${day.name}',
        selected: isSelected || isActive,
        button: isClickable,
        child: pill,
      ),
    );
  }
}
