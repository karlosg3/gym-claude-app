import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/features/exercises/data/drift_exercises_repository.dart';
import 'package:gym_claude/src/features/exercises/data/exercises_dao.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/features/routines/data/drift_routines_repository.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/routines/domain/routine_draft.dart';

void main() {
  late AppDatabase db;
  late DriftRoutinesRepository repository;
  late RoutinesService service;
  late int exercise1Id;
  late int exercise2Id;
  late int exercise3Id;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final exercisesDao = ExercisesDao(db);
    final exercisesRepo = DriftExercisesRepository(exercisesDao);

    // Obtener ejercicios ya sembrados por AppDatabase.onCreate
    final seeded = await exercisesRepo.watchLibrary().first;
    exercise1Id = seeded
        .firstWhere((e) => e.muscleGroup == MuscleGroup.shoulders)
        .id;
    exercise2Id = seeded
        .firstWhere((e) => e.muscleGroup == MuscleGroup.back)
        .id;
    exercise3Id = seeded
        .firstWhere((e) => e.muscleGroup == MuscleGroup.legs)
        .id;

    repository = DriftRoutinesRepository(db.routinesDao);
    service = RoutinesService(repository);
  });

  tearDown(() async {
    await db.close();
  });

  group('RoutinesService', () {
    test('crea y obtiene una rutina con borrador válido', () async {
      const draft = RoutineDraft(
        name: 'Torso / Pierna',
        description: 'Enfoque hipertrofia 4 días',
        activeDays: {
          Weekday.monday,
          Weekday.tuesday,
          Weekday.thursday,
          Weekday.friday,
        },
      );

      final id = await service.create(draft);
      final created = await service.findById(id);

      expect(created, isNotNull);
      expect(created!.name, 'Torso / Pierna');
      expect(created.description, 'Enfoque hipertrofia 4 días');
      expect(created.activeDaysCount, 4);
      expect(created.activeDays, {
        Weekday.monday,
        Weekday.tuesday,
        Weekday.thursday,
        Weekday.friday,
      });
      expect(created.items, isEmpty);
    });

    test('valida nombre obligatorio y días activos al crear', () async {
      // Nombre vacío
      expect(
        () => service.create(
          const RoutineDraft(name: '   ', activeDays: {Weekday.monday}),
        ),
        throwsA(isA<EmptyNameException>()),
      );

      // Nombre demasiado largo (> 60 caracteres)
      expect(
        () => service.create(
          RoutineDraft(name: 'A' * 65, activeDays: const {Weekday.monday}),
        ),
        throwsA(isA<DomainException>()),
      );

      // Sin días activos
      expect(
        () => service.create(
          const RoutineDraft(name: 'Sin días', activeDays: {}),
        ),
        throwsA(isA<RoutineWithoutDaysException>()),
      );
    });

    test(
      'asigna ejercicios a un día y evita duplicados en el mismo día',
      () async {
        final routineId = await service.create(
          const RoutineDraft(
            name: 'Empuje',
            activeDays: {Weekday.monday, Weekday.thursday},
          ),
        );

        // Agregar ejercicio 1 en Lunes
        final item1Id = await service.addExercise(
          routineId,
          Weekday.monday,
          exercise1Id,
          const RepScheme(sets: 4, reps: 8),
        );
        expect(item1Id, isPositive);

        // Agregar ejercicio 2 en Lunes
        final item2Id = await service.addExercise(
          routineId,
          Weekday.monday,
          exercise2Id,
          const RepScheme(sets: 3), // al fallo
        );
        expect(item2Id, isPositive);

        final routine = await service.findById(routineId);
        final mondayItems = routine!.itemsFor(Weekday.monday);
        expect(mondayItems.length, 2);
        expect(mondayItems[0].exercise.id, exercise1Id);
        expect(mondayItems[0].scheme.label, '4 × 8');
        expect(mondayItems[1].exercise.id, exercise2Id);
        expect(mondayItems[1].scheme.isMax, true);
        expect(mondayItems[1].scheme.label, '3 × máx');

        // Intento de volver a agregar ejercicio 1 el mismo día lanza excepción
        expect(
          () => service.addExercise(routineId, Weekday.monday, exercise1Id),
          throwsA(isA<ExerciseAlreadyInDayException>()),
        );

        // Pero sí se permite agregar ejercicio 1 en otro día (Jueves)
        final thursdayItemId = await service.addExercise(
          routineId,
          Weekday.thursday,
          exercise1Id,
        );
        expect(thursdayItemId, isPositive);
      },
    );

    test('reordena ejercicios dentro de un día de la rutina', () async {
      final routineId = await service.create(
        const RoutineDraft(name: 'Full Body', activeDays: {Weekday.wednesday}),
      );

      await service.addExercise(routineId, Weekday.wednesday, exercise1Id);
      await service.addExercise(routineId, Weekday.wednesday, exercise2Id);
      await service.addExercise(routineId, Weekday.wednesday, exercise3Id);

      var routine = await service.findById(routineId);
      var items = routine!.itemsFor(Weekday.wednesday);
      expect(items.map((it) => it.exercise.id).toList(), [
        exercise1Id,
        exercise2Id,
        exercise3Id,
      ]);

      // Mover ejercicio de índice 2 al índice 0
      await service.reorder(routineId, Weekday.wednesday, 2, 0);

      routine = await service.findById(routineId);
      items = routine!.itemsFor(Weekday.wednesday);
      expect(items.map((it) => it.exercise.id).toList(), [
        exercise3Id,
        exercise1Id,
        exercise2Id,
      ]);
    });

    test('actualiza el esquema de series y repeticiones', () async {
      final routineId = await service.create(
        const RoutineDraft(name: 'Rutina', activeDays: {Weekday.friday}),
      );
      final itemId = await service.addExercise(
        routineId,
        Weekday.friday,
        exercise1Id,
        const RepScheme(sets: 3, reps: 10),
      );

      // Cambiar a 5 series al fallo
      await service.setScheme(itemId, const RepScheme(sets: 5));

      final routine = await service.findById(routineId);
      final item = routine!.itemsFor(Weekday.friday).first;
      expect(item.scheme.sets, 5);
      expect(item.scheme.isMax, true);

      // Validación: series fuera de 1..10
      expect(
        () => RepScheme(sets: 11, reps: 10),
        throwsA(isA<AssertionError>()),
      );
    });

    test('eliminar ejercicio puntual de la rutina', () async {
      final routineId = await service.create(
        const RoutineDraft(name: 'Rutina', activeDays: {Weekday.monday}),
      );
      final itemId = await service.addExercise(
        routineId,
        Weekday.monday,
        exercise1Id,
      );

      await service.removeItem(itemId);

      final routine = await service.findById(routineId);
      expect(routine!.itemsFor(Weekday.monday), isEmpty);
    });

    test(
      'actualizar rutina y deseleccionar un día purga sus ejercicios asignados',
      () async {
        final routineId = await service.create(
          const RoutineDraft(
            name: 'Original',
            activeDays: {Weekday.monday, Weekday.wednesday},
          ),
        );

        await service.addExercise(routineId, Weekday.monday, exercise1Id);
        await service.addExercise(routineId, Weekday.wednesday, exercise2Id);

        // Actualizar quitando el Miércoles
        await service.update(
          routineId,
          const RoutineDraft(name: 'Solo Lunes', activeDays: {Weekday.monday}),
        );

        final updated = await service.findById(routineId);
        expect(updated!.name, 'Solo Lunes');
        expect(updated.activeDays, {Weekday.monday});
        expect(updated.itemsFor(Weekday.monday).length, 1);
        expect(updated.itemsFor(Weekday.wednesday), isEmpty);
      },
    );

    test('eliminar rutina borra en cascada sus items', () async {
      final routineId = await service.create(
        const RoutineDraft(name: 'A eliminar', activeDays: {Weekday.tuesday}),
      );
      await service.addExercise(routineId, Weekday.tuesday, exercise1Id);

      await service.delete(routineId);

      final deleted = await service.findById(routineId);
      expect(deleted, isNull);

      final all = await service.watchAll().first;
      expect(all.any((r) => r.id == routineId), false);
    });

    test(
      'calcula accentGroup según el grupo muscular con más ejercicios',
      () async {
        final routineId = await service.create(
          const RoutineDraft(
            name: 'Accent Test',
            activeDays: {Weekday.monday, Weekday.tuesday},
          ),
        );

        // Exercise1 = shoulders, Exercise2 = back
        await service.addExercise(routineId, Weekday.monday, exercise1Id);
        var routine = await service.findById(routineId);
        expect(routine!.accentGroup, MuscleGroup.shoulders);

        await service.addExercise(routineId, Weekday.tuesday, exercise2Id);
        // Desempate: primer orden de aparición (shoulders)
        routine = await service.findById(routineId);
        expect(routine!.accentGroup, MuscleGroup.shoulders);

        // Otro ejercicio de back
        final allExercises = await DriftExercisesRepository(ExercisesDao(db))
            .watchLibrary()
            .first;
        final exercise4Id = allExercises
            .firstWhere(
              (e) => e.muscleGroup == MuscleGroup.back && e.id != exercise2Id,
            )
            .id;
        await service.addExercise(routineId, Weekday.monday, exercise4Id);

        routine = await service.findById(routineId);
        // Ahora back tiene 2, shoulders tiene 1 -> accentGroup = back
        expect(routine!.accentGroup, MuscleGroup.back);
      },
    );

    test(
      'watchPlannedWeekdays emite conjunto de días con ejercicios asignados',
      () async {
        final routineId = await service.create(
          const RoutineDraft(
            name: 'Plan',
            activeDays: {Weekday.monday, Weekday.friday},
          ),
        );

        // Al inicio, no hay ejercicios asignados en ningún día
        var planned = await service.watchPlannedWeekdays().first;
        expect(planned, isEmpty);

        // Asignar ejercicio solo al Lunes
        await service.addExercise(routineId, Weekday.monday, exercise1Id);
        planned = await service.watchPlannedWeekdays().first;
        expect(planned, {Weekday.monday});

        // Asignar ejercicio al Viernes
        await service.addExercise(routineId, Weekday.friday, exercise2Id);
        planned = await service.watchPlannedWeekdays().first;
        expect(planned, {Weekday.monday, Weekday.friday});
      },
    );
  });
}
