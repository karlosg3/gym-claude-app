// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(progressService)
final progressServiceProvider = ProgressServiceProvider._();

final class ProgressServiceProvider
    extends
        $FunctionalProvider<ProgressService, ProgressService, ProgressService>
    with $Provider<ProgressService> {
  ProgressServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressServiceHash();

  @$internal
  @override
  $ProviderElement<ProgressService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProgressService create(Ref ref) {
    return progressService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgressService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgressService>(value),
    );
  }
}

String _$progressServiceHash() => r'add41ef57e8a527547b53ff176017edc5e3bc0a7';
