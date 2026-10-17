import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/date_range.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';

void main() {
  group('DateRange', () {
    test('contains funciona con límites inclusivos', () {
      const start = LocalDate(year: 2026, month: 6, day: 1);
      const end = LocalDate(year: 2026, month: 6, day: 7);
      final range = const DateRange(start: start, end: end);

      expect(range.contains(start), isTrue);
      expect(range.contains(end), isTrue);
      expect(range.contains(const LocalDate(year: 2026, month: 6, day: 4)), isTrue);
      expect(range.contains(const LocalDate(year: 2026, month: 5, day: 31)), isFalse);
      expect(range.contains(const LocalDate(year: 2026, month: 6, day: 8)), isFalse);
    });

    test('daysCount calcula correctamente el total de días', () {
      const start = LocalDate(year: 2026, month: 6, day: 1);
      const end = LocalDate(year: 2026, month: 6, day: 7);
      final range = const DateRange(start: start, end: end);
      expect(range.daysCount, 7);

      const singleDay = DateRange(start: start, end: start);
      expect(singleDay.daysCount, 1);
    });

    test('checked lanza ArgumentError si start es posterior a end', () {
      const start = LocalDate(year: 2026, month: 6, day: 10);
      const end = LocalDate(year: 2026, month: 6, day: 5);
      expect(
        () => DateRange.checked(start: start, end: end),
        throwsArgumentError,
      );
    });
  });
}
