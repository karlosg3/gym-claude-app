import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/routines/domain/exercise_ref.dart';
import 'package:gym_claude/src/features/workout/domain/session_exercise.dart';
import 'package:gym_claude/src/features/workout/domain/session_status.dart';
import 'package:gym_claude/src/features/workout/domain/set_record.dart';
import 'package:gym_claude/src/features/workout/domain/workout_session.dart';

final start = DateTime(2026, 6, 22, 18);

SessionExercise exercise(
  int id, {
  List<SetRecord> sets = const [],
  String note = '',
}) => SessionExercise(
  id: id,
  position: id,
  exercise: ExerciseRef(
    id: id,
    name: 'E$id',
    muscleGroup: MuscleGroup.chest,
    unit: WeightUnit.kg,
  ),
  isBodyweight: false,
  note: note,
  sets: sets,
);

SetRecord set(int n, {int minutes = 0}) => SetRecord(
  id: n,
  setNumber: n,
  weight: const Weight.kg(60),
  reps: 8,
  createdAt: start.add(Duration(minutes: minutes)),
);

WorkoutSession session(List<SessionExercise> exercises) => WorkoutSession(
  id: 1,
  title: 'Día de Empuje',
  date: LocalDate.of(start),
  startedAt: start,
  status: SessionStatus.active,
  exercises: exercises,
);

void main() {
  test('totales, nota unida y reanudar en el primero sin series', () {
    final s = session([
      exercise(0, sets: [set(1), set(2)], note: 'Buena técnica'),
      exercise(1),
      exercise(2, sets: [set(3)], note: 'Subir peso'),
    ]);
    expect(s.totalSets, 3);
    expect(s.exercisesDone, 2);
    expect(s.note, 'Buena técnica · Subir peso');
    expect(s.resumeIndex, 1);
    expect(
      session([
        exercise(0, sets: [set(1)]),
      ]).resumeIndex,
      0,
    );
    expect(session([]).resumeIndex, 0);
  });

  test('olvidada tras más de 6 h sin actividad desde la última serie', () {
    final s = session([
      exercise(0, sets: [set(1, minutes: 40)]),
    ]);
    expect(s.lastActivityAt, start.add(const Duration(minutes: 40)));
    expect(
      s.isStaleAt(start.add(const Duration(hours: 6, minutes: 40))),
      isFalse,
    );
    expect(
      s.isStaleAt(start.add(const Duration(hours: 6, minutes: 41))),
      isTrue,
    );
  });

  test('duración = ahora − inicio mientras está activa', () {
    expect(
      session([])
          .durationAt(start.add(const Duration(minutes: 13, seconds: 33))),
      const Duration(minutes: 13, seconds: 33),
    );
  });
}
