import 'package:clock/clock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/time/clock_provider.dart';

void main() {
  group('Time providers', () {
    test('clockProvider retorna Clock por defecto', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final c = container.read(clockProvider);
      expect(c, isA<Clock>());
    });

    test('todayProvider refleja fecha fija al sobreescribir clockProvider', () {
      final fixedDateTime = DateTime(2026, 6, 22, 10, 0);
      final container = ProviderContainer(
        overrides: [
          clockProvider.overrideWithValue(Clock.fixed(fixedDateTime)),
        ],
      );
      addTearDown(container.dispose);

      final today = container.read(todayProvider);
      expect(today, const LocalDate(year: 2026, month: 6, day: 22));
    });
  });
}
