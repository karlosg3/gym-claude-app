// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exercisesService)
final exercisesServiceProvider = ExercisesServiceProvider._();

final class ExercisesServiceProvider
    extends
        $FunctionalProvider<
          ExercisesService,
          ExercisesService,
          ExercisesService
        >
    with $Provider<ExercisesService> {
  ExercisesServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exercisesServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exercisesServiceHash();

  @$internal
  @override
  $ProviderElement<ExercisesService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExercisesService create(Ref ref) {
    return exercisesService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExercisesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExercisesService>(value),
    );
  }
}

String _$exercisesServiceHash() => r'ac57e217298133e543bcc948f0d33600468036c0';

@ProviderFor(allExercises)
final allExercisesProvider = AllExercisesProvider._();

final class AllExercisesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Exercise>>,
          List<Exercise>,
          Stream<List<Exercise>>
        >
    with $FutureModifier<List<Exercise>>, $StreamProvider<List<Exercise>> {
  AllExercisesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allExercisesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allExercisesHash();

  @$internal
  @override
  $StreamProviderElement<List<Exercise>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Exercise>> create(Ref ref) {
    return allExercises(ref);
  }
}

String _$allExercisesHash() => r'4307aeaad775c8b369c40eb097bc80af97c29d9e';
