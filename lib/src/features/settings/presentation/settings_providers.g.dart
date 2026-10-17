// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settings)
final settingsProvider = SettingsProvider._();

final class SettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppSettings>,
          AppSettings,
          Stream<AppSettings>
        >
    with $FutureModifier<AppSettings>, $StreamProvider<AppSettings> {
  SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  $StreamProviderElement<AppSettings> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AppSettings> create(Ref ref) {
    return settings(ref);
  }
}

String _$settingsHash() => r'885d2c674a447f4e9f776f1d21bb39ff19a18636';

@ProviderFor(themeColor)
final themeColorProvider = ThemeColorProvider._();

final class ThemeColorProvider
    extends $FunctionalProvider<AppAccentColor, AppAccentColor, AppAccentColor>
    with $Provider<AppAccentColor> {
  ThemeColorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeColorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeColorHash();

  @$internal
  @override
  $ProviderElement<AppAccentColor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppAccentColor create(Ref ref) {
    return themeColor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppAccentColor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppAccentColor>(value),
    );
  }
}

String _$themeColorHash() => r'584da4b38e729dbae7b41ded5fbe68117f4de241';

@ProviderFor(userFirstName)
final userFirstNameProvider = UserFirstNameProvider._();

final class UserFirstNameProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  UserFirstNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userFirstNameProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userFirstNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return userFirstName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$userFirstNameHash() => r'4e360c3caface2af30fc1c6d32104fd373eb789b';

@ProviderFor(userInitial)
final userInitialProvider = UserInitialProvider._();

final class UserInitialProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  UserInitialProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userInitialProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userInitialHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return userInitial(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$userInitialHash() => r'02a4dd72bb05f61809cf5e92c67b2619dd3d5b58';

@ProviderFor(defaultUnit)
final defaultUnitProvider = DefaultUnitProvider._();

final class DefaultUnitProvider
    extends $FunctionalProvider<WeightUnit, WeightUnit, WeightUnit>
    with $Provider<WeightUnit> {
  DefaultUnitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'defaultUnitProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$defaultUnitHash();

  @$internal
  @override
  $ProviderElement<WeightUnit> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WeightUnit create(Ref ref) {
    return defaultUnit(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeightUnit value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeightUnit>(value),
    );
  }
}

String _$defaultUnitHash() => r'aec1dac5ccdc3fb647a7cc79eac45c23a48e093a';

@ProviderFor(weeklyGoal)
final weeklyGoalProvider = WeeklyGoalProvider._();

final class WeeklyGoalProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  WeeklyGoalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyGoalProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyGoalHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return weeklyGoal(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$weeklyGoalHash() => r'5a6e2516ddb67229a3983899dcd39b5f0b1392a5';

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

final class SettingsControllerProvider
    extends $AsyncNotifierProvider<SettingsController, void> {
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();
}

String _$settingsControllerHash() =>
    r'a8d0679976b0f7f80dd32fa47bb1d9b203574589';

abstract class _$SettingsController extends $AsyncNotifier<void> {
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
