import 'package:drift/drift.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/database/tables.dart';

part 'daos.g.dart';

/// Read/write access to library entries.
@DriftAccessor(tables: [MediaItems])
class MediaItemDao extends DatabaseAccessor<AppDatabase>
    with _$MediaItemDaoMixin {
  MediaItemDao(super.db);

  SimpleSelectStatement<$MediaItemsTable, MediaItem> _filtered({
    MediaType? mediaType,
    MediaStatus? status,
    String? query,
  }) {
    final statement = select(mediaItems);
    if (mediaType != null) {
      statement.where((t) => t.mediaType.equalsValue(mediaType));
    }
    if (status != null) {
      statement.where((t) => t.status.equalsValue(status));
    }
    final term = query?.trim();
    if (term != null && term.isNotEmpty) {
      final pattern = '%$term%';
      statement.where(
        (t) =>
            t.title.like(pattern) |
            t.originalTitle.cast<String>().like(pattern) |
            t.creators.cast<String>().like(pattern),
      );
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.title)]);
    return statement;
  }

  /// Watches all entries, optionally filtered by type, status, or a search term.
  Stream<List<MediaItem>> watchAll({
    MediaType? mediaType,
    MediaStatus? status,
    String? query,
  }) => _filtered(mediaType: mediaType, status: status, query: query).watch();

  /// Returns all entries, optionally filtered.
  Future<List<MediaItem>> all({
    MediaType? mediaType,
    MediaStatus? status,
    String? query,
  }) => _filtered(mediaType: mediaType, status: status, query: query).get();

  Stream<MediaItem?> watchById(String id) =>
      (select(mediaItems)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<MediaItem?> findById(String id) =>
      (select(mediaItems)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<MediaItem>> watchForFranchise(String franchiseId) =>
      (select(mediaItems)
            ..where((t) => t.franchiseId.equals(franchiseId))
            ..orderBy([(t) => OrderingTerm.asc(t.title)]))
          .watch();

  /// Inserts a new entry and returns its generated id.
  Future<String> insertItem(MediaItemsCompanion item) async =>
      (await into(mediaItems).insertReturning(item)).id;

  /// Replaces an existing entry, matching on its primary key.
  Future<bool> updateItem(MediaItem item) => update(mediaItems).replace(item);

  Future<void> deleteById(String id) =>
      (delete(mediaItems)..where((t) => t.id.equals(id))).go();

  /// Streams how many entries exist per media type.
  Stream<Map<MediaType, int>> watchCountsByType() {
    final count = mediaItems.id.count();
    final query = selectOnly(mediaItems)
      ..addColumns([count, mediaItems.mediaType])
      ..groupBy([mediaItems.mediaType]);
    return query.watch().map((rows) {
      final counts = <MediaType, int>{};
      for (final row in rows) {
        final type = row.readWithConverter(mediaItems.mediaType);
        if (type != null) {
          counts[type] = row.read(count) ?? 0;
        }
      }
      return counts;
    });
  }
}

/// Read/write access to franchises and series.
@DriftAccessor(tables: [Franchises])
class FranchiseDao extends DatabaseAccessor<AppDatabase>
    with _$FranchiseDaoMixin {
  FranchiseDao(super.db);

  Stream<List<Franchise>> watchAll() =>
      (select(franchises)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  Future<Franchise?> findById(String id) =>
      (select(franchises)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<String> insertFranchise(FranchisesCompanion franchise) async =>
      (await into(franchises).insertReturning(franchise)).id;

  Future<bool> updateFranchise(Franchise franchise) =>
      update(franchises).replace(franchise);

  Future<void> deleteById(String id) =>
      (delete(franchises)..where((t) => t.id.equals(id))).go();
}

/// Read/write access to watching/reading orders and their steps.
@DriftAccessor(tables: [WatchOrders, WatchOrderSteps])
class WatchOrderDao extends DatabaseAccessor<AppDatabase>
    with _$WatchOrderDaoMixin {
  WatchOrderDao(super.db);

  Stream<List<WatchOrder>> watchAll() =>
      (select(watchOrders)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  Stream<List<WatchOrder>> watchForFranchise(String franchiseId) =>
      (select(watchOrders)
            ..where((t) => t.franchiseId.equals(franchiseId))
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .watch();

  Future<WatchOrder?> findById(String id) =>
      (select(watchOrders)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<WatchOrderStep>> stepsFor(String orderId) =>
      (select(watchOrderSteps)
            ..where((t) => t.orderId.equals(orderId))
            ..orderBy([(t) => OrderingTerm.asc(t.position)]))
          .get();

  Stream<List<WatchOrderStep>> watchStepsFor(String orderId) =>
      (select(watchOrderSteps)
            ..where((t) => t.orderId.equals(orderId))
            ..orderBy([(t) => OrderingTerm.asc(t.position)]))
          .watch();

  /// Inserts an order and returns its generated id.
  Future<String> insertOrder(WatchOrdersCompanion order) async =>
      (await into(watchOrders).insertReturning(order)).id;

  Future<bool> updateOrder(WatchOrder order) =>
      update(watchOrders).replace(order);

  /// Replaces every step of [orderId] with [steps] inside a transaction.
  Future<void> replaceSteps(
    String orderId,
    List<WatchOrderStepsCompanion> steps,
  ) => transaction(() async {
    await (delete(
      watchOrderSteps,
    )..where((t) => t.orderId.equals(orderId))).go();
    for (final step in steps) {
      await into(watchOrderSteps).insert(step);
    }
  });

  Future<void> deleteOrder(String id) =>
      (delete(watchOrders)..where((t) => t.id.equals(id))).go();
}

/// Read/write access to the consumption history timeline.
@DriftAccessor(tables: [HistoryEntries, MediaItems])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  Stream<List<HistoryEntry>> watchForItem(String mediaItemId) =>
      (select(historyEntries)
            ..where((t) => t.mediaItemId.equals(mediaItemId))
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
          .watch();

  Stream<List<HistoryEntry>> watchRecent({int limit = 50}) =>
      (select(historyEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])
            ..limit(limit))
          .watch();

  /// Watches recent history joined with the entries they refer to.
  Stream<List<(HistoryEntry, MediaItem)>> watchRecentWithItems({
    int limit = 50,
  }) {
    final query = select(historyEntries).join([
      innerJoin(
        mediaItems,
        mediaItems.id.equalsExp(historyEntries.mediaItemId),
      ),
    ])..orderBy([OrderingTerm.desc(historyEntries.occurredAt)]);
    query.limit(limit);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => (row.readTable(historyEntries), row.readTable(mediaItems)),
          )
          .toList(),
    );
  }

  Future<String> insertEntry(HistoryEntriesCompanion entry) async =>
      (await into(historyEntries).insertReturning(entry)).id;

  Future<void> deleteEntry(String id) =>
      (delete(historyEntries)..where((t) => t.id.equals(id))).go();
}

/// Read/write access to the external metadata cache.
@DriftAccessor(tables: [MetadataCacheEntries])
class MetadataCacheDao extends DatabaseAccessor<AppDatabase>
    with _$MetadataCacheDaoMixin {
  MetadataCacheDao(super.db);

  Future<List<MetadataCacheEntry>> forItem(String mediaItemId) => (select(
    metadataCacheEntries,
  )..where((t) => t.mediaItemId.equals(mediaItemId))).get();

  Stream<List<MetadataCacheEntry>> watchForItem(String mediaItemId) => (select(
    metadataCacheEntries,
  )..where((t) => t.mediaItemId.equals(mediaItemId))).watch();

  Future<MetadataCacheEntry?> find({
    required String mediaItemId,
    required String source,
  }) =>
      (select(metadataCacheEntries)..where(
            (t) => t.mediaItemId.equals(mediaItemId) & t.source.equals(source),
          ))
          .getSingleOrNull();

  /// Stores a payload for [mediaItemId]/[source], replacing any existing one.
  Future<void> upsert(MetadataCacheEntriesCompanion entry) =>
      transaction(() async {
        await (delete(metadataCacheEntries)..where(
              (t) =>
                  t.mediaItemId.equals(entry.mediaItemId.value) &
                  t.source.equals(entry.source.value),
            ))
            .go();
        await into(metadataCacheEntries).insert(entry);
      });

  Future<void> deleteForItem(String mediaItemId) => (delete(
    metadataCacheEntries,
  )..where((t) => t.mediaItemId.equals(mediaItemId))).go();

  /// Streams the total number of cached metadata records.
  Stream<int> watchCount() {
    final count = metadataCacheEntries.id.count();
    return (selectOnly(
      metadataCacheEntries,
    )..addColumns([count])).watchSingle().map((row) => row.read(count) ?? 0);
  }

  Future<void> deleteAll() => delete(metadataCacheEntries).go();
}

/// Read/write access to tags.
@DriftAccessor(tables: [Tags, MediaItemTags, MediaItems])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  TagDao(super.db);

  Stream<List<Tag>> watchAll() =>
      (select(tags)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  Future<Tag?> findByName(String name) =>
      (select(tags)..where((t) => t.name.equals(name))).getSingleOrNull();

  Future<String> insertTag(TagsCompanion tag) async =>
      (await into(tags).insertReturning(tag)).id;

  /// Watches the tags attached to [mediaItemId].
  Stream<List<Tag>> watchForItem(String mediaItemId) {
    final query = select(tags).join([
      innerJoin(mediaItemTags, mediaItemTags.tagId.equalsExp(tags.id)),
    ])..where(mediaItemTags.mediaItemId.equals(mediaItemId));
    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(tags)).toList(),
    );
  }

  Future<void> attach(String mediaItemId, String tagId) =>
      into(mediaItemTags).insert(
        MediaItemTagsCompanion.insert(mediaItemId: mediaItemId, tagId: tagId),
        mode: InsertMode.insertOrIgnore,
      );

  Future<void> detach(String mediaItemId, String tagId) =>
      (delete(mediaItemTags)..where(
            (t) => t.mediaItemId.equals(mediaItemId) & t.tagId.equals(tagId),
          ))
          .go();

  Future<void> deleteTag(String id) =>
      (delete(tags)..where((t) => t.id.equals(id))).go();
}

/// Key/value access to persisted application settings.
@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Stream<List<AppSetting>> watchAll() =>
      (select(appSettings)..orderBy([(t) => OrderingTerm.asc(t.key)])).watch();

  Future<String?> get(String key) async {
    final row = await (select(
      appSettings,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  /// Inserts or updates [key] with [value].
  Future<void> set(String key, String value) => into(appSettings)
      .insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          key: key,
          value: value,
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> removeKey(String key) =>
      (delete(appSettings)..where((t) => t.key.equals(key))).go();
}
