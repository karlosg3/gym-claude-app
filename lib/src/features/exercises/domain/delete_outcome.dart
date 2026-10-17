/// Resultado de intentar eliminar un ejercicio de la biblioteca.
enum DeleteOutcome {
  /// El ejercicio no tenía historial y se eliminó por completo de la base de datos.
  deleted,

  /// El ejercicio tenía historial y fue archivado para conservar sus registros pasados.
  archived,
}
