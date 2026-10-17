import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';

/// Etiquetas de fecha y días de la semana en español según el diseño.
abstract final class DateLabels {
  /// Iniciales de una letra para pastillas de día (`L M X J V S D`).
  static String weekdayShort(Weekday day) {
    return switch (day) {
      Weekday.monday => 'L',
      Weekday.tuesday => 'M',
      Weekday.wednesday => 'X',
      Weekday.thursday => 'J',
      Weekday.friday => 'V',
      Weekday.saturday => 'S',
      Weekday.sunday => 'D',
    };
  }

  /// Nombre completo del día de la semana con mayúscula inicial.
  static String weekdayLong(Weekday day) {
    return switch (day) {
      Weekday.monday => 'Lunes',
      Weekday.tuesday => 'Martes',
      Weekday.wednesday => 'Miércoles',
      Weekday.thursday => 'Jueves',
      Weekday.friday => 'Viernes',
      Weekday.saturday => 'Sábado',
      Weekday.sunday => 'Domingo',
    };
  }

  /// Nombre del mes en minúscula (`enero`..`diciembre`).
  static String monthName(int month) {
    return switch (month) {
      1 => 'enero',
      2 => 'febrero',
      3 => 'marzo',
      4 => 'abril',
      5 => 'mayo',
      6 => 'junio',
      7 => 'julio',
      8 => 'agosto',
      9 => 'septiembre',
      10 => 'octubre',
      11 => 'noviembre',
      12 => 'diciembre',
      _ => throw ArgumentError.value(
        month,
        'month',
        'Mes fuera de rango 1..12',
      ),
    };
  }

  /// Nombre del mes con mayúscula inicial (`Junio 2026`).
  static String monthYearTitle(int year, int month) {
    final m = monthName(month);
    final capitalized = '${m[0].toUpperCase()}${m.substring(1)}';
    return '$capitalized $year';
  }

  /// Cabecera larga de fecha (`Lunes, 22 de junio`).
  static String fullHeaderDate(LocalDate date) {
    final dayName = weekdayLong(date.weekday);
    final mName = monthName(date.month);
    return '$dayName, ${date.day} de $mName';
  }

  /// Fecha larga sin coma (`Lunes 22 de junio`).
  static String longDate(LocalDate date) {
    return '${weekdayLong(date.weekday)} ${date.day} de ${monthName(date.month)}';
  }
}
