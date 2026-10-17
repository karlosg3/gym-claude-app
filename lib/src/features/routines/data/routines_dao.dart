import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

part 'routines_dao.g.dart';

@DriftAccessor(include: {'routines.drift'})
class RoutinesDao extends DatabaseAccessor<AppDatabase>
    with _$RoutinesDaoMixin {
  RoutinesDao(super.db);

  Stream<List<WatchAllWithItemsResult>> watchAllWithItemsRows() {
    return watchAllWithItems().watch();
  }

  Stream<Set<Weekday>> watchPlannedWeekdaysStream() {
    return watchPlannedWeekdays().watch().map((rows) {
      return rows.map((w) => Weekday.fromIso(w)).toSet();
    });
  }

  Stream<List<RoutineRow>> watchForWeekdayRows(Weekday day) {
    return watchForWeekday(day.isoValue).watch();
  }

  Future<RoutineRow?> getRoutineByIdRow(int id) {
    return getRoutineById(id).getSingleOrNull();
  }

  Future<List<GetItemsByRoutineAndDayResult>> getItemsByDay(
    int routineId,
    Weekday day,
  ) {
    return getItemsByRoutineAndDay(routineId, day.isoValue).get();
  }

  Future<int> insertRoutineRow(RoutinesCompanion companion) {
    return into(routines).insert(companion);
  }

  Future<bool> updateRoutineRow(int id, RoutinesCompanion companion) {
    return (update(routines)..where((tbl) => tbl.id.equals(id)))
        .write(companion)
        .then((count) => count > 0);
  }

  Future<int> deleteRoutineRow(int id) {
    return (delete(routines)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> insertItemRow(RoutineItemsCompanion companion) {
    return into(routineItems).insert(companion);
  }

  Future<bool> updateItemRow(int id, RoutineItemsCompanion companion) {
    return (update(routineItems)..where((tbl) => tbl.id.equals(id)))
        .write(companion)
        .then((count) => count > 0);
  }

  Future<int> deleteItemRow(int id) {
    return (delete(routineItems)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteItemsByWeekday(int routineId, Weekday day) {
    return (delete(routineItems)..where(
          (tbl) =>
              tbl.routineId.equals(routineId) &
              tbl.weekday.equals(day.isoValue),
        ))
        .go();
  }

  Future<int> deleteItemsNotInDays(int routineId, Set<Weekday> activeDays) {
    final activeIsoValues = activeDays.map((d) => d.isoValue).toList();
    return (delete(routineItems)..where(
          (tbl) =>
              tbl.routineId.equals(routineId) &
              tbl.weekday.isNotIn(activeIsoValues),
        ))
        .go();
  }

  Future<int> getNextItemPosition(int routineId, Weekday day) async {
    final query = selectOnly(routineItems)
      ..addColumns([routineItems.position.max()])
      ..where(
        routineItems.routineId.equals(routineId) &
            routineItems.weekday.equals(day.isoValue),
      );
    final maxPos = await query
        .map((row) => row.read(routineItems.position.max()))
        .getSingleOrNull();
    return (maxPos ?? -1) + 1;
  }
}
