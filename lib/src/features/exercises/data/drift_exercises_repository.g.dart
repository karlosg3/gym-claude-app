// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_exercises_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exercisesDao)
final exercisesDaoProvider = ExercisesDaoProvider._();

final class ExercisesDaoProvider
    extends $FunctionalProvider<ExercisesDao, ExercisesDao, ExercisesDao>
    with $Provider<ExercisesDao> {
  ExercisesDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exercisesDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exercisesDaoHash();

  @$internal
  @override
  $ProviderElement<ExercisesDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExercisesDao create(Ref ref) {
    return exercisesDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExercisesDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExercisesDao>(value),
    );
  }
}

String _$exercisesDaoHash() => r'37d0ce5fc1aa04e18897985ca499f60643563c95';

@ProviderFor(exercisesRepository)
final exercisesRepositoryProvider = ExercisesRepositoryProvider._();

final class ExercisesRepositoryProvider
    extends
        $FunctionalProvider<
          ExercisesRepository,
          ExercisesRepository,
          ExercisesRepository
        >
    with $Provider<ExercisesRepository> {
  ExercisesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exercisesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exercisesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExercisesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExercisesRepository create(Ref ref) {
    return exercisesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExercisesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExercisesRepository>(value),
    );
  }
}

String _$exercisesRepositoryHash() =>
    r'95d3af3f641fa0b6e7876f59ad6fc31780c0b1b4';
