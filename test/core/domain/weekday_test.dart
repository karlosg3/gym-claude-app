import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';

void main() {
  group('Weekday', () {
    test('mapea correctamente valores ISO 1..7', () {
      expect(Weekday.monday.isoValue, 1);
      expect(Weekday.tuesday.isoValue, 2);
      expect(Weekday.wednesday.isoValue, 3);
      expect(Weekday.thursday.isoValue, 4);
      expect(Weekday.friday.isoValue, 5);
      expect(Weekday.saturday.isoValue, 6);
      expect(Weekday.sunday.isoValue, 7);

      for (var i = 1; i <= 7; i++) {
        expect(Weekday.fromIso(i).isoValue, i);
      }
    });

    test('fromIso lanza ArgumentError ante valores fuera de rango', () {
      expect(() => Weekday.fromIso(0), throwsArgumentError);
      expect(() => Weekday.fromIso(8), throwsArgumentError);
    });

    test('fromDateTime obtiene el día correcto', () {
      // 2026-10-15 es jueves
      final dt = DateTime(2026, 10, 15);
      expect(Weekday.fromDateTime(dt), Weekday.thursday);
    });

    test('cálculo de máscara de bits individual', () {
      expect(Weekday.monday.mask, 1); // 1 << 0
      expect(Weekday.tuesday.mask, 2); // 1 << 1
      expect(Weekday.wednesday.mask, 4); // 1 << 2
      expect(Weekday.thursday.mask, 8); // 1 << 3
      expect(Weekday.friday.mask, 16); // 1 << 4
      expect(Weekday.saturday.mask, 32); // 1 << 5
      expect(Weekday.sunday.mask, 64); // 1 << 6
    });

    test('toMask y fromMask son bidireccionales y simétricos', () {
      final days = {Weekday.monday, Weekday.wednesday, Weekday.friday};
      final mask = Weekday.toMask(days);
      expect(mask, 1 | 4 | 16); // 21
      expect(Weekday.fromMask(mask), days);

      final allDays = Weekday.values.toSet();
      expect(Weekday.toMask(allDays), 127);
      expect(Weekday.fromMask(127), allDays);

      expect(Weekday.toMask({}), 0);
      expect(Weekday.fromMask(0), isEmpty);
    });
  });
}
