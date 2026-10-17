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

String _$exercisesServiceHash() => r'55ac620413c4a3d887cb76138d567569868d17f1';
