import 'package:meta/meta.dart';

/// Esquema de series y repeticiones objetivo para un ejercicio en una rutina.
@immutable
class RepScheme {
  const RepScheme({
    required this.sets,
    this.reps,
  })  : assert(sets >= 1 && sets <= 10, 'Sets must be between 1 and 10'),
        assert(reps == null || (reps >= 1 && reps <= 50),
            'Reps must be between 1 and 50 or null');

  /// Cantidad de series objetivo (1..10).
  final int sets;

  /// Repeticiones objetivo (1..50) o `null` para repeticiones al fallo / máximas.
  final int? reps;

  /// `true` si el esquema es al fallo ("máx").
  bool get isMax => reps == null;

  /// Representación en texto: "4 × 8" o "3 × máx".
  String get label => reps == null ? '$sets × máx' : '$sets × $reps';

  RepScheme copyWith({
    int? sets,
    int? Function()? reps,
  }) {
    return RepScheme(
      sets: sets ?? this.sets,
      reps: reps != null ? reps() : this.reps,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepScheme &&
          runtimeType == other.runtimeType &&
          sets == other.sets &&
          reps == other.reps;

  @override
  int get hashCode => Object.hash(sets, reps);

  @override
  String toString() => 'RepScheme($label)';
}
