import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:medialib/core/database/app_database.dart';

/// Serialises date values as ISO-8601 strings so exports stay human-readable.
const librarySerializer = ValueSerializer.defaults(
  serializeDateTimeValuesAsString: true,
);

/// Counts of the records restored by an import.
class ImportSummary {
  const ImportSummary({
    required this.franchises,
    required this.mediaItems,
    required this.tags,
    required this.orders,
    required this.historyEntries,
  });

  final int franchises;
  final int mediaItems;
  final int tags;
  final int orders;
  final int historyEntries;

  int get total => franchises + mediaItems + tags + orders + historyEntries;
}

/// Exports and imports the whole library as an open JSON document.
///
/// The document has a `format`/`version` header and a `data` section holding
/// each table's rows. Imports can merge into the current library or replace it.
class LibraryTransferService {
  LibraryTransferService(this._db);

  final AppDatabase _db;

  static const formatId = 'medialib.library';
  static const formatVersion = 1;

  /// Builds the export document.
  Future<Map<String, dynamic>> exportLibrary() async {
    final franchises = await _db.select(_db.franchises).get();
    final mediaItems = await _db.select(_db.mediaItems).get();
    final tags = await _db.select(_db.tags).get();
    final mediaItemTags = await _db.select(_db.mediaItemTags).get();
    final orders = await _db.select(_db.watchOrders).get();
    final steps = await _db.select(_db.watchOrderSteps).get();
    final history = await _db.select(_db.historyEntries).get();

    return {
      'format': formatId,
      'version': formatVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'data': {
        'franchises': [
          for (final row in franchises)
            row.toJson(serializer: librarySerializer),
        ],
        'mediaItems': [
          for (final row in mediaItems)
            row.toJson(serializer: librarySerializer),
        ],
        'tags': [
          for (final row in tags) row.toJson(serializer: librarySerializer),
        ],
        'mediaItemTags': [
          for (final row in mediaItemTags)
            row.toJson(serializer: librarySerializer),
        ],
        'watchOrders': [
          for (final row in orders) row.toJson(serializer: librarySerializer),
        ],
        'watchOrderSteps': [
          for (final row in steps) row.toJson(serializer: librarySerializer),
        ],
        'historyEntries': [
          for (final row in history) row.toJson(serializer: librarySerializer),
        ],
      },
    };
  }

  /// Serialises the library to a JSON string.
  Future<String> exportToJson({bool pretty = true}) async {
    final document = await exportLibrary();
    return pretty
        ? const JsonEncoder.withIndent('  ').convert(document)
        : jsonEncode(document);
  }

  /// Parses [source] and imports it.
  Future<ImportSummary> importFromJson(
    String source, {
    bool replace = false,
  }) async {
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('The file is not valid JSON.');
    }
    return importLibrary(decoded, replace: replace);
  }

  /// Imports an already-decoded [document].
  ///
  /// When [replace] is true the current library is cleared first; otherwise
  /// records are merged by primary key.
  Future<ImportSummary> importLibrary(
    Map<String, dynamic> document, {
    bool replace = false,
  }) async {
    if (document['format'] != formatId) {
      throw const FormatException('This file is not a MediaLib export.');
    }
    final version = document['version'];
    if (version is! int || version > formatVersion) {
      throw FormatException('Unsupported export version: $version');
    }
    final data = document['data'];
    if (data is! Map) {
      throw const FormatException('The export is missing its data section.');
    }
    final section = data.cast<String, dynamic>();

    final franchises = _rows(section, 'franchises');
    final mediaItems = _rows(section, 'mediaItems');
    final tags = _rows(section, 'tags');
    final mediaItemTags = _rows(section, 'mediaItemTags');
    final orders = _rows(section, 'watchOrders');
    final steps = _rows(section, 'watchOrderSteps');
    final history = _rows(section, 'historyEntries');

    await _db.transaction(() async {
      if (replace) await _clearLibrary();

      // Parents before children so foreign keys resolve.
      for (final row in franchises) {
        await _db
            .into(_db.franchises)
            .insertOnConflictUpdate(
              Franchise.fromJson(
                row,
                serializer: librarySerializer,
              ).toCompanion(true),
            );
      }
      for (final row in mediaItems) {
        await _db
            .into(_db.mediaItems)
            .insertOnConflictUpdate(
              MediaItem.fromJson(
                row,
                serializer: librarySerializer,
              ).toCompanion(true),
            );
      }
      for (final row in tags) {
        await _db
            .into(_db.tags)
            .insertOnConflictUpdate(
              Tag.fromJson(
                row,
                serializer: librarySerializer,
              ).toCompanion(true),
            );
      }
      for (final row in mediaItemTags) {
        await _db
            .into(_db.mediaItemTags)
            .insertOnConflictUpdate(
              MediaItemTag.fromJson(
                row,
                serializer: librarySerializer,
              ).toCompanion(true),
            );
      }
      for (final row in orders) {
        await _db
            .into(_db.watchOrders)
            .insertOnConflictUpdate(
              WatchOrder.fromJson(
                row,
                serializer: librarySerializer,
              ).toCompanion(true),
            );
      }
      for (final row in steps) {
        await _db
            .into(_db.watchOrderSteps)
            .insertOnConflictUpdate(
              WatchOrderStep.fromJson(
                row,
                serializer: librarySerializer,
              ).toCompanion(true),
            );
      }
      for (final row in history) {
        await _db
            .into(_db.historyEntries)
            .insertOnConflictUpdate(
              HistoryEntry.fromJson(
                row,
                serializer: librarySerializer,
              ).toCompanion(true),
            );
      }
    });

    return ImportSummary(
      franchises: franchises.length,
      mediaItems: mediaItems.length,
      tags: tags.length,
      orders: orders.length,
      historyEntries: history.length,
    );
  }

  Future<void> _clearLibrary() async {
    // Children before parents, to satisfy foreign keys.
    await _db.delete(_db.historyEntries).go();
    await _db.delete(_db.metadataCacheEntries).go();
    await _db.delete(_db.mediaItemTags).go();
    await _db.delete(_db.watchOrderSteps).go();
    await _db.delete(_db.watchOrders).go();
    await _db.delete(_db.mediaItems).go();
    await _db.delete(_db.tags).go();
    await _db.delete(_db.franchises).go();
  }

  List<Map<String, dynamic>> _rows(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is! List) return const [];
    return [
      for (final entry in value)
        if (entry is Map) entry.cast<String, dynamic>(),
    ];
  }
}
