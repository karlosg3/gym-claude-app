/// Resultado de finalizar una sesión.
sealed class FinishOutcome {
  const FinishOutcome();
}

/// La sesión tenía series y quedó guardada como completada.
final class FinishCompleted extends FinishOutcome {
  const FinishCompleted(this.sessionId);

  final int sessionId;
}

/// La sesión no tenía series y se descartó.
final class FinishDiscarded extends FinishOutcome {
  const FinishDiscarded();
}
