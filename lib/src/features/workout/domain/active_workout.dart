import 'package:gym_claude/src/features/progress/domain/set_performance.dart';
import 'package:gym_claude/src/features/workout/domain/workout_session.dart';
import 'package:meta/meta.dart';

/// Read model de la pantalla de sesión: la sesión activa + "peso anterior" por ejercicio.
@immutable
class ActiveWorkout {
  const ActiveWorkout({required this.session, this.previousBest = const {}});

  final WorkoutSession session;

  /// Mejor serie de la sesión completada más reciente, por id de ejercicio.
  final Map<int, SetPerformance> previousBest;

  SetPerformance? previousFor(int exerciseId) => previousBest[exerciseId];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveWorkout &&
          session == other.session &&
          _mapEquals(previousBest, other.previousBest);

  @override
  int get hashCode => Object.hash(
    session,
    Object.hashAllUnordered(
      previousBest.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  );
}

bool _mapEquals<K, V>(Map<K, V> a, Map<K, V> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final entry in a.entries) {
    if (!b.containsKey(entry.key) || b[entry.key] != entry.value) return false;
  }
  return true;
}
