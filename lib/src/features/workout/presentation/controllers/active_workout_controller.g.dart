// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_workout_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Acciones de la sesión activa. Valida la forma de la entrada y delega en [WorkoutService];
/// los errores quedan en `state` como `AsyncError`.

@ProviderFor(ActiveWorkoutController)
final activeWorkoutControllerProvider = ActiveWorkoutControllerProvider._();

/// Acciones de la sesión activa. Valida la forma de la entrada y delega en [WorkoutService];
/// los errores quedan en `state` como `AsyncError`.
final class ActiveWorkoutControllerProvider
    extends $AsyncNotifierProvider<ActiveWorkoutController, void> {
  /// Acciones de la sesión activa. Valida la forma de la entrada y delega en [WorkoutService];
  /// los errores quedan en `state` como `AsyncError`.
  ActiveWorkoutControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeWorkoutControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeWorkoutControllerHash();

  @$internal
  @override
  ActiveWorkoutController create() => ActiveWorkoutController();
}

String _$activeWorkoutControllerHash() =>
    r'235f05988fd99267f2e0d6697712db377c36113e';

/// Acciones de la sesión activa. Valida la forma de la entrada y delega en [WorkoutService];
/// los errores quedan en `state` como `AsyncError`.

abstract class _$ActiveWorkoutController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Índice del ejercicio visible (estado de UI). `null` = colocarse en el primero sin series.

@ProviderFor(CurrentExerciseIndex)
final currentExerciseIndexProvider = CurrentExerciseIndexProvider._();

/// Índice del ejercicio visible (estado de UI). `null` = colocarse en el primero sin series.
final class CurrentExerciseIndexProvider
    extends $NotifierProvider<CurrentExerciseIndex, int?> {
  /// Índice del ejercicio visible (estado de UI). `null` = colocarse en el primero sin series.
  CurrentExerciseIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentExerciseIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentExerciseIndexHash();

  @$internal
  @override
  CurrentExerciseIndex create() => CurrentExerciseIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$currentExerciseIndexHash() =>
    r'3737bc78f2c13a2a942d87f1e044fcbac8ebfd75';

/// Índice del ejercicio visible (estado de UI). `null` = colocarse en el primero sin series.

abstract class _$CurrentExerciseIndex extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
