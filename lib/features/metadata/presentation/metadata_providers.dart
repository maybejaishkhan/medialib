import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/settings/settings_keys.dart';
import 'package:medialib/core/settings/settings_providers.dart';
import 'package:medialib/features/metadata/data/anilist_provider.dart';
import 'package:medialib/features/metadata/data/metadata_service.dart';
import 'package:medialib/features/metadata/data/musicbrainz_provider.dart';
import 'package:medialib/features/metadata/data/open_library_provider.dart';
import 'package:medialib/features/metadata/data/tmdb_provider.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';

/// A shared HTTP client for all metadata providers.
final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

/// Builds the provider list from [settings].
///
/// Keyless providers are always present; TMDB is added when a key is set.
/// Exposed for testing without Riverpod.
List<MetadataProvider> buildMetadataProviders(
  http.Client client,
  Map<String, String> settings,
) {
  final providers = <MetadataProvider>[
    AniListProvider(client),
    OpenLibraryProvider(client),
    MusicBrainzProvider(client),
  ];

  final tmdbKey = settings[SettingsKeys.tmdbApiKey]?.trim();
  if (tmdbKey != null && tmdbKey.isNotEmpty) {
    providers.add(TmdbProvider(client, apiKey: tmdbKey));
  }
  return providers;
}

/// The registered metadata providers.
final metadataRegistryProvider = Provider<MetadataProviderRegistry>((ref) {
  final client = ref.watch(httpClientProvider);
  final settings = ref.watch(appSettingsProvider);
  return MetadataProviderRegistry(buildMetadataProviders(client, settings));
});

/// The metadata coordination service.
final metadataServiceProvider = Provider<MetadataService>(
  (ref) => MetadataService(
    registry: ref.watch(metadataRegistryProvider),
    repository: ref.watch(metadataRepositoryProvider),
  ),
);
