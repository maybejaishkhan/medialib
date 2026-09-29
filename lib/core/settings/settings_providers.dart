import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medialib/core/database/database_providers.dart';

/// A live view of all persisted application settings.
final appSettingsStreamProvider = StreamProvider<Map<String, String>>(
  (ref) => ref.watch(settingsRepositoryProvider).watchAll(),
);

/// A synchronous map of the current settings, kept in sync with the database.
///
/// Depend on this provider when the presence of a setting should rebuild a
/// widget or another provider (for example, enabling a metadata provider once
/// its API key is set).
class AppSettingsNotifier extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() =>
      ref.watch(appSettingsStreamProvider).value ?? const {};

  Future<void> set(String key, String value) =>
      ref.read(settingsRepositoryProvider).set(key, value);

  Future<void> remove(String key) =>
      ref.read(settingsRepositoryProvider).delete(key);
}

final appSettingsProvider =
    NotifierProvider<AppSettingsNotifier, Map<String, String>>(
      AppSettingsNotifier.new,
    );
