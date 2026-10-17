// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'GymClaude';

  @override
  String get navHome => 'Inicio';

  @override
  String get navRoutines => 'Rutinas';

  @override
  String get navExercises => 'Ejercicios';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get navWorkout => 'Sesión activa';

  @override
  String get navWorkoutSummary => 'Resumen de sesión';

  @override
  String get navExport => 'Exportar datos';

  @override
  String get emptyScreenPhase0Desc =>
      'Estructura base lista (Fase 0 — Fundaciones).';

  @override
  String get errorUnexpectedTitle => 'Ha ocurrido un problema inesperado';

  @override
  String get errorRetry => 'Reintentar';

  @override
  String get actionBack => 'Volver';

  @override
  String get settingsSectionProfile => 'Perfil';

  @override
  String get settingsNameLabel => 'Nombre';

  @override
  String get settingsNamePlaceholder => 'Tu nombre';

  @override
  String get settingsSectionAppearance => 'Apariencia';

  @override
  String get settingsThemeColorTitle => 'Color de acento';

  @override
  String get settingsThemeColorSubtitle =>
      'Personaliza el tono principal de la interfaz';

  @override
  String get colorOrange => 'Naranja';

  @override
  String get colorBlue => 'Azul';

  @override
  String get colorGreen => 'Verde';

  @override
  String get colorPurple => 'Morado';

  @override
  String get colorRed => 'Rojo';

  @override
  String get settingsSectionTraining => 'Entrenamiento';

  @override
  String get settingsWeeklyGoalTitle => 'Meta semanal';

  @override
  String get settingsWeeklyGoalSubtitle => 'Sesiones por semana';

  @override
  String get settingsDefaultUnitTitle => 'Unidad por defecto';

  @override
  String get settingsDefaultUnitSubtitle => 'Para ejercicios nuevos';

  @override
  String get settingsSectionNotifications => 'Notificaciones';

  @override
  String get settingsWorkoutReminderTitle => 'Recordatorio de entreno';

  @override
  String get settingsWorkoutReminderSubtitle => 'Aviso los días de tu rutina';

  @override
  String get settingsStreakRiskTitle => 'Racha en riesgo';

  @override
  String get settingsStreakRiskSubtitle => 'Si no has entrenado a las 20:00';

  @override
  String get settingsRecordsTitle => 'Récords personales';

  @override
  String get settingsRecordsSubtitle => 'Cuando superas tu máximo';

  @override
  String get settingsReminderTimeTitle => 'Hora del recordatorio';

  @override
  String get settingsSectionData => 'Datos';

  @override
  String get settingsExportSubtitle => 'Markdown, CSV o PDF';

  @override
  String get settingsWipeDataButton => 'Borrar todos los datos';

  @override
  String get settingsWipeConfirmTitle => '¿Borrar todos los datos?';

  @override
  String get settingsWipeConfirmMessage =>
      'Se restablecerán las rutinas y el historial. Se volverán a sembrar los ejercicios iniciales y los ajustes por defecto.';

  @override
  String get settingsWipeConfirmAction => 'Borrar todo';

  @override
  String get settingsWipeCancelAction => 'Cancelar';

  @override
  String get settingsFooterAppVersion => 'GymClaude v0.5 · local-first';

  @override
  String get settingsFooterPrivacy =>
      'Tus datos no salen de tu dispositivo ni de tus copias de seguridad';

  @override
  String exercisesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ejercicios',
      one: '1 ejercicio',
    );
    return '$_temp0';
  }

  @override
  String get exercisesSearchPlaceholder => 'Buscar ejercicio';

  @override
  String get exercisesFilterAll => 'Todos';

  @override
  String get exercisesEmptySearch => 'Sin resultados';

  @override
  String get exercisesMaxLabel => 'máximo';

  @override
  String get exercisesLastLabel => 'última';

  @override
  String get exercisesSessionsLabel => 'sesiones';

  @override
  String get exerciseDetailUnitTitle => 'Unidad de peso';

  @override
  String get exerciseDetailUnitSubtitle => 'Solo para este ejercicio';

  @override
  String get exerciseDetailNoDataTitle => 'Aún no hay registros';

  @override
  String get exerciseDetailNoDataSubtitle =>
      'Inicia una sesión y registra series para ver tu progreso aquí.';

  @override
  String get exerciseDetailDescTitle => 'Descripción';

  @override
  String get exerciseDetailNoDesc => 'Sin descripción.';

  @override
  String get exerciseDetailProgressTitle => 'Progreso · peso máximo';

  @override
  String get exerciseDetailHistoryTitle => 'Historial reciente';

  @override
  String get exerciseFormNewTitle => 'Nuevo ejercicio';

  @override
  String get exerciseFormEditTitle => 'Editar ejercicio';

  @override
  String get exerciseFormNameLabel => 'Nombre';

  @override
  String get exerciseFormNamePlaceholder => 'Ej. Press de banca';

  @override
  String get exerciseFormMuscleLabel => 'Grupo muscular';

  @override
  String get exerciseFormUnitLabel => 'Unidad de peso';

  @override
  String get exerciseFormBodyweightLabel => 'Usa peso corporal';

  @override
  String get exerciseFormBodyweightSubtitle =>
      'El peso se registrará como lastre adicional (+10 kg)';

  @override
  String get exerciseFormDescLabel => 'Descripción';

  @override
  String get exerciseFormDescOptional => '· opcional';

  @override
  String get exerciseFormDescPlaceholder => 'Técnica, notas o recordatorios…';

  @override
  String get exerciseFormSave => 'Guardar ejercicio';

  @override
  String get exerciseFormCancel => 'Cancelar';

  @override
  String get exerciseFormErrorEmptyName => 'El nombre no puede estar vacío';

  @override
  String get exerciseFormErrorDuplicateName =>
      'Ya existe un ejercicio con ese nombre';

  @override
  String get exerciseDeleteTitle => '¿Eliminar ejercicio?';

  @override
  String get exerciseDeleteMessage =>
      '¿Estás seguro de que deseas eliminar este ejercicio de la biblioteca?';

  @override
  String get exerciseArchiveTitle => 'Archivar ejercicio';

  @override
  String get exerciseArchiveMessage =>
      'Tiene sesiones registradas. Se ocultará de la biblioteca pero su historial se conserva.';

  @override
  String get exerciseDeleteAction => 'Eliminar';

  @override
  String get exerciseArchiveAction => 'Archivar';

  @override
  String get exerciseNotFound => 'Ejercicio no encontrado';

  @override
  String get muscleGroupChest => 'Pecho';

  @override
  String get muscleGroupBack => 'Espalda';

  @override
  String get muscleGroupLegs => 'Pierna';

  @override
  String get muscleGroupShoulders => 'Hombro';

  @override
  String get muscleGroupArms => 'Brazo';

  @override
  String get muscleGroupCore => 'Core';

  @override
  String get routinesEmptyTitle => 'Crea tu primera rutina';

  @override
  String get routinesEmptyDesc =>
      'Organiza tus entrenamientos semanales por días y asigna ejercicios.';

  @override
  String get routinesNewButton => 'Nueva rutina';

  @override
  String routinesExercisesAndDays(int exercises, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      exercises,
      locale: localeName,
      other: '$exercises ejercicios',
      one: '1 ejercicio',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días',
      one: '1 día',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get routineNewTitle => 'Nueva rutina';

  @override
  String get routineEditTitle => 'Editar rutina';

  @override
  String get routineNameLabel => 'Nombre de la rutina';

  @override
  String get routineNamePlaceholder => 'Ej. Empuje / Jalón / Pierna';

  @override
  String get routineActiveDaysLabel => 'Días activos';

  @override
  String get routineDescriptionLabel => 'Descripción (opcional)';

  @override
  String get routineDescriptionPlaceholder => 'Breve resumen de tu enfoque';

  @override
  String get routineSaveButton => 'Guardar rutina';

  @override
  String get routineDeleteTitle => '¿Eliminar rutina?';

  @override
  String get routineDeleteMessage =>
      'Se eliminará esta rutina y sus asignaciones. Las sesiones pasadas registradas se conservarán.';

  @override
  String get routineEmptyDay =>
      'Sin ejercicios. Toca “Agregar” para asignar uno.';

  @override
  String get routineAddExerciseButton => 'Agregar ejercicio';

  @override
  String get routineStartDayButton => 'Empezar este día';

  @override
  String get routineEditSchemeTitle => 'Esquema de series y repeticiones';

  @override
  String get routineSetsLabel => 'Series';

  @override
  String get routineRepsLabel => 'Repeticiones';

  @override
  String get routineRepsToFailure => 'Al fallo (máx)';

  @override
  String get routineExerciseAdded => 'Ejercicio agregado a la rutina';

  @override
  String get routineExerciseRemoved => 'Ejercicio quitado';

  @override
  String get routineNotFound => 'Rutina no encontrada';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get exercisesNewButton => 'Nuevo ejercicio';
}
