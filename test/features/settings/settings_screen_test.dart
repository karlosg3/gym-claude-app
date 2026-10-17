import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/features/settings/application/settings_service.dart';
import 'package:gym_claude/src/features/settings/domain/app_settings.dart';
import 'package:gym_claude/src/features/settings/presentation/settings_providers.dart';
import 'package:gym_claude/src/features/settings/presentation/settings_screen.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsService extends Mock implements SettingsService {}

void main() {
  late MockSettingsService mockService;

  setUp(() {
    mockService = MockSettingsService();
  });

  Widget buildTestableWidget(AppSettings currentSettings) {
    when(() => mockService.watchSettings())
        .thenAnswer((_) => Stream.value(currentSettings));
    when(() => mockService.getSettings())
        .thenAnswer((_) async => currentSettings);

    return ProviderScope(
      overrides: [
        settingsServiceProvider.overrideWithValue(mockService),
        settingsProvider.overrideWith((ref) => Stream.value(currentSettings)),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('es'),
        home: SettingsScreen(),
      ),
    );
  }

  group('SettingsScreen', () {
    testWidgets('muestra datos del perfil y meta semanal', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const initial = AppSettings(
        userName: 'Karlos',
        weeklyGoal: 4,
        defaultUnit: WeightUnit.kg,
      );

      await tester.pumpWidget(buildTestableWidget(initial));
      await tester.pumpAndSettle();

      expect(find.text('Ajustes'), findsOneWidget);
      expect(find.text('K'), findsOneWidget);
      expect(find.text('Karlos'), findsOneWidget);
      expect(find.text('Meta semanal'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('Unidad por defecto'), findsOneWidget);
      expect(find.text('Recordatorio de entreno'), findsOneWidget);
      expect(find.text('18:30'), findsOneWidget);
      expect(find.text('Borrar todos los datos'), findsOneWidget);
    });

    testWidgets('pulsar stepper llama a setWeeklyGoal', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const initial = AppSettings(weeklyGoal: 3);
      when(() => mockService.setWeeklyGoal(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(buildTestableWidget(initial));
      await tester.pumpAndSettle();

      await tester.tap(find.text('+'));
      await tester.pumpAndSettle();

      verify(() => mockService.setWeeklyGoal(4)).called(1);
    });

    testWidgets('tocar unidad lb llama a setDefaultUnit', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const initial = AppSettings(defaultUnit: WeightUnit.kg);
      when(() => mockService.setDefaultUnit(WeightUnit.lb))
          .thenAnswer((_) async {});

      await tester.pumpWidget(buildTestableWidget(initial));
      await tester.pumpAndSettle();

      await tester.tap(find.text('lb'));
      await tester.pumpAndSettle();

      verify(() => mockService.setDefaultUnit(WeightUnit.lb)).called(1);
    });

    testWidgets('muestra opciones de colores y permite cambiar el tema', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const initial = AppSettings(themeColor: AppAccentColor.orange);
      when(() => mockService.setThemeColor(AppAccentColor.blue))
          .thenAnswer((_) async {});

      await tester.pumpWidget(buildTestableWidget(initial));
      await tester.pumpAndSettle();

      expect(find.text('Color de acento'), findsOneWidget);
      expect(find.text('Naranja'), findsOneWidget);
      expect(find.text('Azul'), findsOneWidget);
      expect(find.text('Verde'), findsOneWidget);
      expect(find.text('Morado'), findsOneWidget);
      expect(find.text('Rojo'), findsOneWidget);

      await tester.tap(find.text('Azul'));
      await tester.pumpAndSettle();

      verify(() => mockService.setThemeColor(AppAccentColor.blue)).called(1);
    });

    testWidgets('tocar borrar datos abre diálogo de confirmación', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      const initial = AppSettings();
      when(() => mockService.wipeAllData()).thenAnswer((_) async {});

      await tester.pumpWidget(buildTestableWidget(initial));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Borrar todos los datos'));
      await tester.pumpAndSettle();

      expect(find.text('¿Borrar todos los datos?'), findsOneWidget);

      await tester.tap(find.text('Borrar todo'));
      await tester.pumpAndSettle();

      verify(() => mockService.wipeAllData()).called(1);
    });
  });
}
