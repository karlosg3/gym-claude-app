// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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
  late final Exercises exercises = Exercises(this);
  late final Index exercisesActiveName = Index(
    'exercises_active_name',
    'CREATE UNIQUE INDEX exercises_active_name ON exercises (name) WHERE archived_at IS NULL',
  );
  late final Settings settings = Settings(this);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final ExercisesDao exercisesDao = ExercisesDao(this as AppDatabase);
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
    exercises,
    exercisesActiveName,
    settings,
  ];
}

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
          (ExerciseRow, BaseReferences<_$AppDatabase, Exercises, ExerciseRow>),
          ExerciseRow,
          PrefetchHooks Function()
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
                  BaseReferences<_$AppDatabase, Exercises, ExerciseRow>(
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
      (ExerciseRow, BaseReferences<_$AppDatabase, Exercises, ExerciseRow>),
      ExerciseRow,
      PrefetchHooks Function()
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
  $ExercisesTableManager get exercises =>
      $ExercisesTableManager(_db, _db.exercises);
  $SettingsTableManager get settings =>
      $SettingsTableManager(_db, _db.settings);
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
