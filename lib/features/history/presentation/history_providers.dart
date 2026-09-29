import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';

/// The recent consumption timeline, newest first, joined with its entries.
final historyTimelineProvider =
    StreamProvider.autoDispose<List<(HistoryEntry, MediaItem)>>(
      (ref) =>
          ref.watch(historyRepositoryProvider).watchRecentWithItems(limit: 200),
    );

/// The history of a single entry, newest first.
final historyForItemProvider = StreamProvider.autoDispose
    .family<List<HistoryEntry>, String>(
      (ref, mediaItemId) =>
          ref.watch(historyRepositoryProvider).watchForItem(mediaItemId),
    );
