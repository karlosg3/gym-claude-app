// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class Routines extends Table with TableInfo<Routines, RoutineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Routines(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(name)) BETWEEN 1 AND 60)',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'\'',
    defaultValue: const CustomExpression('\'\''),
  );
  late final GeneratedColumnWithTypeConverter<Set<Weekday>, int> activeDays =
      GeneratedColumn<int>(
        'active_days',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL CHECK (active_days BETWEEN 1 AND 127)',
      ).withConverter<Set<Weekday>>(Routines.$converteractiveDays);
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    activeDays,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      activeDays: Routines.$converteractiveDays.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}active_days'],
        )!,
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  Routines createAlias(String alias) {
    return Routines(attachedDatabase, alias);
  }

  static TypeConverter<Set<Weekday>, int> $converteractiveDays =
      const WeekdaySetConverter();
  @override
  bool get dontWriteConstraints => true;
}

class RoutineRow extends DataClass implements Insertable<RoutineRow> {
  final int id;
  final String name;
  final String description;
  final Set<Weekday> activeDays;
  final int sortOrder;
  final DateTime createdAt;
  const RoutineRow({
    required this.id,
    required this.name,
    required this.description,
    required this.activeDays,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    {
      map['active_days'] = Variable<int>(
        Routines.$converteractiveDays.toSql(activeDays),
      );
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      activeDays: Value(activeDays),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory RoutineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      activeDays: serializer.fromJson<Set<Weekday>>(json['active_days']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'active_days': serializer.toJson<Set<Weekday>>(activeDays),
      'sort_order': serializer.toJson<int>(sortOrder),
      'created_at': serializer.toJson<DateTime>(createdAt),
    };
  }

  RoutineRow copyWith({
    int? id,
    String? name,
    String? description,
    Set<Weekday>? activeDays,
    int? sortOrder,
    DateTime? createdAt,
  }) => RoutineRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    activeDays: activeDays ?? this.activeDays,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  RoutineRow copyWithCompanion(RoutinesCompanion data) {
    return RoutineRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      activeDays: data.activeDays.present
          ? data.activeDays.value
          : this.activeDays,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('activeDays: $activeDays, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, activeDays, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.activeDays == this.activeDays &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class RoutinesCompanion extends UpdateCompanion<RoutineRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<Set<Weekday>> activeDays;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.activeDays = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required Set<Weekday> activeDays,
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       activeDays = Value(activeDays),
       createdAt = Value(createdAt);
  static Insertable<RoutineRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? activeDays,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (activeDays != null) 'active_days': activeDays,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RoutinesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<Set<Weekday>>? activeDays,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      activeDays: activeDays ?? this.activeDays,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (activeDays.present) {
      map['active_days'] = Variable<int>(
        Routines.$converteractiveDays.toSql(activeDays.value),
      );
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('activeDays: $activeDays, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class Exercises extends Table with TableInfo<Exercises, ExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Exercises(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL COLLATE NOCASE CHECK (length(trim(name)) BETWEEN 1 AND 80)',
  );
  late final GeneratedColumnWithTypeConverter<MuscleGroup, String> muscleGroup =
      GeneratedColumn<String>(
        'muscle_group',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<MuscleGroup>(Exercises.$convertermuscleGroup);
  late final GeneratedColumnWithTypeConverter<WeightUnit, String> unit =
      GeneratedColumn<String>(
        'unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<WeightUnit>(Exercises.$converterunit);
  static const VerificationMeta _isBodyweightMeta = const VerificationMeta(
    'isBodyweight',
  );
  late final GeneratedColumn<bool> isBodyweight = GeneratedColumn<bool>(
    'is_bodyweight',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'\'',
    defaultValue: const CustomExpression('\'\''),
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    muscleGroup,
    unit,
    isBodyweight,
    description,
    archivedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_bodyweight')) {
      context.handle(
        _isBodyweightMeta,
        isBodyweight.isAcceptableOrUnknown(
          data['is_bodyweight']!,
          _isBodyweightMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      muscleGroup: Exercises.$convertermuscleGroup.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}muscle_group'],
        )!,
      ),
      unit: Exercises.$converterunit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unit'],
        )!,
      ),
      isBodyweight: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_bodyweight'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  Exercises createAlias(String alias) {
    return Exercises(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MuscleGroup, String, String> $convertermuscleGroup =
      const EnumNameConverter<MuscleGroup>(MuscleGroup.values);
  static JsonTypeConverter2<WeightUnit, String, String> $converterunit =
      const EnumNameConverter<WeightUnit>(WeightUnit.values);
  @override
  bool get dontWriteConstraints => true;
}

class ExerciseRow extends DataClass implements Insertable<ExerciseRow> {
  final int id;
  final String name;
  final MuscleGroup muscleGroup;
  final WeightUnit unit;
  final bool isBodyweight;
  final String description;
  final DateTime? archivedAt;
  final DateTime createdAt;
  const ExerciseRow({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.unit,
    required this.isBodyweight,
    required this.description,
    this.archivedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['muscle_group'] = Variable<String>(
        Exercises.$convertermuscleGroup.toSql(muscleGroup),
      );
    }
    {
      map['unit'] = Variable<String>(Exercises.$converterunit.toSql(unit));
    }
    map['is_bodyweight'] = Variable<bool>(isBodyweight);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      muscleGroup: Value(muscleGroup),
      unit: Value(unit),
      isBodyweight: Value(isBodyweight),
      description: Value(description),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
    );
  }

  factory ExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      muscleGroup: Exercises.$convertermuscleGroup.fromJson(
        serializer.fromJson<String>(json['muscle_group']),
      ),
      unit: Exercises.$converterunit.fromJson(
        serializer.fromJson<String>(json['unit']),
      ),
      isBodyweight: serializer.fromJson<bool>(json['is_bodyweight']),
      description: serializer.fromJson<String>(json['description']),
      archivedAt: serializer.fromJson<DateTime?>(json['archived_at']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'muscle_group': serializer.toJson<String>(
        Exercises.$convertermuscleGroup.toJson(muscleGroup),
      ),
      'unit': serializer.toJson<String>(Exercises.$converterunit.toJson(unit)),
      'is_bodyweight': serializer.toJson<bool>(isBodyweight),
      'description': serializer.toJson<String>(description),
      'archived_at': serializer.toJson<DateTime?>(archivedAt),
      'created_at': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExerciseRow copyWith({
    int? id,
    String? name,
    MuscleGroup? muscleGroup,
    WeightUnit? unit,
    bool? isBodyweight,
    String? description,
    Value<DateTime?> archivedAt = const Value.absent(),
    DateTime? createdAt,
  }) => ExerciseRow(
    id: id ?? this.id,
    name: name ?? this.name,
    muscleGroup: muscleGroup ?? this.muscleGroup,
    unit: unit ?? this.unit,
    isBodyweight: isBodyweight ?? this.isBodyweight,
    description: description ?? this.description,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  ExerciseRow copyWithCompanion(ExercisesCompanion data) {
    return ExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      unit: data.unit.present ? data.unit.value : this.unit,
      isBodyweight: data.isBodyweight.present
          ? data.isBodyweight.value
          : this.isBodyweight,
      description: data.description.present
          ? data.description.value
          : this.description,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('unit: $unit, ')
          ..write('isBodyweight: $isBodyweight, ')
          ..write('description: $description, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    muscleGroup,
    unit,
    isBodyweight,
    description,
    archivedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.muscleGroup == this.muscleGroup &&
          other.unit == this.unit &&
          other.isBodyweight == this.isBodyweight &&
          other.description == this.description &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<MuscleGroup> muscleGroup;
  final Value<WeightUnit> unit;
  final Value<bool> isBodyweight;
  final Value<String> description;
  final Value<DateTime?> archivedAt;
  final Value<DateTime> createdAt;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.unit = const Value.absent(),
    this.isBodyweight = const Value.absent(),
    this.description = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required MuscleGroup muscleGroup,
    required WeightUnit unit,
    this.isBodyweight = const Value.absent(),
    this.description = const Value.absent(),
    this.archivedAt = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       muscleGroup = Value(muscleGroup),
       unit = Value(unit),
       createdAt = Value(createdAt);
  static Insertable<ExerciseRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? muscleGroup,
    Expression<String>? unit,
    Expression<bool>? isBodyweight,
    Expression<String>? description,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (unit != null) 'unit': unit,
      if (isBodyweight != null) 'is_bodyweight': isBodyweight,
      if (description != null) 'description': description,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExercisesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<MuscleGroup>? muscleGroup,
    Value<WeightUnit>? unit,
    Value<bool>? isBodyweight,
    Value<String>? description,
    Value<DateTime?>? archivedAt,
    Value<DateTime>? createdAt,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      unit: unit ?? this.unit,
      isBodyweight: isBodyweight ?? this.isBodyweight,
      description: description ?? this.description,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(
        Exercises.$convertermuscleGroup.toSql(muscleGroup.value),
      );
    }
    if (unit.present) {
      map['unit'] = Variable<String>(
        Exercises.$converterunit.toSql(unit.value),
      );
    }
    if (isBodyweight.present) {
      map['is_bodyweight'] = Variable<bool>(isBodyweight.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('unit: $unit, ')
          ..write('isBodyweight: $isBodyweight, ')
          ..write('description: $description, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class RoutineItems extends Table with TableInfo<RoutineItems, RoutineItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RoutineItems(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES routines(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (weekday BETWEEN 1 AND 7)',
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES exercises(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (position >= 0)',
  );
  static const VerificationMeta _targetSetsMeta = const VerificationMeta(
    'targetSets',
  );
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
    'target_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 3 CHECK (target_sets BETWEEN 1 AND 10)',
    defaultValue: const CustomExpression('3'),
  );
  static const VerificationMeta _targetRepsMeta = const VerificationMeta(
    'targetReps',
  );
  late final GeneratedColumn<int> targetReps = GeneratedColumn<int>(
    'target_reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT 10 CHECK (target_reps IS NULL OR target_reps BETWEEN 1 AND 50)',
    defaultValue: const CustomExpression('10'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    weekday,
    exerciseId,
    position,
    targetSets,
    targetReps,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdayMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('target_sets')) {
      context.handle(
        _targetSetsMeta,
        targetSets.isAcceptableOrUnknown(data['target_sets']!, _targetSetsMeta),
      );
    }
    if (data.containsKey('target_reps')) {
      context.handle(
        _targetRepsMeta,
        targetReps.isAcceptableOrUnknown(data['target_reps']!, _targetRepsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {routineId, weekday, exerciseId},
  ];
  @override
  RoutineItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      )!,
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      targetSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_sets'],
      )!,
      targetReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_reps'],
      ),
    );
  }

  @override
  RoutineItems createAlias(String alias) {
    return RoutineItems(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(routine_id, weekday, exercise_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class RoutineItemRow extends DataClass implements Insertable<RoutineItemRow> {
  final int id;
  final int routineId;
  final int weekday;
  final int exerciseId;
  final int position;
  final int targetSets;
  final int? targetReps;
  const RoutineItemRow({
    required this.id,
    required this.routineId,
    required this.weekday,
    required this.exerciseId,
    required this.position,
    required this.targetSets,
    this.targetReps,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['routine_id'] = Variable<int>(routineId);
    map['weekday'] = Variable<int>(weekday);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['position'] = Variable<int>(position);
    map['target_sets'] = Variable<int>(targetSets);
    if (!nullToAbsent || targetReps != null) {
      map['target_reps'] = Variable<int>(targetReps);
    }
    return map;
  }

  RoutineItemsCompanion toCompanion(bool nullToAbsent) {
    return RoutineItemsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      weekday: Value(weekday),
      exerciseId: Value(exerciseId),
      position: Value(position),
      targetSets: Value(targetSets),
      targetReps: targetReps == null && nullToAbsent
          ? const Value.absent()
          : Value(targetReps),
    );
  }

  factory RoutineItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineItemRow(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<int>(json['routine_id']),
      weekday: serializer.fromJson<int>(json['weekday']),
      exerciseId: serializer.fromJson<int>(json['exercise_id']),
      position: serializer.fromJson<int>(json['position']),
      targetSets: serializer.fromJson<int>(json['target_sets']),
      targetReps: serializer.fromJson<int?>(json['target_reps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routine_id': serializer.toJson<int>(routineId),
      'weekday': serializer.toJson<int>(weekday),
      'exercise_id': serializer.toJson<int>(exerciseId),
      'position': serializer.toJson<int>(position),
      'target_sets': serializer.toJson<int>(targetSets),
      'target_reps': serializer.toJson<int?>(targetReps),
    };
  }

  RoutineItemRow copyWith({
    int? id,
    int? routineId,
    int? weekday,
    int? exerciseId,
    int? position,
    int? targetSets,
    Value<int?> targetReps = const Value.absent(),
  }) => RoutineItemRow(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    weekday: weekday ?? this.weekday,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
    targetSets: targetSets ?? this.targetSets,
    targetReps: targetReps.present ? targetReps.value : this.targetReps,
  );
  RoutineItemRow copyWithCompanion(RoutineItemsCompanion data) {
    return RoutineItemRow(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
      targetSets: data.targetSets.present
          ? data.targetSets.value
          : this.targetSets,
      targetReps: data.targetReps.present
          ? data.targetReps.value
          : this.targetReps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineItemRow(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('weekday: $weekday, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetReps: $targetReps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    weekday,
    exerciseId,
    position,
    targetSets,
    targetReps,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineItemRow &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.weekday == this.weekday &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position &&
          other.targetSets == this.targetSets &&
          other.targetReps == this.targetReps);
}

class RoutineItemsCompanion extends UpdateCompanion<RoutineItemRow> {
  final Value<int> id;
  final Value<int> routineId;
  final Value<int> weekday;
  final Value<int> exerciseId;
  final Value<int> position;
  final Value<int> targetSets;
  final Value<int?> targetReps;
  const RoutineItemsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.weekday = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.targetReps = const Value.absent(),
  });
  RoutineItemsCompanion.insert({
    this.id = const Value.absent(),
    required int routineId,
    required int weekday,
    required int exerciseId,
    required int position,
    this.targetSets = const Value.absent(),
    this.targetReps = const Value.absent(),
  }) : routineId = Value(routineId),
       weekday = Value(weekday),
       exerciseId = Value(exerciseId),
       position = Value(position);
  static Insertable<RoutineItemRow> custom({
    Expression<int>? id,
    Expression<int>? routineId,
    Expression<int>? weekday,
    Expression<int>? exerciseId,
    Expression<int>? position,
    Expression<int>? targetSets,
    Expression<int>? targetReps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (weekday != null) 'weekday': weekday,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (targetSets != null) 'target_sets': targetSets,
      if (targetReps != null) 'target_reps': targetReps,
    });
  }

  RoutineItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? routineId,
    Value<int>? weekday,
    Value<int>? exerciseId,
    Value<int>? position,
    Value<int>? targetSets,
    Value<int?>? targetReps,
  }) {
    return RoutineItemsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      weekday: weekday ?? this.weekday,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      targetSets: targetSets ?? this.targetSets,
      targetReps: targetReps ?? this.targetReps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (targetSets.present) {
      map['target_sets'] = Variable<int>(targetSets.value);
    }
    if (targetReps.present) {
      map['target_reps'] = Variable<int>(targetReps.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineItemsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('weekday: $weekday, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetReps: $targetReps')
          ..write(')'))
        .toString();
  }
}

class Settings extends Table with TableInfo<Settings, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Settings(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY CHECK (id = 1)',
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'\'',
    defaultValue: const CustomExpression('\'\''),
  );
  static const VerificationMeta _weeklyGoalMeta = const VerificationMeta(
    'weeklyGoal',
  );
  late final GeneratedColumn<int> weeklyGoal = GeneratedColumn<int>(
    'weekly_goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 3 CHECK (weekly_goal BETWEEN 1 AND 7)',
    defaultValue: const CustomExpression('3'),
  );
  late final GeneratedColumnWithTypeConverter<WeightUnit, String> defaultUnit =
      GeneratedColumn<String>(
        'default_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        $customConstraints: 'NOT NULL DEFAULT \'kg\'',
        defaultValue: const CustomExpression('\'kg\''),
      ).withConverter<WeightUnit>(Settings.$converterdefaultUnit);
  late final GeneratedColumnWithTypeConverter<AppAccentColor, String>
  themeColor = GeneratedColumn<String>(
    'theme_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'orange\'',
    defaultValue: const CustomExpression('\'orange\''),
  ).withConverter<AppAccentColor>(Settings.$converterthemeColor);
  static const VerificationMeta _workoutReminderEnabledMeta =
      const VerificationMeta('workoutReminderEnabled');
  late final GeneratedColumn<bool> workoutReminderEnabled =
      GeneratedColumn<bool>(
        'workout_reminder_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        $customConstraints: 'NOT NULL DEFAULT 1',
        defaultValue: const CustomExpression('1'),
      );
  static const VerificationMeta _reminderMinutesMeta = const VerificationMeta(
    'reminderMinutes',
  );
  late final GeneratedColumn<int> reminderMinutes = GeneratedColumn<int>(
    'reminder_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 1110 CHECK (reminder_minutes BETWEEN 0 AND 1439)',
    defaultValue: const CustomExpression('1110'),
  );
  static const VerificationMeta _streakRiskEnabledMeta = const VerificationMeta(
    'streakRiskEnabled',
  );
  late final GeneratedColumn<bool> streakRiskEnabled = GeneratedColumn<bool>(
    'streak_risk_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1',
    defaultValue: const CustomExpression('1'),
  );
  static const VerificationMeta _recordsEnabledMeta = const VerificationMeta(
    'recordsEnabled',
  );
  late final GeneratedColumn<bool> recordsEnabled = GeneratedColumn<bool>(
    'records_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userName,
    weeklyGoal,
    defaultUnit,
    themeColor,
    workoutReminderEnabled,
    reminderMinutes,
    streakRiskEnabled,
    recordsEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    }
    if (data.containsKey('weekly_goal')) {
      context.handle(
        _weeklyGoalMeta,
        weeklyGoal.isAcceptableOrUnknown(data['weekly_goal']!, _weeklyGoalMeta),
      );
    }
    if (data.containsKey('workout_reminder_enabled')) {
      context.handle(
        _workoutReminderEnabledMeta,
        workoutReminderEnabled.isAcceptableOrUnknown(
          data['workout_reminder_enabled']!,
          _workoutReminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_minutes')) {
      context.handle(
        _reminderMinutesMeta,
        reminderMinutes.isAcceptableOrUnknown(
          data['reminder_minutes']!,
          _reminderMinutesMeta,
        ),
      );
    }
    if (data.containsKey('streak_risk_enabled')) {
      context.handle(
        _streakRiskEnabledMeta,
        streakRiskEnabled.isAcceptableOrUnknown(
          data['streak_risk_enabled']!,
          _streakRiskEnabledMeta,
        ),
      );
    }
    if (data.containsKey('records_enabled')) {
      context.handle(
        _recordsEnabledMeta,
        recordsEnabled.isAcceptableOrUnknown(
          data['records_enabled']!,
          _recordsEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      weeklyGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_goal'],
      )!,
      defaultUnit: Settings.$converterdefaultUnit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}default_unit'],
        )!,
      ),
      themeColor: Settings.$converterthemeColor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_color'],
        )!,
      ),
      workoutReminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}workout_reminder_enabled'],
      )!,
      reminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minutes'],
      )!,
      streakRiskEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}streak_risk_enabled'],
      )!,
      recordsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}records_enabled'],
      )!,
    );
  }

  @override
  Settings createAlias(String alias) {
    return Settings(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WeightUnit, String, String> $converterdefaultUnit =
      const EnumNameConverter<WeightUnit>(WeightUnit.values);
  static JsonTypeConverter2<AppAccentColor, String, String>
  $converterthemeColor = const EnumNameConverter<AppAccentColor>(
    AppAccentColor.values,
  );
  @override
  bool get dontWriteConstraints => true;
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final int id;
  final String userName;
  final int weeklyGoal;
  final WeightUnit defaultUnit;
  final AppAccentColor themeColor;
  final bool workoutReminderEnabled;
  final int reminderMinutes;
  final bool streakRiskEnabled;
  final bool recordsEnabled;
  const SettingsRow({
    required this.id,
    required this.userName,
    required this.weeklyGoal,
    required this.defaultUnit,
    required this.themeColor,
    required this.workoutReminderEnabled,
    required this.reminderMinutes,
    required this.streakRiskEnabled,
    required this.recordsEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    map['weekly_goal'] = Variable<int>(weeklyGoal);
    {
      map['default_unit'] = Variable<String>(
        Settings.$converterdefaultUnit.toSql(defaultUnit),
      );
    }
    {
      map['theme_color'] = Variable<String>(
        Settings.$converterthemeColor.toSql(themeColor),
      );
    }
    map['workout_reminder_enabled'] = Variable<bool>(workoutReminderEnabled);
    map['reminder_minutes'] = Variable<int>(reminderMinutes);
    map['streak_risk_enabled'] = Variable<bool>(streakRiskEnabled);
    map['records_enabled'] = Variable<bool>(recordsEnabled);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      userName: Value(userName),
      weeklyGoal: Value(weeklyGoal),
      defaultUnit: Value(defaultUnit),
      themeColor: Value(themeColor),
      workoutReminderEnabled: Value(workoutReminderEnabled),
      reminderMinutes: Value(reminderMinutes),
      streakRiskEnabled: Value(streakRiskEnabled),
      recordsEnabled: Value(recordsEnabled),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['user_name']),
      weeklyGoal: serializer.fromJson<int>(json['weekly_goal']),
      defaultUnit: Settings.$converterdefaultUnit.fromJson(
        serializer.fromJson<String>(json['default_unit']),
      ),
      themeColor: Settings.$converterthemeColor.fromJson(
        serializer.fromJson<String>(json['theme_color']),
      ),
      workoutReminderEnabled: serializer.fromJson<bool>(
        json['workout_reminder_enabled'],
      ),
      reminderMinutes: serializer.fromJson<int>(json['reminder_minutes']),
      streakRiskEnabled: serializer.fromJson<bool>(json['streak_risk_enabled']),
      recordsEnabled: serializer.fromJson<bool>(json['records_enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user_name': serializer.toJson<String>(userName),
      'weekly_goal': serializer.toJson<int>(weeklyGoal),
      'default_unit': serializer.toJson<String>(
        Settings.$converterdefaultUnit.toJson(defaultUnit),
      ),
      'theme_color': serializer.toJson<String>(
        Settings.$converterthemeColor.toJson(themeColor),
      ),
      'workout_reminder_enabled': serializer.toJson<bool>(
        workoutReminderEnabled,
      ),
      'reminder_minutes': serializer.toJson<int>(reminderMinutes),
      'streak_risk_enabled': serializer.toJson<bool>(streakRiskEnabled),
      'records_enabled': serializer.toJson<bool>(recordsEnabled),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? userName,
    int? weeklyGoal,
    WeightUnit? defaultUnit,
    AppAccentColor? themeColor,
    bool? workoutReminderEnabled,
    int? reminderMinutes,
    bool? streakRiskEnabled,
    bool? recordsEnabled,
  }) => SettingsRow(
    id: id ?? this.id,
    userName: userName ?? this.userName,
    weeklyGoal: weeklyGoal ?? this.weeklyGoal,
    defaultUnit: defaultUnit ?? this.defaultUnit,
    themeColor: themeColor ?? this.themeColor,
    workoutReminderEnabled:
        workoutReminderEnabled ?? this.workoutReminderEnabled,
    reminderMinutes: reminderMinutes ?? this.reminderMinutes,
    streakRiskEnabled: streakRiskEnabled ?? this.streakRiskEnabled,
    recordsEnabled: recordsEnabled ?? this.recordsEnabled,
  );
  SettingsRow copyWithCompanion(SettingsCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      userName: data.userName.present ? data.userName.value : this.userName,
      weeklyGoal: data.weeklyGoal.present
          ? data.weeklyGoal.value
          : this.weeklyGoal,
      defaultUnit: data.defaultUnit.present
          ? data.defaultUnit.value
          : this.defaultUnit,
      themeColor: data.themeColor.present
          ? data.themeColor.value
          : this.themeColor,
      workoutReminderEnabled: data.workoutReminderEnabled.present
          ? data.workoutReminderEnabled.value
          : this.workoutReminderEnabled,
      reminderMinutes: data.reminderMinutes.present
          ? data.reminderMinutes.value
          : this.reminderMinutes,
      streakRiskEnabled: data.streakRiskEnabled.present
          ? data.streakRiskEnabled.value
          : this.streakRiskEnabled,
      recordsEnabled: data.recordsEnabled.present
          ? data.recordsEnabled.value
          : this.recordsEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('weeklyGoal: $weeklyGoal, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('themeColor: $themeColor, ')
          ..write('workoutReminderEnabled: $workoutReminderEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('streakRiskEnabled: $streakRiskEnabled, ')
          ..write('recordsEnabled: $recordsEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userName,
    weeklyGoal,
    defaultUnit,
    themeColor,
    workoutReminderEnabled,
    reminderMinutes,
    streakRiskEnabled,
    recordsEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.weeklyGoal == this.weeklyGoal &&
          other.defaultUnit == this.defaultUnit &&
          other.themeColor == this.themeColor &&
          other.workoutReminderEnabled == this.workoutReminderEnabled &&
          other.reminderMinutes == this.reminderMinutes &&
          other.streakRiskEnabled == this.streakRiskEnabled &&
          other.recordsEnabled == this.recordsEnabled);
}

class SettingsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> userName;
  final Value<int> weeklyGoal;
  final Value<WeightUnit> defaultUnit;
  final Value<AppAccentColor> themeColor;
  final Value<bool> workoutReminderEnabled;
  final Value<int> reminderMinutes;
  final Value<bool> streakRiskEnabled;
  final Value<bool> recordsEnabled;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.weeklyGoal = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.workoutReminderEnabled = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.streakRiskEnabled = const Value.absent(),
    this.recordsEnabled = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.weeklyGoal = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.workoutReminderEnabled = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.streakRiskEnabled = const Value.absent(),
    this.recordsEnabled = const Value.absent(),
  });
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? userName,
    Expression<int>? weeklyGoal,
    Expression<String>? defaultUnit,
    Expression<String>? themeColor,
    Expression<bool>? workoutReminderEnabled,
    Expression<int>? reminderMinutes,
    Expression<bool>? streakRiskEnabled,
    Expression<bool>? recordsEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (weeklyGoal != null) 'weekly_goal': weeklyGoal,
      if (defaultUnit != null) 'default_unit': defaultUnit,
      if (themeColor != null) 'theme_color': themeColor,
      if (workoutReminderEnabled != null)
        'workout_reminder_enabled': workoutReminderEnabled,
      if (reminderMinutes != null) 'reminder_minutes': reminderMinutes,
      if (streakRiskEnabled != null) 'streak_risk_enabled': streakRiskEnabled,
      if (recordsEnabled != null) 'records_enabled': recordsEnabled,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? userName,
    Value<int>? weeklyGoal,
    Value<WeightUnit>? defaultUnit,
    Value<AppAccentColor>? themeColor,
    Value<bool>? workoutReminderEnabled,
    Value<int>? reminderMinutes,
    Value<bool>? streakRiskEnabled,
    Value<bool>? recordsEnabled,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      weeklyGoal: weeklyGoal ?? this.weeklyGoal,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      themeColor: themeColor ?? this.themeColor,
      workoutReminderEnabled:
          workoutReminderEnabled ?? this.workoutReminderEnabled,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      streakRiskEnabled: streakRiskEnabled ?? this.streakRiskEnabled,
      recordsEnabled: recordsEnabled ?? this.recordsEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (weeklyGoal.present) {
      map['weekly_goal'] = Variable<int>(weeklyGoal.value);
    }
    if (defaultUnit.present) {
      map['default_unit'] = Variable<String>(
        Settings.$converterdefaultUnit.toSql(defaultUnit.value),
      );
    }
    if (themeColor.present) {
      map['theme_color'] = Variable<String>(
        Settings.$converterthemeColor.toSql(themeColor.value),
      );
    }
    if (workoutReminderEnabled.present) {
      map['workout_reminder_enabled'] = Variable<bool>(
        workoutReminderEnabled.value,
      );
    }
    if (reminderMinutes.present) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes.value);
    }
    if (streakRiskEnabled.present) {
      map['streak_risk_enabled'] = Variable<bool>(streakRiskEnabled.value);
    }
    if (recordsEnabled.present) {
      map['records_enabled'] = Variable<bool>(recordsEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('weeklyGoal: $weeklyGoal, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('themeColor: $themeColor, ')
          ..write('workoutReminderEnabled: $workoutReminderEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('streakRiskEnabled: $streakRiskEnabled, ')
          ..write('recordsEnabled: $recordsEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final Routines routines = Routines(this);
  late final Exercises exercises = Exercises(this);
  late final RoutineItems routineItems = RoutineItems(this);
  late final Index routineItemsDay = Index(
    'routine_items_day',
    'CREATE INDEX routine_items_day ON routine_items (routine_id, weekday, position)',
  );
  late final Index routineItemsExercise = Index(
    'routine_items_exercise',
    'CREATE INDEX routine_items_exercise ON routine_items (exercise_id)',
  );
  late final Index exercisesActiveName = Index(
    'exercises_active_name',
    'CREATE UNIQUE INDEX exercises_active_name ON exercises (name) WHERE archived_at IS NULL',
  );
  late final Settings settings = Settings(this);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final ExercisesDao exercisesDao = ExercisesDao(this as AppDatabase);
  late final RoutinesDao routinesDao = RoutinesDao(this as AppDatabase);
  Selectable<WatchAllWithItemsResult> watchAllWithItems() {
    return customSelect(
      'SELECT"r"."id" AS "nested_0.id", "r"."name" AS "nested_0.name", "r"."description" AS "nested_0.description", "r"."active_days" AS "nested_0.active_days", "r"."sort_order" AS "nested_0.sort_order", "r"."created_at" AS "nested_0.created_at","ri"."id" AS "nested_1.id", "ri"."routine_id" AS "nested_1.routine_id", "ri"."weekday" AS "nested_1.weekday", "ri"."exercise_id" AS "nested_1.exercise_id", "ri"."position" AS "nested_1.position", "ri"."target_sets" AS "nested_1.target_sets", "ri"."target_reps" AS "nested_1.target_reps", e.id AS exercise_id, e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM routines AS r LEFT JOIN routine_items AS ri ON ri.routine_id = r.id LEFT JOIN exercises AS e ON e.id = ri.exercise_id ORDER BY r.sort_order, r.id, ri.weekday, ri.position',
      variables: [],
      readsFrom: {this.exercises, this.routines, this.routineItems},
    ).asyncMap(
      (QueryRow row) async => WatchAllWithItemsResult(
        r: await this.routines.mapFromRow(row, tablePrefix: 'nested_0'),
        ri: await this.routineItems.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_1',
        ),
        exerciseId: row.readNullable<int>('exercise_id'),
        exerciseName: row.readNullable<String>('exercise_name'),
        exerciseGroup: NullAwareTypeConverter.wrapFromSql(
          Exercises.$convertermuscleGroup,
          row.readNullable<String>('exercise_group'),
        ),
        exerciseUnit: NullAwareTypeConverter.wrapFromSql(
          Exercises.$converterunit,
          row.readNullable<String>('exercise_unit'),
        ),
      ),
    );
  }

  Selectable<int> watchPlannedWeekdays() {
    return customSelect(
      'SELECT DISTINCT weekday FROM routine_items',
      variables: [],
      readsFrom: {this.routineItems},
    ).map((QueryRow row) => row.read<int>('weekday'));
  }

  Selectable<DateTime?> watchPlanStart() {
    return customSelect(
      'SELECT MIN(created_at) AS _c0 FROM routines',
      variables: [],
      readsFrom: {this.routines},
    ).map((QueryRow row) => row.readNullable<DateTime>('_c0'));
  }

  Selectable<RoutineRow> watchForWeekday(int weekday) {
    return customSelect(
      'SELECT * FROM routines WHERE EXISTS (SELECT 1 AS _c0 FROM routine_items AS ri WHERE ri.routine_id = routines.id AND ri.weekday = ?1) ORDER BY sort_order, id',
      variables: [Variable<int>(weekday)],
      readsFrom: {this.routines, this.routineItems},
    ).asyncMap(this.routines.mapFromRow);
  }

  Selectable<RoutineRow> getRoutineById(int id) {
    return customSelect(
      'SELECT * FROM routines WHERE id = ?1',
      variables: [Variable<int>(id)],
      readsFrom: {this.routines},
    ).asyncMap(this.routines.mapFromRow);
  }

  Selectable<GetItemsByRoutineAndDayResult> getItemsByRoutineAndDay(
    int routineId,
    int weekday,
  ) {
    return customSelect(
      'SELECT"ri"."id" AS "nested_0.id", "ri"."routine_id" AS "nested_0.routine_id", "ri"."weekday" AS "nested_0.weekday", "ri"."exercise_id" AS "nested_0.exercise_id", "ri"."position" AS "nested_0.position", "ri"."target_sets" AS "nested_0.target_sets", "ri"."target_reps" AS "nested_0.target_reps", e.id AS exercise_id, e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM routine_items AS ri JOIN exercises AS e ON e.id = ri.exercise_id WHERE ri.routine_id = ?1 AND ri.weekday = ?2 ORDER BY ri.position',
      variables: [Variable<int>(routineId), Variable<int>(weekday)],
      readsFrom: {this.exercises, this.routineItems},
    ).asyncMap(
      (QueryRow row) async => GetItemsByRoutineAndDayResult(
        ri: await this.routineItems.mapFromRow(row, tablePrefix: 'nested_0'),
        exerciseId: row.read<int>('exercise_id'),
        exerciseName: row.read<String>('exercise_name'),
        exerciseGroup: Exercises.$convertermuscleGroup.fromSql(
          row.read<String>('exercise_group'),
        ),
        exerciseUnit: Exercises.$converterunit.fromSql(
          row.read<String>('exercise_unit'),
        ),
      ),
    );
  }

  Selectable<ExerciseRow> watchAllActive() {
    return customSelect(
      'SELECT * FROM exercises WHERE archived_at IS NULL ORDER BY name',
      variables: [],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<ExerciseRow> watchByGroup(MuscleGroup group) {
    return customSelect(
      'SELECT * FROM exercises WHERE archived_at IS NULL AND muscle_group = ?1 ORDER BY name',
      variables: [
        Variable<String>(Exercises.$convertermuscleGroup.toSql(group)),
      ],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<ExerciseRow> findByName(String name) {
    return customSelect(
      'SELECT * FROM exercises WHERE name = ?1',
      variables: [Variable<String>(name)],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<ExerciseRow> getById(int id) {
    return customSelect(
      'SELECT * FROM exercises WHERE id = ?1',
      variables: [Variable<int>(id)],
      readsFrom: {this.exercises},
    ).asyncMap(this.exercises.mapFromRow);
  }

  Selectable<SettingsRow> watchSettings() {
    return customSelect(
      'SELECT * FROM settings WHERE id = 1',
      variables: [],
      readsFrom: {this.settings},
    ).asyncMap(this.settings.mapFromRow);
  }

  Selectable<SettingsRow> getSettings() {
    return customSelect(
      'SELECT * FROM settings WHERE id = 1',
      variables: [],
      readsFrom: {this.settings},
    ).asyncMap(this.settings.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    routines,
    exercises,
    routineItems,
    routineItemsDay,
    routineItemsExercise,
    exercisesActiveName,
    settings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('routine_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('routine_items', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $RoutinesCreateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  required String name,
  Value<String> description,
  required Set<Weekday> activeDays,
  Value<int> sortOrder,
  required DateTime createdAt,
});
typedef $RoutinesUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<Set<Weekday>> activeDays,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
});

final class $RoutinesReferences
    extends BaseReferences<_$AppDatabase, Routines, RoutineRow> {
  $RoutinesReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<RoutineItems, List<RoutineItemRow>>
  _routineItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineItems,
    aliasName: 'routines__id__routine_items__routine_id',
  );

  $RoutineItemsProcessedTableManager get routineItemsRefs {
    final manager = $RoutineItemsTableManager(
      $_db,
      $_db.routineItems,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $RoutinesFilterComposer extends Composer<_$AppDatabase, Routines> {
  $RoutinesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<Weekday>, Set<Weekday>, int>
  get activeDays => $composableBuilder(
    column: $table.activeDays,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routineItemsRefs(
    Expression<bool> Function($RoutineItemsFilterComposer f) f,
  ) {
    final $RoutineItemsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RoutineItemsFilterComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $RoutinesOrderingComposer extends Composer<_$AppDatabase, Routines> {
  $RoutinesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeDays => $composableBuilder(
    column: $table.activeDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $RoutinesAnnotationComposer extends Composer<_$AppDatabase, Routines> {
  $RoutinesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Set<Weekday>, int> get activeDays =>
      $composableBuilder(
        column: $table.activeDays,
        builder: (column) => column,
      );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> routineItemsRefs<T extends Object>(
    Expression<T> Function($RoutineItemsAnnotationComposer a) f,
  ) {
    final $RoutineItemsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RoutineItemsAnnotationComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $RoutinesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Routines,
          RoutineRow,
          $RoutinesFilterComposer,
          $RoutinesOrderingComposer,
          $RoutinesAnnotationComposer,
          $RoutinesCreateCompanionBuilder,
          $RoutinesUpdateCompanionBuilder,
          (RoutineRow, $RoutinesReferences),
          RoutineRow,
          PrefetchHooks Function({bool routineItemsRefs})
        > {
  $RoutinesTableManager(_$AppDatabase db, Routines table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RoutinesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RoutinesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RoutinesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<Set<Weekday>> activeDays = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                name: name,
                description: description,
                activeDays: activeDays,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> description = const Value.absent(),
                required Set<Weekday> activeDays,
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
              }) => RoutinesCompanion.insert(
                id: id,
                name: name,
                description: description,
                activeDays: activeDays,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Routines, RoutineRow>(table),
                  $RoutinesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (routineItemsRefs) db.routineItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (routineItemsRefs)
                    await $_getPrefetchedData<
                      RoutineRow,
                      Routines,
                      RoutineItemRow
                    >(
                      currentTable: table,
                      referencedTable: $RoutinesReferences
                          ._routineItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $RoutinesReferences(db, table, p0).routineItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.routineId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $RoutinesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Routines,
      RoutineRow,
      $RoutinesFilterComposer,
      $RoutinesOrderingComposer,
      $RoutinesAnnotationComposer,
      $RoutinesCreateCompanionBuilder,
      $RoutinesUpdateCompanionBuilder,
      (RoutineRow, $RoutinesReferences),
      RoutineRow,
      PrefetchHooks Function({bool routineItemsRefs})
    >;
typedef $ExercisesCreateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  required String name,
  required MuscleGroup muscleGroup,
  required WeightUnit unit,
  Value<bool> isBodyweight,
  Value<String> description,
  Value<DateTime?> archivedAt,
  required DateTime createdAt,
});
typedef $ExercisesUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<MuscleGroup> muscleGroup,
  Value<WeightUnit> unit,
  Value<bool> isBodyweight,
  Value<String> description,
  Value<DateTime?> archivedAt,
  Value<DateTime> createdAt,
});

final class $ExercisesReferences
    extends BaseReferences<_$AppDatabase, Exercises, ExerciseRow> {
  $ExercisesReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<RoutineItems, List<RoutineItemRow>>
  _routineItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineItems,
    aliasName: 'exercises__id__routine_items__exercise_id',
  );

  $RoutineItemsProcessedTableManager get routineItemsRefs {
    final manager = $RoutineItemsTableManager(
      $_db,
      $_db.routineItems,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ExercisesFilterComposer extends Composer<_$AppDatabase, Exercises> {
  $ExercisesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MuscleGroup, MuscleGroup, String>
  get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<WeightUnit, WeightUnit, String> get unit =>
      $composableBuilder(
        column: $table.unit,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isBodyweight => $composableBuilder(
    column: $table.isBodyweight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routineItemsRefs(
    Expression<bool> Function($RoutineItemsFilterComposer f) f,
  ) {
    final $RoutineItemsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RoutineItemsFilterComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ExercisesOrderingComposer extends Composer<_$AppDatabase, Exercises> {
  $ExercisesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBodyweight => $composableBuilder(
    column: $table.isBodyweight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ExercisesAnnotationComposer extends Composer<_$AppDatabase, Exercises> {
  $ExercisesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleGroup, String> get muscleGroup =>
      $composableBuilder(
        column: $table.muscleGroup,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<WeightUnit, String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get isBodyweight => $composableBuilder(
    column: $table.isBodyweight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> routineItemsRefs<T extends Object>(
    Expression<T> Function($RoutineItemsAnnotationComposer a) f,
  ) {
    final $RoutineItemsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RoutineItemsAnnotationComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ExercisesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Exercises,
          ExerciseRow,
          $ExercisesFilterComposer,
          $ExercisesOrderingComposer,
          $ExercisesAnnotationComposer,
          $ExercisesCreateCompanionBuilder,
          $ExercisesUpdateCompanionBuilder,
          (ExerciseRow, $ExercisesReferences),
          ExerciseRow,
          PrefetchHooks Function({bool routineItemsRefs})
        > {
  $ExercisesTableManager(_$AppDatabase db, Exercises table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ExercisesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ExercisesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ExercisesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<MuscleGroup> muscleGroup = const Value.absent(),
                Value<WeightUnit> unit = const Value.absent(),
                Value<bool> isBodyweight = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                muscleGroup: muscleGroup,
                unit: unit,
                isBodyweight: isBodyweight,
                description: description,
                archivedAt: archivedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required MuscleGroup muscleGroup,
                required WeightUnit unit,
                Value<bool> isBodyweight = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                required DateTime createdAt,
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                muscleGroup: muscleGroup,
                unit: unit,
                isBodyweight: isBodyweight,
                description: description,
                archivedAt: archivedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Exercises, ExerciseRow>(table),
                  $ExercisesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (routineItemsRefs) db.routineItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (routineItemsRefs)
                    await $_getPrefetchedData<
                      ExerciseRow,
                      Exercises,
                      RoutineItemRow
                    >(
                      currentTable: table,
                      referencedTable: $ExercisesReferences
                          ._routineItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $ExercisesReferences(db, table, p0).routineItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.exerciseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $ExercisesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Exercises,
      ExerciseRow,
      $ExercisesFilterComposer,
      $ExercisesOrderingComposer,
      $ExercisesAnnotationComposer,
      $ExercisesCreateCompanionBuilder,
      $ExercisesUpdateCompanionBuilder,
      (ExerciseRow, $ExercisesReferences),
      ExerciseRow,
      PrefetchHooks Function({bool routineItemsRefs})
    >;
typedef $RoutineItemsCreateCompanionBuilder = RoutineItemsCompanion Function({
  Value<int> id,
  required int routineId,
  required int weekday,
  required int exerciseId,
  required int position,
  Value<int> targetSets,
  Value<int?> targetReps,
});
typedef $RoutineItemsUpdateCompanionBuilder = RoutineItemsCompanion Function({
  Value<int> id,
  Value<int> routineId,
  Value<int> weekday,
  Value<int> exerciseId,
  Value<int> position,
  Value<int> targetSets,
  Value<int?> targetReps,
});

final class $RoutineItemsReferences
    extends BaseReferences<_$AppDatabase, RoutineItems, RoutineItemRow> {
  $RoutineItemsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Routines _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias('routine_items__routine_id__routines__id');

  $RoutinesProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $RoutinesTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Exercises _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias('routine_items__exercise_id__exercises__id');

  $ExercisesProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $RoutineItemsFilterComposer
    extends Composer<_$AppDatabase, RoutineItems> {
  $RoutineItemsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => ColumnFilters(column),
  );

  $RoutinesFilterComposer get routineId {
    final $RoutinesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RoutinesFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ExercisesFilterComposer get exerciseId {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RoutineItemsOrderingComposer
    extends Composer<_$AppDatabase, RoutineItems> {
  $RoutineItemsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => ColumnOrderings(column),
  );

  $RoutinesOrderingComposer get routineId {
    final $RoutinesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RoutinesOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ExercisesOrderingComposer get exerciseId {
    final $ExercisesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RoutineItemsAnnotationComposer
    extends Composer<_$AppDatabase, RoutineItems> {
  $RoutineItemsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => column,
  );

  $RoutinesAnnotationComposer get routineId {
    final $RoutinesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RoutinesAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ExercisesAnnotationComposer get exerciseId {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RoutineItemsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          RoutineItems,
          RoutineItemRow,
          $RoutineItemsFilterComposer,
          $RoutineItemsOrderingComposer,
          $RoutineItemsAnnotationComposer,
          $RoutineItemsCreateCompanionBuilder,
          $RoutineItemsUpdateCompanionBuilder,
          (RoutineItemRow, $RoutineItemsReferences),
          RoutineItemRow,
          PrefetchHooks Function({bool routineId, bool exerciseId})
        > {
  $RoutineItemsTableManager(_$AppDatabase db, RoutineItems table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RoutineItemsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RoutineItemsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RoutineItemsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> routineId = const Value.absent(),
                Value<int> weekday = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> targetSets = const Value.absent(),
                Value<int?> targetReps = const Value.absent(),
              }) => RoutineItemsCompanion(
                id: id,
                routineId: routineId,
                weekday: weekday,
                exerciseId: exerciseId,
                position: position,
                targetSets: targetSets,
                targetReps: targetReps,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int routineId,
                required int weekday,
                required int exerciseId,
                required int position,
                Value<int> targetSets = const Value.absent(),
                Value<int?> targetReps = const Value.absent(),
              }) => RoutineItemsCompanion.insert(
                id: id,
                routineId: routineId,
                weekday: weekday,
                exerciseId: exerciseId,
                position: position,
                targetSets: targetSets,
                targetReps: targetReps,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<RoutineItems, RoutineItemRow>(table),
                  $RoutineItemsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.routineId,
                        referencedTable: $RoutineItemsReferences
                            ._routineIdTable(db),
                        referencedColumn: $RoutineItemsReferences
                            ._routineIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (exerciseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.exerciseId,
                        referencedTable: $RoutineItemsReferences
                            ._exerciseIdTable(db),
                        referencedColumn: $RoutineItemsReferences
                            ._exerciseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $RoutineItemsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      RoutineItems,
      RoutineItemRow,
      $RoutineItemsFilterComposer,
      $RoutineItemsOrderingComposer,
      $RoutineItemsAnnotationComposer,
      $RoutineItemsCreateCompanionBuilder,
      $RoutineItemsUpdateCompanionBuilder,
      (RoutineItemRow, $RoutineItemsReferences),
      RoutineItemRow,
      PrefetchHooks Function({bool routineId, bool exerciseId})
    >;
typedef $SettingsCreateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<String> userName,
  Value<int> weeklyGoal,
  Value<WeightUnit> defaultUnit,
  Value<AppAccentColor> themeColor,
  Value<bool> workoutReminderEnabled,
  Value<int> reminderMinutes,
  Value<bool> streakRiskEnabled,
  Value<bool> recordsEnabled,
});
typedef $SettingsUpdateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<String> userName,
  Value<int> weeklyGoal,
  Value<WeightUnit> defaultUnit,
  Value<AppAccentColor> themeColor,
  Value<bool> workoutReminderEnabled,
  Value<int> reminderMinutes,
  Value<bool> streakRiskEnabled,
  Value<bool> recordsEnabled,
});

class $SettingsFilterComposer extends Composer<_$AppDatabase, Settings> {
  $SettingsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyGoal => $composableBuilder(
    column: $table.weeklyGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WeightUnit, WeightUnit, String>
  get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<AppAccentColor, AppAccentColor, String>
  get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get workoutReminderEnabled => $composableBuilder(
    column: $table.workoutReminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get streakRiskEnabled => $composableBuilder(
    column: $table.streakRiskEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get recordsEnabled => $composableBuilder(
    column: $table.recordsEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $SettingsOrderingComposer extends Composer<_$AppDatabase, Settings> {
  $SettingsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyGoal => $composableBuilder(
    column: $table.weeklyGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get workoutReminderEnabled => $composableBuilder(
    column: $table.workoutReminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get streakRiskEnabled => $composableBuilder(
    column: $table.streakRiskEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get recordsEnabled => $composableBuilder(
    column: $table.recordsEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $SettingsAnnotationComposer extends Composer<_$AppDatabase, Settings> {
  $SettingsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<int> get weeklyGoal => $composableBuilder(
    column: $table.weeklyGoal,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<WeightUnit, String> get defaultUnit =>
      $composableBuilder(
        column: $table.defaultUnit,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<AppAccentColor, String> get themeColor =>
      $composableBuilder(
        column: $table.themeColor,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get workoutReminderEnabled => $composableBuilder(
    column: $table.workoutReminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get streakRiskEnabled => $composableBuilder(
    column: $table.streakRiskEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get recordsEnabled => $composableBuilder(
    column: $table.recordsEnabled,
    builder: (column) => column,
  );
}

class $SettingsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Settings,
          SettingsRow,
          $SettingsFilterComposer,
          $SettingsOrderingComposer,
          $SettingsAnnotationComposer,
          $SettingsCreateCompanionBuilder,
          $SettingsUpdateCompanionBuilder,
          (SettingsRow, BaseReferences<_$AppDatabase, Settings, SettingsRow>),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $SettingsTableManager(_$AppDatabase db, Settings table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SettingsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SettingsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SettingsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<int> weeklyGoal = const Value.absent(),
                Value<WeightUnit> defaultUnit = const Value.absent(),
                Value<AppAccentColor> themeColor = const Value.absent(),
                Value<bool> workoutReminderEnabled = const Value.absent(),
                Value<int> reminderMinutes = const Value.absent(),
                Value<bool> streakRiskEnabled = const Value.absent(),
                Value<bool> recordsEnabled = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                userName: userName,
                weeklyGoal: weeklyGoal,
                defaultUnit: defaultUnit,
                themeColor: themeColor,
                workoutReminderEnabled: workoutReminderEnabled,
                reminderMinutes: reminderMinutes,
                streakRiskEnabled: streakRiskEnabled,
                recordsEnabled: recordsEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<int> weeklyGoal = const Value.absent(),
                Value<WeightUnit> defaultUnit = const Value.absent(),
                Value<AppAccentColor> themeColor = const Value.absent(),
                Value<bool> workoutReminderEnabled = const Value.absent(),
                Value<int> reminderMinutes = const Value.absent(),
                Value<bool> streakRiskEnabled = const Value.absent(),
                Value<bool> recordsEnabled = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                userName: userName,
                weeklyGoal: weeklyGoal,
                defaultUnit: defaultUnit,
                themeColor: themeColor,
                workoutReminderEnabled: workoutReminderEnabled,
                reminderMinutes: reminderMinutes,
                streakRiskEnabled: streakRiskEnabled,
                recordsEnabled: recordsEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<Settings, SettingsRow>(table),
                  BaseReferences<_$AppDatabase, Settings, SettingsRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $SettingsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Settings,
      SettingsRow,
      $SettingsFilterComposer,
      $SettingsOrderingComposer,
      $SettingsAnnotationComposer,
      $SettingsCreateCompanionBuilder,
      $SettingsUpdateCompanionBuilder,
      (SettingsRow, BaseReferences<_$AppDatabase, Settings, SettingsRow>),
      SettingsRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $RoutinesTableManager get routines =>
      $RoutinesTableManager(_db, _db.routines);
  $ExercisesTableManager get exercises =>
      $ExercisesTableManager(_db, _db.exercises);
  $RoutineItemsTableManager get routineItems =>
      $RoutineItemsTableManager(_db, _db.routineItems);
  $SettingsTableManager get settings =>
      $SettingsTableManager(_db, _db.settings);
}

class WatchAllWithItemsResult {
  final RoutineRow r;
  final RoutineItemRow? ri;
  final int? exerciseId;
  final String? exerciseName;
  final MuscleGroup? exerciseGroup;
  final WeightUnit? exerciseUnit;
  WatchAllWithItemsResult({
    required this.r,
    this.ri,
    this.exerciseId,
    this.exerciseName,
    this.exerciseGroup,
    this.exerciseUnit,
  });
}

class GetItemsByRoutineAndDayResult {
  final RoutineItemRow ri;
  final int exerciseId;
  final String exerciseName;
  final MuscleGroup exerciseGroup;
  final WeightUnit exerciseUnit;
  GetItemsByRoutineAndDayResult({
    required this.ri,
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseGroup,
    required this.exerciseUnit,
  });
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';

@ProviderFor(transactionRunner)
final transactionRunnerProvider = TransactionRunnerProvider._();

final class TransactionRunnerProvider
    extends
        $FunctionalProvider<
          TransactionRunner,
          TransactionRunner,
          TransactionRunner
        >
    with $Provider<TransactionRunner> {
  TransactionRunnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRunnerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRunnerHash();

  @$internal
  @override
  $ProviderElement<TransactionRunner> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRunner create(Ref ref) {
    return transactionRunner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRunner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRunner>(value),
    );
  }
}

String _$transactionRunnerHash() => r'bea7fa46d23c6500ecdce6a097d735208184e139';
