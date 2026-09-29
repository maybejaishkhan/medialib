import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/daos.dart';

/// Domain-level access to persisted application settings.
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  SettingsDao get _dao => _db.settingsDao;

  Stream<Map<String, String>> watchAll() => _dao.watchAll().map(
    (rows) => {for (final row in rows) row.key: row.value},
  );

  Future<String?> get(String key) => _dao.get(key);

  Future<void> set(String key, String value) => _dao.set(key, value);

  Future<void> delete(String key) => _dao.removeKey(key);
}
