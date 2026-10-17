// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del reloj del sistema.
/// Puede sobreescribirse en tests con `Clock.fixed(...)`.

@ProviderFor(clock)
final clockProvider = ClockProvider._();

/// Proveedor del reloj del sistema.
/// Puede sobreescribirse en tests con `Clock.fixed(...)`.

final class ClockProvider extends $FunctionalProvider<Clock, Clock, Clock>
    with $Provider<Clock> {
  /// Proveedor del reloj del sistema.
  /// Puede sobreescribirse en tests con `Clock.fixed(...)`.
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $ProviderElement<Clock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Clock create(Ref ref) {
    return clock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Clock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Clock>(value),
    );
  }
}

String _$clockHash() => r'ab1b070f4e3c5cfd2fc61060b66d07b79c115c85';

/// Proveedor que expone la fecha de hoy [LocalDate] según el [clockProvider].
/// Toda regla que dependa del día actual debe observar este provider.

@ProviderFor(today)
final todayProvider = TodayProvider._();

/// Proveedor que expone la fecha de hoy [LocalDate] según el [clockProvider].
/// Toda regla que dependa del día actual debe observar este provider.

final class TodayProvider
    extends $FunctionalProvider<LocalDate, LocalDate, LocalDate>
    with $Provider<LocalDate> {
  /// Proveedor que expone la fecha de hoy [LocalDate] según el [clockProvider].
  /// Toda regla que dependa del día actual debe observar este provider.
  TodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayHash();

  @$internal
  @override
  $ProviderElement<LocalDate> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDate create(Ref ref) {
    return today(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDate>(value),
    );
  }
}

String _$todayHash() => r'ce98ed9cc4ee9267eb9a2399bde8b55e49e335e3';
