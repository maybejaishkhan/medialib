import 'package:drift/drift.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/daos.dart';
import 'package:medialib/core/database/enums.dart';

/// Domain-level access to library entries.
///
/// Keeps history bookkeeping (status changes, progress updates) out of the UI
/// and in one place.
class MediaRepository {
  MediaRepository(this._db);

  final AppDatabase _db;

  MediaItemDao get _items => _db.mediaItemDao;
  HistoryDao get _history => _db.historyDao;

  Stream<List<MediaItem>> watchAll({
    MediaType? mediaType,
    MediaStatus? status,
    String? query,
  }) => _items.watchAll(mediaType: mediaType, status: status, query: query);

  Future<List<MediaItem>> all({
    MediaType? mediaType,
    MediaStatus? status,
    String? query,
  }) => _items.all(mediaType: mediaType, status: status, query: query);

  Stream<MediaItem?> watchById(String id) => _items.watchById(id);

  Future<MediaItem?> findById(String id) => _items.findById(id);

  Stream<List<MediaItem>> watchForFranchise(String franchiseId) =>
      _items.watchForFranchise(franchiseId);

  Stream<Map<MediaType, int>> watchCountsByType() => _items.watchCountsByType();

  /// Creates an entry and returns its generated id.
  Future<String> create(MediaItemsCompanion item) => _items.insertItem(item);

  /// Replaces [item], refreshing its `updatedAt` timestamp.
  Future<void> update(MediaItem item) =>
      _items.updateItem(item.copyWith(updatedAt: DateTime.now()));

  /// Changes [item]'s status and records the change in the history.
  Future<void> setStatus(MediaItem item, MediaStatus status) async {
    final now = DateTime.now();
    await _items.updateItem(
      item.copyWith(
        status: status,
        updatedAt: now,
        startedAt: status == MediaStatus.inProgress && item.startedAt == null
            ? Value(now)
            : const Value.absent(),
        finishedAt: status == MediaStatus.completed && item.finishedAt == null
            ? Value(now)
            : const Value.absent(),
      ),
    );
    await _history.insertEntry(
      HistoryEntriesCompanion.insert(
        mediaItemId: item.id,
        eventType: _eventFor(status),
        occurredAt: Value(now),
      ),
    );
  }

  /// Updates reading/watching progress and records it in the history.
  Future<void> updateProgress(MediaItem item, int progress) async {
    final now = DateTime.now();
    await _items.updateItem(item.copyWith(progress: progress, updatedAt: now));
    await _history.insertEntry(
      HistoryEntriesCompanion.insert(
        mediaItemId: item.id,
        eventType: HistoryEventType.progressed,
        occurredAt: Value(now),
        progress: Value(progress),
      ),
    );
  }

  Future<void> delete(String id) => _items.deleteById(id);

  static HistoryEventType _eventFor(MediaStatus status) => switch (status) {
    MediaStatus.planned => HistoryEventType.noted,
    MediaStatus.inProgress => HistoryEventType.started,
    MediaStatus.completed => HistoryEventType.completed,
    MediaStatus.onHold => HistoryEventType.paused,
    MediaStatus.dropped => HistoryEventType.dropped,
  };
}
