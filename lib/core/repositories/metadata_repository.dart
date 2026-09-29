import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/daos.dart';

/// Domain-level access to the cached external metadata.
class MetadataRepository {
  MetadataRepository(this._db);

  final AppDatabase _db;

  MetadataCacheDao get _dao => _db.metadataCacheDao;

  Future<List<MetadataCacheEntry>> forItem(String mediaItemId) =>
      _dao.forItem(mediaItemId);

  Stream<List<MetadataCacheEntry>> watchForItem(String mediaItemId) =>
      _dao.watchForItem(mediaItemId);

  Future<MetadataCacheEntry?> find({
    required String mediaItemId,
    required String source,
  }) => _dao.find(mediaItemId: mediaItemId, source: source);

  /// Decodes the cached JSON payload for [mediaItemId]/[source], if present.
  Future<Map<String, dynamic>?> payload({
    required String mediaItemId,
    required String source,
  }) async {
    final entry = await _dao.find(mediaItemId: mediaItemId, source: source);
    if (entry == null) return null;
    final decoded = jsonDecode(entry.payload);
    return decoded is Map<String, dynamic> ? decoded : null;
  }

  /// Stores [payload] for [mediaItemId]/[source], replacing any existing value.
  Future<void> cache({
    required String mediaItemId,
    required String source,
    required Map<String, dynamic> payload,
    String? externalId,
  }) => _dao.upsert(
    MetadataCacheEntriesCompanion.insert(
      mediaItemId: mediaItemId,
      source: source,
      payload: jsonEncode(payload),
      externalId: Value.absentIfNull(externalId),
      fetchedAt: Value(DateTime.now()),
    ),
  );

  Future<void> deleteForItem(String mediaItemId) =>
      _dao.deleteForItem(mediaItemId);

  /// Streams the number of cached metadata records.
  Stream<int> watchCount() => _dao.watchCount();

  /// Removes every cached metadata record.
  Future<void> clearAll() => _dao.deleteAll();
}
