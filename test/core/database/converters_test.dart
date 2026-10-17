import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/database/converters.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight.dart';

void main() {
  group('Database TypeConverters', () {
    test(
      'WeekdaySetConverter convierte Set<Weekday> a int bitmask y viceversa',
      () {
        const converter = WeekdaySetConverter();
        final set = {Weekday.monday, Weekday.thursday};

        final mask = converter.toSql(set);
        expect(mask, 1 | 8); // 9

        final restored = converter.fromSql(mask);
        expect(restored, set);
      },
    );

    test(
      'LocalDateConverter convierte LocalDate a String YYYY-MM-DD y viceversa',
      () {
        const converter = LocalDateConverter();
        const date = LocalDate(year: 2026, month: 6, day: 22);

        final sql = converter.toSql(date);
        expect(sql, '2026-06-22');

        final restored = converter.fromSql(sql);
        expect(restored, date);
      },
    );

    test('WeightConverter almacena y recupera valor double en kg', () {
      const converter = WeightConverter();
      const weight = Weight.kg(82.5);

      final sql = converter.toSql(weight);
      expect(sql, 82.5);

      final restored = converter.fromSql(sql);
      expect(restored, weight);
    });
  });
}
