import 'package:drift/drift.dart';

/// Puerto que permite a los servicios de aplicación ejecutar operaciones atómicas
/// en una transacción sin tener que importar ni depender directamente de Drift.
abstract interface class TransactionRunner {
  /// Ejecuta la función [action] dentro de una transacción atómica.
  Future<T> run<T>(Future<T> Function() action);
}

/// Implementación concreta de [TransactionRunner] sobre una base de datos Drift.
class DriftTransactionRunner implements TransactionRunner {
  const DriftTransactionRunner(this._db);

  final GeneratedDatabase _db;

  @override
  Future<T> run<T>(Future<T> Function() action) {
    return _db.transaction(action);
  }
}
