import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/design_system/formatters/date_labels.dart';
import 'package:gym_claude/src/design_system/formatters/duration_formatter.dart';
import 'package:gym_claude/src/design_system/formatters/weight_formatter.dart';

void main() {
  group('WeightFormatter', () {
    test('formatea peso nulo como guion largo', () {
      expect(WeightFormatter.format(null, WeightUnit.kg), '—');
    });

    test('formatea en kg con coma decimal y sin .0 superfluo', () {
      expect(WeightFormatter.format(const Weight.kg(80), WeightUnit.kg), '80 kg');
      expect(
        WeightFormatter.format(const Weight.kg(72.5), WeightUnit.kg),
        '72,5 kg',
      );
    });

    test('formatea peso corporal 0 y lastre positivo', () {
      expect(
        WeightFormatter.format(
          Weight.zero,
          WeightUnit.kg,
          isBodyweight: true,
        ),
        'Peso corporal',
      );
      expect(
        WeightFormatter.format(
          Weight.zero,
          WeightUnit.kg,
          isBodyweight: true,
          short: true,
        ),
        'PC',
      );
      expect(
        WeightFormatter.format(
          const Weight.kg(10),
          WeightUnit.kg,
          isBodyweight: true,
        ),
        '+10 kg',
      );
    });

    test('formatea equivalencia y volumen en miles', () {
      expect(
        WeightFormatter.formatEquivalence(const Weight.kg(80), WeightUnit.kg),
        '≈ 176 lb',
      );
      expect(
        WeightFormatter.formatVolume(const Weight.kg(12340), WeightUnit.kg),
        '12,3k kg',
      );
    });
  });

  group('DurationFormatter', () {
    test('formatea cronómetro MM:SS y H:MM:SS', () {
      expect(
        DurationFormatter.stopwatch(const Duration(minutes: 4, seconds: 7)),
        '04:07',
      );
      expect(
        DurationFormatter.stopwatch(
          const Duration(hours: 1, minutes: 5, seconds: 9),
        ),
        '1:05:09',
      );
    });

    test('redondea minutos de sesión con mínimo de 1 minuto', () {
      expect(DurationFormatter.minutesLabel(const Duration(seconds: 12)), '1 min');
      expect(
        DurationFormatter.minutesLabel(const Duration(minutes: 49, seconds: 40)),
        '50 min',
      );
    });

    test('formatea horas desde minutos con coma decimal', () {
      expect(DurationFormatter.hoursFromMinutes(0), '0 h');
      expect(DurationFormatter.hoursFromMinutes(120), '2 h');
      expect(DurationFormatter.hoursFromMinutes(510), '8,5 h');
    });
  });

  group('DateLabels', () {
    test('devuelve iniciales L M X J V S D', () {
      final initials = Weekday.values.map(DateLabels.weekdayShort).toList();
      expect(initials, ['L', 'M', 'X', 'J', 'V', 'S', 'D']);
    });

    test('formatea cabecera larga y título de mes', () {
      const demoMonday = LocalDate(year: 2026, month: 6, day: 22);
      expect(DateLabels.fullHeaderDate(demoMonday), 'Lunes, 22 de junio');
      expect(DateLabels.monthYearTitle(2026, 6), 'Junio 2026');
    });
  });
}
