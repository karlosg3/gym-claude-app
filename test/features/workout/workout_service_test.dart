import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/core/events/app_event.dart';
import 'package:gym_claude/src/features/exercises/domain/delete_outcome.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/routines/domain/routine_draft.dart';
import 'package:gym_claude/src/features/workout/application/workout_service.dart';
import 'package:gym_claude/src/features/workout/domain/finish_outcome.dart';
import 'package:gym_claude/src/features/workout/domain/session_status.dart';

import 'workout_test_harness.dart';

void main() {
  late WorkoutTestHarness h;

  setUp(() async => h = await WorkoutTestHarness.create());
  tearDown(() => h.dispose());

  group('start', () {
    test(
      'copia los ejercicios del día con snapshot de objetivo y peso corporal',
      () async {
        final routineId = await h.createPushRoutine();

        final id = await h.workout.start(
          routineId: routineId,
          day: Weekday.monday,
        );
        final session = (await h.workout.findActive())!;

        expect(session.id, id);
        expect(session.title, 'Día de Empuje');
        expect(session.routineId, routineId);
        expect(session.accentGroup, MuscleGroup.chest);
        expect(session.date, const LocalDate(year: 2026, month: 6, day: 22));
        expect(session.status, SessionStatus.active);
        expect(session.exercises.map((e) => e.exercise.name), [
          'Press de banca',
          'Fondos en paralelas',
        ]);
        expect(session.exercises[0].target, const RepScheme(sets: 4, reps: 8));
        expect(session.exercises[0].isBodyweight, isFalse);
        expect(session.exercises[1].target, const RepScheme(sets: 3));
        expect(session.exercises[1].isBodyweight, isTrue);

        await h.flush();
        expect(h.events, [AppEvent.workoutStarted(id)]);
      },
    );

    test('usa el día de hoy si no se indica', () async {
      final routineId = await h.createPushRoutine();
      await h.workout.start(routineId: routineId);
      expect((await h.workout.findActive())!.exercises, hasLength(2));
    });

    test(
      'editar la rutina después no cambia el objetivo de la sesión',
      () async {
        final routineId = await h.createPushRoutine();
        await h.workout.start(routineId: routineId, day: Weekday.monday);

        final routine = (await h.routines.findById(routineId))!;
        await h.routines.setScheme(
          routine.itemsFor(Weekday.monday).first.id,
          const RepScheme(sets: 5, reps: 5),
        );
        await h.routines.update(
          routineId,
          RoutineDraft(name: 'Empuje B', activeDays: routine.activeDays),
        );

        final session = (await h.workout.findActive())!;
        expect(session.title, 'Día de Empuje');
        expect(
          session.exercises.first.target,
          const RepScheme(sets: 4, reps: 8),
        );
      },
    );

    test('falla con SessionAlreadyActive si ya hay una activa', () async {
      await h.workout.start();
      expect(
        () => h.workout.start(),
        throwsA(isA<SessionAlreadyActiveException>()),
      );
    });

    test('sin rutina es un entrenamiento libre vacío', () async {
      await h.workout.start();
      final session = (await h.workout.findActive())!;
      expect(session.title, WorkoutService.freeTitle);
      expect(session.routineId, isNull);
      expect(session.exercises, isEmpty);
    });
  });

  group('addExercise', () {
    test(
      'añade al final con el peso corporal del ejercicio; no repite',
      () async {
        final routineId = await h.createPushRoutine();
        final id = await h.workout.start(
          routineId: routineId,
          day: Weekday.monday,
        );

        await h.workout.addExercise(id, h.exercise('Dominadas').id);
        final session = (await h.workout.findActive())!;
        expect(session.exercises.last.exercise.name, 'Dominadas');
        expect(session.exercises.last.position, 2);
        expect(session.exercises.last.isBodyweight, isTrue);
        expect(session.exercises.last.target, isNull);

        expect(
          () => h.workout.addExercise(id, h.exercise('Dominadas').id),
          throwsA(isA<DomainException>()),
        );
      },
    );
  });

  group('series', () {
    late int benchId;

    setUp(() async {
      final routineId = await h.createPushRoutine();
      await h.workout.start(routineId: routineId, day: Weekday.monday);
      benchId = (await h.workout.findActive())!.exercises.first.id;
    });

    test('addSet convierte lb a kg y numera correlativamente', () async {
      await h.workout.addSet(benchId, value: 72, unit: WeightUnit.kg, reps: 8);
      await h.workout.addSet(benchId, value: 160, unit: WeightUnit.lb, reps: 6);

      final sets = (await h.workout.findActive())!.exercises.first.sets;
      expect(sets.map((s) => s.setNumber), [1, 2]);
      expect(sets[0].weight.value, 72);
      expect(sets[1].weight.value, closeTo(72.57, 0.01));
    });

    test('reps inválidas o peso negativo fallan; peso 0 se permite', () async {
      expect(
        () =>
            h.workout.addSet(benchId, value: 70, unit: WeightUnit.kg, reps: 0),
        throwsA(isA<InvalidRepsException>()),
      );
      expect(
        () =>
            h.workout.addSet(benchId, value: -1, unit: WeightUnit.kg, reps: 5),
        throwsA(isA<InvalidWeightException>()),
      );
      await h.workout.addSet(benchId, value: 0, unit: WeightUnit.kg, reps: 12);
      expect((await h.workout.findActive())!.totalSets, 1);
    });

    test('deleteSet renumera las posteriores', () async {
      for (final reps in [10, 9, 8]) {
        await h.workout.addSet(
          benchId,
          value: 60,
          unit: WeightUnit.kg,
          reps: reps,
        );
      }
      var sets = (await h.workout.findActive())!.exercises.first.sets;
      await h.workout.deleteSet(sets[0].id);

      sets = (await h.workout.findActive())!.exercises.first.sets;
      expect(sets.map((s) => (s.setNumber, s.reps)), [(1, 9), (2, 8)]);
    });

    test('updateSet cambia peso y reps', () async {
      final setId = await h.workout.addSet(
        benchId,
        value: 60,
        unit: WeightUnit.kg,
        reps: 8,
      );
      await h.workout.updateSet(setId, value: 62.5, reps: 7);
      final set = (await h.workout.findActive())!.exercises.first.sets.single;
      expect(set.weight.value, 62.5);
      expect(set.reps, 7);
    });

    test('setNote guarda la nota del ejercicio', () async {
      await h.workout.setNote(benchId, 'Buena técnica');
      final session = (await h.workout.findActive())!;
      expect(session.exercises.first.note, 'Buena técnica');
      expect(session.note, 'Buena técnica');
    });
  });

  group('finish / discard', () {
    test('sin series descarta la sesión', () async {
      await h.workout.start();
      final outcome = await h.workout.finish();
      expect(outcome, isA<FinishDiscarded>());
      expect(await h.workout.findActive(), isNull);
    });

    test('con series completa y emite WorkoutCompleted', () async {
      final routineId = await h.createPushRoutine();
      final id = await h.workout.start(
        routineId: routineId,
        day: Weekday.monday,
      );
      final benchId = (await h.workout.findActive())!.exercises.first.id;
      h.now = h.now.add(const Duration(minutes: 5));
      await h.workout.addSet(benchId, value: 72, unit: WeightUnit.kg, reps: 8);

      h.now = h.now.add(const Duration(minutes: 42));
      final outcome = await h.workout.finish();

      expect(outcome, isA<FinishCompleted>());
      expect((outcome as FinishCompleted).sessionId, id);
      expect(await h.workout.findActive(), isNull);

      final saved = (await h.workout.watchSession(id).first)!;
      expect(saved.status, SessionStatus.completed);
      expect(saved.durationAt(h.now), const Duration(minutes: 47));
      // Los ejercicios sin series se conservan para el resumen ("1/2").
      expect(saved.exercises, hasLength(2));
      expect(saved.exercisesDone, 1);

      await h.flush();
      expect(h.events.last, isA<WorkoutCompleted>());
    });

    test('finishStale usa la hora de la última serie', () async {
      await h.workout.start();
      final session = (await h.workout.findActive())!;
      await h.workout.addExercise(session.id, h.exercise('Sentadilla').id);
      final seId = (await h.workout.findActive())!.exercises.single.id;

      h.now = h.now.add(const Duration(minutes: 30));
      final lastSetAt = h.now;
      await h.workout.addSet(seId, value: 100, unit: WeightUnit.kg, reps: 5);

      h.now = h.now.add(const Duration(hours: 7));
      expect((await h.workout.findActive())!.isStaleAt(h.now), isTrue);

      final outcome = await h.workout.finishStale();
      final saved = (await h.workout
          .watchSession((outcome as FinishCompleted).sessionId)
          .first)!;
      expect(saved.endedAt, lastSetAt);
    });

    test('discard borra la sesión activa', () async {
      await h.workout.start();
      await h.workout.discard();
      expect(await h.workout.findActive(), isNull);
    });

    test('operar sin sesión activa falla con NoActiveSession', () async {
      expect(
        () => h.workout.finish(),
        throwsA(isA<NoActiveSessionException>()),
      );
    });
  });

  group('récords y peso anterior', () {
    Future<int> trainBench(List<(double, int)> sets) async {
      final routineId =
          (await h.routines.watchAll().first).firstOrNull?.id ??
          await h.createPushRoutine();
      await h.workout.start(routineId: routineId, day: Weekday.monday);
      final benchId = (await h.workout.findActive())!.exercises.first.id;
      for (final (kg, reps) in sets) {
        await h.workout.addSet(
          benchId,
          value: kg,
          unit: WeightUnit.kg,
          reps: reps,
        );
      }
      final outcome = await h.workout.finish();
      h.now = h.now.add(const Duration(days: 3));
      return (outcome as FinishCompleted).sessionId;
    }

    test(
      'la primera vez no es récord; después se emite una vez por sesión',
      () async {
        await trainBench([(70, 8), (72, 8)]);
        await h.flush();
        expect(h.events.whereType<PersonalRecordAchieved>(), isEmpty);

        await trainBench([(74, 6), (75, 5), (72, 8)]);
        await h.flush();
        final records = h.events.whereType<PersonalRecordAchieved>().toList();
        expect(records, hasLength(1));
        expect(records.single.weightKg, 74);
        expect(records.single.exerciseName, 'Press de banca');
      },
    );

    test(
      'peso anterior = mejor serie de la sesión completada más reciente',
      () async {
        await trainBench([(70, 8), (72, 8)]);
        await trainBench([(65, 10), (65, 12)]);

        final bench = h.exercise('Press de banca').id;
        final last = await h.progress.watchLastBest({bench}).first;
        expect(last[bench]!.weight.value, 65);
        expect(last[bench]!.reps, 12);
      },
    );

    test('borrar un ejercicio con historial lo archiva', () async {
      await trainBench([(70, 8)]);
      final outcome = await h.exercises.delete(h.exercise('Press de banca').id);
      expect(outcome, DeleteOutcome.archived);
    });
  });
}
