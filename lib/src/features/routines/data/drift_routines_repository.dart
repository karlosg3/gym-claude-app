import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart'
    hide WatchAllWithItemsResult;
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/features/routines/data/routines_dao.dart';
import 'package:gym_claude/src/features/routines/data/routines_repository.dart';
import 'package:gym_claude/src/features/routines/domain/exercise_ref.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/routines/domain/routine.dart';
import 'package:gym_claude/src/features/routines/domain/routine_draft.dart';
import 'package:gym_claude/src/features/routines/domain/routine_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_routines_repository.g.dart';

class DriftRoutinesRepository implements RoutinesRepository {
  const DriftRoutinesRepository(this._dao);

  final RoutinesDao _dao;

  @override
  Stream<List<Routine>> watchAll() {
    return _dao.watchAllWithItemsRows().map(_groupRowsToRoutines);
  }

  @override
  Stream<Routine?> watchById(int id) {
    return watchAll().map((list) {
      try {
        return list.firstWhere((r) => r.id == id);
      } catch (_) {
        return null;
      }
    });
  }

  @override
  Stream<List<Routine>> watchForWeekday(Weekday day) {
    return _dao.watchForWeekdayRows(day).asyncMap((rows) async {
      final all = await watchAll().first;
      final ids = rows.map((r) => r.id).toSet();
      return all.where((r) => ids.contains(r.id)).toList();
    });
  }

  @override
  Stream<Set<Weekday>> watchPlannedWeekdays() {
    return _dao.watchPlannedWeekdaysStream();
  }

  @override
  Future<Routine?> findById(int id) async {
    final all = await watchAll().first;
    try {
      return all.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int> insert(RoutineDraft draft, DateTime createdAt) {
    return _dao.insertRoutineRow(
      RoutinesCompanion.insert(
        name: draft.name.trim(),
        description: Value(draft.description.trim()),
        activeDays: draft.activeDays,
        createdAt: createdAt,
      ),
    );
  }

  @override
  Future<void> update(int id, RoutineDraft draft) async {
    await _dao.transaction(() async {
      await _dao.updateRoutineRow(
        id,
        RoutinesCompanion(
          name: Value(draft.name.trim()),
          description: Value(draft.description.trim()),
          activeDays: Value(draft.activeDays),
        ),
      );
      // Al desactivar días, se borran automáticamente sus items asignados
      await _dao.deleteItemsNotInDays(id, draft.activeDays);
    });
  }

  @override
  Future<void> delete(int id) {
    return _dao.deleteRoutineRow(id).then((_) {});
  }

  @override
  Future<int> addExercise(
    int routineId,
    Weekday day,
    int exerciseId,
    RepScheme scheme,
  ) async {
    final nextPos = await _dao.getNextItemPosition(routineId, day);
    return _dao.insertItemRow(
      RoutineItemsCompanion.insert(
        routineId: routineId,
        weekday: day.isoValue,
        exerciseId: exerciseId,
        position: nextPos,
        targetSets: Value(scheme.sets),
        targetReps: Value(scheme.reps),
      ),
    );
  }

  @override
  Future<void> removeItem(int itemId) {
    return _dao.deleteItemRow(itemId).then((_) {});
  }

  @override
  Future<void> reorder(
    int routineId,
    Weekday day,
    int oldIndex,
    int newIndex,
  ) async {
    final items = await _dao.getItemsByDay(routineId, day);
    if (oldIndex < 0 ||
        oldIndex >= items.length ||
        newIndex < 0 ||
        newIndex >= items.length) {
      return;
    }
    final mutable = List.of(items);
    final moved = mutable.removeAt(oldIndex);
    mutable.insert(newIndex, moved);

    await _dao.transaction(() async {
      for (var i = 0; i < mutable.length; i++) {
        await _dao.updateItemRow(
          mutable[i].ri.id,
          RoutineItemsCompanion(position: Value(i)),
        );
      }
    });
  }

  @override
  Future<void> setScheme(int itemId, RepScheme scheme) {
    return _dao.updateItemRow(
      itemId,
      RoutineItemsCompanion(
        targetSets: Value(scheme.sets),
        targetReps: Value(scheme.reps),
      ),
    ).then((_) {});
  }

  List<Routine> _groupRowsToRoutines(List<WatchAllWithItemsResult> rows) {
    final routinesMap = <int, Routine>{};
    final itemsMap = <int, List<RoutineItem>>{};

    for (final row in rows) {
      final r = row.r;
      if (!routinesMap.containsKey(r.id)) {
        routinesMap[r.id] = Routine(
          id: r.id,
          name: r.name,
          description: r.description,
          activeDays: r.activeDays,
          sortOrder: r.sortOrder,
          createdAt: r.createdAt,
          items: const [],
        );
        itemsMap[r.id] = [];
      }

      if (row.ri != null && row.exerciseId != null) {
        final ri = row.ri!;
        final item = RoutineItem(
          id: ri.id,
          routineId: ri.routineId,
          weekday: Weekday.fromIso(ri.weekday),
          position: ri.position,
          exercise: ExerciseRef(
            id: row.exerciseId!,
            name: row.exerciseName!,
            muscleGroup: row.exerciseGroup!,
            unit: row.exerciseUnit!,
          ),
          scheme: RepScheme(
            sets: ri.targetSets,
            reps: ri.targetReps,
          ),
        );
        itemsMap[r.id]!.add(item);
      }
    }

    return routinesMap.values.map((r) {
      return r.copyWith(items: itemsMap[r.id] ?? const []);
    }).toList();
  }
}

@Riverpod(keepAlive: true)
RoutinesRepository routinesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftRoutinesRepository(db.routinesDao);
}
