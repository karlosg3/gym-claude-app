import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';

part 'date_range.freezed.dart';

/// Rango cerrado de fechas [start, end] (ambas inclusivas).
@freezed
abstract class DateRange with _$DateRange {
  const DateRange._();

  const factory DateRange({
    required LocalDate start,
    required LocalDate end,
  }) = _DateRange;

  /// Valida que el inicio no sea posterior al final.
  factory DateRange.checked({required LocalDate start, required LocalDate end}) {
    if (start.isAfter(end)) {
      throw ArgumentError('La fecha de inicio ($start) no puede ser posterior a la de fin ($end)');
    }
    return DateRange(start: start, end: end);
  }

  /// Verifica si una fecha dada se encuentra dentro del rango (inclusivo).
  bool contains(LocalDate date) {
    return (date.isAfter(start) || date == start) &&
        (date.isBefore(end) || date == end);
  }

  /// Cantidad total de días en el rango.
  int get daysCount => end.daysDifference(start) + 1;
}
