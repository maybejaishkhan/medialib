import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/features/transfer/data/library_transfer_service.dart';

/// The service used to export and import the library.
final libraryTransferServiceProvider = Provider<LibraryTransferService>(
  (ref) => LibraryTransferService(ref.watch(appDatabaseProvider)),
);
