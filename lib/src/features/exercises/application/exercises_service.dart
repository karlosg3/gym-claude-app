import 'package:clock/clock.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/core/time/clock_provider.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/exercises/data/drift_exercises_repository.dart';
import 'package:gym_claude/src/features/exercises/data/exercises_repository.dart';
import 'package:gym_claude/src/features/exercises/domain/delete_outcome.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_draft.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_service.g.dart';

/// Servicio de lógica de negocio para la biblioteca de ejercicios.
class ExercisesService {
  const ExercisesService({
    required this.repository,
    required this.clock,
    this.hasHistoryChecker,
  });

  final ExercisesRepository repository;
  final Clock clock;
  final Future<bool> Function(int exerciseId)? hasHistoryChecker;

  static String normalizeKey(String text) {
    var s = text.trim().toLowerCase();
    const withAccents = 'áéíóúüñ';
    const withoutAccents = 'aeiouun';
    for (var i = 0; i < withAccents.length; i++) {
      s = s.replaceAll(withAccents[i], withoutAccents[i]);
    }
    return s;
  }

  Stream<List<Exercise>> watchLibrary([ExerciseFilter? filter]) {
    final stream = repository.watchLibrary(group: filter?.group);
    final query = filter?.query.trim() ?? '';
    if (query.isEmpty) {
      return stream;
    }

    final normalizedQuery = normalizeKey(query);
    return stream.map((exercises) {
      return exercises.where((ex) {
        final normalizedName = normalizeKey(ex.name);
        return normalizedName.contains(normalizedQuery);
      }).toList();
    });
  }

  Stream<Exercise?> watchById(int id) {
    return repository.watchLibrary().map((exercises) {
      for (final ex in exercises) {
        if (ex.id == id) return ex;
      }
      return null;
    });
  }

  Future<Exercise?> findById(int id) => repository.findById(id);

  Future<int> create(ExerciseDraft draft) async {
    _validateDraft(draft);

    final normalized = normalizeKey(draft.name);
    final existing = await repository.findByName(draft.name.trim());

    if (existing != null) {
      if (!existing.isArchived) {
        throw const DomainException('Ya existe un ejercicio con ese nombre');
      }
      // Recrear un ejercicio archivado lo restaura
      await repository.restore(existing.id, draft);
      return existing.id;
    }

    // Comprobación adicional contra ejercicios activos normalizados
    final allActive = await repository.watchLibrary().first;
    for (final ex in allActive) {
      if (normalizeKey(ex.name) == normalized) {
        throw const DomainException('Ya existe un ejercicio con ese nombre');
      }
    }

    return repository.insert(draft, clock.now());
  }

  Future<void> update(int id, ExerciseDraft draft) async {
    _validateDraft(draft);

    final existing = await repository.findById(id);
    if (existing == null) {
      throw const DomainException('Ejercicio no encontrado');
    }

    final normalized = normalizeKey(draft.name);
    final allActive = await repository.watchLibrary().first;
    for (final ex in allActive) {
      if (ex.id != id && normalizeKey(ex.name) == normalized) {
        throw const DomainException('Ya existe un ejercicio con ese nombre');
      }
    }

    await repository.update(id, draft);
  }

  Future<void> setUnit(int id, WeightUnit unit) async {
    final existing = await repository.findById(id);
    if (existing == null) {
      throw const DomainException('Ejercicio no encontrado');
    }
    await repository.updateUnit(id, unit);
  }

  Future<DeleteOutcome> delete(int id) async {
    final existing = await repository.findById(id);
    if (existing == null) {
      throw const DomainException('Ejercicio no encontrado');
    }

    final hasHistory = hasHistoryChecker != null
        ? await hasHistoryChecker!(id)
        : false;

    if (hasHistory) {
      await repository.archive(id, clock.now());
      return DeleteOutcome.archived;
    } else {
      await repository.delete(id);
      return DeleteOutcome.deleted;
    }
  }

  void _validateDraft(ExerciseDraft draft) {
    final name = draft.name.trim();
    if (name.isEmpty) {
      throw const DomainException('El nombre no puede estar vacío');
    }
    if (name.length > 80) {
      throw const DomainException('El nombre no puede superar los 80 caracteres');
    }
  }
}

@Riverpod(keepAlive: true)
ExercisesService exercisesService(Ref ref) {
  final repo = ref.watch(exercisesRepositoryProvider);
  final clk = ref.watch(clockProvider);

  return ExercisesService(
    repository: repo,
    clock: clk,
  );
}
