import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Catálogo semántico único de iconos de la aplicación (`lucide_icons_flutter`).
/// Ningún feature importa directamente `lucide_icons_flutter`.
abstract final class GcIcons {
  // Navegación principal (4 pestañas)
  static const IconData home = LucideIcons.house;
  static const IconData routines = LucideIcons.rows2;
  static const IconData exercises = LucideIcons.dumbbell;
  static const IconData history = LucideIcons.calendar;

  // Acciones comunes y cabeceras
  static const IconData settings = LucideIcons.settings;
  static const IconData export = LucideIcons.share;
  static const IconData download = LucideIcons.download;
  static const IconData add = LucideIcons.plus;
  static const IconData remove = LucideIcons.minus;
  static const IconData back = LucideIcons.arrowLeft;
  static const IconData close = LucideIcons.x;
  static const IconData edit = LucideIcons.pencil;
  static const IconData delete = LucideIcons.trash2;
  static const IconData search = LucideIcons.search;
  static const IconData check = LucideIcons.check;
  static const IconData play = LucideIcons.play;
  static const IconData chevronRight = LucideIcons.chevronRight;
  static const IconData chevronLeft = LucideIcons.chevronLeft;
  static const IconData dragHandle = LucideIcons.gripVertical;

  // Dominio de entrenamiento y estado
  static const IconData clock = LucideIcons.clock;
  static const IconData list = LucideIcons.list;
  static const IconData flame = LucideIcons.flame;
  static const IconData award = LucideIcons.trophy;
  static const IconData alert = LucideIcons.circleAlert;
  static const IconData refresh = LucideIcons.refreshCw;
  static const IconData bell = LucideIcons.bell;

  // Tamaños estándar de iconos
  static const double sizeSm = 16.0;
  static const double sizeMd = 20.0;
  static const double sizeLg = 28.0;
}
