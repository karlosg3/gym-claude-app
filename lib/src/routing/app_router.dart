import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercise_detail_screen.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercise_form_screen.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercises_list_screen.dart';
import 'package:gym_claude/src/features/history/presentation/history_screen.dart';
import 'package:gym_claude/src/features/home/presentation/home_screen.dart';
import 'package:gym_claude/src/features/routines/presentation/routines_list_screen.dart';
import 'package:gym_claude/src/features/settings/presentation/settings_screen.dart';
import 'package:gym_claude/src/routing/routes.dart';
import 'package:gym_claude/src/routing/scaffold_with_nav_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Crea una instancia configurada de [GoRouter] con las 4 ramas de pestaña
/// (`StatefulShellRoute.indexedStack`) y rutas a pantalla completa en el navegador raíz.
GoRouter createAppRouter({String? initialLocation}) {
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeBranch');
  final routinesNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'routinesBranch',
  );
  final exercisesNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'exercisesBranch',
  );
  final historyNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'historyBranch',
  );

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation ?? AppRoute.home.pathSegment,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      if (state.matchedLocation == '/') {
        return AppRoute.home.pathSegment;
      }
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.home.pathSegment,
                name: AppRoute.home.routeName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: routinesNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.routines.pathSegment,
                name: AppRoute.routines.routeName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: RoutinesListScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: exercisesNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.exercises.pathSegment,
                name: AppRoute.exercises.routeName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ExercisesListScreen()),
                routes: [
                  GoRoute(
                    path: AppRoute.exerciseNew.pathSegment,
                    name: AppRoute.exerciseNew.routeName,
                    builder: (context, state) => const ExerciseFormScreen(),
                  ),
                  GoRoute(
                    path: AppRoute.exerciseDetail.pathSegment,
                    name: AppRoute.exerciseDetail.routeName,
                    builder: (context, state) {
                      final id =
                          int.tryParse(state.pathParameters['exerciseId'] ?? '') ??
                              0;
                      return ExerciseDetailScreen(exerciseId: id);
                    },
                    routes: [
                      GoRoute(
                        path: AppRoute.exerciseEdit.pathSegment,
                        name: AppRoute.exerciseEdit.routeName,
                        builder: (context, state) {
                          final id = int.tryParse(
                                state.pathParameters['exerciseId'] ?? '',
                              ) ??
                              0;
                          return ExerciseFormScreen(exerciseId: id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: historyNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.history.pathSegment,
                name: AppRoute.history.routeName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HistoryScreen()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AppRoute.settings.pathSegment,
        name: AppRoute.settings.routeName,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final router = createAppRouter();
  ref.onDispose(router.dispose);
  return router;
}
