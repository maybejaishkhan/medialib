import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/daos.dart';

/// Domain-level access to tags and their links to entries.
class TagRepository {
  TagRepository(this._db);

  final AppDatabase _db;

  TagDao get _dao => _db.tagDao;

  Stream<List<Tag>> watchAll() => _dao.watchAll();

  Stream<List<Tag>> watchForItem(String mediaItemId) =>
      _dao.watchForItem(mediaItemId);

  /// Returns the id of the tag named [name], creating it if it does not exist.
  Future<String> ensure(String name) async {
    final trimmed = name.trim();
    final existing = await _dao.findByName(trimmed);
    if (existing != null) return existing.id;
    return _dao.insertTag(TagsCompanion.insert(name: trimmed));
  }

  Future<void> attach(String mediaItemId, String tagId) =>
      _dao.attach(mediaItemId, tagId);

  Future<void> detach(String mediaItemId, String tagId) =>
      _dao.detach(mediaItemId, tagId);

  Future<void> delete(String id) => _dao.deleteTag(id);
}
