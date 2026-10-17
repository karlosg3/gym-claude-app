// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_routines_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routinesRepository)
final routinesRepositoryProvider = RoutinesRepositoryProvider._();

final class RoutinesRepositoryProvider
    extends
        $FunctionalProvider<
          RoutinesRepository,
          RoutinesRepository,
          RoutinesRepository
        >
    with $Provider<RoutinesRepository> {
  RoutinesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routinesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routinesRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoutinesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoutinesRepository create(Ref ref) {
    return routinesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutinesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutinesRepository>(value),
    );
  }
}

String _$routinesRepositoryHash() =>
    r'd83ad2be9a28a8ca9ce74fee5970e80fd811c58b';
