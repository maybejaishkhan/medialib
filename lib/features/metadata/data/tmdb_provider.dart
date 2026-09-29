import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/metadata/data/metadata_utils.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';

/// Film and TV metadata from [TMDB](https://www.themoviedb.org).
///
/// Requires an API key, which the settings screen stores under
/// `SettingsKeys.tmdbApiKey`.
class TmdbProvider extends MetadataProvider {
  TmdbProvider(this._client, {required this.apiKey});

  final http.Client _client;
  final String apiKey;

  @override
  String get id => 'tmdb';

  @override
  String get name => 'TMDB';

  @override
  Set<MediaType> get supportedTypes => {MediaType.movie, MediaType.tv};

  String? _pathFor(MediaType type) => switch (type) {
    MediaType.movie => 'movie',
    MediaType.tv => 'tv',
    _ => null,
  };

  @override
  Future<List<MetadataSearchResult>> search(
    String query, {
    MediaType? type,
  }) async {
    final path = type == null ? 'multi' : _pathFor(type);
    if (path == null) return const [];

    final uri = Uri.https('api.themoviedb.org', '/3/search/$path', {
      'api_key': apiKey,
      'query': query,
      'include_adult': 'false',
    });
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw MetadataException('TMDB request failed (${response.statusCode})');
    }
    final decoded = jsonDecode(response.body);
    final results = decoded is Map<String, dynamic> ? decoded['results'] : null;
    if (results is! List) return const [];
    return [
      for (final result in results)
        if (result is Map<String, dynamic>) _toSearchResult(result, type),
    ];
  }

  @override
  Future<MediaMetadata> fetch(MetadataSearchResult result) async {
    final mediaType =
        (result.raw?['media_type'] as String?) ??
        (result.raw?.containsKey('name') ?? false ? 'tv' : 'movie');
    final uri = Uri.https(
      'api.themoviedb.org',
      '/3/$mediaType/${result.externalId}',
      {'api_key': apiKey},
    );
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw MetadataException('TMDB request failed (${response.statusCode})');
    }
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const MetadataException('TMDB returned an unexpected response');
    }

    final posterPath = decoded['poster_path'] as String?;
    final dateString =
        (decoded['release_date'] ?? decoded['first_air_date']) as String?;
    final vote = decoded['vote_average'];
    return MediaMetadata(
      providerId: id,
      externalId: '${decoded['id']}',
      title: (decoded['title'] ?? decoded['name']) as String?,
      description: switch (decoded['overview']) {
        final String value when value.isNotEmpty => stripHtml(value),
        _ => null,
      },
      coverUrl: posterPath != null
          ? 'https://image.tmdb.org/t/p/w500$posterPath'
          : null,
      releaseDate: parseDate(dateString),
      rating: vote is num && vote > 0 ? vote.toDouble() : null,
      runtimeMinutes: decoded['runtime'] as int?,
      episodeCount: decoded['number_of_episodes'] as int?,
    );
  }

  MetadataSearchResult _toSearchResult(
    Map<String, dynamic> result,
    MediaType? type,
  ) {
    final mediaType =
        (result['media_type'] as String?) ??
        (result['name'] != null ? 'tv' : 'movie');
    final resolved = switch (type) {
      MediaType.movie => 'movie',
      MediaType.tv => 'tv',
      _ => mediaType,
    };
    final posterPath = result['poster_path'] as String?;
    final dateString =
        (result['release_date'] ?? result['first_air_date']) as String?;
    return MetadataSearchResult(
      providerId: id,
      externalId: '${result['id']}',
      title: '${result['title'] ?? result['name'] ?? ''}',
      year: parseDate(dateString)?.year,
      thumbnailUrl: posterPath != null
          ? 'https://image.tmdb.org/t/p/w200$posterPath'
          : null,
      raw: {...result, 'media_type': resolved},
    );
  }
}
