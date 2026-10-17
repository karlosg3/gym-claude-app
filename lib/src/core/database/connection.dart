import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Abre la conexión principal a la base de datos SQLite local (`gymclaude`).
/// `shareAcrossIsolates: true` permite que isolates en segundo plano (notificaciones, widget)
/// compartan la misma conexión de forma segura.
QueryExecutor openConnection() {
  return driftDatabase(
    name: 'gymclaude',
    native: const DriftNativeOptions(shareAcrossIsolates: true),
  );
}
