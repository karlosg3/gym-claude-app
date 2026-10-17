/// Tokens de espaciado basados en rejilla de 4 dp según `10 - Design System.md`.
abstract final class GcSpacing {
  /// 4 dp
  static const double xs = 4.0;

  /// 8 dp
  static const double sm = 8.0;

  /// 12 dp
  static const double md = 12.0;

  /// 16 dp
  static const double lg = 16.0;

  /// 20 dp
  static const double xl = 20.0;

  /// 26 dp
  static const double xxl = 26.0;

  /// Margen horizontal estándar de pantalla (20 dp).
  static const double screenHorizontal = 20.0;

  /// Ancho máximo de contenido centrado en pantallas anchas (480 dp).
  static const double maxContentWidth = 480.0;

  /// Objetivo táctil mínimo de accesibilidad (48 dp).
  static const double minTouchTarget = 48.0;
}
