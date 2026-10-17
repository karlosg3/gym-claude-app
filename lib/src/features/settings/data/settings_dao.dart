import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

part 'settings_dao.g.dart';

@DriftAccessor(include: {'settings.drift'})
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Stream<SettingsRow> watchSettingsRow() => watchSettings().watchSingle();

  Future<SettingsRow> getSettingsRow() => getSettings().getSingle();

  Future<int> updateSettingsRow(SettingsCompanion companion) {
    return (update(settings)..where((tbl) => tbl.id.equals(1))).write(companion);
  }

  Future<int> resetDefaults() {
    return (update(settings)..where((tbl) => tbl.id.equals(1))).write(
      const SettingsCompanion(
        userName: Value(''),
        weeklyGoal: Value(3),
        defaultUnit: Value(WeightUnit.kg),
        themeColor: Value(AppAccentColor.orange),
        workoutReminderEnabled: Value(true),
        reminderMinutes: Value(1110),
        streakRiskEnabled: Value(true),
        recordsEnabled: Value(false),
      ),
    );
  }
}
