import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/database/transaction_runner.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/events/app_event.dart';
import 'package:gym_claude/src/core/events/app_event_bus.dart';
import 'package:gym_claude/src/features/settings/application/app_icon_service.dart';
import 'package:gym_claude/src/features/settings/application/settings_service.dart';
import 'package:gym_claude/src/features/settings/data/drift_settings_repository.dart';
import 'package:gym_claude/src/features/settings/data/settings_dao.dart';

class FakeAppIconService implements AppIconService {
  final List<AppAccentColor> updatedColors = [];

  @override
  Future<void> setAppIcon(AppAccentColor color) async {
    updatedColors.add(color);
  }

  @override
  Future<String?> getCurrentIcon() async => null;
}

void main() {
  late AppDatabase db;
  late SettingsDao dao;
  late DriftSettingsRepository repository;
  late TransactionRunner transactionRunner;
  late AppEventBus eventBus;
  late SettingsService service;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    dao = SettingsDao(db);
    repository = DriftSettingsRepository(dao);
    transactionRunner = DriftTransactionRunner(db);
    eventBus = AppEventBus();
    service = SettingsService(
      repository: repository,
      transactionRunner: transactionRunner,
      eventBus: eventBus,
    );
  });

  tearDown(() async {
    eventBus.dispose();
    await db.close();
  });

  group('SettingsService', () {
    test('obtiene valores por defecto tras crear la base de datos', () async {
      final settings = await service.getSettings();
      expect(settings.userName, '');
      expect(settings.userInitial, '?');
      expect(settings.userFirstName, 'atleta');
      expect(settings.weeklyGoal, 3);
      expect(settings.defaultUnit, WeightUnit.kg);
      expect(settings.workoutReminderEnabled, true);
      expect(settings.reminderMinutes, 1110);
      expect(settings.reminderTimeFormatted, '18:30');
      expect(settings.streakRiskEnabled, true);
      expect(settings.recordsEnabled, false);
    });

    test('actualiza nombre y derivados de usuario', () async {
      await service.setUserName('Carlos Perez');
      final settings = await service.getSettings();
      expect(settings.userName, 'Carlos Perez');
      expect(settings.userInitial, 'C');
      expect(settings.userFirstName, 'Carlos');
    });

    test('actualiza meta semanal y la acota entre 1 y 7', () async {
      await service.setWeeklyGoal(5);
      var settings = await service.getSettings();
      expect(settings.weeklyGoal, 5);

      await service.setWeeklyGoal(10);
      settings = await service.getSettings();
      expect(settings.weeklyGoal, 7);

      await service.setWeeklyGoal(0);
      settings = await service.getSettings();
      expect(settings.weeklyGoal, 1);
    });

    test('actualiza unidad por defecto', () async {
      await service.setDefaultUnit(WeightUnit.lb);
      final settings = await service.getSettings();
      expect(settings.defaultUnit, WeightUnit.lb);
    });

    test('actualiza recordatorio y minutos acotados', () async {
      await service.setWorkoutReminder(false);
      var settings = await service.getSettings();
      expect(settings.workoutReminderEnabled, false);

      await service.setReminderMinutes(540); // 09:00
      settings = await service.getSettings();
      expect(settings.reminderMinutes, 540);
      expect(settings.reminderTimeFormatted, '09:00');
    });

    test('actualiza racha y récords personales', () async {
      await service.setStreakRisk(false);
      await service.setRecords(true);

      final settings = await service.getSettings();
      expect(settings.streakRiskEnabled, false);
      expect(settings.recordsEnabled, true);
    });

    test('wipeAllData restablece ajustes y emite AppEvent.dataWiped', () async {
      await service.setUserName('Karlos');
      await service.setWeeklyGoal(6);

      final events = <AppEvent>[];
      final sub = eventBus.stream.listen(events.add);

      await service.wipeAllData();
      await Future<void>.delayed(Duration.zero);

      final settings = await service.getSettings();
      expect(settings.userName, '');
      expect(settings.weeklyGoal, 3);
      expect(events, [const AppEvent.dataWiped()]);

      await sub.cancel();
    });

    test('actualiza color de tema y sincroniza el icono de la app', () async {
      final fakeIconService = FakeAppIconService();
      final localService = SettingsService(
        repository: repository,
        transactionRunner: transactionRunner,
        eventBus: eventBus,
        appIconService: fakeIconService,
      );

      await localService.setThemeColor(AppAccentColor.blue);
      final settings = await localService.getSettings();
      expect(settings.themeColor, AppAccentColor.blue);
      expect(fakeIconService.updatedColors, [AppAccentColor.blue]);
    });
  });
}
