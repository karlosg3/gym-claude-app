import 'package:clock/clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_claude/src/core/domain/local_date.dart';

part 'clock_provider.g.dart';

/// Proveedor del reloj del sistema.
/// Puede sobreescribirse en tests con `Clock.fixed(...)`.
@Riverpod(keepAlive: true)
Clock clock(Ref ref) {
  return const Clock();
}

/// Proveedor que expone la fecha de hoy [LocalDate] según el [clockProvider].
/// Toda regla que dependa del día actual debe observar este provider.
@riverpod
LocalDate today(Ref ref) {
  final c = ref.watch(clockProvider);
  return LocalDate.of(c.now());
}
