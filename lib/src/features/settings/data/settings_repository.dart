import 'package:gym_claude/src/features/settings/domain/app_settings.dart';

/// Interfaz del repositorio de ajustes de la aplicación.
abstract interface class SettingsRepository {
  Stream<AppSettings> watchSettings();
  Future<AppSettings> getSettings();
  Future<void> updateSettings(AppSettings settings);
  Future<void> resetDefaults();
}
