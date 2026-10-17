import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/events/app_event.dart';
import 'package:gym_claude/src/core/events/app_event_bus.dart';

void main() {
  group('AppEventBus', () {
    late AppEventBus bus;

    setUp(() {
      bus = AppEventBus();
    });

    tearDown(() {
      bus.dispose();
    });

    test('emite y recibe eventos a través de stream global', () async {
      final events = <AppEvent>[];
      final sub = bus.stream.listen(events.add);

      bus.emit(const AppEvent.workoutStarted(1));
      bus.emit(const AppEvent.dataWiped());

      await Future<void>.delayed(Duration.zero);
      expect(events, [
        const AppEvent.workoutStarted(1),
        const AppEvent.dataWiped(),
      ]);

      await sub.cancel();
    });

    test('filtra eventos específicos con on<T>()', () async {
      final completedEvents = <WorkoutCompleted>[];
      final sub = bus.on<WorkoutCompleted>().listen(completedEvents.add);

      bus.emit(const AppEvent.workoutStarted(1));
      bus.emit(const AppEvent.workoutCompleted(1, streakBefore: 2, streakAfter: 3));
      bus.emit(const AppEvent.dataWiped());

      await Future<void>.delayed(Duration.zero);
      expect(completedEvents.length, 1);
      expect(completedEvents.first.sessionId, 1);
      expect(completedEvents.first.streakBefore, 2);
      expect(completedEvents.first.streakAfter, 3);

      await sub.cancel();
    });
  });
}
