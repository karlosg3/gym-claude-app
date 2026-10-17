import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Nombres y segmentos de ruta tipados de GymClaude.
///
/// Ningún código fuera de `lib/src/routing/` debe usar cadenas de ruta en crudo.
enum AppRoute {
  home('home', '/home'),
  routines('routines', '/routines'),
  routineNew('routineNew', 'new'),
  routineDetail('routineDetail', ':routineId'),
  routineEdit('routineEdit', 'edit'),
  routineDayAddExercise('routineDayAddExercise', 'days/:weekday/add'),
  exercises('exercises', '/exercises'),
  exerciseNew('exerciseNew', 'new'),
  exerciseDetail('exerciseDetail', ':exerciseId'),
  exerciseEdit('exerciseEdit', 'edit'),
  history('history', '/history'),
  sessionDetail('sessionDetail', 'sessions/:sessionId'),
  sessionEdit('sessionEdit', 'edit'),
  workout('workout', '/workout'),
  workoutSummary('workoutSummary', '/workout/summary/:sessionId'),
  settings('settings', '/settings'),
  exportData('exportData', '/export');

  const AppRoute(this.routeName, this.pathSegment);

  final String routeName;
  final String pathSegment;
}

/// Helpers tipados de navegación sobre [BuildContext].
extension AppNavigationContext on BuildContext {
  void goHome() => goNamed(AppRoute.home.routeName);

  void goRoutines() => goNamed(AppRoute.routines.routeName);

  Future<T?> pushRoutineNew<T extends Object?>() =>
      pushNamed<T>(AppRoute.routineNew.routeName);

  void goRoutine(int routineId, {int? day}) => goNamed(
    AppRoute.routineDetail.routeName,
    pathParameters: {'routineId': '$routineId'},
    queryParameters: {if (day != null) 'day': '$day'},
  );

  Future<T?> pushRoutineEdit<T extends Object?>(int routineId) => pushNamed<T>(
    AppRoute.routineEdit.routeName,
    pathParameters: {'routineId': '$routineId'},
  );

  Future<T?> pushRoutineDayAddExercise<T extends Object?>({
    required int routineId,
    required int weekday,
  }) => pushNamed<T>(
    AppRoute.routineDayAddExercise.routeName,
    pathParameters: {'routineId': '$routineId', 'weekday': '$weekday'},
  );

  void goExercises() => goNamed(AppRoute.exercises.routeName);

  Future<T?> pushExerciseNew<T extends Object?>() =>
      pushNamed<T>(AppRoute.exerciseNew.routeName);

  void goExercise(int exerciseId) => goNamed(
    AppRoute.exerciseDetail.routeName,
    pathParameters: {'exerciseId': '$exerciseId'},
  );

  Future<T?> pushExerciseEdit<T extends Object?>(int exerciseId) =>
      pushNamed<T>(
        AppRoute.exerciseEdit.routeName,
        pathParameters: {'exerciseId': '$exerciseId'},
      );

  void goHistory({String? month}) => goNamed(
    AppRoute.history.routeName,
    queryParameters: {'month': ?month},
  );

  void goSession(int sessionId) => goNamed(
    AppRoute.sessionDetail.routeName,
    pathParameters: {'sessionId': '$sessionId'},
  );

  Future<T?> pushSessionEdit<T extends Object?>(int sessionId) => pushNamed<T>(
    AppRoute.sessionEdit.routeName,
    pathParameters: {'sessionId': '$sessionId'},
  );

  void goWorkout() => goNamed(AppRoute.workout.routeName);

  void goWorkoutSummary(int sessionId) => goNamed(
    AppRoute.workoutSummary.routeName,
    pathParameters: {'sessionId': '$sessionId'},
  );

  Future<T?> pushSettings<T extends Object?>() =>
      pushNamed<T>(AppRoute.settings.routeName);

  Future<T?> pushExport<T extends Object?>({String? scope, List<int>? ids}) =>
      pushNamed<T>(
        AppRoute.exportData.routeName,
        queryParameters: {
          'scope': ?scope,
          if (ids != null && ids.isNotEmpty) 'ids': ids.join(','),
        },
      );
}
