import 'package:drift/drift.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/daos.dart';
import 'package:medialib/core/database/enums.dart';

/// Domain-level access to the consumption history timeline.
class HistoryRepository {
  HistoryRepository(this._db);

  final AppDatabase _db;

  HistoryDao get _dao => _db.historyDao;

  Stream<List<HistoryEntry>> watchForItem(String mediaItemId) =>
      _dao.watchForItem(mediaItemId);

  Stream<List<HistoryEntry>> watchRecent({int limit = 50}) =>
      _dao.watchRecent(limit: limit);

  /// Watches recent events joined with the entries they refer to.
  Stream<List<(HistoryEntry, MediaItem)>> watchRecentWithItems({
    int limit = 50,
  }) => _dao.watchRecentWithItems(limit: limit);

  Future<String> add({
    required String mediaItemId,
    required HistoryEventType eventType,
    int? progress,
    double? rating,
    String? note,
    DateTime? occurredAt,
  }) => _dao.insertEntry(
    HistoryEntriesCompanion.insert(
      mediaItemId: mediaItemId,
      eventType: eventType,
      occurredAt: Value.absentIfNull(occurredAt),
      progress: Value.absentIfNull(progress),
      rating: Value.absentIfNull(rating),
      note: Value.absentIfNull(note),
    ),
  );

  Future<void> delete(String id) => _dao.deleteEntry(id);
}
