/// Excepción base para todas las violaciones de reglas de negocio en el dominio.
sealed class DomainException implements Exception {
  const DomainException._();

  /// Constructor genérico para excepciones de dominio con mensaje personalizado.
  const factory DomainException(String message) = _GenericDomainException;

  /// Mensaje descriptivo por defecto en español según las especificaciones de diseño.
  String get message;

  @override
  String toString() => message;
}

final class _GenericDomainException extends DomainException {
  const _GenericDomainException(this.message) : super._();

  @override
  final String message;
}

/// El nombre introducido está vacío o solo contiene espacios.
final class EmptyNameException extends DomainException {
  const EmptyNameException() : super._();
  @override
  String get message => 'El nombre no puede estar vacío';
}

/// Ya existe un ejercicio activo con el mismo nombre.
final class DuplicateExerciseNameException extends DomainException {
  const DuplicateExerciseNameException() : super._();
  @override
  String get message => 'Ya existe un ejercicio con este nombre';
}

/// Se intentó guardar una rutina sin ningún día activo seleccionado.
final class RoutineWithoutDaysException extends DomainException {
  const RoutineWithoutDaysException() : super._();
  @override
  String get message => 'Selecciona al menos un día';
}

/// El número de repeticiones especificado es inválido (debe ser mayor a 0).
final class InvalidRepsException extends DomainException {
  const InvalidRepsException() : super._();
  @override
  String get message => 'Ingresa repeticiones válidas';
}

/// El peso especificado es negativo.
final class InvalidWeightException extends DomainException {
  const InvalidWeightException() : super._();
  @override
  String get message => 'El peso no puede ser negativo';
}

/// Se intentó agregar un ejercicio que ya existe en el mismo día de la rutina.
final class ExerciseAlreadyInDayException extends DomainException {
  const ExerciseAlreadyInDayException() : super._();
  @override
  String get message => 'Este ejercicio ya está agregado en este día';
}

/// Ya existe una sesión de entrenamiento activa.
final class SessionAlreadyActiveException extends DomainException {
  const SessionAlreadyActiveException() : super._();
  @override
  String get message => 'Ya hay una sesión de entrenamiento activa';
}

/// Se intentó operar sobre una sesión activa cuando no hay ninguna.
final class NoActiveSessionException extends DomainException {
  const NoActiveSessionException() : super._();
  @override
  String get message => 'No hay ninguna sesión activa';
}

/// No hay datos para generar una exportación.
final class NothingToExportException extends DomainException {
  const NothingToExportException() : super._();
  @override
  String get message => 'No hay datos para exportar';
}
