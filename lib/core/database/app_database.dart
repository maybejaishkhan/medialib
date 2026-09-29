import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:medialib/core/database/daos.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/database/tables.dart';

part 'app_database.g.dart';

/// The application's local SQLite database.
///
/// This is the primary home of the user's library, progress, and history; the
/// network is only ever used to enrich entries with metadata.
@DriftDatabase(
  tables: [
    MediaItems,
    Franchises,
    WatchOrders,
    WatchOrderSteps,
    HistoryEntries,
    MetadataCacheEntries,
    Tags,
    MediaItemTags,
    AppSettings,
  ],
  daos: [
    MediaItemDao,
    FranchiseDao,
    WatchOrderDao,
    HistoryDao,
    MetadataCacheDao,
    TagDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Opens the on-device database file.
  AppDatabase() : super(driftDatabase(name: 'medialib'));

  /// Opens a database with a caller-supplied executor, used in tests.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      // Required for the foreign keys declared in the schema to be enforced.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
