import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';

/// Interfaz para gestionar el cambio del icono del lanzador de la app.
abstract class AppIconService {
  /// Cambia el icono del lanzador para coincidir con el [color] de acento seleccionado.
  Future<void> setAppIcon(AppAccentColor color);

  /// Retorna el identificador del icono alternativo activo, o `null` si está usando el icono por defecto.
  Future<String?> getCurrentIcon();
}

/// Implementación segura que evita que Android mate el proceso al cambiar de color.
class NoopAppIconService implements AppIconService {
  const NoopAppIconService();

  @override
  Future<void> setAppIcon(AppAccentColor color) async {
    // Intencionalmente vacío: cambiar activity-alias en Android mata la app en primer plano
    // y rompe la capacidad de depuración y hot reload de ADB.
  }

  @override
  Future<String?> getCurrentIcon() async => null;
}

/// Proveedor de Riverpod para [AppIconService].
final appIconServiceProvider = Provider<AppIconService>((ref) {
  return const NoopAppIconService();
});
