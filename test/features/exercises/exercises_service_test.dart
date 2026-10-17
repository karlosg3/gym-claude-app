import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/features/exercises/application/exercises_service.dart';
import 'package:gym_claude/src/features/exercises/data/drift_exercises_repository.dart';
import 'package:gym_claude/src/features/exercises/data/exercises_dao.dart';
import 'package:gym_claude/src/features/exercises/domain/delete_outcome.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_draft.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_filter.dart';

void main() {
  late AppDatabase db;
  late ExercisesDao dao;
  late DriftExercisesRepository repository;
  late ExercisesService service;
  late Set<int> exercisesWithHistory;

  final fixedClock = Clock.fixed(DateTime(2026, 6, 22, 10));

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    dao = ExercisesDao(db);
    repository = DriftExercisesRepository(dao);
    exercisesWithHistory = <int>{};

    service = ExercisesService(
      repository: repository,
      clock: fixedClock,
      hasHistoryChecker: (id) async => exercisesWithHistory.contains(id),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('ExercisesService', () {
    test('arranca con los 12 ejercicios base sembrados', () async {
      final library = await service.watchLibrary().first;
      expect(library.length, 12);

      final names = library.map((e) => e.name).toList();
      expect(names, contains('Press de banca'));
      expect(names, contains('Sentadilla'));
      expect(names, contains('Dominadas'));
    });

    test('filtra biblioteca por grupo muscular y texto con búsqueda sin acentos', () async {
      final chestOnly = await service.watchLibrary(
        const ExerciseFilter(group: MuscleGroup.chest),
      ).first;
      expect(chestOnly.length, 3);
      expect(chestOnly.every((e) => e.muscleGroup == MuscleGroup.chest), true);

      final queryResult = await service.watchLibrary(
        const ExerciseFilter(query: 'banca'),
      ).first;
      expect(queryResult.map((e) => e.name), ['Press de banca']);

      // Búsqueda sin acentos: 'biceps' encuentra 'Curl de bíceps'
      final accentInsensitive = await service.watchLibrary(
        const ExerciseFilter(query: 'biceps'),
      ).first;
      expect(accentInsensitive.map((e) => e.name), ['Curl de bíceps']);
    });

    test('crea un nuevo ejercicio con borrador válido', () async {
      const draft = ExerciseDraft(
        name: 'Hip Thrust',
        muscleGroup: MuscleGroup.legs,
        unit: WeightUnit.kg,
        description: 'Empuje de cadera con barra sobre banco.',
      );

      final id = await service.create(draft);
      final created = await service.findById(id);

      expect(created, isNotNull);
      expect(created!.name, 'Hip Thrust');
      expect(created.muscleGroup, MuscleGroup.legs);
      expect(created.unit, WeightUnit.kg);
      expect(created.createdAt, fixedClock.now());
    });

    test('rechaza nombre vacío y nombres duplicados ignorando mayúsculas y acentos', () async {
      const emptyDraft = ExerciseDraft(
        name: '   ',
        muscleGroup: MuscleGroup.arms,
        unit: WeightUnit.kg,
      );
      expect(
        () => service.create(emptyDraft),
        throwsA(isA<DomainException>()),
      );

      // Duplicado con distinta capitalización
      const duplicateCase = ExerciseDraft(
        name: 'press de banca',
        muscleGroup: MuscleGroup.chest,
        unit: WeightUnit.kg,
      );
      expect(
        () => service.create(duplicateCase),
        throwsA(isA<DomainException>()),
      );

      // Duplicado con tildes / sin tildes
      const duplicateAccent = ExerciseDraft(
        name: 'Curl de biceps',
        muscleGroup: MuscleGroup.arms,
        unit: WeightUnit.lb,
      );
      expect(
        () => service.create(duplicateAccent),
        throwsA(isA<DomainException>()),
      );
    });

    test('borrar ejercicio sin historial lo elimina permanentemente', () async {
      const draft = ExerciseDraft(
        name: 'Paseo del granjero',
        muscleGroup: MuscleGroup.arms,
        unit: WeightUnit.kg,
      );
      final id = await service.create(draft);

      final outcome = await service.delete(id);
      expect(outcome, DeleteOutcome.deleted);

      final found = await service.findById(id);
      expect(found, isNull);
    });

    test('borrar ejercicio con historial lo archiva y recrear lo restaura', () async {
      const draft = ExerciseDraft(
        name: 'Press Francés',
        muscleGroup: MuscleGroup.arms,
        unit: WeightUnit.kg,
      );
      final id = await service.create(draft);
      exercisesWithHistory.add(id);

      final outcome = await service.delete(id);
      expect(outcome, DeleteOutcome.archived);

      // Desaparece de la biblioteca activa
      final activeList = await service.watchLibrary().first;
      expect(activeList.any((e) => e.id == id), false);

      // Pero sigue existiendo archivado
      final archived = await service.findById(id);
      expect(archived, isNotNull);
      expect(archived!.isArchived, true);
      expect(archived.archivedAt, fixedClock.now());

      // Recrear un ejercicio con el mismo nombre restaura la fila existente
      final restoredId = await service.create(
        draft.copyWith(description: 'Versión restaurada'),
      );
      expect(restoredId, id);

      final restored = await service.findById(id);
      expect(restored!.isArchived, false);
      expect(restored.description, 'Versión restaurada');
    });

    test('actualiza unidad de peso del ejercicio', () async {
      final library = await service.watchLibrary().first;
      final bench = library.firstWhere((e) => e.name == 'Press de banca');
      expect(bench.unit, WeightUnit.kg);

      await service.setUnit(bench.id, WeightUnit.lb);
      final updated = await service.findById(bench.id);
      expect(updated!.unit, WeightUnit.lb);
    });
  });
}
