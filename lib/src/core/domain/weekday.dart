/// Representa un día de la semana según ISO-8601 (Lunes = 1, Domingo = 7).
enum Weekday {
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  const Weekday(this.isoValue);

  /// Valor entero ISO-8601 (1 = lunes, 7 = domingo).
  final int isoValue;

  /// Máscara de bits para persistencia (bit 0 = lunes ... bit 6 = domingo).
  int get mask => 1 << (isoValue - 1);

  /// Obtiene el día de la semana correspondiente al valor ISO (1..7).
  static Weekday fromIso(int iso) {
    return Weekday.values.firstWhere(
      (w) => w.isoValue == iso,
      orElse: () =>
          throw ArgumentError('Valor ISO de día de la semana inválido: $iso'),
    );
  }

  /// Obtiene el día de la semana de un [DateTime].
  static Weekday fromDateTime(DateTime dt) => fromIso(dt.weekday);

  /// Convierte una máscara de bits a un conjunto de días de la semana.
  static Set<Weekday> fromMask(int mask) {
    final result = <Weekday>{};
    for (final day in Weekday.values) {
      if ((mask & day.mask) != 0) {
        result.add(day);
      }
    }
    return result;
  }

  /// Convierte un conjunto de días de la semana a su máscara de bits.
  static int toMask(Set<Weekday> days) {
    var mask = 0;
    for (final day in days) {
      mask |= day.mask;
    }
    return mask;
  }
}
