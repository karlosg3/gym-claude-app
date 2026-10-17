import 'package:drift/drift.dart';
import 'package:gym_claude/src/core/database/connection.dart';
import 'package:gym_claude/src/core/database/converters.dart';
import 'package:gym_claude/src/core/database/transaction_runner.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weekday.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';
import 'package:gym_claude/src/features/exercises/data/exercises_dao.dart';
import 'package:gym_claude/src/features/progress/data/progress_dao.dart';
import 'package:gym_claude/src/features/routines/data/routines_dao.dart';
import 'package:gym_claude/src/features/settings/data/settings_dao.dart';
import 'package:gym_claude/src/features/workout/data/workout_dao.dart';
import 'package:gym_claude/src/features/workout/domain/session_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

/// Base de datos SQLite local de la aplicación gestionada con Drift.
@DriftDatabase(
  include: {
    '../../features/settings/data/settings.drift',
    '../../features/exercises/data/exercises.drift',
    '../../features/routines/data/routines.drift',
    '../../features/workout/data/workout.drift',
    '../../features/progress/data/progress_queries.drift',
  },
  daos: [SettingsDao, ExercisesDao, RoutinesDao, WorkoutDao, ProgressDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onCreate: (m) async {
      await m.createAll();
      await into(settings).insert(
        const SettingsCompanion(
          id: Value(1),
          userName: Value(''),
          weeklyGoal: Value(3),
          defaultUnit: Value(WeightUnit.kg),
          themeColor: Value(AppAccentColor.orange),
          workoutReminderEnabled: Value(true),
          reminderMinutes: Value(1110),
          streakRiskEnabled: Value(true),
          recordsEnabled: Value(false),
        ),
      );
      await exercisesDao.seedDefaultExercises(DateTime.now());
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(settings, settings.themeColor);
      }
      if (from < 3) {
        await m.createTable(routines);
        await m.createTable(routineItems);
      }
      if (from < 4) {
        await m.createTable(workoutSessions);
        await m.createTable(sessionExercises);
        await m.createTable(setRecords);
        await m.createIndex(workoutSessionsSingleActive);
        await m.createIndex(workoutSessionsDate);
        await m.createIndex(workoutSessionsRoutine);
        await m.createIndex(sessionExercisesExercise);
        await m.createIndex(setRecordsSessionExercise);
      }
    },
  );
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
TransactionRunner transactionRunner(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftTransactionRunner(db);
}
