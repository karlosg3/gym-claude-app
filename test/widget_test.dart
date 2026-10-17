import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/app.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercises_list_screen.dart';
import 'package:gym_claude/src/features/history/presentation/history_screen.dart';
import 'package:gym_claude/src/features/home/presentation/home_screen.dart';
import 'package:gym_claude/src/features/routines/presentation/routines_list_screen.dart';
import 'package:gym_claude/src/features/settings/presentation/settings_screen.dart';
import 'package:gym_claude/src/routing/app_router.dart';
import 'package:gym_claude/src/routing/scaffold_with_nav_bar.dart';

void main() {
  testWidgets(
    'Shell de 4 pestañas cambia de rama y ruta raíz /settings oculta la barra inferior',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: const GymClaudeApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Arranca en /home con barra inferior visible
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(ScaffoldWithNavBar), findsOneWidget);

      // Cambiar a Rutinas
      await tester.tap(find.text('Rutinas'));
      await tester.pumpAndSettle();
      expect(find.byType(RoutinesListScreen), findsOneWidget);

      // Cambiar a Ejercicios
      await tester.tap(find.text('Ejercicios'));
      await tester.pumpAndSettle();
      expect(find.byType(ExercisesListScreen), findsOneWidget);

      // Cambiar a Historial
      await tester.tap(find.text('Historial'));
      await tester.pumpAndSettle();
      expect(find.byType(HistoryScreen), findsOneWidget);

      // Volver a Inicio
      await tester.tap(find.text('Inicio'));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      // Abrir Ajustes (/settings en rootNavigatorKey) -> oculta ScaffoldWithNavBar
      await tester.tap(find.byIcon(GcIcons.settings));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(find.byType(ScaffoldWithNavBar), findsNothing);

      // Volver atrás restaura Inicio y la barra inferior
      await tester.tap(find.byIcon(GcIcons.back));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(ScaffoldWithNavBar), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 50));
    },
  );

  testWidgets('Redirección de / a /home funciona', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final router = createAppRouter(initialLocation: '/');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          goRouterProvider.overrideWithValue(router),
        ],
        child: const GymClaudeApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 50));
  });
}
