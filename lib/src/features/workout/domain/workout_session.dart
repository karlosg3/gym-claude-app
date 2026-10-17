import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/features/workout/domain/session_exercise.dart';
import 'package:gym_claude/src/features/workout/domain/session_status.dart';
import 'package:meta/meta.dart';

/// Sesión de entrenamiento. La activa vive en BD y sobrevive a que el SO mate la app.
@immutable
class WorkoutSession {
  const WorkoutSession({
    required this.id,
    this.routineId,
    required this.title,
    this.accentGroup,
    required this.date,
    required this.startedAt,
    this.endedAt,
    required this.status,
    this.exercises = const [],
  });

  /// Tiempo sin actividad tras el que una sesión activa se considera olvidada.
  static const staleAfter = Duration(hours: 6);

  final int id;

  /// `null` si la rutina se borró o fue una sesión libre.
  final int? routineId;

  /// Snapshot del título ("Día de Empuje").
  final String title;

  /// Snapshot del color de la rutina.
  final MuscleGroup? accentGroup;

  /// Día local de inicio.
  final LocalDate date;
  final DateTime startedAt;
  final DateTime? endedAt;
  final SessionStatus status;
  final List<SessionExercise> exercises;

  bool get isActive => status == SessionStatus.active;

  /// `endedAt - startedAt`, o `now - startedAt` si sigue activa.
  Duration durationAt(DateTime now) {
    final end = endedAt ?? now;
    final d = end.difference(startedAt);
    return d.isNegative ? Duration.zero : d;
  }

  int get totalSets => exercises.fold(0, (sum, e) => sum + e.sets.length);

  int get exercisesDone => exercises.where((e) => e.hasSets).length;

  /// Notas de ejercicio no vacías unidas con " · ".
  String get note => exercises
      .map((e) => e.note.trim())
      .where((n) => n.isNotEmpty)
      .join(' · ');

  /// Última actividad registrada: la serie más reciente o, si no hay, el inicio.
  DateTime get lastActivityAt {
    var last = startedAt;
    for (final e in exercises) {
      for (final s in e.sets) {
        if (s.createdAt.isAfter(last)) last = s.createdAt;
      }
    }
    return last;
  }

  /// Sesión activa olvidada: más de [staleAfter] sin actividad.
  bool isStaleAt(DateTime now) =>
      isActive && now.difference(lastActivityAt) > staleAfter;

  /// Índice del primer ejercicio sin series (para reanudar); el último si todos tienen.
  int get resumeIndex {
    if (exercises.isEmpty) return 0;
    final i = exercises.indexWhere((e) => !e.hasSets);
    return i == -1 ? exercises.length - 1 : i;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSession &&
          id == other.id &&
          routineId == other.routineId &&
          title == other.title &&
          accentGroup == other.accentGroup &&
          date == other.date &&
          startedAt == other.startedAt &&
          endedAt == other.endedAt &&
          status == other.status &&
          _listEquals(exercises, other.exercises);

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    title,
    accentGroup,
    date,
    startedAt,
    endedAt,
    status,
    Object.hashAll(exercises),
  );

  @override
  String toString() =>
      'WorkoutSession(id: $id, $title, $status, exercises: ${exercises.length})';
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
