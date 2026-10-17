import 'dart:math' as math;

/// Formateador de duraciones de sesión y cronómetro según `07 - Reglas de Negocio.md`.
abstract final class DurationFormatter {
  /// Cronómetro activo: `MM:SS` o `H:MM:SS` si supera una hora.
  static String stopwatch(Duration duration) {
    final totalSeconds = math.max(0, duration.inSeconds);
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');
    if (hours > 0) {
      return '$hours:$mm:$ss';
    }
    return '$mm:$ss';
  }

  /// Minutos redondeados de una sesión: `max(1, round(seconds / 60))` -> `50 min`.
  static int sessionMinutes(Duration duration) {
    return math.max(1, (duration.inSeconds / 60).round());
  }

  /// Etiqueta en minutos (`50 min`).
  static String minutesLabel(Duration duration) {
    return '${sessionMinutes(duration)} min';
  }

  /// Horas del mes/exportación con un decimal y coma (`8,5 h`).
  static String hoursFromMinutes(int totalMinutes) {
    if (totalMinutes <= 0) return '0 h';
    final hours = totalMinutes / 60.0;
    if ((hours - hours.roundToDouble()).abs() < 0.05) {
      return '${hours.round()} h';
    }
    return '${hours.toStringAsFixed(1).replaceAll('.', ',')} h';
  }
}
