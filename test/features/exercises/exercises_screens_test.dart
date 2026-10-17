import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/exercises/application/exercises_service.dart';
import 'package:gym_claude/src/features/exercises/domain/exercise.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercise_detail_screen.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercise_form_screen.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercises_list_screen.dart';
import 'package:gym_claude/src/features/exercises/presentation/exercises_providers.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockExercisesService extends Mock implements ExercisesService {}

void main() {
  late MockExercisesService mockService;

  final sampleExercises = [
    Exercise(
      id: 1,
      name: 'Press de banca',
      muscleGroup: MuscleGroup.chest,
      unit: WeightUnit.kg,
      createdAt: DateTime(2026, 6, 22),
    ),
    Exercise(
      id: 2,
      name: 'Sentadilla',
      muscleGroup: MuscleGroup.legs,
      unit: WeightUnit.kg,
      createdAt: DateTime(2026, 6, 22),
    ),
  ];

  setUp(() {
    mockService = MockExercisesService();
  });

  group('ExercisesListScreen', () {
    testWidgets('renderiza lista de ejercicios y contador', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      when(() => mockService.watchLibrary(any()))
          .thenAnswer((_) => Stream.value(sampleExercises));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            exercisesServiceProvider.overrideWithValue(mockService),
            exerciseLibraryProvider
                .overrideWith((ref) => Stream.value(sampleExercises)),
            exerciseCountProvider
                .overrideWith((ref) => Stream.value(sampleExercises.length)),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('es'),
            home: ExercisesListScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ejercicios'), findsOneWidget);
      expect(find.text('2 ejercicios'), findsOneWidget);
      expect(find.text('Press de banca'), findsOneWidget);
      expect(find.text('Sentadilla'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });

  group('ExerciseDetailScreen', () {
    testWidgets('muestra datos del ejercicio y cambia unidad', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final exercise = sampleExercises.first;
      when(() => mockService.watchById(1))
          .thenAnswer((_) => Stream.value(exercise));
      when(() => mockService.setUnit(1, WeightUnit.lb))
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            exercisesServiceProvider.overrideWithValue(mockService),
            exerciseDetailProvider(1)
                .overrideWith((ref) => Stream.value(exercise)),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('es'),
            home: ExerciseDetailScreen(exerciseId: 1),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Press de banca'), findsOneWidget);
      expect(find.text('Pecho'), findsOneWidget);
      expect(find.text('Unidad de peso'), findsOneWidget);

      await tester.tap(find.text('lb'));
      await tester.pumpAndSettle();

      verify(() => mockService.setUnit(1, WeightUnit.lb)).called(1);
    });
  });

  group('ExerciseFormScreen', () {
    testWidgets('muestra error si el nombre está vacío', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            exercisesServiceProvider.overrideWithValue(mockService),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('es'),
            home: ExerciseFormScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nuevo ejercicio'), findsOneWidget);

      await tester.tap(find.text('Guardar ejercicio'));
      await tester.pumpAndSettle();

      expect(find.text('El nombre no puede estar vacío'), findsOneWidget);
    });
  });
}
