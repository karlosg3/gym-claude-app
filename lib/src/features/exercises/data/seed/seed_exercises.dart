import 'package:gym_claude/src/core/domain/muscle_group.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

/// Definición de un ejercicio inicial para la biblioteca base.
class SeedExerciseItem {
  const SeedExerciseItem({
    required this.name,
    required this.muscleGroup,
    this.unit = WeightUnit.kg,
    this.isBodyweight = false,
    required this.description,
  });

  final String name;
  final MuscleGroup muscleGroup;
  final WeightUnit unit;
  final bool isBodyweight;
  final String description;
}

/// Los 12 ejercicios base según el diseño original (`logica-pantallas.js`).
const List<SeedExerciseItem> initialExercises = [
  SeedExerciseItem(
    name: 'Press de banca',
    muscleGroup: MuscleGroup.chest,
    description:
        'Empuje horizontal básico. Mantén los omóplatos retraídos y baja la barra al pecho con control.',
  ),
  SeedExerciseItem(
    name: 'Press inclinado mancuerna',
    muscleGroup: MuscleGroup.chest,
    description:
        'Énfasis en la porción superior del pectoral. Banco a 30–45°.',
  ),
  SeedExerciseItem(
    name: 'Fondos en paralelas',
    muscleGroup: MuscleGroup.chest,
    isBodyweight: true,
    description:
        'Inclina el torso al frente para cargar más pecho. Peso adicional con cinturón.',
  ),
  SeedExerciseItem(
    name: 'Dominadas',
    muscleGroup: MuscleGroup.back,
    isBodyweight: true,
    description:
        'Agarre prono. Lleva el pecho a la barra y controla la bajada.',
  ),
  SeedExerciseItem(
    name: 'Remo con barra',
    muscleGroup: MuscleGroup.back,
    description:
        'Torso inclinado ~45°. Lleva la barra al abdomen apretando la espalda.',
  ),
  SeedExerciseItem(
    name: 'Sentadilla',
    muscleGroup: MuscleGroup.legs,
    description:
        'Profundidad por debajo de paralelo. Rodillas alineadas con la punta de los pies.',
  ),
  SeedExerciseItem(
    name: 'Peso muerto',
    muscleGroup: MuscleGroup.legs,
    description:
        'Cadera y espalda en posición neutra. Empuja el suelo y bloquea arriba.',
  ),
  SeedExerciseItem(
    name: 'Press militar',
    muscleGroup: MuscleGroup.shoulders,
    description:
        'De pie, core firme. Empuja la barra por encima de la cabeza.',
  ),
  SeedExerciseItem(
    name: 'Curl de bíceps',
    muscleGroup: MuscleGroup.arms,
    unit: WeightUnit.lb,
    description:
        'Codos pegados al torso. Evita el balanceo para aislar el bíceps.',
  ),
  SeedExerciseItem(
    name: 'Elevaciones laterales',
    muscleGroup: MuscleGroup.shoulders,
    unit: WeightUnit.lb,
    description:
        'Sube las mancuernas hasta la línea de los hombros sin impulso.',
  ),
  SeedExerciseItem(
    name: 'Prensa de pierna',
    muscleGroup: MuscleGroup.legs,
    description: 'No bloquees las rodillas arriba. Controla la bajada.',
  ),
  SeedExerciseItem(
    name: 'Zancadas',
    muscleGroup: MuscleGroup.legs,
    description:
        'Paso largo, rodilla trasera cerca del suelo. Alterna piernas.',
  ),
];
