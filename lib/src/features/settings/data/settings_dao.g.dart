// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  Settings get settings => attachedDatabase.settings;
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

  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $SettingsTableManager get settings =>
      $SettingsTableManager(_db.attachedDatabase, _db.settings);
}
