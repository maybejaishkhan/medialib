import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/repositories/media_repository.dart';
import 'package:medialib/core/repositories/metadata_repository.dart';
import 'package:medialib/features/metadata/data/anilist_provider.dart';
import 'package:medialib/features/metadata/data/metadata_service.dart';
import 'package:medialib/features/metadata/data/musicbrainz_provider.dart';
import 'package:medialib/features/metadata/data/open_library_provider.dart';
import 'package:medialib/features/metadata/data/tmdb_provider.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';

void main() {
  group('AniListProvider', () {
    test('maps search results', () async {
      final client = MockClient((request) async {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        final query = body['query'] as String;
        expect(query, contains('Page('));
        return http.Response(
          jsonEncode({
            'data': {
              'Page': {
                'media': [
                  {
                    'id': 1,
                    'title': {
                      'romaji': 'Cowboy Bebop',
                      'english': 'Cowboy Bebop',
                    },
                    'startDate': {'year': 1998},
                    'coverImage': {'large': 'http://img/cover.jpg'},
                  },
                ],
              },
            },
          }),
          200,
        );
      });

      final results = await AniListProvider(client)
          .search('bebop', type: MediaType.anime);

      expect(results, hasLength(1));
      expect(results.single.title, 'Cowboy Bebop');
      expect(results.single.externalId, '1');
      expect(results.single.year, 1998);
    });

    test('maps fetched metadata', () async {
      final client = MockClient(
        (request) async => http.Response(
          jsonEncode({
            'data': {
              'Media': {
                'id': 1,
                'title': {'english': 'Cowboy Bebop', 'romaji': 'Cowboy Bebop'},
                'description': '<b>Space</b> bounty hunters.<br>Great.',
                'coverImage': {'large': 'http://img/cover.jpg'},
                'startDate': {'year': 1998, 'month': 4, 'day': 3},
                'episodes': 26,
                'averageScore': 86,
                'staff': {
                  'edges': [
                    {
                      'node': {
                        'name': {'full': 'Shinichiro Watanabe'},
                      },
                    },
                  ],
                },
              },
            },
          }),
          200,
        ),
      );

      final metadata = await AniListProvider(client).fetch(
        const MetadataSearchResult(
          providerId: 'anilist',
          externalId: '1',
          title: 'Cowboy Bebop',
        ),
      );

      expect(metadata.title, 'Cowboy Bebop');
      expect(metadata.description, 'Space bounty hunters.\nGreat.');
      expect(metadata.episodeCount, 26);
      expect(metadata.rating, 8.6);
      expect(metadata.releaseDate, DateTime(1998, 4, 3));
      expect(metadata.creators, 'Shinichiro Watanabe');
    });
  });

  group('OpenLibraryProvider', () {
    MockClient client() => MockClient((request) async {
      if (request.url.path == '/search.json') {
        return http.Response(
          jsonEncode({
            'docs': [
              {
                'key': '/works/OL1W',
                'title': 'Dune',
                'author_name': ['Frank Herbert'],
                'first_publish_year': 1965,
                'cover_i': 123,
                'isbn': ['9780441013593'],
              },
            ],
          }),
          200,
        );
      }
      return http.Response(
        jsonEncode({
          'description': {'value': 'A desert planet.'},
        }),
        200,
      );
    });

    test('maps search results and fetched metadata', () async {
      final provider = OpenLibraryProvider(client());
      final results = await provider.search('dune', type: MediaType.book);

      expect(results.single.title, 'Dune');
      expect(results.single.year, 1965);
      expect(results.single.subtitle, 'Frank Herbert');

      final metadata = await provider.fetch(results.single);
      expect(metadata.description, 'A desert planet.');
      expect(metadata.creators, 'Frank Herbert');
      expect(metadata.isbn, '9780441013593');
      expect(metadata.coverUrl, contains('123'));
      expect(metadata.releaseDate, DateTime(1965));
    });
  });

  group('MusicBrainzProvider', () {
    MockClient client() => MockClient((request) async {
      if (request.url.path.endsWith('/release-group/')) {
        return http.Response(
          jsonEncode({
            'release-groups': [
              {
                'id': 'abc',
                'title': 'Kind of Blue',
                'first-release-date': '1959-08-17',
                'artist-credit': [
                  {'name': 'Miles Davis'},
                ],
                'primary-type': 'Album',
              },
            ],
          }),
          200,
        );
      }
      return http.Response(
        jsonEncode({
          'id': 'abc',
          'title': 'Kind of Blue',
          'first-release-date': '1959-08-17',
          'artist-credit': [
            {'name': 'Miles Davis'},
          ],
        }),
        200,
      );
    });

    test('maps search results and fetched metadata', () async {
      final provider = MusicBrainzProvider(client());
      final results = await provider.search(
        'kind of blue',
        type: MediaType.music,
      );

      expect(results.single.title, 'Kind of Blue');
      expect(results.single.year, 1959);
      expect(results.single.subtitle, contains('Miles Davis'));

      final metadata = await provider.fetch(results.single);
      expect(metadata.creators, 'Miles Davis');
      expect(metadata.releaseDate, DateTime(1959, 8, 17));
    });
  });

  group('TmdbProvider', () {
    MockClient client() => MockClient((request) async {
      if (request.url.path.startsWith('/3/search/')) {
        return http.Response(
          jsonEncode({
            'results': [
              {
                'id': 11,
                'title': 'Star Wars',
                'release_date': '1977-05-25',
                'poster_path': '/p.jpg',
                'media_type': 'movie',
              },
            ],
          }),
          200,
        );
      }
      return http.Response(
        jsonEncode({
          'id': 11,
          'title': 'Star Wars',
          'overview': 'A space opera.',
          'poster_path': '/p.jpg',
          'release_date': '1977-05-25',
          'runtime': 121,
          'vote_average': 8.2,
        }),
        200,
      );
    });

    test('maps search results and fetched metadata', () async {
      final provider = TmdbProvider(client(), apiKey: 'abc');
      final results = await provider.search('star wars', type: MediaType.movie);

      expect(results.single.title, 'Star Wars');
      expect(results.single.year, 1977);

      final metadata = await provider.fetch(results.single);
      expect(metadata.title, 'Star Wars');
      expect(metadata.description, 'A space opera.');
      expect(metadata.runtimeMinutes, 121);
      expect(metadata.rating, 8.2);
      expect(metadata.coverUrl, contains('/p.jpg'));
    });
  });

  group('MetadataService', () {
    late AppDatabase db;
    late MetadataRepository repository;

    setUp(() {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      repository = MetadataRepository(db);
    });

    tearDown(() => db.close());

    test('skips failing providers and aggregates the rest', () async {
      final client = MockClient(
        (request) async => http.Response(
          jsonEncode({
            'docs': [
              {'key': '/works/OL1W', 'title': 'Dune'},
            ],
          }),
          200,
        ),
      );
      final service = MetadataService(
        registry: MetadataProviderRegistry([
          _FailingProvider(),
          OpenLibraryProvider(client),
        ]),
        repository: repository,
      );

      final results = await service.search('dune', type: MediaType.book);

      expect(results, hasLength(1));
      expect(results.single.title, 'Dune');
    });

    test('caches fetched metadata against an entry', () async {
      final service = MetadataService(
        registry: MetadataProviderRegistry(const []),
        repository: repository,
      );
      final mediaItemId = await MediaRepository(db).create(
        MediaItemsCompanion.insert(title: 'Dune', mediaType: MediaType.book),
      );

      await service.cache(
        mediaItemId,
        const MediaMetadata(
          providerId: 'openlibrary',
          externalId: '/works/OL1W',
          title: 'Dune',
        ),
      );

      expect(
        await service.cached(mediaItemId, source: 'openlibrary'),
        isNotNull,
      );
    });
  });
}

class _FailingProvider extends MetadataProvider {
  @override
  String get id => 'failing';

  @override
  String get name => 'Failing';

  @override
  Set<MediaType> get supportedTypes => {MediaType.book};

  @override
  Future<List<MetadataSearchResult>> search(
    String query, {
    MediaType? type,
  }) async => throw const MetadataException('offline');

  @override
  Future<MediaMetadata> fetch(MetadataSearchResult result) async =>
      throw const MetadataException('offline');
}
