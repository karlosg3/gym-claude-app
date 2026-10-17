import 'package:flutter/material.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';

/// Paleta de colores cálidos oscuros del Design System de GymClaude.
@immutable
class GcColors {
  const GcColors({
    this.background = const Color(0xFF161310),
    this.surfaceSunken = const Color(0xFF1B1814),
    this.surface = const Color(0xFF211E19),
    this.surfaceRaised = const Color(0xFF2A2620),
    this.border = const Color(0xFF2E2A24),
    this.borderStrong = const Color(0xFF3A352E),
    this.textPrimary = const Color(0xFFF4F0E9),
    this.textSecondary = const Color(0xFF9A9389),
    this.textMuted = const Color(0xFF857F75),
    this.textFaint = const Color(0xFF6B655C),
    this.textDisabled = const Color(0xFF4F4942),
    this.accent = const Color(0xFFD97757),
    this.accentDark = const Color(0xFFC2613F),
    this.accentSoft = const Color(0xFF3A241B),
    this.accentShadow = const Color(0x4DD97757),
    this.success = const Color(0xFF6FB089),
    this.successSoft = const Color(0xFF1E2C24),
    this.error = const Color(0xFFE08B6B),
    this.danger = const Color(0xFFD98A82),
    this.flameInner = const Color(0xFFF6C27A),
  });

  /// Crea una instancia de [GcColors] configurando la escala completa de acento
  /// según el [AppAccentColor] elegido.
  factory GcColors.fromAccentColor(AppAccentColor accentColor) {
    final scale = AppAccentColors.of(accentColor);
    return GcColors(
      accent: scale.accent,
      accentDark: scale.accentDark,
      accentSoft: scale.accentSoft,
      accentShadow: scale.accentShadow,
    );
  }

  /// Fondo de pantalla y texto sobre acento (`#161310`).
  final Color background;

  /// Campos de entrada, chips inactivos y barra inferior (`#1B1814`).
  final Color surfaceSunken;

  /// Superficie principal de tarjetas (`#211E19`).
  final Color surface;

  /// Segmentos vacíos y divisores dentro de tarjeta (`#2A2620`).
  final Color surfaceRaised;

  /// Borde de tarjetas y chips (`#2E2A24`).
  final Color border;

  /// Pista de interruptor apagado y pestaña de día activa (`#3A352E`).
  final Color borderStrong;

  /// Títulos y valores principales (`#F4F0E9`).
  final Color textPrimary;

  /// Texto de apoyo con contraste AA ≥ 5.5:1 (`#9A9389`).
  final Color textSecondary;

  /// Etiquetas secundarias y metadatos (`#857F75`).
  final Color textMuted;

  /// Iconos inactivos y días de descanso (`#6B655C`).
  final Color textFaint;

  /// Elementos deshabilitados y llama apagada (`#4F4942`).
  final Color textDisabled;

  /// Acción principal, selección y día actual (`#D97757`).
  final Color accent;

  /// Extremo oscuro de degradado hero y estado pulsado (`#C2613F`).
  final Color accentDark;

  /// Fondo de selección suave (`#3A241B`).
  final Color accentSoft;

  /// Sombra del botón principal y hero (`rgba(217, 119, 87, 0.30)`).
  final Color accentShadow;

  /// Día entrenado en tira semanal (`#6FB089`).
  final Color success;

  /// Fondo suave de éxito (`#1E2C24`).
  final Color successSoft;

  /// Error de validación bajo campos de formulario (`#E08B6B`).
  final Color error;

  /// Acciones destructivas (`#D98A82`).
  final Color danger;

  /// Núcleo interior de la llama de racha (`#F6C27A`).
  final Color flameInner;

  GcColors copyWith({
    Color? background,
    Color? surfaceSunken,
    Color? surface,
    Color? surfaceRaised,
    Color? border,
    Color? borderStrong,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textFaint,
    Color? textDisabled,
    Color? accent,
    Color? accentDark,
    Color? accentSoft,
    Color? accentShadow,
    Color? success,
    Color? successSoft,
    Color? error,
    Color? danger,
    Color? flameInner,
  }) {
    return GcColors(
      background: background ?? this.background,
      surfaceSunken: surfaceSunken ?? this.surfaceSunken,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textFaint: textFaint ?? this.textFaint,
      textDisabled: textDisabled ?? this.textDisabled,
      accent: accent ?? this.accent,
      accentDark: accentDark ?? this.accentDark,
      accentSoft: accentSoft ?? this.accentSoft,
      accentShadow: accentShadow ?? this.accentShadow,
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
      error: error ?? this.error,
      danger: danger ?? this.danger,
      flameInner: flameInner ?? this.flameInner,
    );
  }

  static GcColors lerp(GcColors a, GcColors b, double t) {
    return GcColors(
      background: Color.lerp(a.background, b.background, t)!,
      surfaceSunken: Color.lerp(a.surfaceSunken, b.surfaceSunken, t)!,
      surface: Color.lerp(a.surface, b.surface, t)!,
      surfaceRaised: Color.lerp(a.surfaceRaised, b.surfaceRaised, t)!,
      border: Color.lerp(a.border, b.border, t)!,
      borderStrong: Color.lerp(a.borderStrong, b.borderStrong, t)!,
      textPrimary: Color.lerp(a.textPrimary, b.textPrimary, t)!,
      textSecondary: Color.lerp(a.textSecondary, b.textSecondary, t)!,
      textMuted: Color.lerp(a.textMuted, b.textMuted, t)!,
      textFaint: Color.lerp(a.textFaint, b.textFaint, t)!,
      textDisabled: Color.lerp(a.textDisabled, b.textDisabled, t)!,
      accent: Color.lerp(a.accent, b.accent, t)!,
      accentDark: Color.lerp(a.accentDark, b.accentDark, t)!,
      accentSoft: Color.lerp(a.accentSoft, b.accentSoft, t)!,
      accentShadow: Color.lerp(a.accentShadow, b.accentShadow, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      successSoft: Color.lerp(a.successSoft, b.successSoft, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      danger: Color.lerp(a.danger, b.danger, t)!,
      flameInner: Color.lerp(a.flameInner, b.flameInner, t)!,
    );
  }
}

/// Par de colores (principal y fondo suave) para un grupo muscular.
typedef MuscleColorPair = ({Color color, Color soft});

/// Colores semánticos por grupo muscular según `10 - Design System.md`.
abstract final class MuscleGroupColors {
  static const MuscleColorPair chest = (
    color: Color(0xFFE08B6B),
    soft: Color(0xFF3A2419),
  );
  static const MuscleColorPair back = (
    color: Color(0xFF6FA6B8),
    soft: Color(0xFF1A2A30),
  );
  static const MuscleColorPair legs = (
    color: Color(0xFFA294C9),
    soft: Color(0xFF241F33),
  );
  static const MuscleColorPair shoulders = (
    color: Color(0xFFD9B36A),
    soft: Color(0xFF332915),
  );
  static const MuscleColorPair arms = (
    color: Color(0xFF74B894),
    soft: Color(0xFF16301F),
  );
  static const MuscleColorPair core = (
    color: Color(0xFFCE8298),
    soft: Color(0xFF331F26),
  );

  /// Obtiene el par `(color, soft)` asociado al [group].
  static MuscleColorPair of(MuscleGroup group) {
    return switch (group) {
      MuscleGroup.chest => chest,
      MuscleGroup.back => back,
      MuscleGroup.legs => legs,
      MuscleGroup.shoulders => shoulders,
      MuscleGroup.arms => arms,
      MuscleGroup.core => core,
    };
  }
}

/// Escala completa de color de resalte.
typedef AccentScale = ({
  Color accent,
  Color accentDark,
  Color accentSoft,
  Color accentShadow,
});

/// Definición de paletas de acento según [AppAccentColor].
abstract final class AppAccentColors {
  /// Terracota cálido (por defecto).
  static const AccentScale orange = (
    accent: Color(0xFFD97757),
    accentDark: Color(0xFFC2613F),
    accentSoft: Color(0xFF3A241B),
    accentShadow: Color(0x4DD97757),
  );

  /// Azul océano cálido con contraste óptimo en fondo oscuro.
  static const AccentScale blue = (
    accent: Color(0xFF5A9BE6),
    accentDark: Color(0xFF3F7EC4),
    accentSoft: Color(0xFF1A283B),
    accentShadow: Color(0x4D5A9BE6),
  );

  /// Verde esmeralda fresco.
  static const AccentScale green = (
    accent: Color(0xFF5EBA81),
    accentDark: Color(0xFF439E66),
    accentSoft: Color(0xFF1A3325),
    accentShadow: Color(0x4D5EBA81),
  );

  /// Morado amatista vibrante.
  static const AccentScale purple = (
    accent: Color(0xFFA57BED),
    accentDark: Color(0xFF8B5FD3),
    accentSoft: Color(0xFF2C1E40),
    accentShadow: Color(0x4DA57BED),
  );

  /// Rojo carmesí intenso.
  static const AccentScale red = (
    accent: Color(0xFFE25C5C),
    accentDark: Color(0xFFC44141),
    accentSoft: Color(0xFF3B1C1C),
    accentShadow: Color(0x4DE25C5C),
  );

  /// Retorna la escala [AccentScale] para el [color] dado.
  static AccentScale of(AppAccentColor color) {
    return switch (color) {
      AppAccentColor.orange => orange,
      AppAccentColor.blue => blue,
      AppAccentColor.green => green,
      AppAccentColor.purple => purple,
      AppAccentColor.red => red,
    };
  }
}
