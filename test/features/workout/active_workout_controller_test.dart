import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/features/workout/application/workout_service.dart';
import 'package:gym_claude/src/features/workout/presentation/controllers/active_workout_controller.dart';

import 'workout_test_harness.dart';

void main() {
  late WorkoutTestHarness h;
  late ProviderContainer container;
  late int benchId;

  setUp(() async {
    h = await WorkoutTestHarness.create();
    final routineId = await h.createPushRoutine();
    await h.workout.start(routineId: routineId, day: Weekday.monday);
    benchId = (await h.workout.findActive())!.exercises.first.id;
    container = ProviderContainer(
      overrides: [workoutServiceProvider.overrideWithValue(h.workout)],
    );
    container.listen(activeWorkoutControllerProvider, (_, _) {});
  });

  tearDown(() async {
    container.dispose();
    await h.dispose();
  });

  ActiveWorkoutController controller() =>
      container.read(activeWorkoutControllerProvider.notifier);

  test(
    'reps vacías o no numéricas quedan como AsyncError(InvalidReps)',
    () async {
      final ok = await controller().addSet(
        benchId,
        weightText: '72',
        repsText: '',
        unit: WeightUnit.kg,
      );
      expect(ok, isFalse);
      expect(
        container.read(activeWorkoutControllerProvider).error,
        isA<InvalidRepsException>(),
      );
    },
  );

  test('peso con coma decimal y vacío = 0', () async {
    expect(
      await controller().addSet(
        benchId,
        weightText: '72,5',
        repsText: '8',
        unit: WeightUnit.kg,
      ),
      isTrue,
    );
    expect(
      await controller().addSet(
        benchId,
        weightText: '',
        repsText: '12',
        unit: WeightUnit.kg,
      ),
      isTrue,
    );
    final sets = (await h.workout.findActive())!.exercises.first.sets;
    expect(sets.map((s) => s.weight.value), [72.5, 0]);
    expect(container.read(activeWorkoutControllerProvider).hasError, isFalse);
  });

  test(
    'iniciar con otra activa deja SessionAlreadyActive en el estado',
    () async {
      expect(await controller().start(), isFalse);
      expect(
        container.read(activeWorkoutControllerProvider).error,
        isA<SessionAlreadyActiveException>(),
      );
    },
  );
}
