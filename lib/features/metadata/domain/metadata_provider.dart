import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';

/// A source of media metadata (AniList, Open Library, MusicBrainz, ...).
abstract class MetadataProvider {
  /// A stable machine identifier, e.g. `anilist`.
  String get id;

  /// A human-readable name for the UI.
  String get name;

  /// The media types this provider can enrich.
  Set<MediaType> get supportedTypes;

  bool supports(MediaType type) => supportedTypes.contains(type);

  /// Searches for [query], optionally restricted to [type].
  Future<List<MetadataSearchResult>> search(String query, {MediaType? type});

  /// Fetches the full metadata for a selected [result].
  Future<MediaMetadata> fetch(MetadataSearchResult result);
}

/// Looks up providers by id or media type.
class MetadataProviderRegistry {
  MetadataProviderRegistry(Iterable<MetadataProvider> providers)
    : _providers = List.unmodifiable(providers);

  final List<MetadataProvider> _providers;

  List<MetadataProvider> get all => _providers;

  List<MetadataProvider> providersFor(MediaType type) =>
      _providers.where((provider) => provider.supports(type)).toList();

  MetadataProvider? byId(String id) {
    for (final provider in _providers) {
      if (provider.id == id) return provider;
    }
    return null;
  }
}
