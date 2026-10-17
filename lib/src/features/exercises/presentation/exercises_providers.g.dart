// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExerciseFilterNotifier)
final exerciseFilterProvider = ExerciseFilterNotifierProvider._();

final class ExerciseFilterNotifierProvider
    extends $NotifierProvider<ExerciseFilterNotifier, ExerciseFilter> {
  ExerciseFilterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseFilterNotifierHash();

  @$internal
  @override
  ExerciseFilterNotifier create() => ExerciseFilterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseFilter>(value),
    );
  }
}

String _$exerciseFilterNotifierHash() =>
    r'9ed4ce4ab49f90ab4a962fec5f0c080aac24d257';

abstract class _$ExerciseFilterNotifier extends $Notifier<ExerciseFilter> {
  ExerciseFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ExerciseFilter, ExerciseFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExerciseFilter, ExerciseFilter>,
              ExerciseFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(exerciseLibrary)
final exerciseLibraryProvider = ExerciseLibraryProvider._();

final class ExerciseLibraryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Exercise>>,
          List<Exercise>,
          Stream<List<Exercise>>
        >
    with $FutureModifier<List<Exercise>>, $StreamProvider<List<Exercise>> {
  ExerciseLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseLibraryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseLibraryHash();

  @$internal
  @override
  $StreamProviderElement<List<Exercise>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Exercise>> create(Ref ref) {
    return exerciseLibrary(ref);
  }
}

String _$exerciseLibraryHash() => r'254c4e401711c096d63d8c555b72730cefe1211f';

@ProviderFor(exerciseDetail)
final exerciseDetailProvider = ExerciseDetailFamily._();

final class ExerciseDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Exercise?>, Exercise?, Stream<Exercise?>>
    with $FutureModifier<Exercise?>, $StreamProvider<Exercise?> {
  ExerciseDetailProvider._({
    required ExerciseDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'exerciseDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exerciseDetailHash();

  @override
  String toString() {
    return r'exerciseDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Exercise?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Exercise?> create(Ref ref) {
    final argument = this.argument as int;
    return exerciseDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exerciseDetailHash() => r'8eaba337d76adf537709258bdca09d06bf68fb61';

final class ExerciseDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Exercise?>, int> {
  ExerciseDetailFamily._()
    : super(
        retry: null,
        name: r'exerciseDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExerciseDetailProvider call(int id) =>
      ExerciseDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'exerciseDetailProvider';
}

@ProviderFor(exerciseCount)
final exerciseCountProvider = ExerciseCountProvider._();

final class ExerciseCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  ExerciseCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseCountHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return exerciseCount(ref);
  }
}

String _$exerciseCountHash() => r'4c24ad69bb4311baac1c9bb022c2d40c63afa1a4';

@ProviderFor(ExerciseFormController)
final exerciseFormControllerProvider = ExerciseFormControllerProvider._();

final class ExerciseFormControllerProvider
    extends $AsyncNotifierProvider<ExerciseFormController, int?> {
  ExerciseFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseFormControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseFormControllerHash();

  @$internal
  @override
  ExerciseFormController create() => ExerciseFormController();
}

String _$exerciseFormControllerHash() =>
    r'001f020d09eff6d9775cb1f86a33aa97f110c201';

abstract class _$ExerciseFormController extends $AsyncNotifier<int?> {
  FutureOr<int?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int?>, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int?>, int?>,
              AsyncValue<int?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ExerciseDetailController)
final exerciseDetailControllerProvider = ExerciseDetailControllerProvider._();

final class ExerciseDetailControllerProvider
    extends $AsyncNotifierProvider<ExerciseDetailController, void> {
  ExerciseDetailControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseDetailControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseDetailControllerHash();

  @$internal
  @override
  ExerciseDetailController create() => ExerciseDetailController();
}

String _$exerciseDetailControllerHash() =>
    r'2b6e337023296710b437a9cbfcbd028d608a368d';

abstract class _$ExerciseDetailController extends $AsyncNotifier<void> {
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
