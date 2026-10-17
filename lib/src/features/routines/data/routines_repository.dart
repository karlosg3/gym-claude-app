import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/routines/domain/routine.dart';
import 'package:gym_claude/src/features/routines/domain/routine_draft.dart';

/// Contrato del repositorio de persistencia de rutinas e items de rutina.
abstract interface class RoutinesRepository {
  /// Observa todas las rutinas con sus items y datos de ejercicio embebidos.
  Stream<List<Routine>> watchAll();

  /// Observa una rutina específica por su identificador.
  Stream<Routine?> watchById(int id);

  /// Observa las rutinas que tienen al menos un ejercicio asignado para el [day] indicado.
  Stream<List<Routine>> watchForWeekday(Weekday day);

  /// Observa la unión de días de la semana con al menos un ejercicio planificado.
  Stream<Set<Weekday>> watchPlannedWeekdays();

  /// Busca una rutina por ID en una sola lectura puntual.
  Future<Routine?> findById(int id);

  /// Inserta una nueva rutina a partir de su borrador.
  Future<int> insert(RoutineDraft draft, DateTime createdAt);

  /// Actualiza los metadatos y días activos de una rutina.
  /// Desactivar un día elimina automáticamente los items asignados a ese día.
  Future<void> update(int id, RoutineDraft draft);

  /// Elimina una rutina completa y sus items en cascada.
  Future<void> delete(int id);

  /// Añade un ejercicio a un día de la rutina con el esquema indicado.
  Future<int> addExercise(
    int routineId,
    Weekday day,
    int exerciseId,
    RepScheme scheme,
  );

  /// Elimina un item de rutina por su identificador.
  Future<void> removeItem(int itemId);

  /// Reordena los ejercicios de un día específico compactando sus posiciones contiguas.
  Future<void> reorder(
    int routineId,
    Weekday day,
    int oldIndex,
    int newIndex,
  );

  /// Modifica el esquema de series y repeticiones de un item de rutina.
  Future<void> setScheme(int itemId, RepScheme scheme);
}
