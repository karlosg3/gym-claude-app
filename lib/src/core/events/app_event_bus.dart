import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_claude/src/core/events/app_event.dart';

part 'app_event_bus.g.dart';

/// Bus de eventos de la aplicación para desacoplar productores de momentos
/// (servicios) de consumidores reactivos (animaciones, integraciones).
class AppEventBus {
  final StreamController<AppEvent> _controller =
      StreamController<AppEvent>.broadcast();

  /// Flujo global de eventos.
  Stream<AppEvent> get stream => _controller.stream;

  /// Filtra el flujo para un tipo de evento específico.
  Stream<T> on<T extends AppEvent>() =>
      _controller.stream.where((event) => event is T).cast<T>();

  /// Emite un evento en el bus.
  void emit(AppEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  /// Cierra el bus.
  void dispose() {
    _controller.close();
  }
}

/// Proveedor del bus de eventos de la aplicación.
@Riverpod(keepAlive: true)
AppEventBus appEventBus(Ref ref) {
  final bus = AppEventBus();
  ref.onDispose(bus.dispose);
  return bus;
}
