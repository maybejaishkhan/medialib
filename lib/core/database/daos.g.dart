// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$MediaItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $FranchisesTable get franchises => attachedDatabase.franchises;
  $MediaItemsTable get mediaItems => attachedDatabase.mediaItems;
  MediaItemDaoManager get managers => MediaItemDaoManager(this);
}

class MediaItemDaoManager {
  final _$MediaItemDaoMixin _db;
  MediaItemDaoManager(this._db);
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db.attachedDatabase, _db.franchises);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db.attachedDatabase, _db.mediaItems);
}

mixin _$FranchiseDaoMixin on DatabaseAccessor<AppDatabase> {
  $FranchisesTable get franchises => attachedDatabase.franchises;
  FranchiseDaoManager get managers => FranchiseDaoManager(this);
}

class FranchiseDaoManager {
  final _$FranchiseDaoMixin _db;
  FranchiseDaoManager(this._db);
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db.attachedDatabase, _db.franchises);
}

mixin _$WatchOrderDaoMixin on DatabaseAccessor<AppDatabase> {
  $FranchisesTable get franchises => attachedDatabase.franchises;
  $WatchOrdersTable get watchOrders => attachedDatabase.watchOrders;
  $MediaItemsTable get mediaItems => attachedDatabase.mediaItems;
  $WatchOrderStepsTable get watchOrderSteps => attachedDatabase.watchOrderSteps;
  WatchOrderDaoManager get managers => WatchOrderDaoManager(this);
}

class WatchOrderDaoManager {
  final _$WatchOrderDaoMixin _db;
  WatchOrderDaoManager(this._db);
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db.attachedDatabase, _db.franchises);
  $$WatchOrdersTableTableManager get watchOrders =>
      $$WatchOrdersTableTableManager(_db.attachedDatabase, _db.watchOrders);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db.attachedDatabase, _db.mediaItems);
  $$WatchOrderStepsTableTableManager get watchOrderSteps =>
      $$WatchOrderStepsTableTableManager(
        _db.attachedDatabase,
        _db.watchOrderSteps,
      );
}

mixin _$HistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $FranchisesTable get franchises => attachedDatabase.franchises;
  $MediaItemsTable get mediaItems => attachedDatabase.mediaItems;
  $HistoryEntriesTable get historyEntries => attachedDatabase.historyEntries;
  HistoryDaoManager get managers => HistoryDaoManager(this);
}

class HistoryDaoManager {
  final _$HistoryDaoMixin _db;
  HistoryDaoManager(this._db);
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db.attachedDatabase, _db.franchises);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db.attachedDatabase, _db.mediaItems);
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(
        _db.attachedDatabase,
        _db.historyEntries,
      );
}

mixin _$MetadataCacheDaoMixin on DatabaseAccessor<AppDatabase> {
  $FranchisesTable get franchises => attachedDatabase.franchises;
  $MediaItemsTable get mediaItems => attachedDatabase.mediaItems;
  $MetadataCacheEntriesTable get metadataCacheEntries =>
      attachedDatabase.metadataCacheEntries;
  MetadataCacheDaoManager get managers => MetadataCacheDaoManager(this);
}

class MetadataCacheDaoManager {
  final _$MetadataCacheDaoMixin _db;
  MetadataCacheDaoManager(this._db);
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db.attachedDatabase, _db.franchises);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db.attachedDatabase, _db.mediaItems);
  $$MetadataCacheEntriesTableTableManager get metadataCacheEntries =>
      $$MetadataCacheEntriesTableTableManager(
        _db.attachedDatabase,
        _db.metadataCacheEntries,
      );
}

mixin _$TagDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => attachedDatabase.tags;
  $FranchisesTable get franchises => attachedDatabase.franchises;
  $MediaItemsTable get mediaItems => attachedDatabase.mediaItems;
  $MediaItemTagsTable get mediaItemTags => attachedDatabase.mediaItemTags;
  TagDaoManager get managers => TagDaoManager(this);
}

class TagDaoManager {
  final _$TagDaoMixin _db;
  TagDaoManager(this._db);
  $$TagsTableTableManager get tags =>
      $$TagsTableTableManager(_db.attachedDatabase, _db.tags);
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db.attachedDatabase, _db.franchises);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db.attachedDatabase, _db.mediaItems);
  $$MediaItemTagsTableTableManager get mediaItemTags =>
      $$MediaItemTagsTableTableManager(_db.attachedDatabase, _db.mediaItemTags);
}

mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db.attachedDatabase, _db.appSettings);
}
