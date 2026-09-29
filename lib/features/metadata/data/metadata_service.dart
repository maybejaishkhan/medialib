import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/repositories/metadata_repository.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';

/// Coordinates metadata providers, matching, and local caching.
class MetadataService {
  MetadataService({required this.registry, required this.repository});

  final MetadataProviderRegistry registry;
  final MetadataRepository repository;

  /// Whether any registered provider can enrich [type].
  bool hasProviderFor(MediaType type) => registry.providersFor(type).isNotEmpty;

  /// The providers that can enrich [type].
  List<MetadataProvider> providersFor(MediaType type) =>
      registry.providersFor(type);

  /// Searches providers for [query].
  ///
  /// When [sourceId] is given, only that provider is used and its errors
  /// propagate so the caller can report them. Otherwise every provider that
  /// supports [type] is queried and individual failures are skipped.
  Future<List<MetadataSearchResult>> search(
    String query, {
    required MediaType type,
    String? sourceId,
  }) async {
    if (sourceId != null) {
      final provider = registry.byId(sourceId);
      if (provider == null || !provider.supports(type)) {
        throw MetadataException(
          'The selected source cannot search ${type.pluralLabel}.',
        );
      }
      return provider.search(query, type: type);
    }

    final results = <MetadataSearchResult>[];
    for (final provider in registry.providersFor(type)) {
      try {
        results.addAll(await provider.search(query, type: type));
      } catch (_) {
        // Graceful degradation.
      }
    }
    return results;
  }

  /// Fetches the full metadata for a selected search [result].
  Future<MediaMetadata> fetch(MetadataSearchResult result) {
    final provider = registry.byId(result.providerId);
    if (provider == null) {
      throw MetadataException('Unknown metadata source "${result.providerId}"');
    }
    return provider.fetch(result);
  }

  /// Caches [metadata] against the entry with [mediaItemId].
  Future<void> cache(String mediaItemId, MediaMetadata metadata) =>
      repository.cache(
        mediaItemId: mediaItemId,
        source: metadata.providerId,
        externalId: metadata.externalId,
        payload: metadata.toJson(),
      );

  /// The cached metadata for [mediaItemId] from [source], if any.
  Future<Map<String, dynamic>?> cached(String mediaItemId, {String? source}) {
    final resolved = source ?? registry.all.first.id;
    return repository.payload(mediaItemId: mediaItemId, source: resolved);
  }
}
