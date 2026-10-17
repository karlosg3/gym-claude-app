import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

part 'app_settings.freezed.dart';

/// Entidad pura de ajustes y preferencias del usuario.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('') String userName,
    @Default(3) int weeklyGoal,
    @Default(WeightUnit.kg) WeightUnit defaultUnit,
    @Default(AppAccentColor.orange) AppAccentColor themeColor,
    @Default(true) bool workoutReminderEnabled,
    @Default(1110) int reminderMinutes,
    @Default(true) bool streakRiskEnabled,
    @Default(false) bool recordsEnabled,
  }) = _AppSettings;

  const AppSettings._();

  /// Inicial para el avatar (o '?' si el nombre está vacío).
  String get userInitial {
    final trimmed = userName.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }

  /// Primer nombre del usuario (o 'atleta' si está vacío).
  String get userFirstName {
    final trimmed = userName.trim();
    if (trimmed.isEmpty) return 'atleta';
    return trimmed.split(RegExp(r'\s+')).first;
  }

  /// Hora del recordatorio en formato 'HH:mm'.
  String get reminderTimeFormatted {
    final h = (reminderMinutes ~/ 60).toString().padLeft(2, '0');
    final m = (reminderMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }
}
