import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// Nombre de la aplicación
  ///
  /// In es, this message translates to:
  /// **'GymClaude'**
  String get appName;

  /// Pestaña de inicio
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// Pestaña de rutinas
  ///
  /// In es, this message translates to:
  /// **'Rutinas'**
  String get navRoutines;

  /// Pestaña de ejercicios
  ///
  /// In es, this message translates to:
  /// **'Ejercicios'**
  String get navExercises;

  /// Pestaña de historial
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get navHistory;

  /// Título de la pantalla de ajustes
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get navSettings;

  /// Título de la pantalla de sesión de entrenamiento
  ///
  /// In es, this message translates to:
  /// **'Sesión activa'**
  String get navWorkout;

  /// Título de la pantalla de resumen de entrenamiento
  ///
  /// In es, this message translates to:
  /// **'Resumen de sesión'**
  String get navWorkoutSummary;

  /// Título de la pantalla de exportación
  ///
  /// In es, this message translates to:
  /// **'Exportar datos'**
  String get navExport;

  /// Descripción de marcador de posición para las pantallas vacías en la Fase 0
  ///
  /// In es, this message translates to:
  /// **'Estructura base lista (Fase 0 — Fundaciones).'**
  String get emptyScreenPhase0Desc;

  /// Título genérico cuando falla una vista o el arranque
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un problema inesperado'**
  String get errorUnexpectedTitle;

  /// Etiqueta del botón para reintentar una operación fallida
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get errorRetry;

  /// Etiqueta semántica para el botón de volver atrás
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get actionBack;

  /// Sección de perfil en ajustes
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get settingsSectionProfile;

  /// Etiqueta de nombre en perfil
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get settingsNameLabel;

  /// Placeholder de nombre en perfil
  ///
  /// In es, this message translates to:
  /// **'Tu nombre'**
  String get settingsNamePlaceholder;

  /// Sección de apariencia en ajustes
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get settingsSectionAppearance;

  /// Título de selector de color de acento
  ///
  /// In es, this message translates to:
  /// **'Color de acento'**
  String get settingsThemeColorTitle;

  /// Subtítulo de selector de color de acento
  ///
  /// In es, this message translates to:
  /// **'Personaliza el tono principal de la interfaz'**
  String get settingsThemeColorSubtitle;

  /// Color naranja de acento
  ///
  /// In es, this message translates to:
  /// **'Naranja'**
  String get colorOrange;

  /// Color azul de acento
  ///
  /// In es, this message translates to:
  /// **'Azul'**
  String get colorBlue;

  /// Color verde de acento
  ///
  /// In es, this message translates to:
  /// **'Verde'**
  String get colorGreen;

  /// Color morado de acento
  ///
  /// In es, this message translates to:
  /// **'Morado'**
  String get colorPurple;

  /// Color rojo de acento
  ///
  /// In es, this message translates to:
  /// **'Rojo'**
  String get colorRed;

  /// Sección de entrenamiento en ajustes
  ///
  /// In es, this message translates to:
  /// **'Entrenamiento'**
  String get settingsSectionTraining;

  /// Título de meta semanal
  ///
  /// In es, this message translates to:
  /// **'Meta semanal'**
  String get settingsWeeklyGoalTitle;

  /// Subtítulo de meta semanal
  ///
  /// In es, this message translates to:
  /// **'Sesiones por semana'**
  String get settingsWeeklyGoalSubtitle;

  /// Título de unidad por defecto
  ///
  /// In es, this message translates to:
  /// **'Unidad por defecto'**
  String get settingsDefaultUnitTitle;

  /// Subtítulo de unidad por defecto
  ///
  /// In es, this message translates to:
  /// **'Para ejercicios nuevos'**
  String get settingsDefaultUnitSubtitle;

  /// Sección de notificaciones en ajustes
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get settingsSectionNotifications;

  /// Título de recordatorio de entreno
  ///
  /// In es, this message translates to:
  /// **'Recordatorio de entreno'**
  String get settingsWorkoutReminderTitle;

  /// Subtítulo de recordatorio de entreno
  ///
  /// In es, this message translates to:
  /// **'Aviso los días de tu rutina'**
  String get settingsWorkoutReminderSubtitle;

  /// Título de racha en riesgo
  ///
  /// In es, this message translates to:
  /// **'Racha en riesgo'**
  String get settingsStreakRiskTitle;

  /// Subtítulo de racha en riesgo
  ///
  /// In es, this message translates to:
  /// **'Si no has entrenado a las 20:00'**
  String get settingsStreakRiskSubtitle;

  /// Título de récords personales
  ///
  /// In es, this message translates to:
  /// **'Récords personales'**
  String get settingsRecordsTitle;

  /// Subtítulo de récords personales
  ///
  /// In es, this message translates to:
  /// **'Cuando superas tu máximo'**
  String get settingsRecordsSubtitle;

  /// Título de hora de recordatorio
  ///
  /// In es, this message translates to:
  /// **'Hora del recordatorio'**
  String get settingsReminderTimeTitle;

  /// Sección de datos en ajustes
  ///
  /// In es, this message translates to:
  /// **'Datos'**
  String get settingsSectionData;

  /// Subtítulo de exportar datos
  ///
  /// In es, this message translates to:
  /// **'Markdown, CSV o PDF'**
  String get settingsExportSubtitle;

  /// Botón destructivo de borrar todos los datos
  ///
  /// In es, this message translates to:
  /// **'Borrar todos los datos'**
  String get settingsWipeDataButton;

  /// Título del diálogo de confirmación de borrado
  ///
  /// In es, this message translates to:
  /// **'¿Borrar todos los datos?'**
  String get settingsWipeConfirmTitle;

  /// Mensaje de advertencia del diálogo de borrado
  ///
  /// In es, this message translates to:
  /// **'Se restablecerán las rutinas y el historial. Se volverán a sembrar los ejercicios iniciales y los ajustes por defecto.'**
  String get settingsWipeConfirmMessage;

  /// Acción de confirmar borrado
  ///
  /// In es, this message translates to:
  /// **'Borrar todo'**
  String get settingsWipeConfirmAction;

  /// Acción de cancelar borrado
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get settingsWipeCancelAction;

  /// Versión en pie de página de ajustes
  ///
  /// In es, this message translates to:
  /// **'GymClaude v0.5 · local-first'**
  String get settingsFooterAppVersion;

  /// Texto de privacidad local en pie de página de ajustes
  ///
  /// In es, this message translates to:
  /// **'Tus datos no salen de tu dispositivo ni de tus copias de seguridad'**
  String get settingsFooterPrivacy;

  /// Contador de ejercicios en cabecera
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 ejercicio} other{{count} ejercicios}}'**
  String exercisesCount(int count);

  /// Placeholder del buscador de ejercicios
  ///
  /// In es, this message translates to:
  /// **'Buscar ejercicio'**
  String get exercisesSearchPlaceholder;

  /// Pestaña o chip de todos los grupos musculares
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get exercisesFilterAll;

  /// Texto cuando la búsqueda no devuelve ejercicios
  ///
  /// In es, this message translates to:
  /// **'Sin resultados'**
  String get exercisesEmptySearch;

  /// Etiqueta bajo el peso máximo en listas y tarjetas
  ///
  /// In es, this message translates to:
  /// **'máximo'**
  String get exercisesMaxLabel;

  /// Etiqueta bajo el peso de la última sesión
  ///
  /// In es, this message translates to:
  /// **'última'**
  String get exercisesLastLabel;

  /// Etiqueta del número de sesiones completadas
  ///
  /// In es, this message translates to:
  /// **'sesiones'**
  String get exercisesSessionsLabel;

  /// Título de unidad de peso en detalle de ejercicio
  ///
  /// In es, this message translates to:
  /// **'Unidad de peso'**
  String get exerciseDetailUnitTitle;

  /// Subtítulo de unidad de peso en detalle de ejercicio
  ///
  /// In es, this message translates to:
  /// **'Solo para este ejercicio'**
  String get exerciseDetailUnitSubtitle;

  /// Título de sin datos en detalle de ejercicio
  ///
  /// In es, this message translates to:
  /// **'Aún no hay registros'**
  String get exerciseDetailNoDataTitle;

  /// Subtítulo de sin datos en detalle de ejercicio
  ///
  /// In es, this message translates to:
  /// **'Inicia una sesión y registra series para ver tu progreso aquí.'**
  String get exerciseDetailNoDataSubtitle;

  /// Título de sección descripción
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get exerciseDetailDescTitle;

  /// Texto cuando el ejercicio no tiene descripción
  ///
  /// In es, this message translates to:
  /// **'Sin descripción.'**
  String get exerciseDetailNoDesc;

  /// Título del gráfico de progreso en detalle
  ///
  /// In es, this message translates to:
  /// **'Progreso · peso máximo'**
  String get exerciseDetailProgressTitle;

  /// Título de historial reciente en detalle
  ///
  /// In es, this message translates to:
  /// **'Historial reciente'**
  String get exerciseDetailHistoryTitle;

  /// Título al crear nuevo ejercicio
  ///
  /// In es, this message translates to:
  /// **'Nuevo ejercicio'**
  String get exerciseFormNewTitle;

  /// Título al editar ejercicio existente
  ///
  /// In es, this message translates to:
  /// **'Editar ejercicio'**
  String get exerciseFormEditTitle;

  /// Etiqueta de nombre en formulario
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get exerciseFormNameLabel;

  /// Placeholder de nombre en formulario
  ///
  /// In es, this message translates to:
  /// **'Ej. Press de banca'**
  String get exerciseFormNamePlaceholder;

  /// Etiqueta de grupo muscular
  ///
  /// In es, this message translates to:
  /// **'Grupo muscular'**
  String get exerciseFormMuscleLabel;

  /// Etiqueta de unidad de peso en formulario
  ///
  /// In es, this message translates to:
  /// **'Unidad de peso'**
  String get exerciseFormUnitLabel;

  /// Interruptor de peso corporal
  ///
  /// In es, this message translates to:
  /// **'Usa peso corporal'**
  String get exerciseFormBodyweightLabel;

  /// Subtítulo de peso corporal
  ///
  /// In es, this message translates to:
  /// **'El peso se registrará como lastre adicional (+10 kg)'**
  String get exerciseFormBodyweightSubtitle;

  /// Etiqueta de descripción en formulario
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get exerciseFormDescLabel;

  /// Texto opcional en descripción
  ///
  /// In es, this message translates to:
  /// **'· opcional'**
  String get exerciseFormDescOptional;

  /// Placeholder de descripción en formulario
  ///
  /// In es, this message translates to:
  /// **'Técnica, notas o recordatorios…'**
  String get exerciseFormDescPlaceholder;

  /// Botón principal de guardar ejercicio
  ///
  /// In es, this message translates to:
  /// **'Guardar ejercicio'**
  String get exerciseFormSave;

  /// Botón de cancelar formulario
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get exerciseFormCancel;

  /// Error cuando el nombre está vacío
  ///
  /// In es, this message translates to:
  /// **'El nombre no puede estar vacío'**
  String get exerciseFormErrorEmptyName;

  /// Error cuando ya existe un ejercicio con ese nombre
  ///
  /// In es, this message translates to:
  /// **'Ya existe un ejercicio con ese nombre'**
  String get exerciseFormErrorDuplicateName;

  /// Título de diálogo de eliminar ejercicio
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar ejercicio?'**
  String get exerciseDeleteTitle;

  /// Mensaje de confirmación de eliminar ejercicio sin historial
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas eliminar este ejercicio de la biblioteca?'**
  String get exerciseDeleteMessage;

  /// Título de diálogo de archivar ejercicio
  ///
  /// In es, this message translates to:
  /// **'Archivar ejercicio'**
  String get exerciseArchiveTitle;

  /// Mensaje de archivado de ejercicio con historial
  ///
  /// In es, this message translates to:
  /// **'Tiene sesiones registradas. Se ocultará de la biblioteca pero su historial se conserva.'**
  String get exerciseArchiveMessage;

  /// Acción de confirmar eliminación
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get exerciseDeleteAction;

  /// Acción de confirmar archivado
  ///
  /// In es, this message translates to:
  /// **'Archivar'**
  String get exerciseArchiveAction;

  /// Texto cuando el id de ejercicio no existe
  ///
  /// In es, this message translates to:
  /// **'Ejercicio no encontrado'**
  String get exerciseNotFound;

  /// Grupo muscular Pecho
  ///
  /// In es, this message translates to:
  /// **'Pecho'**
  String get muscleGroupChest;

  /// Grupo muscular Espalda
  ///
  /// In es, this message translates to:
  /// **'Espalda'**
  String get muscleGroupBack;

  /// Grupo muscular Pierna
  ///
  /// In es, this message translates to:
  /// **'Pierna'**
  String get muscleGroupLegs;

  /// Grupo muscular Hombro
  ///
  /// In es, this message translates to:
  /// **'Hombro'**
  String get muscleGroupShoulders;

  /// Grupo muscular Brazo
  ///
  /// In es, this message translates to:
  /// **'Brazo'**
  String get muscleGroupArms;

  /// Grupo muscular Core
  ///
  /// In es, this message translates to:
  /// **'Core'**
  String get muscleGroupCore;

  /// Título cuando no hay rutinas
  ///
  /// In es, this message translates to:
  /// **'Crea tu primera rutina'**
  String get routinesEmptyTitle;

  /// Descripción cuando no hay rutinas
  ///
  /// In es, this message translates to:
  /// **'Organiza tus entrenamientos semanales por días y asigna ejercicios.'**
  String get routinesEmptyDesc;

  /// Texto del botón para crear una nueva rutina
  ///
  /// In es, this message translates to:
  /// **'Nueva rutina'**
  String get routinesNewButton;

  /// Resumen de ejercicios y días en la tarjeta de rutina
  ///
  /// In es, this message translates to:
  /// **'{exercises, plural, =1{1 ejercicio} other{{exercises} ejercicios}} · {days, plural, =1{1 día} other{{days} días}}'**
  String routinesExercisesAndDays(int exercises, int days);

  /// Título de la pantalla para crear rutina
  ///
  /// In es, this message translates to:
  /// **'Nueva rutina'**
  String get routineNewTitle;

  /// Título de la pantalla para editar rutina
  ///
  /// In es, this message translates to:
  /// **'Editar rutina'**
  String get routineEditTitle;

  /// Etiqueta del campo de nombre de rutina
  ///
  /// In es, this message translates to:
  /// **'Nombre de la rutina'**
  String get routineNameLabel;

  /// Placeholder de nombre de rutina
  ///
  /// In es, this message translates to:
  /// **'Ej. Empuje / Jalón / Pierna'**
  String get routineNamePlaceholder;

  /// Etiqueta para selector de días activos
  ///
  /// In es, this message translates to:
  /// **'Días activos'**
  String get routineActiveDaysLabel;

  /// Etiqueta de descripción de rutina
  ///
  /// In es, this message translates to:
  /// **'Descripción (opcional)'**
  String get routineDescriptionLabel;

  /// Placeholder de descripción de rutina
  ///
  /// In es, this message translates to:
  /// **'Breve resumen de tu enfoque'**
  String get routineDescriptionPlaceholder;

  /// Botón para guardar rutina
  ///
  /// In es, this message translates to:
  /// **'Guardar rutina'**
  String get routineSaveButton;

  /// Título de diálogo para confirmar borrado de rutina
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar rutina?'**
  String get routineDeleteTitle;

  /// Mensaje de confirmación de borrado de rutina
  ///
  /// In es, this message translates to:
  /// **'Se eliminará esta rutina y sus asignaciones. Las sesiones pasadas registradas se conservarán.'**
  String get routineDeleteMessage;

  /// Texto cuando un día no tiene ejercicios asignados
  ///
  /// In es, this message translates to:
  /// **'Sin ejercicios. Toca “Agregar” para asignar uno.'**
  String get routineEmptyDay;

  /// Botón para agregar ejercicio a un día
  ///
  /// In es, this message translates to:
  /// **'Agregar ejercicio'**
  String get routineAddExerciseButton;

  /// Botón para iniciar entrenamiento con el día seleccionado
  ///
  /// In es, this message translates to:
  /// **'Empezar este día'**
  String get routineStartDayButton;

  /// Título del diálogo para editar series y repeticiones
  ///
  /// In es, this message translates to:
  /// **'Esquema de series y repeticiones'**
  String get routineEditSchemeTitle;

  /// Etiqueta de número de series
  ///
  /// In es, this message translates to:
  /// **'Series'**
  String get routineSetsLabel;

  /// Etiqueta de número de repeticiones
  ///
  /// In es, this message translates to:
  /// **'Repeticiones'**
  String get routineRepsLabel;

  /// Opción de repeticiones al fallo
  ///
  /// In es, this message translates to:
  /// **'Al fallo (máx)'**
  String get routineRepsToFailure;

  /// Mensaje de retroalimentación al agregar ejercicio
  ///
  /// In es, this message translates to:
  /// **'Ejercicio agregado a la rutina'**
  String get routineExerciseAdded;

  /// Mensaje de retroalimentación al quitar ejercicio
  ///
  /// In es, this message translates to:
  /// **'Ejercicio quitado'**
  String get routineExerciseRemoved;

  /// Texto cuando la rutina solicitada no existe
  ///
  /// In es, this message translates to:
  /// **'Rutina no encontrada'**
  String get routineNotFound;

  /// Texto genérico para guardar
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get commonSave;

  /// Texto genérico para cancelar
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// Texto genérico para eliminar
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get commonDelete;

  /// Texto genérico para editar
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get commonEdit;

  /// Botón para crear un nuevo ejercicio
  ///
  /// In es, this message translates to:
  /// **'Nuevo ejercicio'**
  String get exercisesNewButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
