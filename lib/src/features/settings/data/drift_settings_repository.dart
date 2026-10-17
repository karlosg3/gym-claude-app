import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/features/settings/data/settings_dao.dart';
import 'package:gym_claude/src/features/settings/data/settings_repository.dart';
import 'package:gym_claude/src/features/settings/domain/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_settings_repository.g.dart';

class DriftSettingsRepository implements SettingsRepository {
  const DriftSettingsRepository(this._dao);

  final SettingsDao _dao;

  @override
  Stream<AppSettings> watchSettings() {
    return _dao.watchSettingsRow().map(_toDomain);
  }

  @override
  Future<AppSettings> getSettings() async {
    final row = await _dao.getSettingsRow();
    return _toDomain(row);
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    await _dao.updateSettingsRow(
      SettingsCompanion(
        userName: Value(settings.userName),
        weeklyGoal: Value(settings.weeklyGoal),
        defaultUnit: Value(settings.defaultUnit),
        themeColor: Value(settings.themeColor),
        workoutReminderEnabled: Value(settings.workoutReminderEnabled),
        reminderMinutes: Value(settings.reminderMinutes),
        streakRiskEnabled: Value(settings.streakRiskEnabled),
        recordsEnabled: Value(settings.recordsEnabled),
      ),
    );
  }

  @override
  Future<void> resetDefaults() async {
    await _dao.resetDefaults();
  }

  AppSettings _toDomain(SettingsRow row) {
    return AppSettings(
      userName: row.userName,
      weeklyGoal: row.weeklyGoal,
      defaultUnit: row.defaultUnit,
      themeColor: row.themeColor,
      workoutReminderEnabled: row.workoutReminderEnabled,
      reminderMinutes: row.reminderMinutes,
      streakRiskEnabled: row.streakRiskEnabled,
      recordsEnabled: row.recordsEnabled,
    );
  }
}

@Riverpod(keepAlive: true)
SettingsDao settingsDao(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SettingsDao(db);
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  final dao = ref.watch(settingsDaoProvider);
  return DriftSettingsRepository(dao);
}
