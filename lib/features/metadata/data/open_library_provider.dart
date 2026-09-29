import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/metadata/data/metadata_utils.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';

/// Book metadata from [Open Library](https://openlibrary.org).
///
/// The search API requires no key.
class OpenLibraryProvider extends MetadataProvider {
  OpenLibraryProvider(this._client);

  final http.Client _client;

  @override
  String get id => 'openlibrary';

  @override
  String get name => 'Open Library';

  @override
  Set<MediaType> get supportedTypes => {MediaType.book};

  @override
  Future<List<MetadataSearchResult>> search(
    String query, {
    MediaType? type,
  }) async {
    final uri = Uri.https('openlibrary.org', '/search.json', {
      'q': query,
      'limit': '12',
      'fields': 'key,title,author_name,first_publish_year,cover_i,isbn',
    });
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw MetadataException(
        'Open Library request failed (${response.statusCode})',
      );
    }
    final decoded = jsonDecode(response.body);
    final docs = decoded is Map<String, dynamic> ? decoded['docs'] : null;
    if (docs is! List) return const [];
    return [
      for (final doc in docs)
        if (doc is Map<String, dynamic>) _toSearchResult(doc),
    ];
  }

  @override
  Future<MediaMetadata> fetch(MetadataSearchResult result) async {
    final raw = result.raw ?? const <String, dynamic>{};

    // The work record carries the description; enrichment is best-effort.
    String? description;
    try {
      final response = await _client.get(
        Uri.https('openlibrary.org', '${result.externalId}.json'),
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          description = _description(decoded['description']);
        }
      }
    } catch (_) {
      // Fall back to the search data below.
    }

    final coverId = raw['cover_i'];
    final authors = raw['author_name'];
    final isbns = raw['isbn'];
    return MediaMetadata(
      providerId: id,
      externalId: result.externalId,
      title: (raw['title'] ?? result.title) as String?,
      description: description,
      coverUrl: coverId is int
          ? 'https://covers.openlibrary.org/b/id/$coverId-L.jpg'
          : null,
      creators: authors is List
          ? joinCreators(authors.map((author) => author?.toString()))
          : null,
      releaseDate: dateFromParts(raw['first_publish_year'] as int?),
      isbn: isbns is List && isbns.isNotEmpty ? isbns.first as String? : null,
    );
  }

  MetadataSearchResult _toSearchResult(Map<String, dynamic> doc) {
    final authors = doc['author_name'];
    final coverId = doc['cover_i'];
    return MetadataSearchResult(
      providerId: id,
      externalId: '${doc['key']}',
      title: '${doc['title'] ?? ''}',
      subtitle: authors is List
          ? joinCreators(authors.map((author) => author?.toString()))
          : null,
      year: doc['first_publish_year'] as int?,
      thumbnailUrl: coverId is int
          ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
          : null,
      raw: doc,
    );
  }

  String? _description(Object? value) {
    if (value is String && value.isNotEmpty) return value;
    if (value is Map && value['value'] is String) {
      return value['value'] as String;
    }
    return null;
  }
}
