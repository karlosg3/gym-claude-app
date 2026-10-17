// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workoutService)
final workoutServiceProvider = WorkoutServiceProvider._();

final class WorkoutServiceProvider
    extends $FunctionalProvider<WorkoutService, WorkoutService, WorkoutService>
    with $Provider<WorkoutService> {
  WorkoutServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutServiceHash();

  @$internal
  @override
  $ProviderElement<WorkoutService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WorkoutService create(Ref ref) {
    return workoutService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutService>(value),
    );
  }
}

String _$workoutServiceHash() => r'584b121136b3253e764a3bb5c140afb5f53860b5';

/// Sesión activa (o `null`). La observan Inicio, la pantalla de sesión y el router.

@ProviderFor(activeSession)
final activeSessionProvider = ActiveSessionProvider._();

/// Sesión activa (o `null`). La observan Inicio, la pantalla de sesión y el router.

final class ActiveSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkoutSession?>,
          WorkoutSession?,
          Stream<WorkoutSession?>
        >
    with $FutureModifier<WorkoutSession?>, $StreamProvider<WorkoutSession?> {
  /// Sesión activa (o `null`). La observan Inicio, la pantalla de sesión y el router.
  ActiveSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeSessionHash();

  @$internal
  @override
  $StreamProviderElement<WorkoutSession?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WorkoutSession?> create(Ref ref) {
    return activeSession(ref);
  }
}

String _$activeSessionHash() => r'e3e529b758ee48794f10c5364913b734261c7590';

/// Ids de ejercicio de la sesión activa como clave estable ("3,7,12"): solo cambia
/// al añadir ejercicios, no en cada serie.

@ProviderFor(activeSessionExerciseKey)
final activeSessionExerciseKeyProvider = ActiveSessionExerciseKeyProvider._();

/// Ids de ejercicio de la sesión activa como clave estable ("3,7,12"): solo cambia
/// al añadir ejercicios, no en cada serie.

final class ActiveSessionExerciseKeyProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Ids de ejercicio de la sesión activa como clave estable ("3,7,12"): solo cambia
  /// al añadir ejercicios, no en cada serie.
  ActiveSessionExerciseKeyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeSessionExerciseKeyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeSessionExerciseKeyHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return activeSessionExerciseKey(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$activeSessionExerciseKeyHash() =>
    r'cd504b94ae50acbe6a8046184ba6a605a4d71764';

/// "Peso anterior" de los ejercicios de la sesión activa.

@ProviderFor(activeSessionPreviousBest)
final activeSessionPreviousBestProvider = ActiveSessionPreviousBestProvider._();

/// "Peso anterior" de los ejercicios de la sesión activa.

final class ActiveSessionPreviousBestProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<int, SetPerformance>>,
          Map<int, SetPerformance>,
          Stream<Map<int, SetPerformance>>
        >
    with
        $FutureModifier<Map<int, SetPerformance>>,
        $StreamProvider<Map<int, SetPerformance>> {
  /// "Peso anterior" de los ejercicios de la sesión activa.
  ActiveSessionPreviousBestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeSessionPreviousBestProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeSessionPreviousBestHash();

  @$internal
  @override
  $StreamProviderElement<Map<int, SetPerformance>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<int, SetPerformance>> create(Ref ref) {
    return activeSessionPreviousBest(ref);
  }
}

String _$activeSessionPreviousBestHash() =>
    r'8109f024289ff20096f1b77ee56dce1154a5a2fd';

/// Read model de la pantalla de sesión: sesión activa + peso anterior por ejercicio.

@ProviderFor(activeWorkout)
final activeWorkoutProvider = ActiveWorkoutProvider._();

/// Read model de la pantalla de sesión: sesión activa + peso anterior por ejercicio.

final class ActiveWorkoutProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActiveWorkout?>,
          AsyncValue<ActiveWorkout?>,
          AsyncValue<ActiveWorkout?>
        >
    with $Provider<AsyncValue<ActiveWorkout?>> {
  /// Read model de la pantalla de sesión: sesión activa + peso anterior por ejercicio.
  ActiveWorkoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeWorkoutProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeWorkoutHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<ActiveWorkout?>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<ActiveWorkout?> create(Ref ref) {
    return activeWorkout(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ActiveWorkout?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ActiveWorkout?>>(value),
    );
  }
}

String _$activeWorkoutHash() => r'ff8f5497a6e6cc928a62ff92871bad66a89d0304';

/// Sesión por id (resumen, historial).

@ProviderFor(workoutSession)
final workoutSessionProvider = WorkoutSessionFamily._();

/// Sesión por id (resumen, historial).

final class WorkoutSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkoutSession?>,
          WorkoutSession?,
          Stream<WorkoutSession?>
        >
    with $FutureModifier<WorkoutSession?>, $StreamProvider<WorkoutSession?> {
  /// Sesión por id (resumen, historial).
  WorkoutSessionProvider._({
    required WorkoutSessionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'workoutSessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workoutSessionHash();

  @override
  String toString() {
    return r'workoutSessionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<WorkoutSession?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WorkoutSession?> create(Ref ref) {
    final argument = this.argument as int;
    return workoutSession(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutSessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workoutSessionHash() => r'4b769d7447a2783a459e3a1f70ee6b05da46e0d1';

/// Sesión por id (resumen, historial).

final class WorkoutSessionFamily extends $Family
    with $FunctionalFamilyOverride<Stream<WorkoutSession?>, int> {
  WorkoutSessionFamily._()
    : super(
        retry: null,
        name: r'workoutSessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Sesión por id (resumen, historial).

  WorkoutSessionProvider call(int id) =>
      WorkoutSessionProvider._(argument: id, from: this);

  @override
  String toString() => r'workoutSessionProvider';
}

/// Ids de ejercicio de la sesión [id] cuya mejor serie es récord personal (insignia "PR").

@ProviderFor(sessionRecords)
final sessionRecordsProvider = SessionRecordsFamily._();

/// Ids de ejercicio de la sesión [id] cuya mejor serie es récord personal (insignia "PR").

final class SessionRecordsProvider
    extends
        $FunctionalProvider<AsyncValue<Set<int>>, Set<int>, FutureOr<Set<int>>>
    with $FutureModifier<Set<int>>, $FutureProvider<Set<int>> {
  /// Ids de ejercicio de la sesión [id] cuya mejor serie es récord personal (insignia "PR").
  SessionRecordsProvider._({
    required SessionRecordsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'sessionRecordsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sessionRecordsHash();

  @override
  String toString() {
    return r'sessionRecordsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Set<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Set<int>> create(Ref ref) {
    final argument = this.argument as int;
    return sessionRecords(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionRecordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionRecordsHash() => r'fe1637ac6bca0ebcae3bd58bfee10ad02dd07510';

/// Ids de ejercicio de la sesión [id] cuya mejor serie es récord personal (insignia "PR").

final class SessionRecordsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Set<int>>, int> {
  SessionRecordsFamily._()
    : super(
        retry: null,
        name: r'sessionRecordsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Ids de ejercicio de la sesión [id] cuya mejor serie es récord personal (insignia "PR").

  SessionRecordsProvider call(int id) =>
      SessionRecordsProvider._(argument: id, from: this);

  @override
  String toString() => r'sessionRecordsProvider';
}
