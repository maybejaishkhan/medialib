import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/widgets/view_layout.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';

/// The state of the metadata source search tab.
class SourceSearchState {
  const SourceSearchState({
    this.mediaType = MediaType.book,
    this.sourceId,
    this.query = '',
    this.layout = ViewLayout.grid,
    this.results = const [],
    this.loading = false,
    this.error,
    this.hasSearched = false,
  });

  final MediaType mediaType;

  /// The selected provider id, or null to search every applicable source.
  final String? sourceId;

  final String query;
  final ViewLayout layout;
  final List<MetadataSearchResult> results;
  final bool loading;
  final String? error;
  final bool hasSearched;

  static const _unset = Object();

  SourceSearchState copyWith({
    MediaType? mediaType,
    Object? sourceId = _unset,
    String? query,
    ViewLayout? layout,
    List<MetadataSearchResult>? results,
    bool? loading,
    Object? error = _unset,
    bool? hasSearched,
  }) => SourceSearchState(
    mediaType: mediaType ?? this.mediaType,
    sourceId: identical(sourceId, _unset) ? this.sourceId : sourceId as String?,
    query: query ?? this.query,
    layout: layout ?? this.layout,
    results: results ?? this.results,
    loading: loading ?? this.loading,
    error: identical(error, _unset) ? this.error : error as String?,
    hasSearched: hasSearched ?? this.hasSearched,
  );
}

/// Drives the metadata source search: media type, source, query, and results.
class SourceSearchController extends Notifier<SourceSearchState> {
  @override
  SourceSearchState build() => const SourceSearchState();

  void setMediaType(MediaType type) => state = state.copyWith(
    mediaType: type,
    sourceId: null,
    results: const [],
    hasSearched: false,
    error: null,
  );

  void setSource(String? sourceId) => state = state.copyWith(
    sourceId: sourceId,
    results: const [],
    hasSearched: false,
    error: null,
  );

  void setQuery(String query) => state = state.copyWith(query: query);

  void setLayout(ViewLayout layout) => state = state.copyWith(layout: layout);

  Future<void> search() async {
    final query = state.query.trim();
    if (query.isEmpty || state.loading) return;

    state = state.copyWith(loading: true, error: null, hasSearched: true);
    try {
      final results = await ref
          .read(metadataServiceProvider)
          .search(query, type: state.mediaType, sourceId: state.sourceId);
      state = state.copyWith(results: results, loading: false);
    } catch (error) {
      state = state.copyWith(
        loading: false,
        results: const [],
        error: '$error',
      );
    }
  }
}

final sourceSearchProvider =
    NotifierProvider<SourceSearchController, SourceSearchState>(
      SourceSearchController.new,
    );
