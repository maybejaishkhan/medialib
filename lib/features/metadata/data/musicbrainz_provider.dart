import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/metadata/data/metadata_utils.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';

/// Music metadata from [MusicBrainz](https://musicbrainz.org).
///
/// The API requires no key, but asks clients to send a descriptive
/// `User-Agent` and to stay within its rate limits.
class MusicBrainzProvider extends MetadataProvider {
  MusicBrainzProvider(
    this._client, {
    this.userAgent = 'MediaLib/1.0 (personal media library)',
  });

  final http.Client _client;
  final String userAgent;

  @override
  String get id => 'musicbrainz';

  @override
  String get name => 'MusicBrainz';

  @override
  Set<MediaType> get supportedTypes => {MediaType.music};

  Map<String, String> get _headers => {
    'User-Agent': userAgent,
    'Accept': 'application/json',
  };

  @override
  Future<List<MetadataSearchResult>> search(
    String query, {
    MediaType? type,
  }) async {
    final uri = Uri.https('musicbrainz.org', '/ws/2/release-group/', {
      'query': query,
      'fmt': 'json',
      'limit': '12',
    });
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw MetadataException(
        'MusicBrainz request failed (${response.statusCode})',
      );
    }
    final decoded = jsonDecode(response.body);
    final groups = decoded is Map<String, dynamic>
        ? decoded['release-groups']
        : null;
    if (groups is! List) return const [];
    return [
      for (final group in groups)
        if (group is Map<String, dynamic>) _toSearchResult(group),
    ];
  }

  @override
  Future<MediaMetadata> fetch(MetadataSearchResult result) async {
    final uri = Uri.https(
      'musicbrainz.org',
      '/ws/2/release-group/${result.externalId}',
      {'inc': 'artist-credits', 'fmt': 'json'},
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw MetadataException(
        'MusicBrainz request failed (${response.statusCode})',
      );
    }
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const MetadataException(
        'MusicBrainz returned an unexpected response',
      );
    }
    return _toMetadata(decoded);
  }

  MetadataSearchResult _toSearchResult(Map<String, dynamic> group) {
    final id = '${group['id']}';
    final artists = _artists(group);
    final subtitle = [
      ?artists,
      ?(group['primary-type'] as String?),
    ].join(' · ');
    return MetadataSearchResult(
      providerId: this.id,
      externalId: id,
      title: '${group['title'] ?? ''}',
      subtitle: subtitle.isEmpty ? null : subtitle,
      year: parseDate(group['first-release-date'])?.year,
      thumbnailUrl: 'https://coverartarchive.org/release-group/$id/front-250',
      raw: group,
    );
  }

  MediaMetadata _toMetadata(Map<String, dynamic> group) {
    final id = '${group['id']}';
    return MediaMetadata(
      providerId: this.id,
      externalId: id,
      title: group['title'] as String?,
      creators: _artists(group),
      releaseDate: parseDate(group['first-release-date']),
      coverUrl: 'https://coverartarchive.org/release-group/$id/front-500',
    );
  }

  String? _artists(Map<String, dynamic> group) {
    final credits = group['artist-credit'];
    if (credits is! List) return null;
    return joinCreators([
      for (final credit in credits)
        if (credit is Map) credit['name'] as String?,
    ]);
  }
}
