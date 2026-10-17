import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';

part 'local_date.freezed.dart';

/// Fecha de calendario sin hora ni zona horaria (año, mes, día).
/// Ideal para representar el día local en que ocurrió un entrenamiento.
@freezed
abstract class LocalDate with _$LocalDate implements Comparable<LocalDate> {
  const LocalDate._();

  const factory LocalDate({
    required int year,
    required int month,
    required int day,
  }) = _LocalDate;

  /// Crea un [LocalDate] a partir de los componentes locales de un [DateTime].
  factory LocalDate.of(DateTime dateTime) {
    return LocalDate(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  /// Parsea una cadena en formato ISO-8601 estándar `YYYY-MM-DD`.
  factory LocalDate.parse(String formatted) {
    final parts = formatted.split('-');
    if (parts.length != 3) {
      throw FormatException(
        'Formato de fecha inválido (se esperaba YYYY-MM-DD): $formatted',
      );
    }
    final y = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    final d = int.parse(parts[2]);
    return LocalDate(year: y, month: m, day: d);
  }

  /// Retorna la representación ISO `YYYY-MM-DD`.
  String toIso8601String() {
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Obtiene el día de la semana correspondiente.
  Weekday get weekday => Weekday.fromDateTime(toDateTime());

  /// Convierte a un objeto [DateTime] a medianoche local (u hora especificada).
  DateTime toDateTime({int hour = 0, int minute = 0, int second = 0}) {
    return DateTime(year, month, day, hour, minute, second);
  }

  /// Suma [days] días a esta fecha.
  LocalDate addDays(int days) {
    final dt = DateTime(year, month, day + days);
    return LocalDate.of(dt);
  }

  /// Resta [days] días a esta fecha.
  LocalDate subtractDays(int days) => addDays(-days);

  /// Retorna la diferencia en días entre esta fecha y [other] (`this - other`).
  int daysDifference(LocalDate other) {
    final dt1 = DateTime(year, month, day);
    final dt2 = DateTime(other.year, other.month, other.day);
    return dt1.difference(dt2).inDays;
  }

  @override
  int compareTo(LocalDate other) {
    if (year != other.year) return year.compareTo(other.year);
    if (month != other.month) return month.compareTo(other.month);
    return day.compareTo(other.day);
  }

  bool isBefore(LocalDate other) => compareTo(other) < 0;
  bool isAfter(LocalDate other) => compareTo(other) > 0;
  bool isAtSameMomentAs(LocalDate other) => compareTo(other) == 0;
}
