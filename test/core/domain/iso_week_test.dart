import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/iso_week.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';

void main() {
  group('IsoWeek', () {
    test('calcula correctamente la semana de demostración (22-jun-2026)', () {
      final date = const LocalDate(year: 2026, month: 6, day: 22);
      final week = IsoWeek.of(date);
      expect(week.weekYear, 2026);
      expect(week.weekNumber, 26);
      expect(week.start, const LocalDate(year: 2026, month: 6, day: 22));
      expect(week.end, const LocalDate(year: 2026, month: 6, day: 28));
    });

    test('frontera de año nuevo: 1 de enero de 2026 (jueves) pertenece a semana 1 de 2026', () {
      final jan1 = const LocalDate(year: 2026, month: 1, day: 1);
      final week = IsoWeek.of(jan1);
      expect(week.weekYear, 2026);
      expect(week.weekNumber, 1);
      expect(week.start, const LocalDate(year: 2025, month: 12, day: 29));
      expect(week.end, const LocalDate(year: 2026, month: 1, day: 4));
    });

    test('31 de diciembre de 2024 (martes) pertenece a semana 1 de 2025', () {
      final dec31 = const LocalDate(year: 2024, month: 12, day: 31);
      final week = IsoWeek.of(dec31);
      expect(week.weekYear, 2025);
      expect(week.weekNumber, 1);
      expect(week.start, const LocalDate(year: 2024, month: 12, day: 30));
    });

    test('comparación de semanas', () {
      final w1 = const IsoWeek(weekYear: 2026, weekNumber: 10);
      final w2 = const IsoWeek(weekYear: 2026, weekNumber: 26);
      final w3 = const IsoWeek(weekYear: 2027, weekNumber: 1);

      expect(w1.compareTo(w2), isNegative);
      expect(w2.compareTo(w3), isNegative);
    });
  });
}
