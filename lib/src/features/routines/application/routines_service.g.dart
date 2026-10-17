// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routines_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routinesService)
final routinesServiceProvider = RoutinesServiceProvider._();

final class RoutinesServiceProvider
    extends
        $FunctionalProvider<RoutinesService, RoutinesService, RoutinesService>
    with $Provider<RoutinesService> {
  RoutinesServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routinesServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routinesServiceHash();

  @$internal
  @override
  $ProviderElement<RoutinesService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RoutinesService create(Ref ref) {
    return routinesService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutinesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutinesService>(value),
    );
  }
}

String _$routinesServiceHash() => r'61a5536cfeab76bb3f5345d8091714d8c5775f44';

@ProviderFor(routinesList)
final routinesListProvider = RoutinesListProvider._();

final class RoutinesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Routine>>,
          List<Routine>,
          Stream<List<Routine>>
        >
    with $FutureModifier<List<Routine>>, $StreamProvider<List<Routine>> {
  RoutinesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routinesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routinesListHash();

  @$internal
  @override
  $StreamProviderElement<List<Routine>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Routine>> create(Ref ref) {
    return routinesList(ref);
  }
}

String _$routinesListHash() => r'd50f3de80dcdf04a10410a769abb41490578668e';

@ProviderFor(routineDetail)
final routineDetailProvider = RoutineDetailFamily._();

final class RoutineDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Routine?>, Routine?, Stream<Routine?>>
    with $FutureModifier<Routine?>, $StreamProvider<Routine?> {
  RoutineDetailProvider._({
    required RoutineDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'routineDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routineDetailHash();

  @override
  String toString() {
    return r'routineDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Routine?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Routine?> create(Ref ref) {
    final argument = this.argument as int;
    return routineDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routineDetailHash() => r'cdb1de67943241d1a9c2a1317da74590321c7819';

final class RoutineDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Routine?>, int> {
  RoutineDetailFamily._()
    : super(
        retry: null,
        name: r'routineDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutineDetailProvider call(int id) =>
      RoutineDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'routineDetailProvider';
}
