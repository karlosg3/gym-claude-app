import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/errors/domain_exception.dart';
import 'package:gym_claude/src/features/routines/data/drift_routines_repository.dart';
import 'package:gym_claude/src/features/routines/data/routines_repository.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/routines/domain/routine.dart';
import 'package:gym_claude/src/features/routines/domain/routine_draft.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routines_service.g.dart';

/// Servicio de casos de uso y lógica de negocio para la gestión de rutinas.
class RoutinesService {
  const RoutinesService(this._repository);

  final RoutinesRepository _repository;

  /// Observa todas las rutinas.
  Stream<List<Routine>> watchAll() => _repository.watchAll();

  /// Observa una rutina específica por su [id].
  Stream<Routine?> watchById(int id) => _repository.watchById(id);

  /// Observa las rutinas que tienen al menos un ejercicio asignado para el [day].
  Stream<List<Routine>> watchForWeekday(Weekday day) =>
      _repository.watchForWeekday(day);

  /// Observa el conjunto de días con ejercicios planificados (usado por racha y notificaciones).
  Stream<Set<Weekday>> watchPlannedWeekdays() =>
      _repository.watchPlannedWeekdays();

  /// Busca una rutina por ID en una lectura puntual.
  Future<Routine?> findById(int id) => _repository.findById(id);

  /// Crea una nueva rutina validando las reglas de negocio.
  Future<int> create(RoutineDraft draft, [DateTime? createdAt]) async {
    _validateDraft(draft);
    final now = createdAt ?? DateTime.now();
    return _repository.insert(draft, now);
  }

  /// Actualiza una rutina existente. Desactivar un día elimina sus items en cascada.
  Future<void> update(int id, RoutineDraft draft) async {
    _validateDraft(draft);
    return _repository.update(id, draft);
  }

  /// Elimina una rutina por su identificador.
  Future<void> delete(int id) => _repository.delete(id);

  /// Asigna un ejercicio a un día concreto de una rutina con el esquema indicado.
  /// Lanza [ExerciseAlreadyInDayException] si el ejercicio ya está en ese día.
  Future<int> addExercise(
    int routineId,
    Weekday day,
    int exerciseId, [
    RepScheme scheme = const RepScheme(sets: 3, reps: 10),
  ]) async {
    final routine = await _repository.findById(routineId);
    if (routine != null) {
      final existingDayItems = routine.itemsFor(day);
      final alreadyPresent =
          existingDayItems.any((it) => it.exercise.id == exerciseId);
      if (alreadyPresent) {
        throw const ExerciseAlreadyInDayException();
      }
    }
    return _repository.addExercise(routineId, day, exerciseId, scheme);
  }

  /// Elimina un ejercicio asignado a una rutina.
  Future<void> removeItem(int itemId) => _repository.removeItem(itemId);

  /// Reordena los ejercicios dentro de un mismo día de una rutina.
  Future<void> reorder(
    int routineId,
    Weekday day,
    int oldIndex,
    int newIndex,
  ) =>
      _repository.reorder(routineId, day, oldIndex, newIndex);

  /// Modifica el esquema de series y repeticiones de un item de rutina.
  Future<void> setScheme(int itemId, RepScheme scheme) {
    if (scheme.sets < 1 || scheme.sets > 10) {
      throw const DomainException('Las series deben estar entre 1 y 10');
    }
    if (scheme.reps != null && (scheme.reps! < 1 || scheme.reps! > 50)) {
      throw const InvalidRepsException();
    }
    return _repository.setScheme(itemId, scheme);
  }

  void _validateDraft(RoutineDraft draft) {
    if (draft.name.trim().isEmpty) {
      throw const EmptyNameException();
    }
    if (draft.name.trim().length > 60) {
      throw const DomainException('El nombre no puede superar los 60 caracteres');
    }
    if (draft.activeDays.isEmpty) {
      throw const RoutineWithoutDaysException();
    }
  }
}

@Riverpod(keepAlive: true)
RoutinesService routinesService(Ref ref) {
  final repo = ref.watch(routinesRepositoryProvider);
  return RoutinesService(repo);
}

@riverpod
Stream<List<Routine>> routinesList(Ref ref) {
  return ref.watch(routinesServiceProvider).watchAll();
}

@riverpod
Stream<Routine?> routineDetail(Ref ref, int id) {
  return ref.watch(routinesServiceProvider).watchById(id);
}
