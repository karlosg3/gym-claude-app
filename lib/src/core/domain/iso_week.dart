import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';

part 'iso_week.freezed.dart';

/// Representa una semana según la norma ISO-8601 (lunes a domingo).
/// `weekYear` puede ser diferente al año natural de algunos días
/// que caen a finales de diciembre o principios de enero.
@freezed
abstract class IsoWeek with _$IsoWeek implements Comparable<IsoWeek> {
  const IsoWeek._();

  const factory IsoWeek({required int weekYear, required int weekNumber}) =
      _IsoWeek;

  /// Calcula la semana ISO correspondiente a una fecha.
  factory IsoWeek.of(LocalDate date) {
    final dt = date.toDateTime();
    // El jueves de la misma semana determina el año ISO de la semana
    final thursday = dt.add(Duration(days: 4 - dt.weekday));
    final weekYear = thursday.year;

    // El primer jueves del año siempre cae entre el 1 y el 7 de enero (o contiene el 4 de enero)
    final jan4 = DateTime(weekYear, 1, 4);
    final firstThursday = jan4.add(Duration(days: 4 - jan4.weekday));

    // El número de semana es 1 + la diferencia de semanas desde el primer jueves
    final weekNumber = 1 + (thursday.difference(firstThursday).inDays ~/ 7);

    return IsoWeek(weekYear: weekYear, weekNumber: weekNumber);
  }

  /// Fecha de inicio de la semana (Lunes).
  LocalDate get start {
    final jan4 = DateTime(weekYear, 1, 4);
    final week1Monday = jan4.subtract(Duration(days: jan4.weekday - 1));
    final targetMonday = week1Monday.add(Duration(days: (weekNumber - 1) * 7));
    return LocalDate.of(targetMonday);
  }

  /// Fecha de fin de la semana (Domingo).
  LocalDate get end => start.addDays(6);

  @override
  int compareTo(IsoWeek other) {
    if (weekYear != other.weekYear) return weekYear.compareTo(other.weekYear);
    return weekNumber.compareTo(other.weekNumber);
  }
}
