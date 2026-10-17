import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/routines/application/routines_service.dart';
import 'package:gym_claude/src/features/routines/domain/exercise_ref.dart';
import 'package:gym_claude/src/features/routines/domain/rep_scheme.dart';
import 'package:gym_claude/src/features/routines/domain/routine.dart';
import 'package:gym_claude/src/features/routines/domain/routine_item.dart';
import 'package:gym_claude/src/features/routines/presentation/routine_detail_screen.dart';
import 'package:gym_claude/src/features/routines/presentation/routine_form_screen.dart';
import 'package:gym_claude/src/features/routines/presentation/routines_list_screen.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockRoutinesService extends Mock implements RoutinesService {}

void main() {
  late MockRoutinesService mockService;

  final sampleRoutine = Routine(
    id: 1,
    name: 'Fuerza 3 Días',
    description: 'Rutina básica de fuerza',
    activeDays: const {Weekday.monday, Weekday.wednesday, Weekday.friday},
    items: const [
      RoutineItem(
        id: 10,
        routineId: 1,
        weekday: Weekday.monday,
        position: 0,
        exercise: ExerciseRef(
          id: 101,
          name: 'Press militar',
          muscleGroup: MuscleGroup.shoulders,
          unit: WeightUnit.kg,
        ),
        scheme: RepScheme(sets: 4, reps: 8),
      ),
      RoutineItem(
        id: 11,
        routineId: 1,
        weekday: Weekday.monday,
        position: 1,
        exercise: ExerciseRef(
          id: 102,
          name: 'Dominadas',
          muscleGroup: MuscleGroup.back,
          unit: WeightUnit.kg,
        ),
        scheme: RepScheme(sets: 3),
      ),
    ],
    createdAt: DateTime(2026, 6, 22),
  );

  setUp(() {
    mockService = MockRoutinesService();
  });

  group('RoutinesListScreen', () {
    testWidgets('muestra estado vacío cuando no hay rutinas', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            routinesServiceProvider.overrideWithValue(mockService),
            routinesListProvider.overrideWith((ref) => Stream.value(const [])),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: RoutinesListScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(EmptyState), findsOneWidget);
      expect(find.text('Crea tu primera rutina'), findsOneWidget);
      expect(find.text('Nueva rutina'), findsWidgets);
    });

    testWidgets('renderiza tarjeta de rutina con nombre, días y ejercicios', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            routinesServiceProvider.overrideWithValue(mockService),
            routinesListProvider.overrideWith(
              (ref) => Stream.value([sampleRoutine]),
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: RoutinesListScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Fuerza 3 Días'), findsOneWidget);
      expect(find.text('Rutina básica de fuerza'), findsOneWidget);
      expect(find.byType(DayPills), findsOneWidget);
      expect(find.textContaining('2 ejercicios · 3 días'), findsOneWidget);
    });
  });

  group('RoutineDetailScreen', () {
    testWidgets('renderiza ejercicios del día y pastillas de días activos', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            routinesServiceProvider.overrideWithValue(mockService),
            routineDetailProvider(1)
                .overrideWith((ref) => Stream.value(sampleRoutine)),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: RoutineDetailScreen(routineId: 1, initialDay: 1), // Lunes
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Fuerza 3 Días'), findsOneWidget);
      expect(find.text('Lunes'), findsOneWidget);
      expect(find.text('Press militar'), findsOneWidget);
      expect(find.text('4 × 8'), findsOneWidget);
      expect(find.text('Dominadas'), findsOneWidget);
      expect(find.text('3 × máx'), findsOneWidget);
      expect(find.text('Agregar ejercicio'), findsOneWidget);
      expect(find.text('Empezar este día'), findsOneWidget);
    });
  });

  group('RoutineFormScreen', () {
    testWidgets('valida nombre obligatorio al intentar guardar', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [routinesServiceProvider.overrideWithValue(mockService)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: RoutineFormScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nueva rutina'), findsOneWidget);
      expect(find.text('Guardar rutina'), findsOneWidget);

      // Tocar botón guardar sin rellenar nombre
      await tester.tap(find.text('Guardar rutina'));
      await tester.pumpAndSettle();

      expect(find.text('El nombre no puede estar vacío'), findsOneWidget);
    });
  });
}
