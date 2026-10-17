import 'package:flutter/widgets.dart';

/// Tokens de radios de borde según `10 - Design System.md`.
abstract final class GcRadii {
  /// 8 dp
  static const double sm = 8.0;

  /// 12 dp — campos pequeños, botones cuadrados
  static const double md = 12.0;

  /// 14 dp — botones principales y campos de texto
  static const double lg = 14.0;

  /// 16 dp — tarjetas estándar
  static const double xl = 16.0;

  /// 18 dp — tarjetas grandes y hero
  static const double xxl = 18.0;

  /// 99 dp — chips y pastillas
  static const double pill = 99.0;
  static const double full = pill;

  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius borderXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius borderPill = BorderRadius.all(
    Radius.circular(pill),
  );
  static const BorderRadius borderFull = borderPill;
}
