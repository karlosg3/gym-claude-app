import 'package:flutter/foundation.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';

/// Interfaz para gestionar el cambio dinámico del icono del lanzador de la app.
abstract class AppIconService {
  /// Cambia el icono del lanzador para coincidir con el [color] de acento seleccionado.
  Future<void> setAppIcon(AppAccentColor color);

  /// Retorna el identificador del icono alternativo activo, o `null` si está usando el icono por defecto.
  Future<String?> getCurrentIcon();
}

/// Implementación de [AppIconService] basada en [FlutterDynamicIconPlus].
class DynamicAppIconService implements AppIconService {
  const DynamicAppIconService();

  /// Lista de marcas reconocidas para forzar el cambio inmediato del alias
  /// del lanzador en Android sin esperar a `onTaskRemoved` (que en MagicOS/EMUI
  /// u otros fabricantes no se dispara al cerrar apps).
  static const List<String> _immediateUpdateBrands = [
    'HONOR',
    'HUAWEI',
    'Xiaomi',
    'Redmi',
    'POCO',
    'samsung',
    'Google',
    'OnePlus',
    'OPPO',
    'vivo',
    'realme',
    'motorola',
    'Sony',
    'LG',
    'ASUS',
    'Nokia',
    'Nothing',
    'Transsion',
    'TECNO',
    'Infinix',
    'itel',
    'Lenovo',
    'ZTE',
    'Meizu',
    'TCL',
  ];

  static const List<String> _immediateUpdateManufactures = [
    'HONOR',
    'HUAWEI',
    'Xiaomi',
    'Redmi',
    'POCO',
    'samsung',
    'Google',
    'OnePlus',
    'OPPO',
    'vivo',
    'realme',
    'motorola',
    'Sony',
    'LG',
    'ASUS',
    'Nokia',
    'Nothing',
    'Transsion',
    'TECNO',
    'Infinix',
    'itel',
    'Lenovo',
    'ZTE',
    'Meizu',
    'TCL',
  ];

  @override
  Future<void> setAppIcon(AppAccentColor color) async {
    try {
      final isSupported = await FlutterDynamicIconPlus.supportsAlternateIcons;
      if (!isSupported) {
        debugPrint('[AppIconService] Alternate icons no están soportados en esta plataforma o dispositivo.');
        return;
      }

      // En iOS: pasar `null` restablece al icono primario (naranja).
      // En Android: pasar `null` habilita el alias `.DEFAULT` (naranja).
      final iconName = color == AppAccentColor.orange ? null : color.name;
      await FlutterDynamicIconPlus.setAlternateIconName(
        iconName: iconName,
        blacklistBrands: _immediateUpdateBrands,
        blacklistManufactures: _immediateUpdateManufactures,
      );
      debugPrint('[AppIconService] Icono cambiado exitosamente a: ${color.name} (alias: $iconName)');
    } catch (e, st) {
      debugPrint('[AppIconService] Error al cambiar el icono dinámico: $e\n$st');
    }
  }

  @override
  Future<String?> getCurrentIcon() async {
    try {
      final isSupported = await FlutterDynamicIconPlus.supportsAlternateIcons;
      if (isSupported) {
        return await FlutterDynamicIconPlus.alternateIconName;
      }
    } catch (e) {
      debugPrint('[AppIconService] Error al consultar icono alternativo: $e');
    }
    return null;
  }
}

/// Proveedor de Riverpod para [AppIconService].
final appIconServiceProvider = Provider<AppIconService>((ref) {
  return const DynamicAppIconService();
});
