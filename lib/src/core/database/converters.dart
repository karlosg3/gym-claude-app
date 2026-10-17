import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight.dart';

/// Conversor Drift para conjuntos de días de la semana a una máscara de bits entera (1..127).
class WeekdaySetConverter extends TypeConverter<Set<Weekday>, int> {
  const WeekdaySetConverter();

  @override
  Set<Weekday> fromSql(int fromDb) => Weekday.fromMask(fromDb);

  @override
  int toSql(Set<Weekday> value) => Weekday.toMask(value);
}

/// Conversor Drift para fechas [LocalDate] a formato de texto ISO `YYYY-MM-DD`.
class LocalDateConverter extends TypeConverter<LocalDate, String> {
  const LocalDateConverter();

  @override
  LocalDate fromSql(String fromDb) => LocalDate.parse(fromDb);

  @override
  String toSql(LocalDate value) => value.toIso8601String();
}

/// Conversor Drift para objetos [Weight] almacenados como valor `double` en kg.
class WeightConverter extends TypeConverter<Weight, double> {
  const WeightConverter();

  @override
  Weight fromSql(double fromDb) => Weight.kg(fromDb);

  @override
  double toSql(Weight value) => value.value;
}
