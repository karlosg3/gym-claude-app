// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_event_bus.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del bus de eventos de la aplicación.

@ProviderFor(appEventBus)
final appEventBusProvider = AppEventBusProvider._();

/// Proveedor del bus de eventos de la aplicación.

final class AppEventBusProvider
    extends $FunctionalProvider<AppEventBus, AppEventBus, AppEventBus>
    with $Provider<AppEventBus> {
  /// Proveedor del bus de eventos de la aplicación.
  AppEventBusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appEventBusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appEventBusHash();

  @$internal
  @override
  $ProviderElement<AppEventBus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppEventBus create(Ref ref) {
    return appEventBus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppEventBus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppEventBus>(value),
    );
  }
}

String _$appEventBusHash() => r'528054a1e8fe7f2470020f268b3f0b2d73cc71b8';
