import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medialib/core/database/database_providers.dart';

/// The number of cached metadata records.
final cachedMetadataCountProvider = StreamProvider<int>(
  (ref) => ref.watch(metadataRepositoryProvider).watchCount(),
);
