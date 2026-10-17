import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/app.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/time/clock_provider.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/home/presentation/home_screen.dart';
import 'package:gym_claude/src/features/workout/presentation/active_workout_screen.dart';
import 'package:gym_claude/src/features/workout/presentation/workout_summary_screen.dart';
import 'package:gym_claude/src/routing/app_router.dart';

import 'workout_test_harness.dart';

void main() {
  late WorkoutTestHarness h;

  setUp(() async => h = await WorkoutTestHarness.create());
  tearDown(() => h.dispose());

  /// Arranca la app completa sobre la BD del harness, como si se abriera de cero.
  Future<void> pumpApp(WidgetTester tester, String location) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.6;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(h.db),
          clockProvider.overrideWithValue(Clock.fixed(h.now)),
          goRouterProvider.overrideWithValue(
            createAppRouter(initialLocation: location),
          ),
        ],
        child: const GymClaudeApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Desmonta la app (cancela streams de Drift y el cronómetro) antes de cerrar la BD.
  Future<void> unmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  }

  /// Deja que Drift re-emita sus streams (necesita tiempo real, no el reloj falso del test).
  Future<void> settleDb(WidgetTester tester) async {
    for (var i = 0; i < 3; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();
  }

  Future<void> startPushDay(WidgetTester tester) => tester.runAsync(() async {
    final routineId = await h.createPushRoutine();
    await h.workout.start(routineId: routineId, day: Weekday.monday);
  });

  List<SegmentState> segments(WidgetTester tester) =>
      tester.widget<ProgressSegments>(find.byType(ProgressSegments)).segments;

  testWidgets('segmentos según series y "Finalizar" solo en el último', (
    tester,
  ) async {
    await startPushDay(tester);
    await tester.runAsync(() async {
      final bench = (await h.workout.findActive())!.exercises.first;
      await h.workout.addSet(bench.id, value: 72, unit: WeightUnit.kg, reps: 8);
    });

    await pumpApp(tester, '/workout');

    // Reanuda en el primer ejercicio sin series.
    expect(find.text('Ejercicio 2 de 2'), findsOneWidget);
    expect(find.text('Fondos en paralelas'), findsOneWidget);
    expect(segments(tester), [SegmentState.done, SegmentState.current]);
    expect(find.byKey(const Key('workout-finish')), findsOneWidget);
    expect(find.byKey(const Key('workout-next')), findsNothing);

    await tester.tap(find.byTooltip('Ejercicio anterior'));
    await tester.pumpAndSettle();
    expect(find.text('Ejercicio 1 de 2'), findsOneWidget);
    expect(find.text('Objetivo 4 × 8'), findsOneWidget);
    expect(find.text('72 kg × 8 reps'), findsOneWidget);
    expect(find.byKey(const Key('workout-next')), findsOneWidget);
    expect(find.byKey(const Key('workout-finish')), findsNothing);

    await unmount(tester);
  });

  testWidgets('reps vacías muestran error; al añadir se precargan los campos', (
    tester,
  ) async {
    await startPushDay(tester);
    await pumpApp(tester, '/workout');

    expect(
      find.text('Aún no registras series. Añade la primera abajo.'),
      findsOneWidget,
    );

    await tester.enterText(find.byKey(const Key('set-input-weight')), '72,5');
    await tester.tap(find.byKey(const Key('set-input-submit')));
    await tester.pumpAndSettle();
    expect(find.text('Ingresa repeticiones válidas'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('set-input-reps')), '8');
    await tester.tap(find.byKey(const Key('set-input-submit')));
    await settleDb(tester);

    expect(find.text('Ingresa repeticiones válidas'), findsNothing);
    expect(find.text('Serie 1'), findsOneWidget);
    expect(find.text('72,5 kg × 8 reps'), findsOneWidget);
    expect(segments(tester).first, SegmentState.done);

    final weight = tester.widget<TextField>(
      find.byKey(const Key('set-input-weight')),
    );
    final reps = tester.widget<TextField>(
      find.byKey(const Key('set-input-reps')),
    );
    expect(weight.controller!.text, '72,5');
    expect(reps.controller!.text, '8');

    await unmount(tester);
  });

  testWidgets('cancelar con series pide confirmación y descarta', (
    tester,
  ) async {
    await startPushDay(tester);
    await tester.runAsync(() async {
      final bench = (await h.workout.findActive())!.exercises.first;
      await h.workout.addSet(bench.id, value: 72, unit: WeightUnit.kg, reps: 8);
    });
    await pumpApp(tester, '/workout');

    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(find.text('¿Descartar la sesión?'), findsOneWidget);
    expect(find.text('Perderás 1 serie.'), findsOneWidget);

    await tester.tap(find.text('Descartar'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(await tester.runAsync(h.workout.findActive), isNull);

    await unmount(tester);
  });

  testWidgets('al reabrir la app, Inicio ofrece reanudar con todo intacto', (
    tester,
  ) async {
    await startPushDay(tester);
    await tester.runAsync(() async {
      final bench = (await h.workout.findActive())!.exercises.first;
      await h.workout.addSet(bench.id, value: 72, unit: WeightUnit.kg, reps: 8);
    });

    await pumpApp(tester, '/home');
    expect(find.text('Día de Empuje'), findsOneWidget);

    await tester.tap(find.byKey(const Key('home-resume')));
    await tester.pumpAndSettle();

    expect(find.byType(ActiveWorkoutScreen), findsOneWidget);
    await tester.tap(find.byTooltip('Ejercicio anterior'));
    await tester.pumpAndSettle();
    expect(find.text('72 kg × 8 reps'), findsOneWidget);

    await unmount(tester);
  });

  testWidgets('finalizar abre el resumen con estadísticas', (tester) async {
    await startPushDay(tester);
    await tester.runAsync(() async {
      final bench = (await h.workout.findActive())!.exercises.first;
      await h.workout.addSet(bench.id, value: 72, unit: WeightUnit.kg, reps: 8);
    });
    await pumpApp(tester, '/workout');

    await tester.tap(find.byKey(const Key('workout-finish')));
    // La llama queda en bucle: no se puede usar pumpAndSettle.
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.byType(WorkoutSummaryScreen), findsOneWidget);
    expect(find.text('¡Sesión completada!'), findsOneWidget);
    expect(find.text('1 serie'), findsOneWidget);
    expect(find.text('0 series'), findsOneWidget);
    expect(find.text('72 kg × 8'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);

    await unmount(tester);
  });

  testWidgets('/workout sin sesión activa vuelve a Inicio', (tester) async {
    await pumpApp(tester, '/workout');
    expect(find.byType(HomeScreen), findsOneWidget);
    await unmount(tester);
  });
}
