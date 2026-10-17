import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/settings/application/settings_service.dart';
import 'package:gym_claude/src/features/settings/domain/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
Stream<AppSettings> settings(Ref ref) {
  final service = ref.watch(settingsServiceProvider);
  return service.watchSettings();
}

@Riverpod(keepAlive: true)
AppAccentColor themeColor(Ref ref) {
  final settingsAsync = ref.watch(settingsProvider);
  return settingsAsync.value?.themeColor ?? AppAccentColor.orange;
}

@Riverpod(keepAlive: true)
String userFirstName(Ref ref) {
  final settingsAsync = ref.watch(settingsProvider);
  return settingsAsync.value?.userFirstName ?? 'atleta';
}

@Riverpod(keepAlive: true)
String userInitial(Ref ref) {
  final settingsAsync = ref.watch(settingsProvider);
  return settingsAsync.value?.userInitial ?? '?';
}

@Riverpod(keepAlive: true)
WeightUnit defaultUnit(Ref ref) {
  final settingsAsync = ref.watch(settingsProvider);
  return settingsAsync.value?.defaultUnit ?? WeightUnit.kg;
}

@Riverpod(keepAlive: true)
int weeklyGoal(Ref ref) {
  final settingsAsync = ref.watch(settingsProvider);
  return settingsAsync.value?.weeklyGoal ?? 3;
}

@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<void> build() {}

  Future<void> updateUserName(String name) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setUserName(name),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> updateWeeklyGoal(int goal) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setWeeklyGoal(goal),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> updateDefaultUnit(WeightUnit unit) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setDefaultUnit(unit),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> updateThemeColor(AppAccentColor color) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setThemeColor(color),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> toggleWorkoutReminder(bool enabled) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setWorkoutReminder(enabled),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> updateReminderMinutes(int minutes) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setReminderMinutes(minutes),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> toggleStreakRisk(bool enabled) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setStreakRisk(enabled),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> toggleRecords(bool enabled) async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).setRecords(enabled),
    );
    if (!ref.mounted) return;
    state = res;
  }

  Future<void> wipeAllData() async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(
      () => ref.read(settingsServiceProvider).wipeAllData(),
    );
    if (!ref.mounted) return;
    state = res;
  }
}
