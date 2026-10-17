import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/database/app_database.dart';
import 'package:gym_claude/src/core/database/transaction_runner.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    test('inicializa en memoria con schemaVersion 4', () async {
      expect(db.schemaVersion, 4);

      // Verificamos que PRAGMA foreign_keys = ON esté habilitado
      final result = await db.customSelect('PRAGMA foreign_keys;').getSingle();
      expect(result.data['foreign_keys'], 1);
    });

    test('TransactionRunner ejecuta acciones atómicas correctamente', () async {
      final runner = DriftTransactionRunner(db);
      final value = await runner.run(() async => 42);
      expect(value, 42);
    });
  });
}
