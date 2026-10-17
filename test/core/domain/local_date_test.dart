import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';

void main() {
  group('LocalDate', () {
    test('crea a partir de DateTime', () {
      final dt = DateTime(2026, 6, 22, 18, 30);
      final date = LocalDate.of(dt);
      expect(date.year, 2026);
      expect(date.month, 6);
      expect(date.day, 22);
    });

    test('parsea formato ISO YYYY-MM-DD y serializa simétricamente', () {
      final date = LocalDate.parse('2026-06-22');
      expect(date.year, 2026);
      expect(date.month, 6);
      expect(date.day, 22);
      expect(date.toIso8601String(), '2026-06-22');
    });

    test('parse lanza FormatException ante entradas inválidas', () {
      expect(() => LocalDate.parse('2026/06/22'), throwsFormatException);
      expect(() => LocalDate.parse('invalido'), throwsFormatException);
    });

    test('calcula el día de la semana correcto', () {
      // 2026-06-22 es lunes
      final monday = LocalDate.parse('2026-06-22');
      expect(monday.weekday, Weekday.monday);

      // 2026-06-28 es domingo
      final sunday = LocalDate.parse('2026-06-28');
      expect(sunday.weekday, Weekday.sunday);
    });

    test('operaciones de suma, resta y diferencia de días', () {
      final base = const LocalDate(year: 2026, month: 1, day: 31);
      final next = base.addDays(1);
      expect(next, const LocalDate(year: 2026, month: 2, day: 1));

      final prev = next.subtractDays(1);
      expect(prev, base);

      expect(next.daysDifference(base), 1);
      expect(base.daysDifference(next), -1);
    });

    test('comparaciones de orden temporal', () {
      const d1 = LocalDate(year: 2026, month: 5, day: 10);
      const d2 = LocalDate(year: 2026, month: 5, day: 20);
      const d3 = LocalDate(year: 2026, month: 6, day: 1);

      expect(d1.isBefore(d2), isTrue);
      expect(d2.isAfter(d1), isTrue);
      expect(d2.isBefore(d3), isTrue);
      expect(d1.compareTo(d2), isNegative);
      expect(d1.isAtSameMomentAs(d1), isTrue);
    });
  });
}
