import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/metadata/data/metadata_utils.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';

/// Metadata for anime and manga from [AniList](https://anilist.co)'s GraphQL API.
///
/// The public API requires no key, so this provider works out of the box.
class AniListProvider extends MetadataProvider {
  AniListProvider(this._client);

  static const _endpoint = 'https://graphql.anilist.co';

  final http.Client _client;

  @override
  String get id => 'anilist';

  @override
  String get name => 'AniList';

  @override
  Set<MediaType> get supportedTypes => {MediaType.anime, MediaType.manga};

  static const _searchQuery = r'''
    query ($search: String, $type: MediaType) {
      Page(perPage: 12) {
        media(search: $search, type: $type, sort: SEARCH_MATCH) {
          id
          title { romaji english }
          startDate { year }
          coverImage { large }
        }
      }
    }
  ''';

  static const _fetchQuery = r'''
    query ($id: Int) {
      Media(id: $id) {
        id
        title { romaji english native }
        description(asHtml: false)
        coverImage { large }
        startDate { year month day }
        episodes
        chapters
        averageScore
        staff(perPage: 4) { edges { node { name { full } } } }
      }
    }
  ''';

  Future<Map<String, dynamic>> _post(
    String query,
    Map<String, dynamic> variables,
  ) async {
    final response = await _client.post(
      Uri.parse(_endpoint),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'query': query, 'variables': variables}),
    );
    if (response.statusCode != 200) {
      throw MetadataException(
        'AniList request failed (${response.statusCode})',
      );
    }
    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic> ? decoded['data'] : null;
    if (data is! Map<String, dynamic>) {
      throw const MetadataException('AniList returned an unexpected response');
    }
    return data;
  }

  @override
  Future<List<MetadataSearchResult>> search(
    String query, {
    MediaType? type,
  }) async {
    final typeArgument = switch (type) {
      MediaType.anime => 'ANIME',
      MediaType.manga => 'MANGA',
      _ => null,
    };
    final data = await _post(_searchQuery, {
      'search': query,
      'type': typeArgument,
    });
    final media = (data['Page'] as Map?)?['media'];
    if (media is! List) return const [];
    return [
      for (final entry in media)
        if (entry is Map<String, dynamic>) _toSearchResult(entry),
    ];
  }

  @override
  Future<MediaMetadata> fetch(MetadataSearchResult result) async {
    final id = int.tryParse(result.externalId);
    if (id == null) {
      throw const MetadataException('Invalid AniList id');
    }
    final data = await _post(_fetchQuery, {'id': id});
    final media = data['Media'];
    if (media is! Map<String, dynamic>) {
      throw const MetadataException('AniList entry was not found');
    }
    return _toMetadata(media);
  }

  MetadataSearchResult _toSearchResult(Map<String, dynamic> media) {
    final title = media['title'] as Map?;
    return MetadataSearchResult(
      providerId: id,
      externalId: '${media['id']}',
      title: (title?['english'] ?? title?['romaji'] ?? '') as String,
      year: (media['startDate'] as Map?)?['year'] as int?,
      thumbnailUrl: (media['coverImage'] as Map?)?['large'] as String?,
    );
  }

  MediaMetadata _toMetadata(Map<String, dynamic> media) {
    final title = media['title'] as Map?;
    final startDate = media['startDate'] as Map?;
    final score = media['averageScore'];

    return MediaMetadata(
      providerId: id,
      externalId: '${media['id']}',
      title:
          (title?['english'] ?? title?['romaji'] ?? title?['native'])
              as String?,
      description: switch (media['description']) {
        final String value when value.isNotEmpty => stripHtml(value),
        _ => null,
      },
      coverUrl: (media['coverImage'] as Map?)?['large'] as String?,
      creators: _creators(media),
      releaseDate: dateFromParts(
        startDate?['year'] as int?,
        startDate?['month'] as int?,
        startDate?['day'] as int?,
      ),
      rating: score is num ? score.toDouble() / 10 : null,
      episodeCount: media['episodes'] as int?,
      chapterCount: media['chapters'] as int?,
    );
  }

  String? _creators(Map<String, dynamic> media) {
    final edges = (media['staff'] as Map?)?['edges'];
    if (edges is! List) return null;
    final names = <String?>[];
    for (final edge in edges) {
      if (edge is! Map) continue;
      final node = edge['node'];
      if (node is! Map) continue;
      final name = node['name'];
      if (name is Map) names.add(name['full'] as String?);
    }
    return joinCreators(names);
  }
}
