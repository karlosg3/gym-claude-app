import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/database/transaction_runner.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/events/app_event.dart';
import 'package:gym_claude/src/core/events/app_event_bus.dart';
import 'package:gym_claude/src/features/settings/application/app_icon_service.dart';
import 'package:gym_claude/src/features/settings/data/drift_settings_repository.dart';
import 'package:gym_claude/src/features/settings/data/settings_repository.dart';
import 'package:gym_claude/src/features/settings/domain/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_service.g.dart';

/// Servicio de aplicación para consultar y modificar preferencias de usuario.
class SettingsService {
  const SettingsService({
    required this.repository,
    required this.transactionRunner,
    required this.eventBus,
    this.appIconService,
    this.onWipeCustomTables,
  });

  final SettingsRepository repository;
  final TransactionRunner transactionRunner;
  final AppEventBus eventBus;
  final AppIconService? appIconService;
  final Future<void> Function()? onWipeCustomTables;

  Stream<AppSettings> watchSettings() => repository.watchSettings();

  Future<AppSettings> getSettings() => repository.getSettings();

  Future<void> setUserName(String name) async {
    final current = await repository.getSettings();
    await repository.updateSettings(current.copyWith(userName: name.trim()));
  }

  Future<void> setWeeklyGoal(int goal) async {
    final clamped = goal.clamp(1, 7);
    final current = await repository.getSettings();
    await repository.updateSettings(current.copyWith(weeklyGoal: clamped));
  }

  Future<void> setDefaultUnit(WeightUnit unit) async {
    final current = await repository.getSettings();
    await repository.updateSettings(current.copyWith(defaultUnit: unit));
  }

  Future<void> setThemeColor(AppAccentColor color) async {
    final current = await repository.getSettings();
    await repository.updateSettings(current.copyWith(themeColor: color));
    await appIconService?.setAppIcon(color);
  }

  Future<void> setWorkoutReminder(bool enabled) async {
    final current = await repository.getSettings();
    await repository.updateSettings(
      current.copyWith(workoutReminderEnabled: enabled),
    );
  }

  Future<void> setReminderMinutes(int minutes) async {
    final clamped = minutes.clamp(0, 1439);
    final current = await repository.getSettings();
    await repository.updateSettings(current.copyWith(reminderMinutes: clamped));
  }

  Future<void> setStreakRisk(bool enabled) async {
    final current = await repository.getSettings();
    await repository.updateSettings(
      current.copyWith(streakRiskEnabled: enabled),
    );
  }

  Future<void> setRecords(bool enabled) async {
    final current = await repository.getSettings();
    await repository.updateSettings(current.copyWith(recordsEnabled: enabled));
  }

  /// Restablece todos los datos de la app a sus valores por defecto dentro de una
  /// transacción atómica y emite [AppEvent.dataWiped].
  Future<void> wipeAllData() async {
    await transactionRunner.run(() async {
      await repository.resetDefaults();
      if (onWipeCustomTables != null) {
        await onWipeCustomTables!();
      }
    });

    await appIconService?.setAppIcon(AppAccentColor.orange);
    eventBus.emit(const AppEvent.dataWiped());
  }
}

@Riverpod(keepAlive: true)
SettingsService settingsService(Ref ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  final txRunner = ref.watch(transactionRunnerProvider);
  final bus = ref.watch(appEventBusProvider);
  final appIcon = ref.watch(appIconServiceProvider);

  return SettingsService(
    repository: repo,
    transactionRunner: txRunner,
    eventBus: bus,
    appIconService: appIcon,
  );
}
