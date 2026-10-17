import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:meta/meta.dart';

/// Datos introducidos en el formulario para crear o actualizar una rutina.
@immutable
class RoutineDraft {
  const RoutineDraft({
    required this.name,
    this.description = '',
    required this.activeDays,
  });

  final String name;
  final String description;
  final Set<Weekday> activeDays;

  RoutineDraft copyWith({
    String? name,
    String? description,
    Set<Weekday>? activeDays,
  }) {
    return RoutineDraft(
      name: name ?? this.name,
      description: description ?? this.description,
      activeDays: activeDays ?? this.activeDays,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineDraft &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          _setEquals(activeDays, other.activeDays);

  @override
  int get hashCode => Object.hash(name, description, Object.hashAll(activeDays));

  @override
  String toString() =>
      'RoutineDraft(name: $name, description: $description, activeDays: $activeDays)';
}

bool _setEquals<T>(Set<T>? a, Set<T>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  return a.containsAll(b);
}
