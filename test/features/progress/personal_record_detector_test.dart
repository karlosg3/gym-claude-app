import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/features/progress/domain/personal_record_detector.dart';
import 'package:gym_claude/src/features/progress/domain/set_performance.dart';

SetPerformance s(double kg, int reps) =>
    SetPerformance(weight: Weight.kg(kg), reps: reps);

void main() {
  group('PersonalRecordDetector.best', () {
    test('mayor peso; a igual peso, más reps; vacío = null', () {
      expect(PersonalRecordDetector.best([]), isNull);
      expect(
        PersonalRecordDetector.best([s(70, 10), s(72, 6), s(72, 8)]),
        s(72, 8),
      );
      expect(PersonalRecordDetector.best([s(0, 12), s(0, 15)]), s(0, 15));
    });
  });

  group('PersonalRecordDetector.isFirstRecordInSession', () {
    final cases =
        <(String, SetPerformance, List<SetPerformance>, double?, bool)>[
          (
            'primera vez (sin máximo previo) no es récord',
            s(80, 5),
            [],
            null,
            false,
          ),
          ('supera el máximo previo', s(75, 5), [], 72.5, true),
          ('igualar el máximo no es récord', s(72.5, 10), [], 72.5, false),
          (
            'ya hubo récord antes en la sesión',
            s(80, 3),
            [s(75, 5)],
            72.5,
            false,
          ),
          ('series previas sin récord', s(75, 5), [s(70, 8)], 72.5, true),
        ];
    for (final (name, newSet, earlier, prevMax, expected) in cases) {
      test(name, () {
        expect(
          PersonalRecordDetector.isFirstRecordInSession(
            newSet: newSet,
            earlierSets: earlier,
            previousMax: prevMax == null ? null : Weight.kg(prevMax),
          ),
          expected,
        );
      });
    }
  });
}
