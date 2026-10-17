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

class WorkoutSessions extends Table
    with TableInfo<WorkoutSessions, WorkoutSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkoutSessions(this.attachedDatabase, [this._alias]);
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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES routines(id)ON DELETE SET NULL',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumnWithTypeConverter<MuscleGroup?, String>
  accentGroup = GeneratedColumn<String>(
    'accent_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  ).withConverter<MuscleGroup?>(WorkoutSessions.$converteraccentGroupn);
  late final GeneratedColumnWithTypeConverter<LocalDate, String> localDate =
      GeneratedColumn<String>(
        'local_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL CHECK (local_date GLOB \'[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]\')',
      ).withConverter<LocalDate>(WorkoutSessions.$converterlocalDate);
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  late final GeneratedColumnWithTypeConverter<SessionStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      ).withConverter<SessionStatus>(WorkoutSessions.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    title,
    accentGroup,
    localDate,
    startedAt,
    endedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSessionRow> instance, {
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
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      accentGroup: WorkoutSessions.$converteraccentGroupn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}accent_group'],
        ),
      ),
      localDate: WorkoutSessions.$converterlocalDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}local_date'],
        )!,
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      status: WorkoutSessions.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  WorkoutSessions createAlias(String alias) {
    return WorkoutSessions(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MuscleGroup, String, String> $converteraccentGroup =
      const EnumNameConverter<MuscleGroup>(MuscleGroup.values);
  static JsonTypeConverter2<MuscleGroup?, String?, String?>
  $converteraccentGroupn = JsonTypeConverter2.asNullable($converteraccentGroup);
  static TypeConverter<LocalDate, String> $converterlocalDate =
      const LocalDateConverter();
  static JsonTypeConverter2<SessionStatus, String, String> $converterstatus =
      const EnumNameConverter<SessionStatus>(SessionStatus.values);
  @override
  List<String> get customConstraints => const [
    'CHECK((status = \'active\' AND ended_at IS NULL)OR(status = \'completed\' AND ended_at IS NOT NULL AND ended_at >= started_at))',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkoutSessionRow extends DataClass
    implements Insertable<WorkoutSessionRow> {
  final int id;
  final int? routineId;
  final String title;
  final MuscleGroup? accentGroup;
  final LocalDate localDate;
  final DateTime startedAt;
  final DateTime? endedAt;
  final SessionStatus status;
  const WorkoutSessionRow({
    required this.id,
    this.routineId,
    required this.title,
    this.accentGroup,
    required this.localDate,
    required this.startedAt,
    this.endedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || routineId != null) {
      map['routine_id'] = Variable<int>(routineId);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || accentGroup != null) {
      map['accent_group'] = Variable<String>(
        WorkoutSessions.$converteraccentGroupn.toSql(accentGroup),
      );
    }
    {
      map['local_date'] = Variable<String>(
        WorkoutSessions.$converterlocalDate.toSql(localDate),
      );
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    {
      map['status'] = Variable<String>(
        WorkoutSessions.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      routineId: routineId == null && nullToAbsent
          ? const Value.absent()
          : Value(routineId),
      title: Value(title),
      accentGroup: accentGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(accentGroup),
      localDate: Value(localDate),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      status: Value(status),
    );
  }

  factory WorkoutSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSessionRow(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<int?>(json['routine_id']),
      title: serializer.fromJson<String>(json['title']),
      accentGroup: WorkoutSessions.$converteraccentGroupn.fromJson(
        serializer.fromJson<String?>(json['accent_group']),
      ),
      localDate: serializer.fromJson<LocalDate>(json['local_date']),
      startedAt: serializer.fromJson<DateTime>(json['started_at']),
      endedAt: serializer.fromJson<DateTime?>(json['ended_at']),
      status: WorkoutSessions.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routine_id': serializer.toJson<int?>(routineId),
      'title': serializer.toJson<String>(title),
      'accent_group': serializer.toJson<String?>(
        WorkoutSessions.$converteraccentGroupn.toJson(accentGroup),
      ),
      'local_date': serializer.toJson<LocalDate>(localDate),
      'started_at': serializer.toJson<DateTime>(startedAt),
      'ended_at': serializer.toJson<DateTime?>(endedAt),
      'status': serializer.toJson<String>(
        WorkoutSessions.$converterstatus.toJson(status),
      ),
    };
  }

  WorkoutSessionRow copyWith({
    int? id,
    Value<int?> routineId = const Value.absent(),
    String? title,
    Value<MuscleGroup?> accentGroup = const Value.absent(),
    LocalDate? localDate,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    SessionStatus? status,
  }) => WorkoutSessionRow(
    id: id ?? this.id,
    routineId: routineId.present ? routineId.value : this.routineId,
    title: title ?? this.title,
    accentGroup: accentGroup.present ? accentGroup.value : this.accentGroup,
    localDate: localDate ?? this.localDate,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    status: status ?? this.status,
  );
  WorkoutSessionRow copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSessionRow(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      title: data.title.present ? data.title.value : this.title,
      accentGroup: data.accentGroup.present
          ? data.accentGroup.value
          : this.accentGroup,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionRow(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('title: $title, ')
          ..write('accentGroup: $accentGroup, ')
          ..write('localDate: $localDate, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    title,
    accentGroup,
    localDate,
    startedAt,
    endedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSessionRow &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.title == this.title &&
          other.accentGroup == this.accentGroup &&
          other.localDate == this.localDate &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.status == this.status);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSessionRow> {
  final Value<int> id;
  final Value<int?> routineId;
  final Value<String> title;
  final Value<MuscleGroup?> accentGroup;
  final Value<LocalDate> localDate;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<SessionStatus> status;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.title = const Value.absent(),
    this.accentGroup = const Value.absent(),
    this.localDate = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    required String title,
    this.accentGroup = const Value.absent(),
    required LocalDate localDate,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required SessionStatus status,
  }) : title = Value(title),
       localDate = Value(localDate),
       startedAt = Value(startedAt),
       status = Value(status);
  static Insertable<WorkoutSessionRow> custom({
    Expression<int>? id,
    Expression<int>? routineId,
    Expression<String>? title,
    Expression<String>? accentGroup,
    Expression<String>? localDate,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (title != null) 'title': title,
      if (accentGroup != null) 'accent_group': accentGroup,
      if (localDate != null) 'local_date': localDate,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (status != null) 'status': status,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? routineId,
    Value<String>? title,
    Value<MuscleGroup?>? accentGroup,
    Value<LocalDate>? localDate,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<SessionStatus>? status,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      title: title ?? this.title,
      accentGroup: accentGroup ?? this.accentGroup,
      localDate: localDate ?? this.localDate,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      status: status ?? this.status,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (accentGroup.present) {
      map['accent_group'] = Variable<String>(
        WorkoutSessions.$converteraccentGroupn.toSql(accentGroup.value),
      );
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(
        WorkoutSessions.$converterlocalDate.toSql(localDate.value),
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        WorkoutSessions.$converterstatus.toSql(status.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('title: $title, ')
          ..write('accentGroup: $accentGroup, ')
          ..write('localDate: $localDate, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status')
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

class SessionExercises extends Table
    with TableInfo<SessionExercises, SessionExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SessionExercises(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES workout_sessions(id)ON DELETE CASCADE',
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
    $customConstraints: 'NOT NULL REFERENCES exercises(id)ON DELETE RESTRICT',
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
  static const VerificationMeta _targetSetsMeta = const VerificationMeta(
    'targetSets',
  );
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
    'target_sets',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'CHECK (target_sets IS NULL OR target_sets BETWEEN 1 AND 10)',
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
    $customConstraints:
        'CHECK (target_reps IS NULL OR target_reps BETWEEN 1 AND 50)',
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'\'',
    defaultValue: const CustomExpression('\'\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exerciseId,
    position,
    isBodyweight,
    targetSets,
    targetReps,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
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
    if (data.containsKey('is_bodyweight')) {
      context.handle(
        _isBodyweightMeta,
        isBodyweight.isAcceptableOrUnknown(
          data['is_bodyweight']!,
          _isBodyweightMeta,
        ),
      );
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
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sessionId, exerciseId},
  ];
  @override
  SessionExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      isBodyweight: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_bodyweight'],
      )!,
      targetSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_sets'],
      ),
      targetReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_reps'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  SessionExercises createAlias(String alias) {
    return SessionExercises(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(session_id, exercise_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class SessionExerciseRow extends DataClass
    implements Insertable<SessionExerciseRow> {
  final int id;
  final int sessionId;
  final int exerciseId;
  final int position;
  final bool isBodyweight;
  final int? targetSets;
  final int? targetReps;
  final String note;
  const SessionExerciseRow({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.position,
    required this.isBodyweight,
    this.targetSets,
    this.targetReps,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['position'] = Variable<int>(position);
    map['is_bodyweight'] = Variable<bool>(isBodyweight);
    if (!nullToAbsent || targetSets != null) {
      map['target_sets'] = Variable<int>(targetSets);
    }
    if (!nullToAbsent || targetReps != null) {
      map['target_reps'] = Variable<int>(targetReps);
    }
    map['note'] = Variable<String>(note);
    return map;
  }

  SessionExercisesCompanion toCompanion(bool nullToAbsent) {
    return SessionExercisesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      position: Value(position),
      isBodyweight: Value(isBodyweight),
      targetSets: targetSets == null && nullToAbsent
          ? const Value.absent()
          : Value(targetSets),
      targetReps: targetReps == null && nullToAbsent
          ? const Value.absent()
          : Value(targetReps),
      note: Value(note),
    );
  }

  factory SessionExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionExerciseRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['session_id']),
      exerciseId: serializer.fromJson<int>(json['exercise_id']),
      position: serializer.fromJson<int>(json['position']),
      isBodyweight: serializer.fromJson<bool>(json['is_bodyweight']),
      targetSets: serializer.fromJson<int?>(json['target_sets']),
      targetReps: serializer.fromJson<int?>(json['target_reps']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'session_id': serializer.toJson<int>(sessionId),
      'exercise_id': serializer.toJson<int>(exerciseId),
      'position': serializer.toJson<int>(position),
      'is_bodyweight': serializer.toJson<bool>(isBodyweight),
      'target_sets': serializer.toJson<int?>(targetSets),
      'target_reps': serializer.toJson<int?>(targetReps),
      'note': serializer.toJson<String>(note),
    };
  }

  SessionExerciseRow copyWith({
    int? id,
    int? sessionId,
    int? exerciseId,
    int? position,
    bool? isBodyweight,
    Value<int?> targetSets = const Value.absent(),
    Value<int?> targetReps = const Value.absent(),
    String? note,
  }) => SessionExerciseRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
    isBodyweight: isBodyweight ?? this.isBodyweight,
    targetSets: targetSets.present ? targetSets.value : this.targetSets,
    targetReps: targetReps.present ? targetReps.value : this.targetReps,
    note: note ?? this.note,
  );
  SessionExerciseRow copyWithCompanion(SessionExercisesCompanion data) {
    return SessionExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
      isBodyweight: data.isBodyweight.present
          ? data.isBodyweight.value
          : this.isBodyweight,
      targetSets: data.targetSets.present
          ? data.targetSets.value
          : this.targetSets,
      targetReps: data.targetReps.present
          ? data.targetReps.value
          : this.targetReps,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionExerciseRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('isBodyweight: $isBodyweight, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetReps: $targetReps, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    exerciseId,
    position,
    isBodyweight,
    targetSets,
    targetReps,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionExerciseRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position &&
          other.isBodyweight == this.isBodyweight &&
          other.targetSets == this.targetSets &&
          other.targetReps == this.targetReps &&
          other.note == this.note);
}

class SessionExercisesCompanion extends UpdateCompanion<SessionExerciseRow> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> exerciseId;
  final Value<int> position;
  final Value<bool> isBodyweight;
  final Value<int?> targetSets;
  final Value<int?> targetReps;
  final Value<String> note;
  const SessionExercisesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.isBodyweight = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.note = const Value.absent(),
  });
  SessionExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int exerciseId,
    required int position,
    this.isBodyweight = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.note = const Value.absent(),
  }) : sessionId = Value(sessionId),
       exerciseId = Value(exerciseId),
       position = Value(position);
  static Insertable<SessionExerciseRow> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? exerciseId,
    Expression<int>? position,
    Expression<bool>? isBodyweight,
    Expression<int>? targetSets,
    Expression<int>? targetReps,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (isBodyweight != null) 'is_bodyweight': isBodyweight,
      if (targetSets != null) 'target_sets': targetSets,
      if (targetReps != null) 'target_reps': targetReps,
      if (note != null) 'note': note,
    });
  }

  SessionExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? exerciseId,
    Value<int>? position,
    Value<bool>? isBodyweight,
    Value<int?>? targetSets,
    Value<int?>? targetReps,
    Value<String>? note,
  }) {
    return SessionExercisesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      isBodyweight: isBodyweight ?? this.isBodyweight,
      targetSets: targetSets ?? this.targetSets,
      targetReps: targetReps ?? this.targetReps,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (isBodyweight.present) {
      map['is_bodyweight'] = Variable<bool>(isBodyweight.value);
    }
    if (targetSets.present) {
      map['target_sets'] = Variable<int>(targetSets.value);
    }
    if (targetReps.present) {
      map['target_reps'] = Variable<int>(targetReps.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionExercisesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('isBodyweight: $isBodyweight, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetReps: $targetReps, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class SetRecords extends Table with TableInfo<SetRecords, SetRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SetRecords(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionExerciseIdMeta = const VerificationMeta(
    'sessionExerciseId',
  );
  late final GeneratedColumn<int> sessionExerciseId = GeneratedColumn<int>(
    'session_exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES session_exercises(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (set_number >= 1)',
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (weight_kg >= 0 AND weight_kg < 1000)',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (reps BETWEEN 1 AND 999)',
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
    sessionExerciseId,
    setNumber,
    weightKg,
    reps,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'set_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SetRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_exercise_id')) {
      context.handle(
        _sessionExerciseIdMeta,
        sessionExerciseId.isAcceptableOrUnknown(
          data['session_exercise_id']!,
          _sessionExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionExerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
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
  SetRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_exercise_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  SetRecords createAlias(String alias) {
    return SetRecords(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SetRecordRow extends DataClass implements Insertable<SetRecordRow> {
  final int id;
  final int sessionExerciseId;
  final int setNumber;
  final double weightKg;
  final int reps;
  final DateTime createdAt;
  const SetRecordRow({
    required this.id,
    required this.sessionExerciseId,
    required this.setNumber,
    required this.weightKg,
    required this.reps,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_exercise_id'] = Variable<int>(sessionExerciseId);
    map['set_number'] = Variable<int>(setNumber);
    map['weight_kg'] = Variable<double>(weightKg);
    map['reps'] = Variable<int>(reps);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SetRecordsCompanion toCompanion(bool nullToAbsent) {
    return SetRecordsCompanion(
      id: Value(id),
      sessionExerciseId: Value(sessionExerciseId),
      setNumber: Value(setNumber),
      weightKg: Value(weightKg),
      reps: Value(reps),
      createdAt: Value(createdAt),
    );
  }

  factory SetRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetRecordRow(
      id: serializer.fromJson<int>(json['id']),
      sessionExerciseId: serializer.fromJson<int>(json['session_exercise_id']),
      setNumber: serializer.fromJson<int>(json['set_number']),
      weightKg: serializer.fromJson<double>(json['weight_kg']),
      reps: serializer.fromJson<int>(json['reps']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'session_exercise_id': serializer.toJson<int>(sessionExerciseId),
      'set_number': serializer.toJson<int>(setNumber),
      'weight_kg': serializer.toJson<double>(weightKg),
      'reps': serializer.toJson<int>(reps),
      'created_at': serializer.toJson<DateTime>(createdAt),
    };
  }

  SetRecordRow copyWith({
    int? id,
    int? sessionExerciseId,
    int? setNumber,
    double? weightKg,
    int? reps,
    DateTime? createdAt,
  }) => SetRecordRow(
    id: id ?? this.id,
    sessionExerciseId: sessionExerciseId ?? this.sessionExerciseId,
    setNumber: setNumber ?? this.setNumber,
    weightKg: weightKg ?? this.weightKg,
    reps: reps ?? this.reps,
    createdAt: createdAt ?? this.createdAt,
  );
  SetRecordRow copyWithCompanion(SetRecordsCompanion data) {
    return SetRecordRow(
      id: data.id.present ? data.id.value : this.id,
      sessionExerciseId: data.sessionExerciseId.present
          ? data.sessionExerciseId.value
          : this.sessionExerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetRecordRow(')
          ..write('id: $id, ')
          ..write('sessionExerciseId: $sessionExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionExerciseId, setNumber, weightKg, reps, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetRecordRow &&
          other.id == this.id &&
          other.sessionExerciseId == this.sessionExerciseId &&
          other.setNumber == this.setNumber &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.createdAt == this.createdAt);
}

class SetRecordsCompanion extends UpdateCompanion<SetRecordRow> {
  final Value<int> id;
  final Value<int> sessionExerciseId;
  final Value<int> setNumber;
  final Value<double> weightKg;
  final Value<int> reps;
  final Value<DateTime> createdAt;
  const SetRecordsCompanion({
    this.id = const Value.absent(),
    this.sessionExerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SetRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionExerciseId,
    required int setNumber,
    this.weightKg = const Value.absent(),
    required int reps,
    required DateTime createdAt,
  }) : sessionExerciseId = Value(sessionExerciseId),
       setNumber = Value(setNumber),
       reps = Value(reps),
       createdAt = Value(createdAt);
  static Insertable<SetRecordRow> custom({
    Expression<int>? id,
    Expression<int>? sessionExerciseId,
    Expression<int>? setNumber,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionExerciseId != null) 'session_exercise_id': sessionExerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SetRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionExerciseId,
    Value<int>? setNumber,
    Value<double>? weightKg,
    Value<int>? reps,
    Value<DateTime>? createdAt,
  }) {
    return SetRecordsCompanion(
      id: id ?? this.id,
      sessionExerciseId: sessionExerciseId ?? this.sessionExerciseId,
      setNumber: setNumber ?? this.setNumber,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionExerciseId.present) {
      map['session_exercise_id'] = Variable<int>(sessionExerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetRecordsCompanion(')
          ..write('id: $id, ')
          ..write('sessionExerciseId: $sessionExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
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
  late final WorkoutSessions workoutSessions = WorkoutSessions(this);
  late final Exercises exercises = Exercises(this);
  late final SessionExercises sessionExercises = SessionExercises(this);
  late final SetRecords setRecords = SetRecords(this);
  late final Index workoutSessionsSingleActive = Index(
    'workout_sessions_single_active',
    'CREATE UNIQUE INDEX workout_sessions_single_active ON workout_sessions (status) WHERE status = \'active\'',
  );
  late final Index workoutSessionsDate = Index(
    'workout_sessions_date',
    'CREATE INDEX workout_sessions_date ON workout_sessions (local_date)',
  );
  late final Index workoutSessionsRoutine = Index(
    'workout_sessions_routine',
    'CREATE INDEX workout_sessions_routine ON workout_sessions (routine_id)',
  );
  late final Index sessionExercisesExercise = Index(
    'session_exercises_exercise',
    'CREATE INDEX session_exercises_exercise ON session_exercises (exercise_id)',
  );
  late final Index setRecordsSessionExercise = Index(
    'set_records_session_exercise',
    'CREATE INDEX set_records_session_exercise ON set_records (session_exercise_id, set_number)',
  );
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
  late final WorkoutDao workoutDao = WorkoutDao(this as AppDatabase);
  late final ProgressDao progressDao = ProgressDao(this as AppDatabase);
  Selectable<bool> exerciseHasHistory(int exerciseId) {
    return customSelect(
      'SELECT EXISTS (SELECT 1 AS _c1 FROM session_exercises WHERE exercise_id = ?1) AS _c0',
      variables: [Variable<int>(exerciseId)],
      readsFrom: {this.sessionExercises},
    ).map((QueryRow row) => row.read<bool>('_c0'));
  }

  Selectable<LastBestPerExerciseResult> lastBestPerExercise(
    List<int> exerciseIds,
  ) {
    var $arrayStartIndex = 1;
    final expandedexerciseIds = $expandVar(
      $arrayStartIndex,
      exerciseIds.length,
    );
    $arrayStartIndex += exerciseIds.length;
    return customSelect(
      'WITH ranked AS (SELECT se.exercise_id, sr.weight_kg, sr.reps, ROW_NUMBER()OVER (PARTITION BY se.exercise_id ORDER BY ws.started_at DESC, sr.weight_kg DESC, sr.reps DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS rn FROM session_exercises AS se JOIN workout_sessions AS ws ON ws.id = se.session_id AND ws.status = \'completed\' JOIN set_records AS sr ON sr.session_exercise_id = se.id WHERE se.exercise_id IN ($expandedexerciseIds)) SELECT exercise_id, weight_kg, reps FROM ranked WHERE rn = 1',
      variables: [for (var $ in exerciseIds) Variable<int>($)],
      readsFrom: {this.sessionExercises, this.setRecords, this.workoutSessions},
    ).map(
      (QueryRow row) => LastBestPerExerciseResult(
        exerciseId: row.read<int>('exercise_id'),
        weightKg: row.read<double>('weight_kg'),
        reps: row.read<int>('reps'),
      ),
    );
  }

  Selectable<double?> maxWeightBefore(int exerciseId, int sessionId) {
    return customSelect(
      'SELECT MAX(sr.weight_kg) AS _c0 FROM set_records AS sr JOIN session_exercises AS se ON se.id = sr.session_exercise_id JOIN workout_sessions AS ws ON ws.id = se.session_id WHERE se.exercise_id = ?1 AND ws.status = \'completed\' AND ws.started_at < (SELECT started_at FROM workout_sessions WHERE id = ?2)',
      variables: [Variable<int>(exerciseId), Variable<int>(sessionId)],
      readsFrom: {this.setRecords, this.sessionExercises, this.workoutSessions},
    ).map((QueryRow row) => row.readNullable<double>('_c0'));
  }

  Selectable<WorkoutSessionRow> watchActiveSession() {
    return customSelect(
      'SELECT * FROM workout_sessions WHERE status = \'active\'',
      variables: [],
      readsFrom: {this.workoutSessions},
    ).asyncMap(this.workoutSessions.mapFromRow);
  }

  Selectable<WatchSessionTreeResult> watchSessionTree(int sessionId) {
    return customSelect(
      'SELECT"ws"."id" AS "nested_0.id", "ws"."routine_id" AS "nested_0.routine_id", "ws"."title" AS "nested_0.title", "ws"."accent_group" AS "nested_0.accent_group", "ws"."local_date" AS "nested_0.local_date", "ws"."started_at" AS "nested_0.started_at", "ws"."ended_at" AS "nested_0.ended_at", "ws"."status" AS "nested_0.status","se"."id" AS "nested_1.id", "se"."session_id" AS "nested_1.session_id", "se"."exercise_id" AS "nested_1.exercise_id", "se"."position" AS "nested_1.position", "se"."is_bodyweight" AS "nested_1.is_bodyweight", "se"."target_sets" AS "nested_1.target_sets", "se"."target_reps" AS "nested_1.target_reps", "se"."note" AS "nested_1.note","sr"."id" AS "nested_2.id", "sr"."session_exercise_id" AS "nested_2.session_exercise_id", "sr"."set_number" AS "nested_2.set_number", "sr"."weight_kg" AS "nested_2.weight_kg", "sr"."reps" AS "nested_2.reps", "sr"."created_at" AS "nested_2.created_at", e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM workout_sessions AS ws LEFT JOIN session_exercises AS se ON se.session_id = ws.id LEFT JOIN exercises AS e ON e.id = se.exercise_id LEFT JOIN set_records AS sr ON sr.session_exercise_id = se.id WHERE ws.id = ?1 ORDER BY se.position, sr.set_number',
      variables: [Variable<int>(sessionId)],
      readsFrom: {
        this.exercises,
        this.workoutSessions,
        this.sessionExercises,
        this.setRecords,
      },
    ).asyncMap(
      (QueryRow row) async => WatchSessionTreeResult(
        ws: await this.workoutSessions.mapFromRow(row, tablePrefix: 'nested_0'),
        se: await this.sessionExercises.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_1',
        ),
        sr: await this.setRecords.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_2',
        ),
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

  Selectable<WatchActiveTreeResult> watchActiveTree() {
    return customSelect(
      'SELECT"ws"."id" AS "nested_0.id", "ws"."routine_id" AS "nested_0.routine_id", "ws"."title" AS "nested_0.title", "ws"."accent_group" AS "nested_0.accent_group", "ws"."local_date" AS "nested_0.local_date", "ws"."started_at" AS "nested_0.started_at", "ws"."ended_at" AS "nested_0.ended_at", "ws"."status" AS "nested_0.status","se"."id" AS "nested_1.id", "se"."session_id" AS "nested_1.session_id", "se"."exercise_id" AS "nested_1.exercise_id", "se"."position" AS "nested_1.position", "se"."is_bodyweight" AS "nested_1.is_bodyweight", "se"."target_sets" AS "nested_1.target_sets", "se"."target_reps" AS "nested_1.target_reps", "se"."note" AS "nested_1.note","sr"."id" AS "nested_2.id", "sr"."session_exercise_id" AS "nested_2.session_exercise_id", "sr"."set_number" AS "nested_2.set_number", "sr"."weight_kg" AS "nested_2.weight_kg", "sr"."reps" AS "nested_2.reps", "sr"."created_at" AS "nested_2.created_at", e.name AS exercise_name, e.muscle_group AS exercise_group, e.unit AS exercise_unit FROM workout_sessions AS ws LEFT JOIN session_exercises AS se ON se.session_id = ws.id LEFT JOIN exercises AS e ON e.id = se.exercise_id LEFT JOIN set_records AS sr ON sr.session_exercise_id = se.id WHERE ws.status = \'active\' ORDER BY se.position, sr.set_number',
      variables: [],
      readsFrom: {
        this.exercises,
        this.workoutSessions,
        this.sessionExercises,
        this.setRecords,
      },
    ).asyncMap(
      (QueryRow row) async => WatchActiveTreeResult(
        ws: await this.workoutSessions.mapFromRow(row, tablePrefix: 'nested_0'),
        se: await this.sessionExercises.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_1',
        ),
        sr: await this.setRecords.mapFromRowOrNull(
          row,
          tablePrefix: 'nested_2',
        ),
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

  Future<int> copyRoutineDay(int sessionId, int routineId, int weekday) {
    return customInsert(
      'INSERT INTO session_exercises (session_id, exercise_id, position, is_bodyweight, target_sets, target_reps) SELECT ?1, ri.exercise_id, ri.position, e.is_bodyweight, ri.target_sets, ri.target_reps FROM routine_items AS ri JOIN exercises AS e ON e.id = ri.exercise_id WHERE ri.routine_id = ?2 AND ri.weekday = ?3 AND e.archived_at IS NULL',
      variables: [
        Variable<int>(sessionId),
        Variable<int>(routineId),
        Variable<int>(weekday),
      ],
      updates: {this.sessionExercises},
    );
  }

  Selectable<int> nextExercisePosition(int sessionId) {
    return customSelect(
      'SELECT COALESCE(MAX(position), -1) + 1 AS _c0 FROM session_exercises WHERE session_id = ?1',
      variables: [Variable<int>(sessionId)],
      readsFrom: {this.sessionExercises},
    ).map((QueryRow row) => row.read<int>('_c0'));
  }

  Selectable<int> nextSetNumber(int sessionExerciseId) {
    return customSelect(
      'SELECT COALESCE(MAX(set_number), 0) + 1 AS _c0 FROM set_records WHERE session_exercise_id = ?1',
      variables: [Variable<int>(sessionExerciseId)],
      readsFrom: {this.setRecords},
    ).map((QueryRow row) => row.read<int>('_c0'));
  }

  Future<int> renumberAfter(int sessionExerciseId, int deletedNumber) {
    return customUpdate(
      'UPDATE set_records SET set_number = set_number - 1 WHERE session_exercise_id = ?1 AND set_number > ?2',
      variables: [
        Variable<int>(sessionExerciseId),
        Variable<int>(deletedNumber),
      ],
      updates: {this.setRecords},
      updateKind: UpdateKind.update,
    );
  }

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
    workoutSessions,
    exercises,
    sessionExercises,
    setRecords,
    workoutSessionsSingleActive,
    workoutSessionsDate,
    workoutSessionsRoutine,
    sessionExercisesExercise,
    setRecordsSessionExercise,
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
      result: [TableUpdate('workout_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('session_exercises', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'session_exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('set_records', kind: UpdateKind.delete)],
    ),
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

  static MultiTypedResultKey<WorkoutSessions, List<WorkoutSessionRow>>
  _workoutSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSessions,
    aliasName: 'routines__id__workout_sessions__routine_id',
  );

  $WorkoutSessionsProcessedTableManager get workoutSessionsRefs {
    final manager = $WorkoutSessionsTableManager(
      $_db,
      $_db.workoutSessions,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

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

  Expression<bool> workoutSessionsRefs(
    Expression<bool> Function($WorkoutSessionsFilterComposer f) f,
  ) {
    final $WorkoutSessionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutSessionsFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

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

  Expression<T> workoutSessionsRefs<T extends Object>(
    Expression<T> Function($WorkoutSessionsAnnotationComposer a) f,
  ) {
    final $WorkoutSessionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutSessionsAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

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
          PrefetchHooks Function({
            bool workoutSessionsRefs,
            bool routineItemsRefs,
          })
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
          prefetchHooksCallback:
              ({workoutSessionsRefs = false, routineItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutSessionsRefs) db.workoutSessions,
                    if (routineItemsRefs) db.routineItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutSessionsRefs)
                        await $_getPrefetchedData<
                          RoutineRow,
                          Routines,
                          WorkoutSessionRow
                        >(
                          currentTable: table,
                          referencedTable: $RoutinesReferences
                              ._workoutSessionsRefsTable(db),
                          managerFromTypedResult: (p0) => $RoutinesReferences(
                            db,
                            table,
                            p0,
                          ).workoutSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (routineItemsRefs)
                        await $_getPrefetchedData<
                          RoutineRow,
                          Routines,
                          RoutineItemRow
                        >(
                          currentTable: table,
                          referencedTable: $RoutinesReferences
                              ._routineItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $RoutinesReferences(
                            db,
                            table,
                            p0,
                          ).routineItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
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
      PrefetchHooks Function({bool workoutSessionsRefs, bool routineItemsRefs})
    >;
typedef $WorkoutSessionsCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<int> id,
      Value<int?> routineId,
      required String title,
      Value<MuscleGroup?> accentGroup,
      required LocalDate localDate,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required SessionStatus status,
    });
typedef $WorkoutSessionsUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<int> id,
      Value<int?> routineId,
      Value<String> title,
      Value<MuscleGroup?> accentGroup,
      Value<LocalDate> localDate,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<SessionStatus> status,
    });

final class $WorkoutSessionsReferences
    extends BaseReferences<_$AppDatabase, WorkoutSessions, WorkoutSessionRow> {
  $WorkoutSessionsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Routines _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias('workout_sessions__routine_id__routines__id');

  $RoutinesProcessedTableManager? get routineId {
    final $_column = $_itemColumn<int>('routine_id');
    if ($_column == null) return null;
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

  static MultiTypedResultKey<SessionExercises, List<SessionExerciseRow>>
  _sessionExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionExercises,
    aliasName: 'workout_sessions__id__session_exercises__session_id',
  );

  $SessionExercisesProcessedTableManager get sessionExercisesRefs {
    final manager = $SessionExercisesTableManager(
      $_db,
      $_db.sessionExercises,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $WorkoutSessionsFilterComposer
    extends Composer<_$AppDatabase, WorkoutSessions> {
  $WorkoutSessionsFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MuscleGroup?, MuscleGroup, String>
  get accentGroup => $composableBuilder(
    column: $table.accentGroup,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get localDate =>
      $composableBuilder(
        column: $table.localDate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SessionStatus, SessionStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
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

  Expression<bool> sessionExercisesRefs(
    Expression<bool> Function($SessionExercisesFilterComposer f) f,
  ) {
    final $SessionExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SessionExercisesFilterComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $WorkoutSessionsOrderingComposer
    extends Composer<_$AppDatabase, WorkoutSessions> {
  $WorkoutSessionsOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentGroup => $composableBuilder(
    column: $table.accentGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
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
}

class $WorkoutSessionsAnnotationComposer
    extends Composer<_$AppDatabase, WorkoutSessions> {
  $WorkoutSessionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleGroup?, String> get accentGroup =>
      $composableBuilder(
        column: $table.accentGroup,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<LocalDate, String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SessionStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

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

  Expression<T> sessionExercisesRefs<T extends Object>(
    Expression<T> Function($SessionExercisesAnnotationComposer a) f,
  ) {
    final $SessionExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SessionExercisesAnnotationComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $WorkoutSessionsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          WorkoutSessions,
          WorkoutSessionRow,
          $WorkoutSessionsFilterComposer,
          $WorkoutSessionsOrderingComposer,
          $WorkoutSessionsAnnotationComposer,
          $WorkoutSessionsCreateCompanionBuilder,
          $WorkoutSessionsUpdateCompanionBuilder,
          (WorkoutSessionRow, $WorkoutSessionsReferences),
          WorkoutSessionRow,
          PrefetchHooks Function({bool routineId, bool sessionExercisesRefs})
        > {
  $WorkoutSessionsTableManager(_$AppDatabase db, WorkoutSessions table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $WorkoutSessionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $WorkoutSessionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $WorkoutSessionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> routineId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<MuscleGroup?> accentGroup = const Value.absent(),
                Value<LocalDate> localDate = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<SessionStatus> status = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                routineId: routineId,
                title: title,
                accentGroup: accentGroup,
                localDate: localDate,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> routineId = const Value.absent(),
                required String title,
                Value<MuscleGroup?> accentGroup = const Value.absent(),
                required LocalDate localDate,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required SessionStatus status,
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                routineId: routineId,
                title: title,
                accentGroup: accentGroup,
                localDate: localDate,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<WorkoutSessions, WorkoutSessionRow>(table),
                  $WorkoutSessionsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({routineId = false, sessionExercisesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionExercisesRefs) db.sessionExercises,
                  ],
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
                            referencedTable: $WorkoutSessionsReferences
                                ._routineIdTable(db),
                            referencedColumn: $WorkoutSessionsReferences
                                ._routineIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionExercisesRefs)
                        await $_getPrefetchedData<
                          WorkoutSessionRow,
                          WorkoutSessions,
                          SessionExerciseRow
                        >(
                          currentTable: table,
                          referencedTable: $WorkoutSessionsReferences
                              ._sessionExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $WorkoutSessionsReferences(
                                db,
                                table,
                                p0,
                              ).sessionExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $WorkoutSessionsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      WorkoutSessions,
      WorkoutSessionRow,
      $WorkoutSessionsFilterComposer,
      $WorkoutSessionsOrderingComposer,
      $WorkoutSessionsAnnotationComposer,
      $WorkoutSessionsCreateCompanionBuilder,
      $WorkoutSessionsUpdateCompanionBuilder,
      (WorkoutSessionRow, $WorkoutSessionsReferences),
      WorkoutSessionRow,
      PrefetchHooks Function({bool routineId, bool sessionExercisesRefs})
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

  static MultiTypedResultKey<SessionExercises, List<SessionExerciseRow>>
  _sessionExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionExercises,
    aliasName: 'exercises__id__session_exercises__exercise_id',
  );

  $SessionExercisesProcessedTableManager get sessionExercisesRefs {
    final manager = $SessionExercisesTableManager(
      $_db,
      $_db.sessionExercises,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

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

  Expression<bool> sessionExercisesRefs(
    Expression<bool> Function($SessionExercisesFilterComposer f) f,
  ) {
    final $SessionExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SessionExercisesFilterComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

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

  Expression<T> sessionExercisesRefs<T extends Object>(
    Expression<T> Function($SessionExercisesAnnotationComposer a) f,
  ) {
    final $SessionExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SessionExercisesAnnotationComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

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
          PrefetchHooks Function({
            bool sessionExercisesRefs,
            bool routineItemsRefs,
          })
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
          prefetchHooksCallback:
              ({sessionExercisesRefs = false, routineItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionExercisesRefs) db.sessionExercises,
                    if (routineItemsRefs) db.routineItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionExercisesRefs)
                        await $_getPrefetchedData<
                          ExerciseRow,
                          Exercises,
                          SessionExerciseRow
                        >(
                          currentTable: table,
                          referencedTable: $ExercisesReferences
                              ._sessionExercisesRefsTable(db),
                          managerFromTypedResult: (p0) => $ExercisesReferences(
                            db,
                            table,
                            p0,
                          ).sessionExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (routineItemsRefs)
                        await $_getPrefetchedData<
                          ExerciseRow,
                          Exercises,
                          RoutineItemRow
                        >(
                          currentTable: table,
                          referencedTable: $ExercisesReferences
                              ._routineItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $ExercisesReferences(
                            db,
                            table,
                            p0,
                          ).routineItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
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
      PrefetchHooks Function({bool sessionExercisesRefs, bool routineItemsRefs})
    >;
typedef $SessionExercisesCreateCompanionBuilder =
    SessionExercisesCompanion Function({
      Value<int> id,
      required int sessionId,
      required int exerciseId,
      required int position,
      Value<bool> isBodyweight,
      Value<int?> targetSets,
      Value<int?> targetReps,
      Value<String> note,
    });
typedef $SessionExercisesUpdateCompanionBuilder =
    SessionExercisesCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> exerciseId,
      Value<int> position,
      Value<bool> isBodyweight,
      Value<int?> targetSets,
      Value<int?> targetReps,
      Value<String> note,
    });

final class $SessionExercisesReferences
    extends
        BaseReferences<_$AppDatabase, SessionExercises, SessionExerciseRow> {
  $SessionExercisesReferences(super.$_db, super.$_table, super.$_typedResult);

  static WorkoutSessions _sessionIdTable(_$AppDatabase db) => db.workoutSessions
      .createAlias('session_exercises__session_id__workout_sessions__id');

  $WorkoutSessionsProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $WorkoutSessionsTableManager(
      $_db,
      $_db.workoutSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Exercises _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias('session_exercises__exercise_id__exercises__id');

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

  static MultiTypedResultKey<SetRecords, List<SetRecordRow>>
  _setRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.setRecords,
    aliasName: 'session_exercises__id__set_records__session_exercise_id',
  );

  $SetRecordsProcessedTableManager get setRecordsRefs {
    final manager = $SetRecordsTableManager(
      $_db,
      $_db.setRecords,
    ).filter((f) => f.sessionExerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_setRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $SessionExercisesFilterComposer
    extends Composer<_$AppDatabase, SessionExercises> {
  $SessionExercisesFilterComposer({
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

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBodyweight => $composableBuilder(
    column: $table.isBodyweight,
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

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $WorkoutSessionsFilterComposer get sessionId {
    final $WorkoutSessionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutSessionsFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
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

  Expression<bool> setRecordsRefs(
    Expression<bool> Function($SetRecordsFilterComposer f) f,
  ) {
    final $SetRecordsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setRecords,
      getReferencedColumn: (t) => t.sessionExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SetRecordsFilterComposer(
            $db: $db,
            $table: $db.setRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $SessionExercisesOrderingComposer
    extends Composer<_$AppDatabase, SessionExercises> {
  $SessionExercisesOrderingComposer({
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

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBodyweight => $composableBuilder(
    column: $table.isBodyweight,
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

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $WorkoutSessionsOrderingComposer get sessionId {
    final $WorkoutSessionsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutSessionsOrderingComposer(
            $db: $db,
            $table: $db.workoutSessions,
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

class $SessionExercisesAnnotationComposer
    extends Composer<_$AppDatabase, SessionExercises> {
  $SessionExercisesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get isBodyweight => $composableBuilder(
    column: $table.isBodyweight,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $WorkoutSessionsAnnotationComposer get sessionId {
    final $WorkoutSessionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutSessionsAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
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

  Expression<T> setRecordsRefs<T extends Object>(
    Expression<T> Function($SetRecordsAnnotationComposer a) f,
  ) {
    final $SetRecordsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setRecords,
      getReferencedColumn: (t) => t.sessionExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SetRecordsAnnotationComposer(
            $db: $db,
            $table: $db.setRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $SessionExercisesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          SessionExercises,
          SessionExerciseRow,
          $SessionExercisesFilterComposer,
          $SessionExercisesOrderingComposer,
          $SessionExercisesAnnotationComposer,
          $SessionExercisesCreateCompanionBuilder,
          $SessionExercisesUpdateCompanionBuilder,
          (SessionExerciseRow, $SessionExercisesReferences),
          SessionExerciseRow,
          PrefetchHooks Function({
            bool sessionId,
            bool exerciseId,
            bool setRecordsRefs,
          })
        > {
  $SessionExercisesTableManager(_$AppDatabase db, SessionExercises table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SessionExercisesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SessionExercisesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SessionExercisesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<bool> isBodyweight = const Value.absent(),
                Value<int?> targetSets = const Value.absent(),
                Value<int?> targetReps = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => SessionExercisesCompanion(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                position: position,
                isBodyweight: isBodyweight,
                targetSets: targetSets,
                targetReps: targetReps,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int exerciseId,
                required int position,
                Value<bool> isBodyweight = const Value.absent(),
                Value<int?> targetSets = const Value.absent(),
                Value<int?> targetReps = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => SessionExercisesCompanion.insert(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                position: position,
                isBodyweight: isBodyweight,
                targetSets: targetSets,
                targetReps: targetReps,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<SessionExercises, SessionExerciseRow>(table),
                  $SessionExercisesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sessionId = false,
                exerciseId = false,
                setRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (setRecordsRefs) db.setRecords],
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
                        if (sessionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.sessionId,
                            referencedTable: $SessionExercisesReferences
                                ._sessionIdTable(db),
                            referencedColumn: $SessionExercisesReferences
                                ._sessionIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (exerciseId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.exerciseId,
                            referencedTable: $SessionExercisesReferences
                                ._exerciseIdTable(db),
                            referencedColumn: $SessionExercisesReferences
                                ._exerciseIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (setRecordsRefs)
                        await $_getPrefetchedData<
                          SessionExerciseRow,
                          SessionExercises,
                          SetRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $SessionExercisesReferences
                              ._setRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $SessionExercisesReferences(
                                db,
                                table,
                                p0,
                              ).setRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionExerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $SessionExercisesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      SessionExercises,
      SessionExerciseRow,
      $SessionExercisesFilterComposer,
      $SessionExercisesOrderingComposer,
      $SessionExercisesAnnotationComposer,
      $SessionExercisesCreateCompanionBuilder,
      $SessionExercisesUpdateCompanionBuilder,
      (SessionExerciseRow, $SessionExercisesReferences),
      SessionExerciseRow,
      PrefetchHooks Function({
        bool sessionId,
        bool exerciseId,
        bool setRecordsRefs,
      })
    >;
typedef $SetRecordsCreateCompanionBuilder = SetRecordsCompanion Function({
  Value<int> id,
  required int sessionExerciseId,
  required int setNumber,
  Value<double> weightKg,
  required int reps,
  required DateTime createdAt,
});
typedef $SetRecordsUpdateCompanionBuilder = SetRecordsCompanion Function({
  Value<int> id,
  Value<int> sessionExerciseId,
  Value<int> setNumber,
  Value<double> weightKg,
  Value<int> reps,
  Value<DateTime> createdAt,
});

final class $SetRecordsReferences
    extends BaseReferences<_$AppDatabase, SetRecords, SetRecordRow> {
  $SetRecordsReferences(super.$_db, super.$_table, super.$_typedResult);

  static SessionExercises _sessionExerciseIdTable(_$AppDatabase db) => db
      .sessionExercises
      .createAlias('set_records__session_exercise_id__session_exercises__id');

  $SessionExercisesProcessedTableManager get sessionExerciseId {
    final $_column = $_itemColumn<int>('session_exercise_id')!;

    final manager = $SessionExercisesTableManager(
      $_db,
      $_db.sessionExercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionExerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $SetRecordsFilterComposer extends Composer<_$AppDatabase, SetRecords> {
  $SetRecordsFilterComposer({
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

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $SessionExercisesFilterComposer get sessionExerciseId {
    final $SessionExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionExerciseId,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SessionExercisesFilterComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $SetRecordsOrderingComposer extends Composer<_$AppDatabase, SetRecords> {
  $SetRecordsOrderingComposer({
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

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $SessionExercisesOrderingComposer get sessionExerciseId {
    final $SessionExercisesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionExerciseId,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SessionExercisesOrderingComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $SetRecordsAnnotationComposer
    extends Composer<_$AppDatabase, SetRecords> {
  $SetRecordsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $SessionExercisesAnnotationComposer get sessionExerciseId {
    final $SessionExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionExerciseId,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $SessionExercisesAnnotationComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $SetRecordsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          SetRecords,
          SetRecordRow,
          $SetRecordsFilterComposer,
          $SetRecordsOrderingComposer,
          $SetRecordsAnnotationComposer,
          $SetRecordsCreateCompanionBuilder,
          $SetRecordsUpdateCompanionBuilder,
          (SetRecordRow, $SetRecordsReferences),
          SetRecordRow,
          PrefetchHooks Function({bool sessionExerciseId})
        > {
  $SetRecordsTableManager(_$AppDatabase db, SetRecords table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SetRecordsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SetRecordsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SetRecordsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionExerciseId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SetRecordsCompanion(
                id: id,
                sessionExerciseId: sessionExerciseId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionExerciseId,
                required int setNumber,
                Value<double> weightKg = const Value.absent(),
                required int reps,
                required DateTime createdAt,
              }) => SetRecordsCompanion.insert(
                id: id,
                sessionExerciseId: sessionExerciseId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<SetRecords, SetRecordRow>(table),
                  $SetRecordsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionExerciseId = false}) {
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
                    if (sessionExerciseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionExerciseId,
                        referencedTable: $SetRecordsReferences
                            ._sessionExerciseIdTable(db),
                        referencedColumn: $SetRecordsReferences
                            ._sessionExerciseIdTable(db)
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

typedef $SetRecordsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      SetRecords,
      SetRecordRow,
      $SetRecordsFilterComposer,
      $SetRecordsOrderingComposer,
      $SetRecordsAnnotationComposer,
      $SetRecordsCreateCompanionBuilder,
      $SetRecordsUpdateCompanionBuilder,
      (SetRecordRow, $SetRecordsReferences),
      SetRecordRow,
      PrefetchHooks Function({bool sessionExerciseId})
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
  $WorkoutSessionsTableManager get workoutSessions =>
      $WorkoutSessionsTableManager(_db, _db.workoutSessions);
  $ExercisesTableManager get exercises =>
      $ExercisesTableManager(_db, _db.exercises);
  $SessionExercisesTableManager get sessionExercises =>
      $SessionExercisesTableManager(_db, _db.sessionExercises);
  $SetRecordsTableManager get setRecords =>
      $SetRecordsTableManager(_db, _db.setRecords);
  $RoutineItemsTableManager get routineItems =>
      $RoutineItemsTableManager(_db, _db.routineItems);
  $SettingsTableManager get settings =>
      $SettingsTableManager(_db, _db.settings);
}

class LastBestPerExerciseResult {
  final int exerciseId;
  final double weightKg;
  final int reps;
  LastBestPerExerciseResult({
    required this.exerciseId,
    required this.weightKg,
    required this.reps,
  });
}

class WatchSessionTreeResult {
  final WorkoutSessionRow ws;
  final SessionExerciseRow? se;
  final SetRecordRow? sr;
  final String? exerciseName;
  final MuscleGroup? exerciseGroup;
  final WeightUnit? exerciseUnit;
  WatchSessionTreeResult({
    required this.ws,
    this.se,
    this.sr,
    this.exerciseName,
    this.exerciseGroup,
    this.exerciseUnit,
  });
}

class WatchActiveTreeResult {
  final WorkoutSessionRow ws;
  final SessionExerciseRow? se;
  final SetRecordRow? sr;
  final String? exerciseName;
  final MuscleGroup? exerciseGroup;
  final WeightUnit? exerciseUnit;
  WatchActiveTreeResult({
    required this.ws,
    this.se,
    this.sr,
    this.exerciseName,
    this.exerciseGroup,
    this.exerciseUnit,
  });
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
