import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/tokens/gc_colors.dart';

/// Tokens tipográficos basados en la fuente empaquetada `PlusJakartaSans`.
@immutable
class GcTextStyles {
  const GcTextStyles._({
    required this.display,
    required this.title,
    required this.headline,
    required this.subtitle,
    required this.bodyStrong,
    required this.body,
    required this.label,
    required this.caption,
    required this.overline,
    required this.micro,
  });

  factory GcTextStyles.fromColors(GcColors colors) {
    const base = TextStyle(fontFamily: fontFamily, height: 1.25);
    return GcTextStyles._(
      display: base.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: colors.textPrimary,
        letterSpacing: -0.3,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      title: base.copyWith(
        fontSize: 23,
        fontWeight: FontWeight.w800,
        color: colors.textPrimary,
        letterSpacing: -0.25,
      ),
      headline: base.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: colors.textPrimary,
        letterSpacing: -0.2,
      ),
      subtitle: base.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      bodyStrong: base.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      body: base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
      ),
      label: base.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      caption: base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textSecondary,
      ),
      overline: base.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: colors.textSecondary,
        letterSpacing: 0.8,
      ),
      micro: base.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: colors.textSecondary,
      ),
    );
  }

  static const String fontFamily = 'PlusJakartaSans';
  static const String monoFontFamily = 'monospace';

  /// 26 / 800 — Cronómetro, cifra principal del resumen (con cifras tabulares).
  final TextStyle display;

  /// 23 / 800 — Título de pantalla.
  final TextStyle title;

  /// 20 / 800 — Nombre en detalle, valor de stat.
  final TextStyle headline;

  /// 18 / 700 — Título de tarjeta hero.
  final TextStyle subtitle;

  /// 15 / 700 — Nombre en fila de lista.
  final TextStyle bodyStrong;

  /// 14 / 500 — Texto general, campos.
  final TextStyle body;

  /// 13 / 600 — Botones secundarios, chips.
  final TextStyle label;

  /// 12 / 500 — Metadatos.
  final TextStyle caption;

  /// 11 / 700, tracking amplio — Encabezados de sección.
  final TextStyle overline;

  /// 10 / 700 — Letras de día, etiquetas de barra inferior.
  final TextStyle micro;

  static GcTextStyles lerp(GcTextStyles a, GcTextStyles b, double t) {
    return GcTextStyles._(
      display: TextStyle.lerp(a.display, b.display, t)!,
      title: TextStyle.lerp(a.title, b.title, t)!,
      headline: TextStyle.lerp(a.headline, b.headline, t)!,
      subtitle: TextStyle.lerp(a.subtitle, b.subtitle, t)!,
      bodyStrong: TextStyle.lerp(a.bodyStrong, b.bodyStrong, t)!,
      body: TextStyle.lerp(a.body, b.body, t)!,
      label: TextStyle.lerp(a.label, b.label, t)!,
      caption: TextStyle.lerp(a.caption, b.caption, t)!,
      overline: TextStyle.lerp(a.overline, b.overline, t)!,
      micro: TextStyle.lerp(a.micro, b.micro, t)!,
    );
  }
}

/// Extensión para activar cifras tabulares en cualquier estilo tipográfico.
extension GcTabularTextStyle on TextStyle {
  TextStyle get tabular =>
      copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}
