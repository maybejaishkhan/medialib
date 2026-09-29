import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/widgets/view_layout.dart';

/// The active library view state: search text, filters, and layout.
class LibraryFilter {
  const LibraryFilter({
    this.query = '',
    this.mediaType,
    this.status,
    this.layout = ViewLayout.grid,
  });

  final String query;
  final MediaType? mediaType;
  final MediaStatus? status;
  final ViewLayout layout;

  static const _unset = Object();

  LibraryFilter copyWith({
    String? query,
    Object? mediaType = _unset,
    Object? status = _unset,
    ViewLayout? layout,
  }) => LibraryFilter(
    query: query ?? this.query,
    mediaType: identical(mediaType, _unset)
        ? this.mediaType
        : mediaType as MediaType?,
    status: identical(status, _unset) ? this.status : status as MediaStatus?,
    layout: layout ?? this.layout,
  );

  bool get hasFilters =>
      query.trim().isNotEmpty || mediaType != null || status != null;
}

/// Holds and mutates the [LibraryFilter].
class LibraryFilterNotifier extends Notifier<LibraryFilter> {
  @override
  LibraryFilter build() => const LibraryFilter();

  void setQuery(String query) => state = state.copyWith(query: query);

  void setMediaType(MediaType? type) => state = state.copyWith(mediaType: type);

  void setStatus(MediaStatus? status) => state = state.copyWith(status: status);

  void setLayout(ViewLayout layout) => state = state.copyWith(layout: layout);

  void clear() => state = const LibraryFilter();
}

final libraryFilterProvider =
    NotifierProvider<LibraryFilterNotifier, LibraryFilter>(
      LibraryFilterNotifier.new,
    );

/// The library entries matching the current filter, streamed from the database.
final libraryItemsProvider = StreamProvider.autoDispose<List<MediaItem>>((ref) {
  final filter = ref.watch(libraryFilterProvider);
  return ref
      .watch(mediaRepositoryProvider)
      .watchAll(
        mediaType: filter.mediaType,
        status: filter.status,
        query: filter.query,
      );
});

/// How many entries exist for each media type.
final libraryTypeCountsProvider = StreamProvider<Map<MediaType, int>>(
  (ref) => ref.watch(mediaRepositoryProvider).watchCountsByType(),
);

/// Watches a single entry by id.
final mediaItemProvider = StreamProvider.autoDispose.family<MediaItem?, String>(
  (ref, id) => ref.watch(mediaRepositoryProvider).watchById(id),
);

/// The list of franchises, used by the editor's franchise picker.
final franchisesProvider = StreamProvider<List<Franchise>>(
  (ref) => ref.watch(franchiseRepositoryProvider).watchAll(),
);
