import 'package:flutter/material.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/design_system/tokens/gc_colors.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_typography.dart';

/// Extensión de tema de GymClaude que agrupa colores y estilos tipográficos.
/// Accesible desde cualquier widget mediante `context.gc`.
@immutable
class GcTheme extends ThemeExtension<GcTheme> {
  const GcTheme({required this.colors, required this.text});

  factory GcTheme.dark({
    AppAccentColor accentColor = AppAccentColor.orange,
    Color? customAccent,
  }) {
    var colors = GcColors.fromAccentColor(accentColor);
    if (customAccent != null) {
      colors = colors.copyWith(accent: customAccent);
    }
    final text = GcTextStyles.fromColors(colors);
    return GcTheme(colors: colors, text: text);
  }

  final GcColors colors;
  final GcTextStyles text;

  @override
  GcTheme copyWith({GcColors? colors, GcTextStyles? text}) {
    final nextColors = colors ?? this.colors;
    return GcTheme(
      colors: nextColors,
      text: text ?? GcTextStyles.fromColors(nextColors),
    );
  }

  @override
  GcTheme lerp(covariant ThemeExtension<GcTheme>? other, double t) {
    if (other is! GcTheme) return this;
    return GcTheme(
      colors: GcColors.lerp(colors, other.colors, t),
      text: GcTextStyles.lerp(text, other.text, t),
    );
  }
}

/// Factoría del `ThemeData` oscuro de GymClaude según `10 - Design System.md`.
abstract final class AppTheme {
  static ThemeData dark({
    AppAccentColor accentColor = AppAccentColor.orange,
    Color? accent,
  }) {
    final gc = GcTheme.dark(accentColor: accentColor, customAccent: accent);
    final c = gc.colors;
    final t = gc.text;

    final colorScheme = ColorScheme.dark(
      surface: c.surface,
      onSurface: c.textPrimary,
      primary: c.accent,
      onPrimary: c.background,
      secondary: c.accent,
      onSecondary: c.background,
      error: c.error,
      onError: c.background,
      outline: c.border,
      outlineVariant: c.borderStrong,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GcTextStyles.fontFamily,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.surface,
      colorScheme: colorScheme,
      dividerColor: c.border,
      splashFactory: InkSparkle.splashFactory,
      textTheme: TextTheme(
        displaySmall: t.display,
        headlineMedium: t.title,
        headlineSmall: t.headline,
        titleLarge: t.subtitle,
        titleMedium: t.bodyStrong,
        bodyMedium: t.body,
        labelLarge: t.label,
        bodySmall: t.caption,
        labelSmall: t.overline,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: t.title,
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: GcRadii.borderXl,
          side: BorderSide(color: c.border),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: GcRadii.borderXxl,
          side: BorderSide(color: c.border),
        ),
        titleTextStyle: t.subtitle,
        contentTextStyle: t.body.copyWith(color: c.textSecondary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(GcRadii.xxl),
          ),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[gc],
    );
  }
}

/// Extensiones de acceso rápido a los tokens del Design System desde `BuildContext`.
extension GcThemeContext on BuildContext {
  GcTheme get gc => Theme.of(this).extension<GcTheme>() ?? GcTheme.dark();
  GcColors get gcColors => gc.colors;
  GcTextStyles get gcText => gc.text;
}
