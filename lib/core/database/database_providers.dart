import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/repositories/franchise_repository.dart';
import 'package:medialib/core/repositories/history_repository.dart';
import 'package:medialib/core/repositories/media_repository.dart';
import 'package:medialib/core/repositories/metadata_repository.dart';
import 'package:medialib/core/repositories/order_repository.dart';
import 'package:medialib/core/repositories/settings_repository.dart';
import 'package:medialib/core/repositories/tag_repository.dart';

/// The application's local database.
///
/// Override this provider in tests with an in-memory database, e.g.
/// `AppDatabase.forTesting(NativeDatabase.memory())`.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final mediaRepositoryProvider = Provider<MediaRepository>(
  (ref) => MediaRepository(ref.watch(appDatabaseProvider)),
);

final franchiseRepositoryProvider = Provider<FranchiseRepository>(
  (ref) => FranchiseRepository(ref.watch(appDatabaseProvider)),
);

final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepository(ref.watch(appDatabaseProvider)),
);

final historyRepositoryProvider = Provider<HistoryRepository>(
  (ref) => HistoryRepository(ref.watch(appDatabaseProvider)),
);

final metadataRepositoryProvider = Provider<MetadataRepository>(
  (ref) => MetadataRepository(ref.watch(appDatabaseProvider)),
);

final tagRepositoryProvider = Provider<TagRepository>(
  (ref) => TagRepository(ref.watch(appDatabaseProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(appDatabaseProvider)),
);
