import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/features/routines/domain/routine_item.dart';
import 'package:meta/meta.dart';

/// Rutina de entrenamiento con días activos asignados y lista de ejercicios asociados.
@immutable
class Routine {
  const Routine({
    required this.id,
    required this.name,
    this.description = '',
    required this.activeDays,
    this.items = const [],
    this.sortOrder = 0,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String description;
  final Set<Weekday> activeDays;
  final List<RoutineItem> items;
  final int sortOrder;
  final DateTime createdAt;

  /// Retorna los items ordenados por posición para un día determinado.
  List<RoutineItem> itemsFor(Weekday day) {
    final list = items.where((it) => it.weekday == day).toList()
      ..sort((a, b) => a.position.compareTo(b.position));
    return List.unmodifiable(list);
  }

  /// Total de asignaciones de ejercicios en toda la rutina.
  int get totalExercisesCount => items.length;

  /// Cantidad de días activos configurados.
  int get activeDaysCount => activeDays.length;

  /// Grupo muscular más frecuente entre sus ejercicios (desempate: primer orden de aparición).
  MuscleGroup? get accentGroup {
    if (items.isEmpty) return null;
    final counts = <MuscleGroup, int>{};
    final firstSeen = <MuscleGroup, int>{};

    for (var i = 0; i < items.length; i++) {
      final group = items[i].exercise.muscleGroup;
      counts[group] = (counts[group] ?? 0) + 1;
      firstSeen.putIfAbsent(group, () => i);
    }

    MuscleGroup? bestGroup;
    var maxCount = -1;
    var bestOrder = 999999;

    for (final entry in counts.entries) {
      final group = entry.key;
      final count = entry.value;
      final order = firstSeen[group]!;
      if (count > maxCount || (count == maxCount && order < bestOrder)) {
        bestGroup = group;
        maxCount = count;
        bestOrder = order;
      }
    }

    return bestGroup;
  }

  Routine copyWith({
    int? id,
    String? name,
    String? description,
    Set<Weekday>? activeDays,
    List<RoutineItem>? items,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      activeDays: activeDays ?? this.activeDays,
      items: items ?? this.items,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Routine &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          _setEquals(activeDays, other.activeDays) &&
          _listEquals(items, other.items) &&
          sortOrder == other.sortOrder &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(
        id,
        name,
        description,
        Object.hashAll(activeDays),
        Object.hashAll(items),
        sortOrder,
        createdAt,
      );

  @override
  String toString() =>
      'Routine(id: $id, name: $name, activeDays: $activeDays, items: ${items.length})';
}

bool _setEquals<T>(Set<T>? a, Set<T>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  return a.containsAll(b);
}

bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
